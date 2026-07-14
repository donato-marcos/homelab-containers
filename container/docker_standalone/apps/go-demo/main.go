package main

import (
	_ "embed"
	"encoding/json"
	"fmt"
	"html/template"
	"io"
	"log"
	"net/http"
	"os"
	"runtime"
	"sync/atomic"
	"time"
)

//go:embed index.html
var indexHTML string

var (
	version      = envOr("APP_VERSION", "1.0.0")
	color        = envOr("APP_COLOR", "#1e88e5")
	label        = envOr("APP_LABEL", "Go Demo")
	hostname, _  = os.Hostname()
	startTime    = time.Now()
	requestCount atomic.Int64
)

func envOr(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

// ---------- handlers ----------

func handleIndex(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	tmpl, err := template.New("index").Parse(indexHTML)
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	if err := tmpl.Execute(w, map[string]string{
		"Version":  version,
		"Color":    color,
		"Label":    label,
		"Hostname": hostname,
	}); err != nil {
		log.Printf("template execute error: %v", err)
	}
}

func handleInfo(w http.ResponseWriter, r *http.Request) {
	requestCount.Add(1)
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	_ = json.NewEncoder(w).Encode(map[string]interface{}{
		"hostname":   hostname,
		"version":    version,
		"label":      label,
		"color":      color,
		"requests":   requestCount.Load(),
		"uptime_sec": int(time.Since(startTime).Seconds()),
		"goroutines": runtime.NumGoroutine(),
		"go_version": runtime.Version(),
		"timestamp":  time.Now().UTC().Format(time.RFC3339),
	})
}

func handleHealthz(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprint(w, "ok")
}

// ---------- healthcheck client mode ----------
// A imagem final roda em `scratch`, sem curl/wget. Este modo permite que o
// próprio binário faça o GET em /healthz e retorne o exit code adequado,
// para uso em HEALTHCHECK do Dockerfile ou docker-compose.
func runHealthcheck() {
	port := envOr("PORT", "8080")
	client := http.Client{Timeout: 2 * time.Second}
	resp, err := client.Get("http://127.0.0.1:" + port + "/healthz")
	if err != nil {
		fmt.Fprintln(os.Stderr, "healthcheck failed:", err)
		os.Exit(1)
	}
	defer resp.Body.Close()
	io.Copy(io.Discard, resp.Body)
	if resp.StatusCode != http.StatusOK {
		fmt.Fprintln(os.Stderr, "healthcheck failed: status", resp.StatusCode)
		os.Exit(1)
	}
	os.Exit(0)
}

// ---------- main ----------

func main() {
	if len(os.Args) > 1 && os.Args[1] == "-healthcheck" {
		runHealthcheck()
		return
	}

	port := envOr("PORT", "8080")

	mux := http.NewServeMux()
	mux.HandleFunc("/", handleIndex)
	mux.HandleFunc("/api/info", handleInfo)
	mux.HandleFunc("/healthz", handleHealthz)

	srv := &http.Server{
		Addr:              ":" + port,
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
		ReadTimeout:       10 * time.Second,
		WriteTimeout:      10 * time.Second,
		IdleTimeout:       60 * time.Second,
	}

	log.Printf("🚀 %s v%s | host=%s | listening :%s", label, version, hostname, port)
	log.Fatal(srv.ListenAndServe())
}
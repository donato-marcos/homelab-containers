FROM golang:1.26.5-alpine3.24 AS builder
WORKDIR /src
COPY go.mod ./
COPY main.go index.html ./
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app .

FROM scratch
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app /app
USER nobody
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=2s --retries=3 CMD ["/app", "-healthcheck"]
ENTRYPOINT ["/app"]
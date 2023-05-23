FROM golang:1.16.3-alpine3.13 AS builder

WORKDIR /src

COPY main.go .

RUN go mod init g2d2/myapp && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch

COPY --from=builder /src/app .

ENTRYPOINT [ "./app" ]

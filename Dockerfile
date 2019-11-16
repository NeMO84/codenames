# Codenames - An API service to generate codenames but with failure modes! 

# Build env for Go
FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash
WORKDIR $GOPATH/src/mypackage/myapp/
COPY ./main.go .
RUN go get -d -v
RUN go build -o /go/bin/codenames

# Run scratch
FROM alpine:latest
LABEL Author="Nirmit Patel"
COPY --from=builder /go/bin/codenames /app/codenames
ADD adjectives.txt /app
ADD animals.txt /app

WORKDIR /app
EXPOSE 8081
CMD ["/app/codenames",  "--adjectives", "/app/adjectives.txt", "--animals", "/app/animals.txt", "--port", "8081"]

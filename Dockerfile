FROM golang:1.17.1-alpine as build

WORKDIR /app

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

COPY go.mod go.sum ./

RUN go mod download

COPY ./ ./

RUN go build

FROM scratch as final

COPY --from=build /app/hello-world-cli ./

ENTRYPOINT [ "./hello-world-cli" ]




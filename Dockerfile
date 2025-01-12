FROM golang:1.21.3-alpine3.17 AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/server

FROM scratch

COPY --from=build /bin/server /bin/server

EXPOSE 2324

CMD ["/bin/server"]

# Use the offical Golang image to create a build artifact.
FROM golang:1.16-alpine as builder

# Copy local code to the container image.
COPY . /go/app
WORKDIR /go/app

# Build the command inside the container.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o app main.go

# Use a Docker multi-stage build to create a lean production image.
FROM gcr.io/distroless/base
COPY --from=builder /go/app/ .

# Run the service binary.
CMD ["/app"]
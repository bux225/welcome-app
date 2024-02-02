# Start from the official golang image, tagged as version 1.17 with Alpine Linux
FROM golang:1.17-alpine AS builder

# Set the current working directory inside the container
WORKDIR /app

# Copy the Go Modules and the source code
COPY go.mod ./
COPY . .

# Build the Go application
RUN go build -o welcome-app .

# Start a new stage from the Alpine Linux image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the executable from the builder stage
COPY --from=builder /app/welcome-app .

# Copy static and templates directories
COPY static ./static
COPY templates ./templates

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./welcome-app"]

FROM ubuntu AS build
RUN apt-get update && apt-get install -y golang-go
WORKDIR /go/src/app

ENV GO111MODULE=off

COPY main.go ./

RUN CGO_ENABLED=0 go build -o webserver .


FROM scratch
WORKDIR /app
# Copying the compiled binary file from the build stage
COPY --from=build /go/src/app/ /app/

# Set the entrypoint for the container to run the binary
ENTRYPOINT ["./webserver"]

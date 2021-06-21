FROM golang:1.13.12-alpine as builder

COPY . /pgpool2_exporter
WORKDIR /pgpool2_exporter
RUN apk update && apk add --no-cache make
RUN make

FROM quay.io/prometheus/busybox:latest

COPY --from=builder /pgpool2_exporter/pgpool2_exporter /bin/pgpool2_exporter

ENTRYPOINT ["/bin/pgpool2_exporter"]
EXPOSE     9719

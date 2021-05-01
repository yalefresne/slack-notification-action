FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

FROM hashicorp/terraform:0.12.30

RUN apk add make

WORKDIR /tmp
COPY . /tmp

ENTRYPOINT [ "/usr/bin/make" ]

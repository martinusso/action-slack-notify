FROM FROM golang:alpine as builder

LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="yellow"
LABEL "com.github.actions.name"="Slack Notify"
LABEL "com.github.actions.description"="This action will send notification to Slack"

WORKDIR ${GOPATH}/src/github.com/martinusso/action-slack-notify
COPY main.go ${GOPATH}/src/github.com/martinusso/action-slack-notify

ENV GOOS linux

RUN go get -v ./...
RUN go build -a -installsuffix cgo -ldflags '-w  -extldflags "-static"' -o /go/bin/slack-notify .

# alpine
FROM alpine

COPY --from=builder /go/bin/slack-notify /usr/bin/slack-notify

RUN apk update \
	&& apk upgrade \
	&& apk add \
	bash \
	jq \
	ca-certificates \
	python \
	py2-pip \
	rsync && \
	pip install shyaml && \
	rm -rf /var/cache/apk/*

# fix the missing dependency - https://stackoverflow.com/a/35613430
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY *.sh /

RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]

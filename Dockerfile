FROM golang:latest AS build
WORKDIR /Users/douglas.kalemba/Documents/disney/gitleaks-fork/gitleaks
COPY . .
RUN VERSION=$(git describe --tags --abbrev=0) && \
CGO_ENABLED=0 go build -o bin/gitleaks -ldflags "-X="https://github.com/squatchBKLN/gitleaks/v9/cmd.Version=${VERSION}

FROM alpine:latest
RUN adduser -D gitleaks && \
    apk add --no-cache bash git openssh-client
COPY --from=build /Users/douglas.kalemba/Documents/disney/gitleaks-fork/gitleaks/bin/* /usr/bin/
USER gitleaks

RUN git config --global --add safe.directory '*'

ENTRYPOINT ["gitleaks"]

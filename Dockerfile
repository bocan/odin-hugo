# the following version can be overridden at image build time with --build-arg
# https://github.com/gohugoio/hugo
# renovate: datasource=github-releases depName=gohugoio/hugo
ARG HUGO_VERSION=0.163.3

# ---

# https://hub.docker.com/_/golang/
FROM golang:1.26-alpine AS build

# renew global args from above
# https://docs.docker.com/engine/reference/builder/#scope
ARG HUGO_VERSION

# vanilla (non-extended) Hugo is pure Go: build a fully static binary
ENV CGO_ENABLED=0

WORKDIR /src/hugo

RUN apk upgrade --update --no-cache && apk add --update --no-cache \
  git

# clone source from Git repo:
RUN git clone \
  --branch "v${HUGO_VERSION}" \
  --single-branch \
  --depth 1 \
  https://github.com/gohugoio/hugo.git ./

# https://github.com/gohugoio/hugo/commit/241481931f5f5f2803cd4be519936b26d8648dfd
RUN go build -v -ldflags "-X github.com/gohugoio/hugo/common/hugo.vendorInfo=docker" && \
  mv ./hugo /go/bin/hugo

# ---

# https://hub.docker.com/_/alpine
FROM alpine:3.24

# renew global args from above
ARG HUGO_VERSION

LABEL version="${HUGO_VERSION}"
LABEL repository="https://github.com/bocan/odin-hugo"
LABEL homepage="https://chris.funderburg.me/"
LABEL maintainer="Chris Funderburg <chris@funderburg.me>"

# https://docs.github.com/en/free-pro-team@latest/packages/managing-container-images-with-github-container-registry/connecting-a-repository-to-a-container-image#connecting-a-repository-to-a-container-image-on-the-command-line
LABEL org.opencontainers.image.source="https://github.com/bocan/odin-hugo"

# bring over patched binary from build stage
COPY --from=build /go/bin/hugo /usr/bin/hugo

# this step is intentionally a bit of a mess to minimize the number of layers in the final image
RUN set -euo pipefail && \
  # alpine packages
  # ca-certificates are required to fetch outside resources (like Twitter oEmbeds)
  apk upgrade --update --no-cache && apk add --update --no-cache \
  ca-certificates \
  tzdata \
  git && \
  update-ca-certificates && \
  # clean up some junk
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* && \
  # tell git to trust /src
  git config --global --add safe.directory /src && \
  # make super duper sure that everything went OK, exit otherwise
  hugo env

# add site source as volume
VOLUME /src
WORKDIR /src

# expose live-refresh server on default port
EXPOSE 1313

ENTRYPOINT ["hugo"]

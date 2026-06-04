# ruby-alpine

A lean Ruby base image on Alpine Linux, preloaded with the native libraries and
tools commonly needed to build and run Rails-style applications — without baking
those dependencies into every downstream `Dockerfile`.

Published to Docker Hub as [`7a6163/ruby-alpine`](https://hub.docker.com/r/7a6163/ruby-alpine).

## What's Included

| Component | Notes |
|-----------|-------|
| Ruby | `3.3.11` (Alpine variant) |
| Bundler | `4.0.10` |
| Build toolchain | `build-base`, `curl-dev`, `cmake` — for compiling native gem extensions |
| Database | `postgresql-dev` headers (for the `pg` gem) |
| Graphics / PDF | `cairo-dev`, `imagemagick`, and a static `wkhtmltopdf` binary |
| Version control | `git`, `libgit2-dev` (for `rugged`) |
| JavaScript | `nodejs-current` |
| Other | `tzdata`, `openssh`, `less` |

Locale is set to `en_US.UTF-8`.

## Usage

Use it as the base image in your own `Dockerfile`:

```dockerfile
FROM 7a6163/ruby-alpine:latest

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
```

Or pull and inspect it directly:

```bash
docker pull 7a6163/ruby-alpine:latest
docker run --rm 7a6163/ruby-alpine ruby -v
```

## Building Locally

```bash
# Single-arch build for the host platform
docker build -t ruby-alpine .

# Multi-arch build matching CI (requires Buildx + QEMU)
docker buildx build --platform linux/amd64,linux/arm64 -t ruby-alpine .
```

## Releasing

Images are published by GitHub Actions on **semver tags** only:

```bash
git tag v<version>
git push origin v<version>
```

This cross-builds `linux/amd64` and `linux/arm64` and pushes both the version tag
and `latest` to Docker Hub. The workflow requires the `DOCKERHUB_USERNAME` and
`DOCKERHUB_TOKEN` repository secrets.

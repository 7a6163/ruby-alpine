FROM ruby:3.3.12-alpine

ENV BUILD_PACKAGES="curl-dev build-base"
ENV RUBY_PACKAGES="cairo-dev cmake libgit2-dev postgresql-client postgresql-dev tzdata wget"
ENV WKHTMLTOPDF_PACKAGES="gtk+3.0 glib ttf-freefont fontconfig dbus"

RUN apk add --no-cache \
    $BUILD_PACKAGES \
    $RUBY_PACKAGES \
    $WKHTMLTOPDF_PACKAGES \
    font-noto-cjk \
    git \
    imagemagick \
    imagemagick-jpeg \
    imagemagick-webp \
    less \
    nodejs-current \
    openssh \
    typst \
    vips

# Pre-cache the tiaoma Typst package (Code 128 / QR barcode generator, WASM-compiled
# zint) so PDF rendering never needs network access. Without this the first compile
# reaches out to packages.typst.org and dies on runners with no egress to it.
RUN printf '#import "@preview/tiaoma:0.3.0" as tiaoma\n#tiaoma.qrcode("warmup")\n' > /tmp/pc.typ && \
    typst compile /tmp/pc.typ /tmp/pc.pdf && \
    rm /tmp/pc.typ /tmp/pc.pdf

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN gem install bundler -v 4.0.19

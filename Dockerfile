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

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN gem install bundler -v 4.0.19

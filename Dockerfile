FROM ruby:3.3.9-alpine

ENV BUILD_PACKAGES curl-dev build-base
ENV RUBY_PACKAGES cairo-dev cmake libgit2-dev postgresql-dev tzdata wget
ENV WKHTMLTOPDF_PACKAGES gtk+3.0 glib ttf-freefont fontconfig dbus

RUN apk add --no-cache \
    $BUILD_PACKAGES \
    $RUBY_PACKAGES \
    $WKHTMLTOPDF_PACKAGES \
    git \
    imagemagick \
    less \
    nodejs-current \
    openssh

RUN wget --no-check-certificate https://github.com/kernix/wkhtmltopdf-docker-alpine/raw/master/wkhtmltopdf -P /usr/bin/
RUN chmod a+x /usr/bin/wkhtmltopdf

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN gem install bundler -v 2.6.8

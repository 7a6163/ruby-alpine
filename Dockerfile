FROM ruby:2.7.8-alpine

ENV BUILD_PACKAGES curl-dev build-base
ENV RUBY_PACKAGES cairo-dev postgresql-dev tzdata wget
ENV WKHTMLTOPDF_PACKAGES gtk+ glib ttf-freefont fontconfig dbus

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
RUN gem install bundler && gem cleanup uri && gem install uri -v 0.10.3

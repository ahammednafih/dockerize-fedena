FROM ruby:2.5.0

ENV APP_PATH /myapp
ENV RAILS_PORT 3000
ENV RAILS_ENV production
ENV BUNDLER_VERSION 1.17.3
ENV BUNDLE_PATH /usr/local/bundle
ENV GEM_PATH /usr/local/bundle
ENV GEM_HOME /usr/local/bundle

RUN apt-get update -qq && apt-get install -y \
      software-properties-common \
      build-essential \
      libpq-dev \
      libcurl4-openssl-dev \
      libxml2-dev \
      libxslt-dev \
      zip \
      imagemagick

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version "$BUNDLER_VERSION"
RUN bundle check || bundle install --jobs 20 --retry 5

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . .

EXPOSE $RAILS_PORT

# Configure the main process to run when running the image
CMD ["script/server", "-b", "0.0.0.0", "-p", "3000"]
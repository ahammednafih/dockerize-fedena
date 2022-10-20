FROM ruby:2.2.2-slim-buster

ENV APP_PATH /myapp
ENV RAILS_PORT 5001
ENV RAILS_ENV development

ENV BUNDLER_VERSION 1.14.6
ENV BUNDLE_PATH /usr/local/bundle
ENV GEM_PATH /usr/local/bundle
ENV GEM_HOME /usr/local/bundle

RUN apt-get update -qq && apt-get install -y \
      software-properties-common \
      build-essential \
      libmariadb-dev \
      wget \
      git

WORKDIR $APP_PATH

COPY Gemfile ./

RUN gem install bundler --version "$BUNDLER_VERSION"
RUN bundle check || bundle install --jobs 20 --retry 5

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . .

EXPOSE $RAILS_PORT

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "5001"]

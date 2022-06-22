FROM ruby:2.4.0

ENV APP_PATH /myapp
ENV RAILS_PORT 3001
ENV RAILS_ENV development
ENV BUNDLE_PATH /usr/local/bundle
ENV GEM_PATH /usr/local/bundle
ENV GEM_HOME /usr/local/bundle

RUN apt-get update -qq && apt-get install -y \
      software-properties-common \
      build-essential \
      libmysqlclient-dev \
      wget \
      git \
      libpq-dev \
      libpng-dev \
      pkg-config \
      libcurl4-openssl-dev \
      libxml2-dev \
      libxslt-dev \
      zip \
      imagemagick \
      nodejs

WORKDIR $APP_PATH

COPY Gemfile ./

RUN gem install bundler -v '1.14.6'
RUN bundle check || bundle install --jobs 20 --retry 5

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

COPY . .

EXPOSE $RAILS_PORT

# Configure the main process to run when running the image
CMD ["rails", "server", "-p", "3001", "-b", "0.0.0.0"]

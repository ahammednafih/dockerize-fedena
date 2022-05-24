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
      libmariadb-dev \
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
      rsync

# Configure Wkhtmltopdf
RUN apt-get install -y \
      fontconfig \
      libfreetype6 \
      libjpeg62-turbo \
      libpng16-16 \
      libx11-6 \
      libxcb1 \
      libxext6 \
      libxrender1 \
      xfonts-75dpi \
      xfonts-base \
      ttf-dejavu \
      ttf-freefont \
      ttf-liberation \
      wkhtmltopdf

RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.stretch_arm64.deb && \
    apt-get update -yq && \
    dpkg -i wkhtmltox_0.12.6-1.stretch_arm64.deb && \
    rm -rf wkhtmltox_0.12.6-1.stretch_arm64.deb && \
    ln -nfs /usr/local/bin/wkhtmltopdf /usr/bin/ && \
    ln -nfs /usr/local/bin/wkhtmltoimage /usr/bin/ && \
    echo "Configured Wkhtmltopdf!"

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

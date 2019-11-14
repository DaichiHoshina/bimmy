FROM ruby:2.6.2
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    vim \
    mysql-client \
    yarn \
    nodejs && \
    gem install bundler && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /myapp

WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

CMD ["rails", "server", "-b", "0.0.0.0"]

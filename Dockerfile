From ruby:2.0.0

# Install package
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12 && \
    echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu quantal main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y redis-server pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /ask-ruby
WORKDIR /ask-ruby
ADD Gemfile /ask-ruby/Gemfile
RUN bundle install
ADD . /ask-ruby
From ruby:2.2.0

# Install package
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN mkdir /ask-ruby
WORKDIR /ask-ruby
ADD Gemfile /ask-ruby/Gemfile
RUN bundle install
ADD . /ask-ruby
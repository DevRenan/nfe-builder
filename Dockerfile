# syntax=docker/dockerfile:1
FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -qq --no-install-recommends vim\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /nfe-builder
COPY Gemfile /nfe-builder/Gemfile
COPY Gemfile.lock /nfe-builder/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
FROM ruby:3.2.3

ENV LANG C.UTF-8
ENV RAILS_ENV development

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs yarn

RUN apt-get install -y \
    build-essential \
    postgresql-client \
    && apt-get clean

WORKDIR /app

RUN bundle config set --local path /vendor
RUN mkdir /vendor

RUN gem install foreman

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 5000

CMD ["bundle", "exec", "foreman", "start"]

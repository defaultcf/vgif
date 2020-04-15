FROM ruby:2.6.5
ENV LANG C.UTF-8
RUN apt update -y && \
    apt install -y nodejs npm
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install -j4

COPY . /app/
RUN npm i -g yarn && yarn install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

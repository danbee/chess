FROM elixir:1.6.0

ENV PHANTOMJS_VERSION 2.1.1
ENV PHANTOMJS_DIR /phantomjs

WORKDIR /phantomjs

RUN wget -q --continue \
    "https://s3.amazonaws.com/codeship-packages/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2"
RUN tar -xjf phantomjs* \
    --strip-components=1

ENV PATH $PHANTOMJS_DIR/bin:$PATH

WORKDIR /app

RUN mix local.rebar --force && mix local.hex --force

COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mix deps.compile

WORKDIR /app/assets
COPY assets/ ./
RUN yarn install && yarn run build

WORKDIR /app

COPY . ./

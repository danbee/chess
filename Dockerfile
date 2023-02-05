FROM --platform=linux/amd64 elixir:1.14.1

# Create a directory for your application code and set it as the WORKDIR. All following commands will be run in this directory.
RUN mkdir /app
WORKDIR /app

# Update package repo
RUN apt-get update

# Install Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  apt-get -y install ./google-chrome-stable_current_amd64.deb

# Install ChromeDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install nodejs

# Install Yarn
RUN npm install yarn

# Install Rebar and Hex
RUN mix local.rebar --force && mix local.hex --force 

# Install the Phoenix Mix archive
RUN mix archive.install --sha512 2a2f5167f5ea30f314500da449dbd8cfb4b6986cc27197c82fa4cc328798814f89a4dbe0183a5f213faed3587e8133ce99c1fab74cf1597978a270bdcc7bf789 --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# COPY mix.exs and mix.lock and install dependencies before adding the full code so the cache only
# gets invalidated when dependencies are changed
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copy the app source code into the image
COPY ./ /app

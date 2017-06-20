###
# MAGE Docker image
#
# Feel free to add or customise the image according to your needs.
###
FROM IMAGE
MAINTAINER Marc Trudel <mtrudel@wizcorp.jp>

# System dependencies
RUN apt-get -qq update \
      && apt-get -qq install --no-install-recommends sudo vim bash-completion libzmq3-dev \
      && apt-get clean all

# Set EDITOR variable (for git)
ENV EDITOR=vim

# Create an app user to run things from
RUN useradd -m app && echo "app:app" | chpasswd && adduser app sudo
RUN mkdir /usr/src/app && chown app.app /usr/src/app
RUN echo "app         ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER app
COPY .bashrc /home/app

# Environment variables

# Set working directory (this will get mounted during development)
WORKDIR /usr/src/app

# Load files and install dependencies
ONBUILD ARG node_env=production
ONBUILD ARG npm_flags
ONBUILD ARG npm_loglevel=http
ONBUILD ENV NODE_ENV=$node_env
ONBUILD ENV NPM_CONFIG_LOGLEVEL=$npm_loglevel
ONBUILD COPY package.json /usr/src/app
ONBUILD RUN npm install $npm_flags \
      && npm cache clean
ONBUILD COPY . /usr/src/app

# Command to run
CMD ["npm", "run", "mage"]

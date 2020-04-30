FROM node:10

COPY . /stellar-account-viewer

WORKDIR /stellar-account-viewer

# Set the SHELL to bash with pipefail option
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install nvm (node version manager) and node v6
ENV NVM_DIR $HOME/.nvm
RUN mkdir -p "$NVM_DIR"; \
    curl -o- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/v0.30.1/install.sh" | \
        bash \
    ; \
    source $NVM_DIR/nvm.sh; \
    nvm install 6

RUN source ~/.bashrc; \
    # install node_modules using yarn and node@10
    yarn install; \
    # switch to node 6
    nvm use 6; \
    # install interstellar using npm and node@6
    npm install https://github.com/stellar/interstellar.git#yarn; \
    # add hook to make this build possible
    cp ./hooks/webpack.config.es6 ./node_modules/interstellar/lib/webpack.config.es6; \
    # build
    ./node_modules/.bin/interstellar build --env=prd

# expose ports for copying files to local file system
EXPOSE 8080

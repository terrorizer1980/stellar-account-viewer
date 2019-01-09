FROM node:6

COPY . /stellar-account-viewer
WORKDIR /stellar-account-viewer

RUN yarn install
RUN npm install interstellar

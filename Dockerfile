# syntax=docker/dockerfile:1.4

# 1. For build React app
FROM node:lts As base

# Setting our current work directory every command 
# we instruct the dockerfile to run will be done in this directory

WORKDIR /app

# Splitting out our react dependancies into their own cached build stage
# Allows for faster docker builds

COPY package.json /app/package.json

# Instructing Docker we want to install the dependacies for this build stage
RUN npm install

# Copy contents of the root dir into the docker image /app directory
# root is specified by `.`
COPY . /app

ENV PORT=3000

# Instructs the Dockerfile what command to start this build stage with

FROM node:lts-slim as final

COPY --from=base /app .

CMD [ "npm", "start" ]

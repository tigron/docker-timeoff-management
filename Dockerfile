# This is the base for our build step container
FROM node:13-alpine AS base

# Install dependencies
RUN apk add --no-cache git make python3 sqlite

# Create and change to workdir
WORKDIR /app
RUN git clone --branch 1.4.1 https://github.com/timeoff-management/application.git timeoff-management

WORKDIR /app/timeoff-management

# Install dependencies
RUN npm install mysql && npm install sqlite3 && npm install --unsafe-perm --production

# 20190118-chnage-type-value-for-api-token.js isn't compatible with mariadb. A better solution is used to replace it
# Issue comment: https://github.com/timeoff-management/timeoff-management-application/issues/329#issuecomment-488327844
COPY scripts/20190118-chnage-type-value-for-api-token.js /app/timeoff-management/migrations/

# This is our runtime container
FROM alpine:3.13

# Install npm and dependencies
RUN apk add --update make nodejs npm python3 sqlite build-base
RUN ln -s /usr/bin/python3 /usr/bin/python

# Copy files from first stage
COPY --from=base /app/timeoff-management/ /app/timeoff-management

WORKDIR /app/timeoff-management

RUN npm install mysql && npm install sqlite3 && npm install --unsafe-perm --production

RUN mkdir /app/data
VOLUME /app/data

RUN mkdir /app/config
VOLUME /app/config

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

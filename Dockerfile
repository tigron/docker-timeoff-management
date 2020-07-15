# This is the base for our build step container
FROM node:10-alpine AS base

# Install dependencies
RUN apk add --no-cache git

# Create and change to workdir
WORKDIR /app
RUN git clone --branch 1.0.0 https://github.com/timeoff-management/application.git timeoff-management

WORKDIR /app/timeoff-management

# Install dependencies
RUN npm install mysql && npm install --production

# This is our runtime container
FROM alpine:3.10

# Install npm
RUN apk add --update nodejs npm

WORKDIR /app/timeoff-management

RUN mkdir /app/data
VOLUME /app/data

RUN mkdir /app/config
VOLUME /app/config

# Copy files from first stage
COPY --from=base /app/timeoff-management/ /app/timeoff-management

# 20190118-chnage-type-value-for-api-token.js isn't compatible with mariadb. A fixed version is used to replace it
# Issue comment: https://github.com/timeoff-management/timeoff-management-application/issues/329#issuecomment-488327844
COPY scripts/20190118-chnage-type-value-for-api-token.js /app/timeoff-management/migrations/

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]

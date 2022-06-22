# tigron/timeoff-management

Docker implementation of the timeoff-management project. Originally made by
[NOS Inovação](https://github.com/nosinovacao/docker-timeoff-management)

## Using the image

By default timeoff-management uses SQLite for both data and sessions and no SMTP
server.

To change the default configurations use the environment variables listed
below.

| Variable | Possible values|
| -------- | ------ |
| ALLOW_ACCOUNTS_CREATION | true (default), false |
| MYSQL_HOST | host |
| MYSQL_USER | port |
| MYSQL_PASSWORD | password |
| PROMOTION_URL | <http://timeoff.management> |
| NODE_ENV | development (default), test, production |
| SENDER_MAIL | email address |
| SESSION_USE_REDIS | true, false (default) |
| SESSION_REDIS_HOST | host
| SESSION_REDIS_PORT | port |
| APP_URL | <http://app.timeoff.management> (default) |
| SMTP_HOST | host |
| SMTP_PORT | port |
| SMTP_USER | username |
| SMTP_PASSWORD | password |

## Tags

Docker images are tagged using the TimeOff.Management version number, followed
by a revision if there is one. There are also tags for the most recent image as
well as for the development image.

* timeoff-management:latest
* timeoff-management:development
* timeoff-management:release-1.0.0
* timeoff-management:release-1.4.0

More info on [Docker hub](https://hub.docker.com/r/tigron/timeoff-management).

### Building and running the Docker image

#### Building

Building the image can be done using the command below.

    $ docker build -t tigron/timeoff-management:latest .

This will result in an image being built with tag `latest`.

#### Running

Running the image in a local Docker instance can be done as follows.

    $ docker run -e NODE_ENV=production tigron/timeoff-management:latest

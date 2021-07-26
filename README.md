# unotifier

Simple Telegram bot that allows you, through a simple REST API, to send messages to any user who had generated and shared a token. This helps you to implement a library of notifications to users for free and in a few minutes, taking advantage of the infrastructure of this application.

The project is a Node.js dockerized program with CI that deploys it automatically on every commit. It's hosted in an AWS VPS instance using nginx as a reverse proxy. The docker images are stored in the AWS ECR, and the data is stored in a PostgreSQL database.

## Requirements

- `docker`
- `docker-compose`
- `make`
- `git`


## Running the bot backend

In order to run your own instance of the bot, you need to copy the file `.env.exaple` into `.env` and fill with with your own data. You can generate your own bot token in Telegram, creating a new bot using the "Botfather". This is an example:

```env
DATABASE_URL="postgresql://postgres:postgres@db:5432/postgres?schema=public"

BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN_HERE"

PRISMA_STUDIO_PORT=5555
API_PORT=8080
PGPORT=5432
POSTGRES_DB=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

To run the bot:

```
# Development mode
make development

# Production mode
make production
```

## Usage in telegram

My instance of the bot is called \@unotifierBot in Telegram, but you can use your own instance.

```
/start - Start the bot and get a token. Show the token if it's already generated.
/stop  - Stop the bot and delete your token.
```

## Sending notifications

Get your uNotifier token and use it for calling the REST api.

JavaScript example:

```javascript
const token = '123456-123456-123456' // Here your generated uNotifier token
const url = `https://unotifier.pjnicolas.com/${token}` // Use here your bot backend url. You can use mine as well

const message = 'Hello uNotifier!'

fetch(url, {
  method: 'POST',
  body: message,
})
```


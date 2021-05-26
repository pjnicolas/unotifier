import dotenv from 'dotenv'
dotenv.config({ path: '.env' })

let API_PORT = Number(process.env.API_PORT)
let BOT_TOKEN = process.env.BOT_TOKEN as string

if (!Number.isInteger(API_PORT) || API_PORT < 1 || API_PORT > 65535) {
  throw new Error('[ENV] API_PORT must be greater than 1 and lower than 65535')
}

if (typeof BOT_TOKEN !== 'string' || BOT_TOKEN.length < 1) {
  throw new Error('[ENV] BOT_TOKEN must be a string')
}

export {
  API_PORT,
  BOT_TOKEN,
}

import { Telegraf, Telegram } from 'telegraf'
import { BOT_TOKEN } from './env'
import prisma from './prisma'

const bot = new Telegraf(BOT_TOKEN)
const telegram = new Telegram(BOT_TOKEN)

const RANDOM_ALPHABET = 'ABCDEFGHJKLMNPRSTXZ23456789'
const TOKEN_HASH_SECTION_LENGTH = 6
const TOKEN_HASH_SECTION_COUNT = 3

const generateRandomChar = () => {
  const randomPosition = Math.floor(Math.random() * RANDOM_ALPHABET.length)
  return RANDOM_ALPHABET[randomPosition]
}

const generateRandomCode = () => {
  const hash = []
  for (let section = 0; section < TOKEN_HASH_SECTION_COUNT; section += 1) {
    hash[section] = [] as Array<string>
    for (let i = 0; i < TOKEN_HASH_SECTION_LENGTH; i += 1) {
      hash[section].push(generateRandomChar())
    }
  }

  return hash.map((e) => e.join('')).join('-')
}

bot.command('start', async (ctx) => {
  const chatId = String(ctx.message.chat.id)
  const code = generateRandomCode()

  const oldToken = await prisma.token.findFirst({ where: { chatId } })

  if (oldToken) {
    ctx.reply(`You already have an active token. You can delete it with /stop. Your current token is: \n\n\`${oldToken.code}\``, { parse_mode: 'Markdown' })
  } else {
    const newToken = await prisma.token.create({
      data: {
        chatId,
        code,
      },
    })

    ctx.reply(`Token generated: \n\n\`${newToken.code}\``, { parse_mode: 'Markdown' })
  }
})

bot.command('stop', async (ctx) => {
  const chatId = String(ctx.message.chat.id)

  await prisma.token.deleteMany({ where: { chatId } })

  ctx.reply('Bot stopped, token deleted.')
})


export { telegram, bot }

import express from 'express'
import cors from 'cors'
import prisma from './prisma'
import { telegram } from './bot'

const app = express()

app.use(express.text())
app.use(cors())

app.post('/:code', async (req, res) => {
  const { code } = req.params
  const token = await prisma.token.findUnique({ where: { code } })
  if (!token) {
    res.status(404).send('Token not found')
  } else {
    try {
      telegram.sendMessage(token.chatId, req.body)
      res.status(200).send('Ok')
    } catch {
      res.status(500).send('Internal error')
    }
  }
})

export { app }

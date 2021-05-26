import './env'

import { API_PORT } from './env'
import { app } from './express'
import { bot } from './bot'

app.listen(API_PORT, () => console.log(`Express server listening on *:${API_PORT}`))
bot.launch()

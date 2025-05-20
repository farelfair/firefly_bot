import asyncio
from telegram import Bot, InlineKeyboardMarkup, InlineKeyboardButton
import json

async def main():
    bot = Bot("")
    chat_id = "@"

    with open("telegram_payload.json") as f:
        data = json.load(f)

    text = data["text"]
    keyboard = InlineKeyboardMarkup(data["reply_markup"]["inline_keyboard"])

    await bot.send_message(chat_id=chat_id, text=text, parse_mode=data["parse_mode"], reply_markup=keyboard)

# Jalankan event loop
asyncio.run(main())
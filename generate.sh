#!/bin/bash

# Nama file
FILE="index.html"

# Cek file
if [ ! -f "$FILE" ]; then
  echo "[✗] File '$FILE' tidak ditemukan!"
  exit 1
fi

# Metadata
FILE_SIZE=$(du -h "$FILE" | cut -f1)
UPLOAD_DATE=$(date "+%Y-%m-%d %H:%M:%S")
EXPIRE_DATE=$(date -d "+3 days" "+%Y-%m-%d %H:%M:%S")
MD5_SUM=$(md5sum "$FILE" | cut -d ' ' -f1)
SHA1_SUM=$(sha1sum "$FILE" | cut -d ' ' -f1)

# Minta link download Google Drive
read -p "Masukkan Link Google Drive: " DOWNLOAD_URL

# Gabungkan semua ke file JSON satu paket
cat <<EOF > telegram_payload.json
{
  "text": "*File Information:*\n*File Name:* \`$FILE\`\n*File Size:* \`$FILE_SIZE\`\n*Upload Date:* \`$UPLOAD_DATE\`\n*Expired Date:* \`$EXPIRE_DATE\`\n*MD5 Sum:* \`$MD5_SUM\`\n*SHA1 Sum:* \`$SHA1_SUM\`",
  "parse_mode": "Markdown",
  "reply_markup": {
    "inline_keyboard": [
      [
        {
          "text": "⬇️ Download",
          "url": "$DOWNLOAD_URL"
        }
      ]
    ]
  }
}
EOF

echo "[✓] Payload Telegram siap di 'telegram_payload.json'"
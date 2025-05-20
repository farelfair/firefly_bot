#!/bin/bash

# Nama file
FILE=""

# Cek file
if [ ! -f "$FILE" ]; then
  echo "[✗] File '$FILE' tidak ditemukan!"
  exit 1
fi

# Atur zona waktu ke Asia/Jakarta (WIB)
export TZ="Asia/Jakarta"

# Metadata
FILE_SIZE=$(du -h "$FILE" | cut -f1)
UPLOAD_DATE=$(date "+%Y-%m-%d %H:%M:%S %Z")  # Contoh: 2025-05-20 23:40:00 WIB
MD5_SUM=$(md5sum "$FILE" | cut -d ' ' -f1)
SHA1_SUM=$(sha1sum "$FILE" | cut -d ' ' -f1)

# Minta link download Google Drive
read -p "Masukkan Link Google Drive: " DOWNLOAD_URL

# Buat file JSON payload Telegram
cat <<EOF > telegram_payload.json
{
  "text": "*File Information:*\n*File Name:* \`$FILE\`\n*File Size:* \`$FILE_SIZE\`\n*Upload Date:* \`$UPLOAD_DATE\`\n*MD5 Sum:* \`$MD5_SUM\`\n*SHA1 Sum:* \`$SHA1_SUM\`",
  "parse_mode": "Markdown",
  "reply_markup": {
    "inline_keyboard": [
      [
        {
          "text": "Download",
          "url": "$DOWNLOAD_URL"
        }
      ]
    ]
  }
}
EOF

echo "[✓] Payload Telegram siap di 'telegram_payload.json' (Zona waktu: $TZ)"
#!/bin/bash

# ===== file path example /home/farelfair/file.zip =====
FILE=""
FILE_NAME=$(basename "$FILE")

# ===== check file =====
if [ ! -f "$FILE" ]; then
  echo "[✗] File '$FILE' not found!"
  exit 1
fi

# ===== set time zone =====
export TZ="Asia/Jakarta"

# ===== metadata =====
FILE_SIZE=$(du -h "$FILE" | cut -f1)
UPLOAD_DATE=$(date "+%Y-%m-%d %H:%M:%S %Z")  # Contoh: 2025-05-20 23:40:00 WIB
MAINTAINER="@" # user tag like @farel
DEVICE="" # device name
MD5_SUM=$(md5sum "$FILE" | cut -d ' ' -f1)
SHA1_SUM=$(sha1sum "$FILE" | cut -d ' ' -f1)

# ===== Paste link =====
read -p "enter the file download link: " DOWNLOAD_URL

# ===== created file JSON payload Telegram =====
cat <<EOF > message.json
{
  "text": "*File Information:*\n*File Name:* \`$FILE_NAME\`\n*File Size:* *$FILE_SIZE*\n*Upload Date:* \`$UPLOAD_DATE\`\n*Maintainer:* $MAINTAINER\n*Device:* *$DEVICE*\n*MD5 Sum:* \`$MD5_SUM\`\n*SHA1 Sum:* \`$SHA1_SUM\`",
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

echo " payload successfully created 'telegram_payload.json' (Timezone: $TZ)"

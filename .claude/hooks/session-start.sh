#!/bin/bash
set -euo pipefail

# Only run in Claude Code on the web (remote) sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

MISSING=()
command -v ffmpeg >/dev/null 2>&1 || MISSING+=(ffmpeg)
command -v node >/dev/null 2>&1 || MISSING+=(nodejs npm)
command -v python3 >/dev/null 2>&1 || MISSING+=(python3 python3-pip)

if [ ${#MISSING[@]} -gt 0 ]; then
  apt-get update
  apt-get install -y --no-install-recommends "${MISSING[@]}"
fi

pip3 install --break-system-packages -U openai-whisper

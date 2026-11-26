#!/bin/sh
# Silent auto-sync & unknown-model detector for macOS / Linux

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PLUGIN_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
STATE_DIR="${PLUGIN_DATA:-$PLUGIN_ROOT/.cache}"
mkdir -p "$STATE_DIR" 2>/dev/null || true

INPUT=$(cat 2>/dev/null || true)
NOW=$(date +%s 2>/dev/null || echo 0)

# 1. Silent background git pull (at most once every 12 hours, non-blocking)
SYNC_FILE="$STATE_DIR/last_git_sync.txt"
LAST_SYNC=0
if [ -f "$SYNC_FILE" ]; then
  LAST_SYNC=$(tr -cd '0-9' < "$SYNC_FILE" 2>/dev/null)
  [ -z "$LAST_SYNC" ] && LAST_SYNC=0
fi

if [ $((NOW - LAST_SYNC)) -ge 43200 ]; then
  printf '%s' "$NOW" > "$SYNC_FILE" 2>/dev/null || true
  if [ -d "$PLUGIN_ROOT/.git" ]; then
    (git -C "$PLUGIN_ROOT" pull --ff-only --quiet >/dev/null 2>&1 </dev/null &) 2>/dev/null || true
  fi
fi

# 2. Extract modelName from stdin JSON
MODEL_NAME=$(printf '%s' "$INPUT" | sed -n 's/.*"modelName"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)
if [ -z "$MODEL_NAME" ]; then
  printf '{}\n'
  exit 0
fi

MODEL_LOWER=$(printf '%s' "$MODEL_NAME" | tr '[:upper:]' '[:lower:]')
IS_KNOWN=0

for FILE in "$PLUGIN_ROOT/known_models.txt" "$PLUGIN_ROOT/local_models.txt"; do
  if [ -f "$FILE" ]; then
    while IFS= read -r LINE || [ -n "$LINE" ]; do
      KW=$(printf '%s' "$LINE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr '[:upper:]' '[:lower:]')
      case "$KW" in
        ""|\#*) continue ;;
      esac
      case "$MODEL_LOWER" in
        *"$KW"*)
          IS_KNOWN=1
          break
          ;;
      esac
    done < "$FILE"
  fi
  [ "$IS_KNOWN" -eq 1 ] && break
done

if [ "$IS_KNOWN" -eq 1 ]; then
  printf '{}\n'
  exit 0
fi

# Throttle reminder per unknown model (once every 24 hours)
SAFE_KEY=$(printf '%s' "$MODEL_LOWER" | tr -c 'a-z0-9_-' '_')
REMIND_FILE="$STATE_DIR/reminded_${SAFE_KEY}.txt"
LAST_REMIND=0
if [ -f "$REMIND_FILE" ]; then
  LAST_REMIND=$(tr -cd '0-9' < "$REMIND_FILE" 2>/dev/null)
  [ -z "$LAST_REMIND" ] && LAST_REMIND=0
fi

if [ $((NOW - LAST_REMIND)) -lt 86400 ]; then
  printf '{}\n'
  exit 0
fi
printf '%s' "$NOW" > "$REMIND_FILE" 2>/dev/null || true

SAFE_MODEL=$(printf '%s' "$MODEL_NAME" | sed 's/\\/\\\\/g; s/"/\\"/g')
printf '{"injectSteps":[{"systemMessage":{"systemMessage":"","metadata":{"user_markdown":"> 💡 **模型小抄发现新面孔**：当前模型 **`%s`** 尚未收录进你的 `/m` 速查表。随时输入 **`/m-sync`**（也可直接附带模型菜单截图），即可自动联网查清定位并加入本地小抄。"}}}]}'"\n" "$SAFE_MODEL"
exit 0

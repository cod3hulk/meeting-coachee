#!/bin/bash

# Config
AUDIO_DEVICE_INDEX=""
AUDIO_FILE="/tmp/audio.wav"
TRANSCRIPT_FILE="${AUDIO_FILE}.txt"
MODEL="gemma3:4b"
SILENCE_DB="-35dB"
SILENCE_DURATION="30"
SILENCE_LOG="/tmp/silence_detect.log"
OBS_PATH=""
WHISPER_HOME=""


# Create folder if needed
mkdir -p "$OBS_PATH"

TIMESTAMP=$(date "+%Y-%m-%d_%H-%M")
SUMMARY_FILE="$OBS_PATH/meeting-summary-$TIMESTAMP.md"

echo "🎙️ Recording... Will auto-stop after $SILENCE_DURATION seconds of silence."

# Clean up
rm -f "$AUDIO_FILE" "$TRANSCRIPT_FILE" "$SILENCE_LOG"

# Start main recording
ffmpeg -f avfoundation -i ":$AUDIO_DEVICE_INDEX" -ac 2 -ar 16000 -y -loglevel quiet "$AUDIO_FILE" &
RECORD_PID=$!

# Start silence detection
ffmpeg -f avfoundation -i ":$AUDIO_DEVICE_INDEX" -af "silencedetect=n=$SILENCE_DB:d=$SILENCE_DURATION" -t 3600 -f null - > "$SILENCE_LOG" 2>&1 &
SILENCE_PID=$!

# Monitor silence in background
(
  tail -n 0 -F "$SILENCE_LOG" | while read -r line; do
    if echo "$line" | grep -q "silence_end"; then
      echo "🔇 Silence detected. Stopping recording..."
      kill -INT $RECORD_PID >/dev/null 2>&1
      kill $SILENCE_PID >/dev/null 2>&1
      break
    fi
  done
) &

# Wait for recording to stop
wait $RECORD_PID

# Transcription
echo "📝 Transcribing..."
$WHISPER_HOME/build/bin/whisper-cli -f $AUDIO_FILE -otxt -m $WHISPER_HOME/models/ggml-large-v3-turbo.bin > /dev/null 2>&1

# Read transcript
TRANSCRIPT=$(cat "$TRANSCRIPT_FILE")

# Load prompt template and inject transcript
PROMPT_TEMPLATE=$(cat /Users/tave/Development/meeting-coachee/prompt.md)
FULL_PROMPT="${PROMPT_TEMPLATE//'{{TRANSCRIPT}}'/$TRANSCRIPT}"
echo $FULL_PROMPT

# Summarize using Ollama
echo "💡 Summarizing with structured prompt..."
SUMMARY=$(ollama run "$MODEL" "$FULL_PROMPT")

# Save to Obsidian
echo "🗃️ Saving to Obsidian: $SUMMARY_FILE"
echo "# 🧠 Meeting Summary ($TIMESTAMP)" > "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "## ✍️ Transcript" >> "$SUMMARY_FILE"
echo "$TRANSCRIPT" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"
echo "$SUMMARY" >> "$SUMMARY_FILE"

echo "✅ Done!"

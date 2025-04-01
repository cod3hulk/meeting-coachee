#!/bin/bash

# Config
AUDIO_DEVICE_INDEX="0"
AUDIO_FILE="audio.wav"
TRANSCRIPT_FILE="audio.txt"
MODEL="gemma3:12b"

echo "🎙️ Recording... Press Ctrl+C to stop."

# 1. Record until user interrupts
ffmpeg -f avfoundation -i ":$AUDIO_DEVICE_INDEX" -ac 2 -ar 16000 -y -loglevel quiet $AUDIO_FILE > /dev/null 2>&1

# 2. Transcribe
echo "📝 Transcribing with Whisper..."
whisper $AUDIO_FILE --model medium --language en --output_format txt

# 3. Summarize
echo "💡 Summarizing with Ollama..."
SUMMARY=$(ollama run $MODEL "Summarize key insights from the following meeting transcript and provide feedback:\n\n$(cat $TRANSCRIPT_FILE)")

echo -e "\n🧠 Summary:\n$SUMMARY"

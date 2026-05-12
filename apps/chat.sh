#!/bin/bash -eu

port="$(qwen36 get http.port)"
model_name="$(qwen36 get model-name 2>/dev/null || true)" # model name isn't always set

# Normally the OpenAI API is hosted under http://server:port/v1. In some cases like with OpenVINO Model Server it is under http://server:port/v3
api_base_path="$(qwen36 get http.base-path)"
if [ -z "$api_base_path" ]; then
  api_base_path="v1"
fi


export OPENAI_BASE_URL="http://localhost:$port/$api_base_path"
export MODEL_NAME="$model_name"

$SNAP/bin/go-chat-client

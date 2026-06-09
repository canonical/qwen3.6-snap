#!/bin/bash
set -euo pipefail

port="$(modelctl get webui.http.port)"
host="$(modelctl get webui.http.host)"

# Qwen3.6-35B-A3B is a text-only model
capabilities="text, text:markdown"

exec modelctl serve-webui "$SNAP/webui" --port "$port" --host "$host" --capabilities "$capabilities"

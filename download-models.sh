#!/bin/bash
#
# Download the Qwen3.6-35B-A3B UD-Q4_K_M model shards and the multimodal
# projector needed to build this snap.
#
# The model weights are pulled as pre-split GGUF shards (<5 GB each) from
# Hugging Face, so each shard fits into a snap component.  No local GGUF
# splitter is required.
#
# The multimodal projector (mmproj-F16.gguf) is not hosted on the same
# HF repo; provide its path via the MMPROJ_GGUF environment variable.
#
set -euo pipefail

HF_REPO="mrmara/Qwen3.6-35B-A3B-UD-Q4_K_M-5GB"
HF_BASE="https://huggingface.co/$HF_REPO/resolve/main"
MMPROJ_GGUF="${MMPROJ_GGUF:-./mmproj-F16.gguf}"
OUT_DIR="components/model-35b-a3b-ud-q4-k-m-gguf"
MMPROJ_OUT_DIR="components/mmproj-35b-a3b-f16-gguf"

if ! command -v wget >/dev/null 2>&1; then
  echo "error: wget not found on PATH (install it, e.g. apt install wget)." >&2
  exit 1
fi

# --- Download the 6 pre-split model shards ---
mkdir -p "$OUT_DIR"

echo "Downloading model shards from $HF_REPO ..."
for i in $(seq -w 1 6); do
  url="$HF_BASE/Qwen3.6-35B-A3B-UD-Q4_K_M-000$i-of-00006.gguf"
  dest="$OUT_DIR/Qwen3.6-35B-A3B-UD-Q4_K_M-000$i-of-00006.gguf"
  if [ -f "$dest" ]; then
    echo "  already present: $dest"
  else
    echo "  downloading: $url"
    wget --progress=dot:giga -O "$dest" "$url"
  fi
done

echo ""
ls -la "$OUT_DIR"

# --- Stage the multimodal projector (vision support) ---
if [ ! -f "$MMPROJ_GGUF" ]; then
  echo "error: mmproj GGUF not found: $MMPROJ_GGUF" >&2
  echo "Set MMPROJ_GGUF to the path of the Qwen3.6-35B-A3B mmproj-F16.gguf vision projector." >&2
  exit 1
fi

mkdir -p "$MMPROJ_OUT_DIR"
cp "$MMPROJ_GGUF" "$MMPROJ_OUT_DIR/mmproj-F16.gguf"

echo ""
ls -la "$MMPROJ_OUT_DIR"
echo ""
echo "All model and projector files are staged and ready for snap build."

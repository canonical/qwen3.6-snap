#!/bin/bash
#
# Prepare the Qwen3.6-35B-A3B UD-Q4_K_M model shards used to build this snap.
#
# The snap is packaged from a single-file GGUF that is split into 6 shards,
# each smaller than 5 GB, so the weights can be distributed as snap components.
#
# Provide the path to the full GGUF via the SOURCE_GGUF environment variable
# (default: ./Qwen3.6-35B-A3B-UD-Q4_K_M.gguf). The `llama-gguf-split` tool from
# llama.cpp must be available on PATH.
#
set -euo pipefail

SOURCE_GGUF="${SOURCE_GGUF:-./Qwen3.6-35B-A3B-UD-Q4_K_M.gguf}"
MMPROJ_GGUF="${MMPROJ_GGUF:-./mmproj-F16.gguf}"
OUT_DIR="components/model-35b-a3b-ud-q4-k-m-gguf"
MMPROJ_OUT_DIR="components/mmproj-35b-a3b-f16-gguf"
PREFIX="$OUT_DIR/Qwen3.6-35B-A3B-UD-Q4_K_M"

if ! command -v llama-gguf-split >/dev/null 2>&1; then
  echo "error: llama-gguf-split not found on PATH (install it from llama.cpp)." >&2
  exit 1
fi

if [ ! -f "$SOURCE_GGUF" ]; then
  echo "error: source GGUF not found: $SOURCE_GGUF" >&2
  echo "Set SOURCE_GGUF to the path of the full Qwen3.6-35B-A3B-UD-Q4_K_M.gguf file." >&2
  exit 1
fi

if [ ! -f "$MMPROJ_GGUF" ]; then
  echo "error: mmproj GGUF not found: $MMPROJ_GGUF" >&2
  echo "Set MMPROJ_GGUF to the path of the Qwen3.6-35B-A3B mmproj-F16.gguf vision projector." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

# Split into shards no larger than 4 GB, keeping each component under the
# snap store 5 GB component size limit. This produces the
# *-0000N-of-00006.gguf files referenced by snap/snapcraft.yaml.
llama-gguf-split --split --split-max-size 4G "$SOURCE_GGUF" "$PREFIX"

ls -la "$OUT_DIR"

# Stage the multimodal projector (vision support) into its component directory.
mkdir -p "$MMPROJ_OUT_DIR"
cp "$MMPROJ_GGUF" "$MMPROJ_OUT_DIR/mmproj-F16.gguf"

ls -la "$MMPROJ_OUT_DIR"

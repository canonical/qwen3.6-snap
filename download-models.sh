#!/bin/bash
 set -euo pipefail

sudo apt-get update
sudo apt-get install -y python3-venv

rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -U huggingface_hub

hf download inference-snaps/Qwen3.6-35B-A3B-UD-Q4_K_M-5GB \
    --local-dir components/model-35b-a3b-ud-q4-k-m-gguf
ls components/model-35b-a3b-ud-q4-k-m-gguf

# Qwen3.6 mmproj
wget -nv https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF/resolve/main/mmproj-F16.gguf \
    --directory-prefix=components/mmproj-35b-a3b-f16-gguf/

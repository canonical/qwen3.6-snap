SHELL := /bin/bash

# Always run `hf` via pipx to avoid relying on local `hf` installations.
hf := pipx run --spec "huggingface_hub[cli]" hf

SNAP_NAME ?= qwen3-6
ENGINE ?= cpu

.PHONY: all help init build install upload smoke-test install-deps init-submodules download-models \
	download-model-35b-a3b download-mmproj-35b-a3b

all: help

#
# Main targets
#

help: ## Show this help message
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@# List all targets with descriptions (lines starting with '##'):
	@grep -E '^[a-zA-Z0-9_-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-11s %s\n", $$1, $$2}'

init: init-submodules install-deps download-models ## Initialize the build environment (dependencies, model weights, submodules, etc.)

build: ## Build the snap
	./dev/build.sh

install: ## Install the snap
	./dev/install.sh

upload: ## Upload the snap
	./dev/upload.sh

smoke-test: ## Run smoke tests (override with SNAP_NAME=... ENGINE=...)
	sudo ./dev/smoke-test.sh $(SNAP_NAME) $(ENGINE)

#
# Supporting targets
#

install-deps:
	@echo "Installing dependencies..."
	@# Ensure pipx is available for running the hf CLI.
	@command -v pipx >/dev/null 2>&1 || { \
		sudo apt-get update; \
		sudo apt-get install -y pipx; \
	}

init-submodules:
	@echo "Initializing submodules..."
	@if git submodule status | grep -q '^-'; then \
		git submodule update --init; \
	fi

download-models: download-model-35b-a3b download-mmproj-35b-a3b

download-model-35b-a3b:
	@echo "Downloading Qwen3.6-35B-A3B-UD-Q4_K_M model weights..."
	$(hf) download inference-snaps/Qwen3.6-35B-A3B-UD-Q4_K_M-5GB \
		--local-dir components/model-35b-a3b-ud-q4-k-m-gguf

download-mmproj-35b-a3b:
	@echo "Downloading Qwen3.6-35B-A3B mmproj weights..."
	$(hf) download unsloth/Qwen3.6-35B-A3B-MTP-GGUF mmproj-F16.gguf \
		--local-dir components/mmproj-35b-a3b-f16-gguf/

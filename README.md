# Qwen3.6 Snap

This snap installs an optimized environment for inference with the Qwen3.6-35B-A3B Vision Language Model from Unsloth, quantized with UD-Q4_K_XL.

## Quick Start

```bash
# Install the snap
snap install qwen36

# The server will auto-start with the best engine for your hardware
# Check the status
snap logs qwen36.server

# Use the CLI to interact
qwen36 use-engine --auto

# Start the chat
qwen36 chat
```

## Engines

This snap supports the following hardware-specific engines:

- **cpu**: Uses CPU with llama.cpp (best balance of speed and accuracy)
- **cuda**: Uses NVIDIA GPU via CUDA (requires GPU with 10GB+ VRAM)

## Model

- **Model**: Qwen3.6-35B-A3B
- **Quantization**: UD-Q4_K_XL
- **Type**: Mixture of Experts (35B total / 3B activated parameters)
- **Context length**: 262144
- **Model size**: ~22 GB (UD-Q4_K_XL)
- **BF16 size**: ~69.4 GB (for reference)
- **License**: Apache-2.0

## Components

The snap uses snap components to independently install:
- Inference engine (llama.cpp)
- Model weights (Qwen3.6-35B-A3B-UD-Q4_K_XL)
- Multimodal projector (mmproj-F16)

## Configuration

```bash
# View current engine
qwen36 show-engine

# Change engine
qwen36 use-engine cpu
qwen36 use-engine cuda

# View/set configuration
qwen36 get http.port
qwen36 set http.port=8326
```

## License

- Snap packaging code: GPL-3.0
- Qwen3.6-35B-A3B model: Apache-2.0

# Qwen 3.6 snap
[![qwen3-6](https://snapcraft.io/qwen3-6/badge.svg)](https://snapcraft.io/qwen3-6)

This snap installs a hardware-optimized engine for inference with
Qwen3.6-35B-A3B, a multimodal (text + vision) Mixture-of-Experts
(35B total / 3B active) instruction-tuned large language model, quantized to
UD-Q4_K_M (GGUF).

## Resources

📚 **[Documentation](https://documentation.ubuntu.com/inference-snaps/)**, learn how to use inference snaps

💬 **[Discussions](https://github.com/canonical/inference-snaps/discussions)**, ask questions and share ideas

🐛 **[Issues](https://github.com/canonical/inference-snaps/issues)**, report bugs and request features

## Build and install from source

Clone this repo with its submodules:
```shell
git clone --recurse-submodules https://github.com/canonical/qwen3.6-snap
```

Prepare the required model shards and multimodal projector by running
`download-models.sh`. Everything is downloaded automatically from
Hugging Face:
```shell
./download-models.sh
```

Build the snap and its components:
```shell
snapcraft pack -v
```

Refer to the `./dev` directory for additional development tools.

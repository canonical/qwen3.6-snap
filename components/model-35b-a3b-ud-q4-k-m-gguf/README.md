# Qwen3.6-35B-A3B UD-Q4_K_M GGUF shards

This directory holds the model weight shards consumed by the snap build.

The full `Qwen3.6-35B-A3B-UD-Q4_K_M.gguf` model is split into 6 shards
(each < 5 GB so it fits within the snap component size limit):

```
Qwen3.6-35B-A3B-UD-Q4_K_M-00001-of-00006.gguf
Qwen3.6-35B-A3B-UD-Q4_K_M-00002-of-00006.gguf
Qwen3.6-35B-A3B-UD-Q4_K_M-00003-of-00006.gguf
Qwen3.6-35B-A3B-UD-Q4_K_M-00004-of-00006.gguf
Qwen3.6-35B-A3B-UD-Q4_K_M-00005-of-00006.gguf
Qwen3.6-35B-A3B-UD-Q4_K_M-00006-of-00006.gguf
```

The `.gguf` files are not tracked in git. Generate them before building by
running `download-models.sh` from the repository root (see that script for
details).

#!/bin/bash -eu
# Entry point used by the CI build workflow (init-build-script).
# Delegates to the Makefile which downloads all model components.
make download-models

#!/bin/bash

_qwen36_completion() {
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "$($SNAP/bin/qwen36 completion bash 2>/dev/null)" -- "$cur") )
    return 0
}

complete -F _qwen36_completion qwen36

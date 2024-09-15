#!/bin/sh
set -euo pipefail
OPENAI_API_KEY=$(<"{{ ansible_env.HOME }}/.config/helix/openai.key")
export OPENAI_API_KEY
exec helix-gpt --handler openai

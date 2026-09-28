#!/usr/bin/env bash
set -euo pipefail

curl --fail --silent --show-error --retry 5 --retry-delay 2 http://127.0.0.1/ >/dev/null

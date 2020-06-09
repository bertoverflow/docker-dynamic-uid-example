#!/usr/bin/env bash

set -euo pipefail

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"

useradd --uid $USER_ID --shell /bin/bash --non-unique --create-home user

exec gosu user "$@"

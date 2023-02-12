#!/bin/bash

set -e

work_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# List of keys that are missing, which is expected to be missing
MISSING_KEYS_CMD=(
    -e problems.show.languages.en
    -e problems.show.languages.ru
    -e problems.show.languages.uk
    -e activerecord.attributes.user.username
)

LOCALES_CMD=(bundle exec i18n-tasks missing)

(
    cd "${work_dir}/.."
    missing_cnt="$("${LOCALES_CMD[@]}" --format keys | grep --invert-match "${MISSING_KEYS_CMD[@]}" | wc -l)"
    if [ "${missing_cnt}" -gt 0 ]; then
        "${LOCALES_CMD[@]}" 2>/dev/null | grep --invert-match "${MISSING_KEYS_CMD[@]}"
        exit 1
    else
        echo "OK!"
        exit 0
    fi
)

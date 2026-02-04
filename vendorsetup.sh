#!/bin/bash

# be strict on failures
set -euo pipefail

echo "vendor/partner_gms/vendorsetup.sh called"

get_microg_files() {
    local trg_name src_name src_url
    trg_name="${1}"
    src_name="${2}"
    src_url=$(curl --fail --silent --show-error https://api.github.com/repos/microg/GmsCore/releases/latest | grep -E "/${src_name}-[0-9]+.apk\"" | cut -d"\"" -f4)
    curl --fail --silent --show-error --location "${src_url}" --output "$(dirname "${BASH_SOURCE[0]}")"/"${trg_name}"/"${trg_name}".apk
}

get_fdroid_files() {
    local trg_name src_name
    trg_name="${1}"
    src_name="${2}"
    curl --fail --silent --show-error https://f-droid.org/"${src_name}".apk --output "$(dirname "${BASH_SOURCE[0]}")"/"${trg_name}"/"${trg_name}".apk
}

get_microg_files GmsCore "com.google.android.gms"
get_microg_files FakeStore "com.android.vending"

get_fdroid_files FDroid F-Droid

set +euo pipefail

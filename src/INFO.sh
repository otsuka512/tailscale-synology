#!/bin/bash

VERSION=$1
ARCH=$2
PKG_SIZE=$3
DSM_VERSION=$4

TIMESTAMP=$(date -u +%Y%m%d-%H:%M:%S)

# architecture taken from:
# https://github.com/SynoCommunity/spksrc/wiki/Synology-and-SynoCommunity-Package-Architectures
# https://github.com/SynologyOpenSource/pkgscripts-ng/tree/master/include platform.<PLATFORM> files
case $ARCH in
amd64)
  PLATFORMS="x86_64"
  ;;
386)
  PLATFORMS="i686"
  ;;
arm64)
  PLATFORMS="armv8"
  ;;
arm)
  PLATFORMS="armv7"
  ;;
  # TODO, each separate: armada370, armada375, armada38x, armadaxp, comcerto2k, monaco
*)
  echo "Unsupported architecture: ${ARCH}"
  exit 1
  ;;
esac

if [ "$DSM_VERSION" = "6" ]; then
  os_min_ver="6.0.1-7445"
  os_max_ver="7.0-40000"
else
  os_min_ver="7.0-40000"
  os_max_ver=""
fi

cat <<EOF
package="Tailscale"
version="${VERSION}"
arch="${PLATFORMS}"
description="Connect all your devices using WireGuard, without the hassle."
displayname="Tailscale"
maintainer="Tailscale"
maintainer_url="https://github.com/tailscale/tailscale-synology"
create_time="${TIMESTAMP}"
dsmuidir="ui"
dsmappname="SYNO.SDS.Tailscale"
startstop_restart_services="nginx"
os_min_ver="${os_min_ver}"
os_max_ver="${os_max_ver}"
extractsize="${PKG_SIZE}"
EOF

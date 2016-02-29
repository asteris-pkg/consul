#/usr/bin/env bash
set -e

CONSUL_VERSION=${1:-"0.6.3"}
ALPINE_VERSION=${2:-"3.3"}

if [ "$EUID" -ne 0 ]; then
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

# start the build with an empty ACI
acbuild begin

# stop build automatically
acbuildEnd() {
    export EXIT=$?
    acbuild end && exit $EXIT
}
trap acbuildEnd EXIT

# name
acbuild set-name pkg.aster.is/aci/consul

# based on alpine
acbuild dep add pkg.aster.is/aci/alpine:${ALPINE_VERSION}
acbuild run -- apk add --no-cache openssl ca-certificates

# install consul
acbuild run -- wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
acbuild run -- wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS
acbuild run -- /bin/sh -c "grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c"
acbuild run -- unzip -d /usr/bin consul_${CONSUL_VERSION}_linux_amd64.zip

# add ports
acbuild port add dns tcp 8600
acbuild port add http tcp 8500
acbuild port add rpc tcp 8400
acbuild port add serf-lan tcp 8301
acbuild port add serf-wan tcp 8302
acbuild port add server-rpc tcp 8300

# add mounts
acbuild mount add config /etc/consul
acbuild mount add data /var/lib/consul

# run consul
acbuild set-exec -- /usr/bin/consul agent -data-dir=/var/lib/consul -client=127.0.0.1 -config-dir=/etc/consul

# clean up
acbuild run -- rm consul_${CONSUL_VERSION}_linux_amd64.zip
acbuild run -- rm consul_${CONSUL_VERSION}_SHA256SUMS
acbuild run -- apk del --purge --rdepends openssl

# save the ACI
acbuild write --overwrite consul-${CONSUL_VERSION}-linux-amd64.aci

ALPINE_VERSION := 3.3
CONSUL_VERSION := 0.6.3
SIGNING_KEY    := 17BE6741
.PHONY=all

all: consul-${CONSUL_VERSION}-linux-amd64.aci consul-${CONSUL_VERSION}-linux-amd64.aci.asc

consul-%-linux-amd64.aci:
	./build.sh $* ${ALPINE_VERSION}

consul-%-linux-amd64.aci.asc: consul-%-linux-amd64.aci
	gpg --default-key ${SIGNING_KEY} --detach-sign --output $@ --armor $^

# Consul

This repo packages [Consul](https://www.consul.io) for use in
[rkt](https://coreos.com/rkt)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Consul](#consul)
    - [Use](#use)
    - [Hacking](#hacking)
    - [License](#license)

<!-- markdown-toc end -->

## Use

This image comes with two data volumes:

- `config`: holds what you'd expect in `/etc/consul/` - you'd drop your
  `consul.json` in here.
- `data`: holds the data for consul, what's stored at `/var/lib/consul` in an
  on-host installation.

Since Consul typically makes up the lowest level of service discovery in a
cluster, it makes sense to run it in the host network for easier discovery.
Here's how you'd do that:

```
rkt --net=host \
    --volume=config,kind=host,source=/etc/consul/config \
    --volume=data,kind=host,source=/var/lib/consul \
    run pkg.aster.is/aci/consul:0.6.3 -- --bind=your.private.ip.here
```

## Hacking

With [`acbuild`](https://github.com/appc/acbuild) installed, run `make
consul-{YOUR_VERSION}-linux-amd64.aci` or `make all CONSUL_VERSION=0.6.3` to
create and sign.

## License

See [LICENSE](LICENSE).

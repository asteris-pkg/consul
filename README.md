# Consul

This repo packages [Consul](https://www.consul.io) for use in
[rkt](https://coreos.com/rkt)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Alpine Docker to rkt Conversion](#alpine-docker-to-rkt-conversion)
    - [Use](#use)
    - [Hacking](#hacking)
    - [License](#license)

<!-- markdown-toc end -->

## Use

```
rkt fetch pkg.aster.is/aci/consul:0.6.3
```

## Hacking

With [`acbuild`]() installed, run `make alpine-{YOUR_VERSION}-linux-amd64.aci`
or `make all CONSUL_VERSION=3.3`

## License

See [LICENSE](LICENSE).

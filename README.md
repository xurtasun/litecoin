# DevOps  Litecoin

## Dockerfile
The dockerfile build a litecoin `v0.18.1` image base on `alpine`.
It installs:

 - `litecoin:0.18.1`
 - `glibc:2.34-r0`

The `entrypoint.sh` has been copied from [uphold project](https://github.com/uphold/docker-litecoin-core/blob/master/0.18/docker-entrypoint.sh).

You can check security vulnerabilities with any `sec-tool` (ie. [trivy](https://github.com/aquasecurity/trivy))

    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy ${imageName:imageTag}

# DevOps  Litecoin

  

## T1 Dockerfile
`./Dockerfile`

The dockerfile build a litecoin `v0.18.1` image base on `alpine`.
It installs:

 - `litecoin:0.18.1`
 - `glibc:2.34-r0`

The `entrypoint.sh` has been copied from [uphold project](https://github.com/uphold/docker-litecoin-core/blob/master/0.18/docker-entrypoint.sh).

You can check security vulnerabilities with any `sec-tool` (ie. [trivy](https://github.com/aquasecurity/trivy))

    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy ${imageName:imageTag}

## T2 K8s
`k8s`

The `kubernetes` resource has been create with `helm` templates found in `./k8s/templates`. The parameters are defined in `./k8s/values.yaml`

To validate the resources run `helm lint k8s`

To deploy to a valid `k8s cluster` run: `helm install v1 k8s`

## T3 Deployment Pipeline
`./deploy`

I have used declarative `Jenkinsfile` located in `./deploy/Jenkinsfile`

The steps it follows are the next:

 1. Clone this repo to the agent defined
 2. Build the `./Dockerfile`
 3. Push to my own registry `xurtasun` located in docker hub. This should change in order to use your own image.
 4. Deploy to valid k8s cluster. This pipeline suppose that the agent has `kubectl context` over cluster.
 5. Remove the local `docker images` from the agent.

## T4 Scripting Bash
`./scripts/bash`

I used a public url `https://jsonplaceholder.typicode.com/comments` that response a json to parse the objects inside. Using `grep` | `awk` | `sed`


## T5 Scripting Python

`./scripts/python`

I used a public url `https://jsonplaceholder.typicode.com/comments` that response a json to parse the objects inside. Using `requests` and `json` parser

## T6 Terraform

`./terraform`

Using terraform to create `iam` resources.
Created a module with two variables `name` and `environment` to create all the resources.

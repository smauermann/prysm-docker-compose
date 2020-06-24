Credits for the bootstrapping Docker via Ansible: https://ops.tips/blog/docker-ansible-role/ 
# Packer
Builds an image ready to run `prysm-docker-compose`. During build, we install:
- git
- Docker
- docker-compose

Installation (macOS):
```shell
$ brew install packer
```

Packer will spin up a build machine, provide connection via SSH and execute the selected provisioner.

# Ansible
Ansible is used as remote provisioner here, and will perform all setup steps defined in `playbook.yml` on the build machine.
For remote provisioning, we need to install Ansible on our local machine.

Installation:
1. Standard `pip` install:
    ```shell
    $ pip install --user ansible
    ```
2. The [`pipx`](https://pipxproject.github.io/pipx/) way without messing with your default python environment:  
    ```shell
    $ brew install pipx && pipx ensurepath
    $ pipx install ansible
    ```
# Build the Image
1. Setup AWS credentials
    ```shell
    $ aws configure
    ```
2. Run packer
    ```shell
    $ packer build ec.json
    ```
3. We now have an AMI ready for running an ETH2 staking node on AWS EC2.

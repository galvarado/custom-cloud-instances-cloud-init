# Cloud custom instances with cloud-init

Repo that shows how to use cloud-init with Terraform and Vagrant. Cloud-init is the industry standard multi-distribution method for cross-platform cloud instance initialization. It is supported across all major public cloud providers, provisioning systems for private cloud infrastructure, and bare-metal installations.

Cloud-init files are essentially bootstrap codes, that run before each startup, and can - among others - modify files, set up services, create users, etc. Combined with terraform are a powerful solution for Infrastructure as Code . To tests test a cloud-init file locally wihout spin up real cloud instances we can use Vagrant.

## How to use it

### Prerequisites

Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) and [Vagrant](https://www.vagrantup.com/docs/installation).

Vagrant needs a Hypervisor, the most used is [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

### Cloud-init config file

### How to test it with Vagrant

### How to provision a customized instance on AWS with Terraform
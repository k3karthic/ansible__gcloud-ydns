# Ansible - Dynamic DNS using YDNS

The Ansible playbook in this repository installs and periodically runs a [bash script](https://github.com/k3karthic/bash-updater/tree/gcloud) which sends the public IP to [YDNS](https://ydns.io/) which is a free dynamic DNS service. 

The playbook assumes the instance runs in Google Cloud using the terraform scripts below,
* [https://github.com/k3karthic/terraform__gcloud-instance](https://github.com/k3karthic/terraform__gcloud-instance).

## Requirements

Install the following Ansible modules before running the playbook,
```
ansible-galaxy collection install google.cloud
ansible-galaxy collection install community.general
```

## Dynamic Inventory

This playbook uses the Google [Ansible Inventory Plugin](https://docs.ansible.com/ansible/latest/collections/google/cloud/gcp_compute_inventory.html) to populate public FreeBSD instances dynamically.

Public instances with a YDNS hostname are assumed to have a label `ydns_host: yes` and a metadata entry `ydns_host: <hostname>`.

## Playbook Configuration

1. Create `inventory/google.gcp_compute.yml` based on `inventory/google.gcp_compute.yml.sample`
    1. specify the project id
    1. specify the zone where you have deployed your server on Google Cloud.
    1. Configure the authentication
1. Set username and ssh authentication in `inventory/group_vars/
1. Set username and password for YDNS in `inventory/group_vars/all.yml` using the sample `inventory/group_vars/all.yml.sample`.

## Deployment

Run the playbook using the following command,
```
./bin/apply.sh
```

## Encryption

Sensitive files like the SSH private keys are encrypted before being stored in the repository.

You must add the unencrypted file paths to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```

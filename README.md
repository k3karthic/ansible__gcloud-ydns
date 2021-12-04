# Ansible - Dynamic DNS using YDNS

This playbook runs a [bash script](https://github.com/k3karthic/bash-updater/tree/gcloud) which sends the public IP of an instance on Oracle Cloud to [YDNS](https://ydns.io/).

**Assumption:** Create an instance using one of the Terraform scripts below,
* terraform__gcloud-instance
	* GitHub: [github.com/k3karthic/terraform__gcloud-instance](https://github.com/k3karthic/terraform__gcloud-instance)
	* Codeberg: [codeberg.org/k3karthic/terraform__gcloud-instance](https://codeberg.org/k3karthic/terraform__gcloud-instance)

## Code Mirrors

* GitHub: [github.com/k3karthic/ansible__gcloud-ydns](https://github.com/k3karthic/ansible__gcloud-ydns/)
* Codeberg: [codeberg.org/k3karthic/ansible__gcloud-ydns](https://codeberg.org/k3karthic/ansible__gcloud-ydns)

## Requirements

Install the following before running the playbook,
```
ansible-galaxy collection install community.general
pip install google-auth requests
ansible-galaxy collection install google.cloud
```

## Dynamic Inventory

The Google [Ansible Inventory Plugin](https://docs.ansible.com/ansible/latest/collections/google/cloud/gcp_compute_inventory.html) populates public FreeBSD instances.

The target FreeBSD instances must have the label `yidns_host: yes` and a metadata entry `ydns_host: <hostname>`.

## Playbook Configuration

1. Create `inventory/google.gcp_compute.yml` based on `inventory/google.gcp_compute.yml.sample`
    1. Specify the project ID 
    1. Specify the zone where you have deployed your server on Google Cloud
    1. Configure the authentication
1. Set username and ssh authentication in `inventory/group_vars/
1. Set username and password for YDNS in `inventory/group_vars/ydns.yml` using the sample `inventory/group_vars/ydns.yml.sample`.

## Deployment

Run the playbook using the following command,
```
./bin/apply.sh
```

## Encryption

Encrypt sensitive files (SSH private keys) before saving them. `.gitignore` must contain the unencrypted file paths.

Use the following command to decrypt the files after cloning the repository,

```
$ ./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
$ ./bin/encrypt.sh <gpg key id>
```

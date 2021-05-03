#!/usr/bin/env bash

ansible-playbook -i inventory/google.gcp_compute.yml site.yml

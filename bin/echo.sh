#!/usr/bin/env bash

ansible all -i inventory/google.gcp_compute.yml -a "/bin/echo hello"

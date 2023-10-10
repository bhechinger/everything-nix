#!/usr/bin/env bash

for host in config/host_keys/*; do
  if [ ! -f ${host}/ssh_host_dsa_key ]; then
    ssh-keygen -q -N "" -t dsa -f ${host}/ssh_host_dsa_key
  fi

  if [ ! -f ${host}/ssh_host_rsa_key ]; then
    ssh-keygen -q -N "" -t rsa -b 4096 -f ${host}/ssh_host_rsa_key
  fi

  if [ ! -f ${host}/ssh_host_ecdsa_key ]; then
    ssh-keygen -q -N "" -t ecdsa -f ${host}/ssh_host_ecdsa_key
  fi

  if [ ! -f ${host}/ssh_host_ed25519_key ]; then
    ssh-keygen -q -N "" -t ed25519 -f ${host}/ssh_host_ed25519_key
  fi
done

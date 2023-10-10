#!/usr/bin/env bash

cd config || exit

for host in host_keys/*; do
  echo "Generating password for ${host}"
	nix run github:ryantm/agenix -- -e wonko_password-"$(basename ${host})".age -i "${host}"/ssh_host_ed25519_key
done

cp wonko_password-*.age ../../../everything-nix/hosts/nixos/common/users/

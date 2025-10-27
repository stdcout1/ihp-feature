#!/bin/sh

echo "=== Setting up cachix ==="
cachix use cachix
cachix use digitallyinduced

echo "=== Installing direnv ==="
sudo apt update
sudo apt install -y direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

echo "=== Setting IHP BASEURL ==="
echo 'export IHP_BASEURL=$(if [ -n "${CODESPACE_NAME}" ]; then echo "https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"; else echo "http://localhost:8000"; fi)' >> ~/.bashrc

echo "=== Setting IHP IDE BASEURL ==="
echo 'export IHP_IDE_BASEURL=$(if [ -n "${CODESPACE_NAME}" ]; then echo "https://${CODESPACE_NAME}-8001.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"; else echo "http://localhost:8001"; fi)' >> ~/.bashrc

echo "=== Fixing Nix permissions ==="
sudo apt install -y acl
sudo setfacl -k /tmp

echo "=== Allowing direnv for /workspaces ==="
mkdir -p ~/.config/direnv
touch ~/.config/direnv/direnv.toml
echo "[whitelist]
prefix = ['/workspaces/']" >> ~/.config/direnv/direnv.toml

echo "=== Prefetching IHP flake ==="
nix build --accept-flake-config --impure github:digitallyinduced/ihp-boilerplate#devShells.x86_64-linux.default --no-link

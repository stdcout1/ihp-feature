#!/bin/sh

nix profile add nixpkgs#direnv
nix profile add nixpkgs#cachix
nix profile add nixpkgs#devenv
mkdir -p ~/.config/direnv && echo '[whitelist]\nprefix = ["/workspaces/"]' > ~/.config/direnv/direnv.toml
echo '\\neval \"$(direnv hook bash)\"' >> ~/.bashrc
echo 'export IHP_BASEURL=$(if [ -n \"${CODESPACE_NAME}\" ]; then echo \"https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}\"; else echo \"http://localhost:8000\"; fi)' >> ~/.bashrc
echo 'export IHP_IDE_BASEURL=$(if [ -n \"${CODESPACE_NAME}\" ]; then echo \"https://${CODESPACE_NAME}-8001.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}\"; else echo \"http://localhost:8001\"; fi)' >> ~/.bashrc
direnv allow
nix develop --accept-flake-config --impure


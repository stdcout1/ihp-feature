#!/bin/sh

# nix profile add nixpkgs#direnv
nix profile add nixpkgs#cachix
cachix use cachix
cachix use digitallyinduced
mkdir -p ~/.config/direnv && echo '[whitelist]\nprefix = ["/workspaces/"]' > ~/.config/direnv/direnv.toml
# echo '\\neval \"$(direnv hook bash)\"' >> ~/.bashrc
echo 'export IHP_BASEURL=$(if [ -n \"${CODESPACE_NAME}\" ]; then echo \"https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}\"; else echo \"http://localhost:8000\"; fi)' >> ~/.bashrc
echo 'export IHP_IDE_BASEURL=$(if [ -n \"${CODESPACE_NAME}\" ]; then echo \"https://${CODESPACE_NAME}-8001.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}\"; else echo \"http://localhost:8001\"; fi)' >> ~/.bashrc
echo "prefetching..."
nix build --accept-flake-config --impure github:digitallyinduced/ihp-boilerplate#devShells.x86_64-linux.default --no-link


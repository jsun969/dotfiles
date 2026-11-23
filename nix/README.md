# Nix Config

> SteamOS Only

## Soft Link

- `nix` -> `~/.config/nix`
- `home-manager` -> `~/.config/home-manager`

## Installation (SteamOS)

1. Install Nix with offical installer

```sh
sudo chown deck:deck /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

2. Setup bash for Konsole

```sh
echo '[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh' >> ~/.bashrc
```

3. Clone and link folders

4. Apply Home Manager

```sh
nix run home-manager/master -- switch
```

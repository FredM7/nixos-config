# Fred's NixOS Configurations

## Setting up a new machine:

> I'm assuming you come from the default NixOS GNOME install.

1. Clone this repository.
2. Copy your `/etc/nixos/hardware-configuration.nix` to the `<repo>/src/hardware-configuration.nix`
3. In the `<repo>/flake.nix` make sure you change the `username` to the one you used when you installed NixOS.
4. Rebuild the system with `sudo nixos-rebuild switch --flake '.#fred'`. Just replace `fred` with your username.
5. TO BE CONTINUED...

## Issues

### Keystore/Keyring

If keystore keeps asking for a password, it means it could not be unlocked automatically, we can delete the keyring file to fix this. Next time, when asked for a password, leave the password EMPTY - so that the Display Manager can unlock it on auto-login.

Delete the `login.keyring` file:

```
rm .local/share/keyrings/login.keyring
```

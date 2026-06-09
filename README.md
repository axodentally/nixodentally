# nixodentally --- axo's personal NixOS and Home Manager configurations

My [dendritic](https://github.com/mightyiam/dendritic) NixOS & Home Manager configuration, inspired by [Doc-Steve/dendritic-design-with-flake-parts](https://github.com/Doc-Steve/dendritic-design-with-flake-parts) and built with [flake-parts](https://flake.parts).

## Hosts

| Host      | Type              | User    | Description                                       |
| --------- | ----------------- | ------- | ------------------------------------------------- |
| `chalco`  | NixOS + HM        | `axo`   | AMD laptop running GNOME with a full desktop suite |
| `axobuntu` | HM standalone    | `esaxo` | Headless server, Home Manager only                 |

## Directory structure

| Path                    | Purpose                                                                 |
| ----------------------- | ----------------------------------------------------------------------- |
| `flake.nix`             | Top-level flake, using `import-tree ./modules`                          |
| `modules/flake-parts/`  | flake-parts setup and small helpers                                     |
| `modules/hosts/`        | Host config, specifying the modules to use for each host                |
| `modules/system/`       | System-level modules: settings, peripherals, secrets, virtualisation    |
| `modules/users/`        | User definitions                                                        |
| `modules/programs/`     | Application modules: (shell, dev, browser, ...)                         |
| `flakes/`               | Local flake inputs for custom packages and patches                      |

## How modules work

Every `.nix` file under `modules/` is automatically discovered by [import-tree](https://github.com/vic/import-tree) — no manual import lists.

Each file can declare module entries under `flake.modules.nixos.<name>`, `flake.modules.homeManager.<name>`, or both.
This means a single file (e.g. `firefox.nix`) can contribute Firefox policies at the NixOS level and Firefox user configuration at the Home Manager level simultaneously.

### Hosts

Host definitions are minimal. Each host's `config.nix` simply imports the discovered module names it needs, then calls the appropriate helper from `flake-parts/lib.nix`:

- `mkNixos` — wraps a NixOS module list into a `nixosSystem` configuration
- `mkHomeManager` — wraps a Home Manager module list into a
  `homeManagerConfiguration` (for standalone HM hosts)

This keeps host files declarative and focused on *which* modules to combine, not *how* to wire them together.

### System types

System types cascade, each building on the previous:

```
system-default → system-essential → system-desktop
```

| Type               | Inherits from       | Adds                                                |
| ------------------ | ------------------- | --------------------------------------------------- |
| `system-default`   | —                   | Locale, unfree packages, flakes, unstable overlay   |
| `system-essential` | `system-default`    | systemd-boot                                        |
| `system-desktop`   | `system-essential`  | CUPS, fwupd, bluetooth, NetworkManager, PipeWire    |

NixOS hosts import the system type they need; HM hosts that share the same machine import the matching HM counterpart (e.g. `system-desktop`'s HM counterpart enables Flatpak user integration).

## Secrets

Secrets are stored encrypted in a private flake input, so that even the encrypted secrets are not publically available, and decrypted on activation using [sops-nix](https://github.com/Mic92/sops-nix).
I inherited this design from the awesome [NixOS Secrets Management Guide](https://unmovedcentre.com/posts/secrets-management/), with the following repository roughly representing how my nix-secrets repo looks like: [nix-secrets refererence](https://github.com/EmergentMind/nix-secrets-reference/tree/complex).


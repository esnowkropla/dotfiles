# Per-host configuration

Shared config lives at the repo root. Anything that differs between machines
lives here, keyed by short hostname (`hostname -s`).

- `<host>.sh` is sourced at the end of `bashrc` if it exists. PATH additions,
  aliases, and environment variables that only make sense on one machine go here.
- `gitconfig-<host>` holds the `[user]` identity. `gitconfig` includes
  `~/.gitconfig.local`, so on each machine link it once:

      ln -s ~/dotfiles/hosts/gitconfig-$(hostname -s) ~/.gitconfig.local

Scripts that depend on what is installed (e.g. docker vs podman) should detect
it at runtime rather than branch on hostname; see `docker/run_pg.sh`.

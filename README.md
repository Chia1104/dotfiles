# Dotfiles

Personal macOS development environment configuration files, managed with symlinks.

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc          # Zsh main configuration
│   ├── .p10k.zsh       # Powerlevel10k prompt theme
│   ├── .zshenv         # Zsh environment variables
│   └── .zprofile       # Zsh login shell config
├── git/
│   └── .gitconfig      # Git configuration
├── config/
│   ├── gh/             # GitHub CLI config
│   │   ├── config.yml
│   │   └── hosts.yml
│   └── fish/           # Fish shell config
│       └── conf.d/
│           └── uv.env.fish
├── .gitignore
├── install.sh          # Symlink installer script
└── README.md
```

## Installation

```sh
git clone https://github.com/Chia1104/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The install script will:

1. Create symlinks from the repo files to their expected locations in `$HOME`
2. Automatically back up any existing files to `*.backup` before overwriting
3. Skip any source files that don't exist

## What's Included

### Zsh (`.zshrc`)

- [Oh My Zsh](https://ohmyz.sh/) with plugins: `git`, `vscode`, `npm`, `docker`, `brew`
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt theme
- Centralized `PATH` management with `typeset -U` (auto-dedup)
- Lazy-loaded [NVM](https://github.com/nvm-sh/nvm) for faster shell startup
- [SDKMAN](https://sdkman.io/) for Java version management
- Environment setup for: pnpm, Android Studio, Ruby, PostgreSQL

### Git (`.gitconfig`)

- Git LFS configuration
- User identity

### GitHub CLI (`config/gh/`)

- Default protocol and account settings

## Prerequisites

- [Homebrew](https://brew.sh/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) — cloned to `~/powerlevel10k`
- [NVM](https://github.com/nvm-sh/nvm)
- [SDKMAN](https://sdkman.io/) (via Homebrew: `brew install sdkman-cli`)

## Adding New Dotfiles

1. Copy the config file into the appropriate directory in this repo
2. Add a `link_file` call in `install.sh`
3. Re-run `./install.sh`

## Restoring Backups

If the install script backed up an existing file, you can restore it:

```sh
mv ~/.zshrc.backup ~/.zshrc
```

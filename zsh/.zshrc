# ============================================================================
# Powerlevel10k instant prompt
# ============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# Oh My Zsh
# ============================================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme

plugins=(git vscode npm docker brew)

source "$ZSH/oh-my-zsh.sh"

# ============================================================================
# PATH (typeset -U)
# ============================================================================

typeset -U path

path=(
  /opt/homebrew/bin
  /opt/homebrew/opt/postgresql@16/bin
  /opt/homebrew/opt/ruby/bin
  $HOME/.console-ninja/.bin
  $HOME/.ex-i18n
  $HOME/.gem/bin
  $HOME/.antigravity/antigravity/bin
  $HOME/Library/pnpm
  $HOME/Library/Android/sdk/emulator
  $HOME/Library/Android/sdk/platform-tools
  $path
)

# ============================================================================
# Env
# ============================================================================

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# Android Studio
export ANDROID_HOME="$HOME/Library/Android/sdk"

# Java (zulu 17)
export JAVA_HOME="/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/17.0.17.fx-zulu"

# Ruby
export GEM_HOME="$HOME/.gem"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# PostgreSQL / Ruby - Flags
export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib -L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include -I/opt/homebrew/opt/ruby/include"

# ============================================================================
# NVM
# ============================================================================

export NVM_DIR="$HOME/.nvm"

if [[ -d "$NVM_DIR/versions/node" ]]; then
  NODE_DEFAULT_DIR="$NVM_DIR/alias/default"
  if [[ -f "$NODE_DEFAULT_DIR" ]]; then
    NODE_VERSION=$(cat "$NODE_DEFAULT_DIR")
    NODE_BIN="$NVM_DIR/versions/node/v${NODE_VERSION#v}/bin"
    [[ -d "$NODE_BIN" ]] && path=($NODE_BIN $path)
  else
    NODE_LATEST_BIN=$(ls -d "$NVM_DIR/versions/node"/*/bin 2>/dev/null | tail -1)
    [[ -n "$NODE_LATEST_BIN" ]] && path=($NODE_LATEST_BIN $path)
  fi
fi

_load_nvm() {
  unfunction nvm 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() { _load_nvm; nvm "$@"; }

# ============================================================================
# SDKMAN
# ============================================================================

export SDKMAN_DIR="/opt/homebrew/opt/sdkman-cli/libexec"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# ============================================================================
# Others
# ============================================================================

# local bin env
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Yarn Switch
[[ -f "$HOME/.yarn/switch/env" ]] && source "$HOME/.yarn/switch/env"

# ============================================================================
# Powerlevel10k config
# ============================================================================

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

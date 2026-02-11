# ~/.zshrc (macOS)

# ---- Zinit bootstrap (macOS + zsh 5.9+) ----
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname "$ZINIT_HOME")"
[[ ! -d "$ZINIT_HOME/.git" ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ---- Homebrew (Apple Silicon + Intel) ----
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ---- Starship prompt ----
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ---- fzf (Homebrew) key-bindings + completion ----
# Prefer brew's fzf scripts; fall back to common mac locations.
for p in \
  /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
  /opt/homebrew/opt/fzf/shell/completion.zsh \
  /usr/local/opt/fzf/shell/key-bindings.zsh \
  /usr/local/opt/fzf/shell/completion.zsh
do
  [[ -r "$p" ]] && source "$p"
done

# ---- Completions ----
autoload -U compinit && compinit

# ---- ZSH plugins (zinit) ----
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# Recommended to load syntax-highlighting last
zinit light zsh-users/zsh-syntax-highlighting

# ---- History ----
HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.zsh_history"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ---- Keybinds ----
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ---- Completion styling ----
# macOS often lacks LS_COLORS by default; only apply if set.
if [[ -n "$LS_COLORS" ]]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# ---- Aliases ----
if command -v lsd >/dev/null 2>&1; then
  alias ll='lsd -l'
  alias lla='lsd -la'
fi


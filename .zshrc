# Created by newuser for 5.9
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
if [[ "$(uname -s)" == "Darwin" ]] && [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
# fzf key-bindings + completion (works with older fzf)
if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [[ -r /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi

# ZSH plugins 
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# Load completions
autoload -U compinit && compinit

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion styling
zstyle ':completion:*' list-color "${(s.:.)LS_COLORS}"



# Alias
alias ll='lsd -l'
alias lla='lsd -la'
alias bat='batcat'

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
# export MAMBA_EXE='/usr/local/bin/micromamba';
# export MAMBA_ROOT_PREFIX='/Users/omar/micromamba';
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
    # eval "$__mamba_setup"
# else
    # alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
# fi
# unset __mamba_setup
# <<s< mamba initialize <<<



# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download zinit if it's not already present
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# fix for https://github.com/zdharma-continuum/zinit/pull/708/commits/88a9ff98ace5058abe0f86410ac79de3d5c2c008
# Create "$ZSH_CACHE_DIR/completions" directory
[[ ! -d "$ZSH_CACHE_DIR/completions" ]] && command mkdir -p "$ZSH_CACHE_DIR/completions"
# Add "$ZSH_CACHE_DIR/completions" diretory to fpath
[[ -z ${fpath[(re)$ZSH_CACHE_DIR/completions]} ]] && fpath=( "$ZSH_CACHE_DIR/completions" "${fpath[@]}" )

# Use zinit to load plugins with a shallow clone
zinit ice depth=1
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes
zstyle ':omz:plugins:eza' 'show-group' no
zstyle ':omz:plugins:eza' 'git-status' yes

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::autoenv
zinit snippet OMZP::eza
zinit snippet OMZP::ansible
zinit snippet OMZP::kubectl
zinit snippet OMZP::mise
zinit snippet OMZP::fzf
zinit snippet OMZP::zoxide
zinit snippet OMZP::k9s
zinit snippet OMZP::opentofu
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^L' 'clear^M'

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'

# aliases
alias kns="kubens"
alias kctx="kubectx"
alias cd="z"
alias y="yazi"
alias v="nvim"
alias dotfiles="cd ~/dotfiles && git pull"

# Set the prompt
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh.toml)"
fi

# Load custom scripts and configurations
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

if [ -f ~/.zsh_secrets ]; then
  source ~/.zsh_secrets
fi

if [ -f ~/scripts/vo_functions.sh ]; then
  source ~/scripts/vo_functions.sh
fi

# environment variables
export TERM=xterm-256color
export K9S_CONFIG_DIR=~/.config/k9s

if [[ $(uname) == "Linux" ]]; then
  export HOSTNAME=$(hostname)
  keychain -q $HOME/.ssh/gitlab $HOME/.ssh/github
  source $HOME/.keychain/$HOSTNAME-sh
fi

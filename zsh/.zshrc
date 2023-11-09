### ZSH HOME
export ZSH=$HOME/.zsh

### ---- history config -------------------------------------
HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
HISTSIZE=10000

# How many commands history will save on file.
SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS
### --------------------------------------------------------

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

autoload -U colors && colors

# Completion
autoload -U compinit && compinit
_comp_options+=(globdots)


### PLUGINS
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=($ZSH/plugins/zsh-completions/src $fpath)

source $ZSH/plugins/git-prompt.zsh/git-prompt.zsh

source $ZSH/appearance.zsh
source $ZSH/completion.zsh

source $ZSH/timestamp.sh

source $ZSH/plugins/colored-man-pages.zsh
source $ZSH/plugins/command-not-found.zsh
source $ZSH/plugins/you-should-use.zsh

source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source $HOME/.aliases

# History completion
source $ZSH/plugins/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=none
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=none

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


### PROMPT
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_SEPARATOR=")"
ZSH_GIT_PROMPT_SHOW_STASH=1

if [[ -n $SSH_CONNECTION ]]; then
    PROMPT='%{$fg[yellow]%}% ➤ %{$reset_color%}'
    PROMPT+=' %{$fg[yellow]%}%~%{$reset_color%} $(gitprompt)'
else
    PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'
    PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(gitprompt)'
fi


### KEYBINDINGS
autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/zsh-:0 ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/zsh-:0

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# now in kitty config to work also while in for ex. vim
# fzf
#source $HOME/.local/share/fzf/fzf-cd.sh
#bindkey -s "^f" "fzfcd\n"
#bindkey -s "^[f" "fzfhome\n"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/lib/python3.8/site-packages/powerline:$PATH
export ZSH="/home/botanthebushpig/.oh-my-zsh"
export UPDATE_ZSH_DAYS=13
export EDITOR="vim"
export LANG=en_US.UTF-8

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART="true"
ZSH_DISABLE_COMPFIX="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  fzf
  git
  tmux
  tmuxinator
  z
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  web-search
)

source ~/z.sh
source $ZSH/oh-my-zsh.sh
source $(dirname $(gem which colorls))/tab_complete.sh
eval `dircolors ~/.dircolors/dircolors.256dark`

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

setopt auto_list
setopt auto_menu
setopt always_to_end

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

if [[ "$ENABLE_CORRECTION" == "true" ]]; then
  alias zshconfig="vim ~/.zshrc"
  alias vimconfig="vim ~/.vimrc"
  alias zshreload="source ~/.zshrc"
  alias tmuxconfig="vim ~/.tmux.conf"
  alias bashrcconfig="vim ~/.bashrc"
  alias cp='nocorrect cp -v'
  alias man='nocorrect man'
  alias mv='nocorrect mv -v'
  alias mkdir='nocorrect mkdir -v -p'
  alias sudo='nocorrect sudo'

  alias ls='nocorrect colorls --sd -A'
  alias ll='nocorrect colorls --sd -A1'
  alias lldir='nocorrect colorls -d1A'
  alias llfile='nocorrect colorls -f1A --sf'
  alias tree='nocorrect colorls --tree=1'
  alias updatesys='nocorrect sudo apt update && sudo apt upgrade'

  alias cp='nocorrect cp -rv'
  alias mv='nocorrect mv -v'
  alias mkdir='mkdir -pv'
  alias wget='wget -c'

  setopt correct_all
fi

export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export LIBGL_ALWAYS_INDIRECT=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

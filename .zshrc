#export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:$PATH
#export GOPATH=~/go
#export PATH=$PATH:$GOPATH/bin
#bindkey -v

#PROMPT='[%n@%m]# '
RPROMPT='[%d]'
export CLICOLOR=true

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# alias
alias vi='vim'
autoload -U compinit      #補完機能を有効
compinit
setopt auto_list          #補完候補を一覧表示
setopt auto_menu          #TABで補完候補切り替え
setopt auto_param_keys    #カッコなどを自動補完
setopt auto_param_slash   #ディレクトリ補完で/を自動付加
setopt list_packed        #補完候補を詰めて表示
setopt correct            #スペルチェック
setopt nobeep             #ビープ音をオフ
setopt auto_cd            #ディレクトリ名でcd

# cdの後にlsを実行する
function cd() {
  builtin cd $@ && ls;
}

# stでSublimeTextを起動する
alias st="/opt/homebrew-cask/Caskroom/sublime-text3/Build\ 3059/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

#
if [ $TERM = screen ]; then
function mosh_tmux() {
    tmux new-window -n $@ "exec mosh $@"
}
alias mosh=mosh_tmux
fi

# git add
#function peco-select-gitadd() {
#  local selected_file_to_add=$(git status --porcelain | \
#    peco --query "$LBUFFER" | \
#    awk -F ' ' '{print $NF}')
#  if [ -n "$selected_file_to_add" ]; then
#    BUFFER="git add${selected_file_to_add}"
#    CURSOR=$#BUFFER
#    zle accept-line
#  fi
#  zle clear-screen
#}
#zle -N peco-select-gitadd
#bindkey "^g^a" peco-select-gitadd


# 濁点付きファイルの文字化け対策
setopt combining_chars


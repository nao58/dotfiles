########################################
# 環境変数
export LANG=ja_JP.UTF-8
 
 
# 色を使用出来るようにする
autoload -Uz colors
colors
 
# emacs 風キーバインドにする
bindkey -e
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
 
# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
%# "
 
 
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
 
########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
 
 
########################################
# vcs_info
 
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"
 
 
########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# beep を無効にする
setopt no_beep
 
# フローコントロールを無効にする
setopt no_flow_control
 
# '#' 以降をコメントとして扱う
setopt interactive_comments
 
# ディレクトリ名だけでcdする
setopt auto_cd
 
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
# = の後はパス名として補完する
setopt magic_equal_subst
 
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu
 
# 高機能なワイルドカード展開を使用する
setopt extended_glob
 
########################################
# キーバインド
 
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
########################################
# エイリアス
 
alias la='ls -a'
alias ll='ls -l'
 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
 
alias mkdir='mkdir -p'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
 
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
 
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
 
 
 
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        ;;
esac
 
########################################
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH=/usr/local/bin:$PATH
export PATH=${PATH}:~/bin:~/local/bin
export PATH=${PATH}:~/.nodebrew/current/bin

########################################
# screen
export SCREENDIR=/usr/local/screens
s () {
    if [ -n "$1" ]; then
      name="$1"
    else
      #name=`ruby -e 'puts ":"+Dir.pwd.split("/").last+":"'`
      pwd=`pwd`
      name=":`basename $pwd`:"
    fi
    screen -x $name || screen -r $name || screen -S $name
}

########################################
# tmux
t () {
    if [ -n "$1" ]; then
      name="$1"
    else
      pwd=`pwd`
      name="-`basename $pwd`-"
    fi
    tmux a -t $name || tmux new-session -s $name
}

########################################
# git
autoload -U colors; colors
function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
        # これをしないと右プロンプトの位置がずれる
        echo "%{$color%}$name%{$reset_color%} "
}
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
RPROMPT='[`rprompt-git-current-branch`%~]'

alias gst="git status -s -b"
alias gch="git cherry -v"
alias glgg="git logg"
alias glg="git logg | head"

########################################
# go lang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

########################################
# mysql
alias mysql="mysql --pager='less -S -n -i -F -X'"

# vim:set ft=zsh:

########################################
# aws
EB_CLI_HOME=/var/aws/AWS-ElasticBeanstalk-CLI-2.6.2
PATH=${PATH}:${EB_CLI_HOME}/eb/macosx/python2.7

########################################
# cordova
# export ANDROID_HOME=`brew --prefix android`
# export PATH=${PATH}:$ANDROID_HOME/bin
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

########################################
# python
export CLOUDSDK_PYTHON=python3.9
# ln -s /usr/local/Cellar/python@3.9/*/bin/python3.9 /usr/local/bin/python3.9

########################################
# local file
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# The next line updates PATH for the Google Cloud SDK.
# source '/Users/nao58/src/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
# source '/Users/nao58/src/google-cloud-sdk/completion.zsh.inc'
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

########################################
# yarn
export PATH="$HOME/.yarn/bin:$PATH"

########################################
# docker
alias dke="docker-compose exec -e COLUMNS=$(tput cols) -e LINES=$(tput lines)"

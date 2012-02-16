
################ 参考にしたページ ##############
# http://www.manpagez.com/man/1/zsh/
# http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html#
# http://hatena.g.hatena.ne.jp/hatenatech/20060517/1147833430
# http://d.hatena.ne.jp/khiker/20061118
# http://www.cozmixng.org/~kou/linux/zsh
# http://q-eng.imat.eng.osaka-cu.ac.jp/~ippei/unix/?UNIX%BA%A3%C6%FC%A4%CE%B5%BB%2Fzsh
# http://www.dna.bio.keio.ac.jp/~yuji/zsh/zshrc.txt

# ファイルを分割するための設定
[ -f ~/.zshrc.testing ] && source ~/.zshrc.testing
[ -f ~/.zshrc.function ] && source ~/.zshrc.function
[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f /usr/local/Cellar/coreutils/8.11/aliases ] && source /usr/local/Cellar/coreutils/8.11/aliases
[ -f /usr/local/Cellar/coreutils/8.12/aliases ] && source /usr/local/Cellar/coreutils/8.12/aliases

# ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# プロンプトのカラー表示を有効
autoload -U colors
colors

# プロンプトの設定
#PROMPTは, 左側のもの. RPROMPTは, 右側のもの.
#PROMPT="%{[33m%}%B%n@%m%b%# "
#RPROMPT="[%~]"
#SPROMPT="correct: %R -> %r ? "

case ${UID} in
    0)
        PROMPT="
%F{green}%1v%f %{[36m%}%/%{${reset_color}%}
%{[1;31m%}%B%n@%m%b%# "
        PROMPT2="%B%{[1;31m%}%_>%{[m%}%b "
        RPROMPT="%D{%Y/}%D{%m/}%D{%d}%D{(%a)} %*"
        SPROMPT="%B%{[1;31m%}%R -> %r ? [n,y,a,e]:%{[m%}%b "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && \
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
        ;;
    *)
        PROMPT="
%F{green}%1v%f %{[36m%}%/%{${reset_color}%}
%{[1;33m%}%B%n@%m%b%# "
        PROMPT2="%{[1;33m%}%_>%{[m%} "
        RPROMPT="%D{%Y/}%D{%m/}%D{%d}%D{(%a)} %*"
        SPROMPT="%{[1;33m%}%R -> %r ? [n,y,a,e]:%{[m%} "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && \
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
        ;;
esac

# zshをemacsで使う時にM-x shellでzshが動かなくなるのを回避する
[[ $EMACS = t ]] && unsetopt zle

# EDITORの設定
export EDITOR=vi

# PATHの設定
export PATH=${HOME}/.cabal/bin:${HOME}/bin:/usr/local/bin:~/bin:/opt/local/bin:${PATH}
export TERMINFO=${HOME}/.terminfo

# LANGUAGEの設定
export LANG=ja_JP.UTF-8

# classpathの設定
export CLASSPATH=.

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# rlwrap の設定
export RLWRAP_HOME=~/.rlwrap
export RLWRAP_EDITOR=vim

# PERL5LIB
export PERL5LIB=~/lib/perl

# virtualenvの設定
export WORKON_HOME=~/.virtualenvs
[ -e /usr/bin/virtualenvwrapper.sh ] && source /usr/bin/virtualenvwrapper.sh

# 色の設定
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# 履歴ファイルのパス
HISTFILE=$HOME/.zsh_history

# メモリ上に保存される履歴のサイズ
HISTSIZE=100000

# 保存される履歴の数
SAVEHIST=100000

# autoloadの設定
autoload -U compinit
compinit

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Emacsライクなキーバインドにする
bindkey -e
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^z" backward-word
bindkey "^]" forward-word
bindkey "^o" copy-prev-word
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# 補完侯補をEmacsのキーバインドで動き回る
zstyle ':completion:*:default' menu select=1

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# cdでlsもする
function chpwd() { ls }

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# =command を command のパス名に展開する
setopt equals

# 履歴をインクリメンタルに追加
#setopt inc_append_history

# zshの開始・終了時刻を履歴ファイルに記録する
# setopt extended_history

# beep音を鳴らさない
setopt nobeep
setopt nolistbeep

# jobsの出力をデフォルトで jobs -l にする
setopt long_list_jobs

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume

# pushdで同じディレクトリを重複して登録しない
setopt pushd_ignore_dups

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup

#cd -[tab] でpushd
setopt auto_pushd

#補完候補が複数あるときに一覧表示する
setopt auto_list

#補完キーを押すと自動的に順に補完候補を補完する
setopt auto_menu

#ヒストリを呼び出してから実行するまでに編集できるようにする
setopt hist_verify

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

#コマンドの入力誤りを指摘する
setopt correct

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt numeric_glob_sort

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops

#ディレクトリ名の補完の際に自動的にスラッシュを追加する
setopt auto_param_slash

#入力したコマンドがコマンド名に合致せず、かつカレントディレクトリにに入力したコマンドと同名のディレクトリがあった場合にそのディレクトリに移動する
setopt auto_cd

#シェルのプロセスごとに履歴を共有する
setopt share_history

# 色を使う
setopt prompt_subst

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

# Ctrl+D では終了しないようになる（exit, logout などを使う）
setopt ignore_eof

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# 文字列末尾に改行コードが無い場合でも表示する
unsetopt promptcr

#コピペの時rpromptを非表示する
setopt transient_rprompt

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 補完候補のリスト表示をコンパクトにする
setopt list_packed

# バックスラッシュを自動的に削るのを許可しない
setopt noautoremoveslash

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

# デフォルトでscreenモード
if [ $SHLVL = 1 ];then
  screen
fi

# エイリアスの設定
alias ll="ls -al"
alias rm="rm -i"

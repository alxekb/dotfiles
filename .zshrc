# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ai/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bureau"
ZSH_THEME="af-magic"
# ZSH_THEME="steeef"
# ZSH_THEME="ys"
# ZSH_THEME="aussiegeek"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  history
  web-search
  bundler
  dotenv
  macos
  rake
  rbenv
  ruby
)

source $ZSH/oh-my-zsh.sh

# user configuration

# export manpath="/usr/local/man:$manpath"

# you may need to manually set your language environment
# export lang=en_us.utf-8

# preferred editor for local and remote sessions
if [[ -n $ssh_connection ]]; then
  export editor='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/mysql-5.7.21-macos10.13-x86_64/bin/:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/.flutter/flutter/bin:$PATH"

alias mvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
alias nvim="~/nvim-osx64/bin/nvim"
alias ctags="/usr/local/Cellar/ctags/5.8_2/bin/ctags"
alias solargraph="/Users/ai/.rbenv/versions/3.1.0/bin/solargraph"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias tioar="cd ~/Dev/github/test.io/app;
            tmux a -t app;

            tmux new -d -s app;
            tmux rename-window 'main';
            tmux send-keys -t app:0 'git status' Enter;

            tmux new-window -t app:1 -n 'app Console' -c ~/Dev/github/test.io/app;
            tmux send-keys -t app:1 'rails c' Enter;

            tmux new-window -t app:2 -n 'app Server, Foreman' -c ~/Dev/github/test.io/app;
            tmux split-window -v -c ~/Dev/github/test.io/app;
            tmux send-keys -t app:2.0 'rails s -p 4001' Enter;
            tmux send-keys -t app:2.1 'foreman start -f Procfile.local' Enter;

            tmux new-window -t app:3 -n 'devices Server, Foreman' -c ~/Dev/github/test.io/devices;

            tmux split-window -v -c ~/Dev/github/test.io/devices;

            tmux send-keys -t app:3.0 'rails s -p 4003' Enter;
            tmux send-keys -t app:3.1 'bundle exec foreman start' Enter;

            tmux new-window -t app:4 -n 'cirro Server, Foreman' -c ~/Dev/github/test.io/cirro;
            tmux split-window -v -c ~/Dev/github/test.io/cirro;
            tmux send-keys -t app:4.0 'foreman start -f Procfile' Enter;

            tmux a -t app:0;"


export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ai/.google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ai/.google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ai/.google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ai/.google-cloud-sdk/completion.zsh.inc'; fi
eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"
eval "$(dip console)"

export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"
export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export LDFLAGS="-L/usr/local/opt/avr-gcc@8/lib"
export LDFLAGS="-L/usr/local/opt/arm-gcc-bin@8/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"

# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=light,fg:232,bg:255,bg+:116,info:27'
# Solarized colors
# export FZF_DEFAULT_OPTS='
#   --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
#   --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
#   --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
# '
# export FZF_DEFAULT_OPTS='--color=dark'
export BAT_THEME="ansi"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
# export FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up,j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort\""
# alias solargraph='~/.rbenv/versions/2.7.3/bin/solargraph'
export PATH="$HOME/.rbenv/bin:$PATH"
git-daily () {
  while read -r -u 9 since name
  do
    until=$(date -j -v+1d -f '%Y-%m-%d' $since +%Y-%m-%d)

    echo "$since $name"
    echo

    GIT_PAGER=cat git log             \
      --no-merges                     \
      --committer="$name"             \
      --since="$since 00:00:00 +0000" \
      --until="$until 00:00:00 +0000" \
      --format='  * [%h] %s'

    echo
  done 9< <(git log --no-merges --format=$'%cd %cn' --date=short | sort --unique --reverse)
}
# export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history --bind shift-up:preview-page-up,shift-down:preview-page-down"
# export FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
  # fzf \
  #     --disabled --query "$INITIAL_QUERY" \
  #     --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
  #     --delimiter : \
  #     --preview 'bat --color=always {1} --highlight-line {2}' \
  #     --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'

# export FZF_DEFAULT_COMMAND="--preview-window 'up,60%'"

alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"

export FZF_DEFAULT_OPTS="-m"
FZF_DEFAULT_OPTS+=" --color='light'"
FZF_DEFAULT_OPTS+=" --height 40%"
FZF_DEFAULT_OPTS+=" --bind 'ctrl-k:preview-up,ctrl-j:preview-down,ctrl-o:toggle+up,ctrl-i:toggle+down,ctrl-space:toggle-preview'"
FZF_DEFAULT_OPTS+=" --preview 'head -500 {}'"
FZF_DEFAULT_OPTS+=" --preview-window 'right:60%' --margin=1,4"
FZF_DEFAULT_OPTS+=" --ansi"
FZF_DEFAULT_OPTS+=" --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export GPG_TTY=$(tty)
set -o vi

PROMPT_TITLE='echo -ne "\033]0;ai@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE}; "

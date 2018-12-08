PROFILE_STARTUP=false

if [[ $PROFILE_STARTUP == true ]]; then
	zmodload zsh/zprof
fi

################################## FUNCTIONS ##################################
zrecompile() {
	if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
		zcompile ${1}
	fi
}

batch_zrecompile() {
	while read file; do
		zrecompile "$file"
	done
}

#################################### STEPS ####################################
step_zgen() {
	export ZGEN_DIR="$ZDOTDIR/zgen"

	# nvm
	export NVM_DIR="$HOME/.local/share/nvm"
	export NVM_LAZY_LOAD=true
	export NVM_NO_USE=true
	export NVM_AUTO_USE=true

	# autosuggestions
	export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
	export ZSH_AUTOSUGGEST_USE_ASYNC=true

	# theme
	export SPACESHIP_CHAR_SYMBOL='❯ '
	export SPACESHIP_CHAR_SYMBOL_ROOT='# '
	export SPACESHIP_CHAR_SYMBOL_SECONDARY='$ '
	export SPACESHIP_DIR_TRUNC=0
	export SPACESHIP_DIR_LOCK_SYMBOL=' 🗝'
	export SPACESHIP_GIT_SYMBOL=''
	export SPACESHIP_GIT_STATUS_AHEAD='Λ'
	export SPACESHIP_GIT_STATUS_BEHIND='V'
	export SPACESHIP_GIT_STATUS_DIVERGED='ΛV'
	export SPACESHIP_PACKAGE_SHOW=false
	export SPACESHIP_VI_MODE_SHOW=false

	if ! step_zgen__source; then
		step_zgen__config
	fi
}

step_zgen__source() {
	source $ZGEN_DIR/init.zsh
}

step_zgen__config() {
	source $ZGEN_DIR/zgen.zsh

	zgen reset

	echo "Creating a zgen save"

	# base
	zgen load mafredri/zsh-async

	# theme 
	zgen load denysdovhan/spaceship-prompt spaceship

	# nvm
	zgen load ypconstante/zsh-nvm

	# 
	zgen load zsh-users/zsh-autosuggestions
	zgen load zsh-users/zsh-completions
	zgen load zsh-users/zsh-history-substring-search

	zgen oh-my-zsh plugins/autojump
	zgen oh-my-zsh plugins/colored-man-pages
	zgen oh-my-zsh plugins/gitfast
	zgen oh-my-zsh plugins/npm
	zgen oh-my-zsh plugins/yarn

	zgen load twang817/zsh-clipboard
	zgen load MichaelAquilina/zsh-you-should-use
	zgen load zdharma/fast-syntax-highlighting

	zgen save

	zgen init

	find $ZDOTDIR -type f \
		-name "*.zsh" \
		-not -path "*.git*" -not -path "*test-data*" -not -path "*/tests/*" \
		| batch_zrecompile
	find $ZDOTDIR -type f \
		-not -name "*.*" -not -name "README" -not -name "LICENSE" -not -name "chucknorris" \
		-not -path "*.git*" -not -path "*test-data*" -not -path "*/tests/*" \
		| batch_zrecompile
}

step_compile_zsh_files() {
	zrecompile $ZDOTDIR/.zshrc
	zrecompile $ZDOTDIR/.zcompdump
}

step_load_nvm() {
	perl -i -p0e 's/(\n(nvm_die_on_prefix|nvm_ensure_version_installed)\(\) ?\{)[^}].+?\n\}/$1."}"/seg' $NVM_DIR/nvm.sh
	sed -i '/#/!s/\(nvm_echo "Found\)/# \1/g' $NVM_DIR/nvm.sh
	sed -i '/#/!s/\(.*\s\(compinit\)\)/# \1/' $NVM_DIR/bash_completion
	source $NVM_DIR/nvm.sh
	source $NVM_DIR/bash_completion
	_zsh_nvm_auto_use
}

step_alias() {
	alias ls='ls --color'
	alias ll='ls --color=auto -lh'
	alias lla='ls --color=auto -lha'

	alias ..='cd ..'
	alias ...='cd ../..'
	alias ....='cd ../../..'
	alias ~='cd ~'
	alias -- -='cd -'

	alias d='dirs -v | head -10'

	alias -- g-='git checkout -'

	alias tis='tig status'
	alias til='tig log'
	alias tib='tig blame -C'
}

step_zstyle() {
	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' group-name ''
	eval "eval \"$(dircolors -b)\""
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true

	zstyle ':completion:*' menu select
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

	# remove paste text delay
	zstyle ':bracketed-paste-magic' active-widgets '.self-*'

	# Keep directories and files separated
	zstyle ':completion:*' list-dirs-first true
}

step_completion() {
	autoload -Uz compinit
	compinit
}

step_history() {
	HISTSIZE=1000
	SAVEHIST=1000
	HISTFILE="$ZDOTDIR/.zsh_history"

	setopt hist_ignore_all_dups	# ignore duplicated commands history list
	setopt hist_ignore_space	# ignore commands that start with space
	setopt hist_reduce_blanks	# remove extra spaces on command
	setopt hist_verify			# show command with history expansion to user before running it
	setopt inc_append_history	# add commands to HISTFILE in order of execution
	setopt share_history		# share command history data
}

step_keybinding() {
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")

	KEYTIMEOUT=1
	bindkey -v

	# delete on delete or backspace
	bindkey '^?' backward-delete-char
	bindkey '^H' backward-kill-word
	bindkey "^[[3~" delete-char
	bindkey "^[[3;5~" kill-word

	# go back in menu on shift+tab
	bindkey '^[[Z' reverse-menu-complete

	# search on up and down arrow
	bindkey '^[OA' history-substring-search-up
	bindkey '^[OB' history-substring-search-down

	# go to previous or next word on ctrl+arrow
	bindkey '^[[1;5C' forward-word
	bindkey '^[[1;5D' backward-word

	# search on ctrl+r
	bindkey '^R' history-incremental-search-backward
}

#################################### START ####################################
step_zgen
step_alias
step_zstyle
step_history
step_keybinding

async_start_worker setup_worker -n
async_register_callback setup_worker step_load_nvm
async_register_callback setup_worker step_completion
async_register_callback setup_worker step_compile_zsh_files
async_job setup_worker sleep .1

# completion
setopt listpacked # make completion columns with different widths 

# io
setopt correct # suggest fix on command with error

if [[ $PROFILE_STARTUP == true ]]; then
	zprof
fi

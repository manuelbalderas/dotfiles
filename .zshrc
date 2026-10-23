# ── zinit bootstrap ──────────────────────────────────────────────
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33}Installing %F{220}zdharma-continuum/zinit%f…"
    command mkdir -p "${ZINIT_HOME:h}" && command chmod g-rwX "${ZINIT_HOME:h}"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{34}Installation successful.%f" || \
        print -P "%F{160}The clone has failed.%f"
fi

source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ── env ──────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=dark'

# ── plugins ──────────────────────────────────────────────────────
zinit ice depth=1
zinit light spaceship-prompt/spaceship-prompt

zinit light zsh-users/zsh-completions

autoload -Uz compinit && compinit
zinit cdreplay -q

# fzf-tab: no turbo, must load right after compinit and before autosuggestions
zinit light Aloxaf/fzf-tab
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid atload'eval "$(fzf --zsh)"'
zinit light junegunn/fzf

# keep last: it wraps widgets defined by the plugins above
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# ── tools ────────────────────────────────────────────────────────
eval "$($HOME/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"

# real cd when the path exists, otherwise zoxide's fuzzy jump
cd() {
  if (( $# == 0 )); then
    builtin cd ~
  elif [[ -d $1 ]]; then
    builtin cd "$1"
  else
    z "$@"
  fi
}

# ── aliases ──────────────────────────────────────────────────────
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ls=lsd

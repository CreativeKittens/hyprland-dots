zinit ice wait lucid from"gh-r" as"program" mv"bin/exa* -> exa"
zinit light ogham/exa

zinit ice wait lucid from"gh-r" as"program" mv"*/rg -> rg"
zinit light junegunn/fzf-bin

zinit ice wait lucid from"gh-r" as"program" mv"jq* -> jq"
zinit light jqlang/jq 

zinit ice wait lucid from"gh-r" as"program" mv"*/rg -> rg"
zinit light BurntSushi/ripgrep

zinit ice wait lucid from"gh-r" as"program" mv"bin/fnm* -> fnm" atload'eval "$(fnm env --use-on-cd)"'
zinit light Schniz/fnm

zinit ice wait lucid from"gh-r" as"program" mv"*/bat -> bat" atload"export BAT_THEME='Catppuccin-mocha'"
zinit light sharkdp/bat

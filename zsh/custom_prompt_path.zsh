#Load themes from yadr and from user's custom prompts (themes) in ~/.zsh.prompts
autoload -Uz promptinit
fpath=($HOME/.yadr/zsh/prezto-themes $HOME/.zsh.prompts $fpath)
promptinit
[[ -f $HOME/.zsh.prompts/powerlevel10k.zsh ]] && . $HOME/.zsh.prompts/powerlevel10k.zsh
prompt spaceship

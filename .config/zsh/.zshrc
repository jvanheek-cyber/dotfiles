###############################################################################
# Completion                                                                  #
###############################################################################
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
_comp_options+=(globdots)


###############################################################################
# History                                                                     #
###############################################################################
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000


###############################################################################
# Aliases                                                                     #
###############################################################################
source "$XDG_CONFIG_HOME/profile.d/aliases.sh"


###############################################################################
# Prompt                                                                      #
###############################################################################
source "$ZDOTDIR/plugins/git-prompt/git-prompt.plugin.zsh"
source "$ZDOTDIR/prompt.zsh"


###############################################################################
# Misc. Plugins                                                               #
###############################################################################
source "$ZDOTDIR/plugins/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


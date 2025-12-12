autoload -U colors
function add_section {
    local symbol=$1
    local content=$2
    local bg_color=$3
    local prev_bg_color=$4
    local transition="%K{${bg_color}}%F{${prev_bg_color}}%F{black}"
    echo -n "${transition} ${symbol} ${content} "
}
function build_prompt {
    if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
        local prompt="%K{green}%F{black}${ZSH_THEME_ICON_CONDA} ${CONDA_DEFAULT_ENV} "
        local prev_bg_color="green"
        prompt+=$(add_section $ZSH_THEME_ICON_CWD "%~" "blue" $prev_bg_color)
        prev_bg_color="blue"
	else
        local prompt="%K{blue}%F{black} ${ZSH_THEME_ICON_CWD} %~"
        local prev_bg_color="blue"
    fi

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        prompt+=$(add_section $ZSH_THEME_ICON_GIT $(git_super_status) "magenta" $prev_bg_color)
        prev_bg_color="magenta"
    fi

    prompt+="%k%b%f%F{${prev_bg_color}}%k%b%f"

    echo "${prompt}\\n➜ "
}

git_super_status() {
	precmd_update_git_vars
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
	  STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH"
	  if [ "$GIT_BEHIND" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND"
	  fi
	  if [ "$GIT_AHEAD" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD"
	  fi
	  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
	  if [ "$GIT_STAGED" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED"
	  fi
	  if [ "$GIT_CONFLICTS" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS"
	  fi
	  if [ "$GIT_CHANGED" -ne "0" ]; then
		  STATUS="$STATUS%B+%b$GIT_CHANGED"
	  fi
	  if [ "$GIT_UNTRACKED" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
	  fi
	  if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
	  fi
	  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
	  echo "$STATUS"
	fi
}
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_STAGED="%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{✚%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{✔%G%}"

ZSH_THEME_ICON_CONDA=" "
ZSH_THEME_ICON_CWD=""
ZSH_THEME_ICON_GIT=""

setopt prompt_subst
PROMPT='$(build_prompt)'
RPROMPT=''

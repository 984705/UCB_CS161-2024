 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
cat -n lockdown.c
cat scaffold.py
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
ls -al
./debug-exploit
clear
./debug-exploit
clear
checksec
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
cat ./debug-exploit
clear
./exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
./debug-exploit
clear
./debug-exploit
clear
./exploit
clear
cat lockdown.c
cat -n lockdown.c
clear
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
clear
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
ls -al
cat exploit
cat -n lockdown.c
clear
ls -al
cat interact
clear
cat -n lockdown.c
./exploit
clear
cat -n lockdown.c
vim interact
clear
./exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
cleawr
clear
vim interact
./exploit
clear
vim interact
clear
./exploit
clear
vim interact
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./exploit
./exploit
./exploit
clear
vim interact
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
./debug-exploit
clear
./debug-exploit
clear
ls -al
vim interact
clea
clear
./debug-exploit
clear
vim interact
[A
clear
vim interact
cat interact
clear
./debug-exploit
clear
./debug-exploit
clear
vim interact
clear
./debug-exploit
clear
vim interact
./debug-exploit
clear
vim interact
clear
./debug-exploit
clear
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
clear
./debug-exploit
clear
./debug-exploit
clear
ls -al
cat lockdown.c
vim interact
clear
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
clear
./debug-exploit
clear
./exploit
vim interact
./debug-exploit
vim interact
vim interact
./exploit
./exploit
./exploit
./exploit
./exploit
clear
vim interact
clear
cat scaffold.py
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
vim interact
clear
./exploit
./exploit
./exploit
./exploit
./exploit
clear
vim interact
clear
./debug-exploit
clear
vim interact
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
clear
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
vim interact
clear
./debug-exploit
clear
vim interact
./debug-exploit
clear
vim interact
clear
./debug-exploit
clear
./exploit
c
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
./exploit
clear
ls -al
cat lockdown.c
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
rigle
clear
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
vim interact
clear
./exploit
c
./exploit
./exploit
clear
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
cat -n lockdown.c
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
ls -al
cat exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
disas
ckear
clear
vim interact
clear
./exploit
clear
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
objdump
clear
objdump lockdown
clear
objdump -d lockdown
clear
./debug-exploit
clear
readelf -l
readelf -l lockdown
clear
ls -al
cat Makefile
clear
ls -al
cat debug-exploit
clear
readelf -l lockdown
vim Makefile
clear
cat Makefile
clear
./debug-exploit
clear
make
make all
clear
cat Makefile
clear
make all
cat Makefile
clear
rm -rf lockdown
clear
./debug
./debug-
./debug-exploit
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
ls -al
./debug-exploit
clear
./debug-exploit
clear
./debug-exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
clear
./exploit
clear
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
 builtin printf "\e]4545;A\a\e[?1049h"
 if [ "$_termius_integration_installed" = "" ]; then  _termius_integration_installed="yes";  _termius_encode() {  builtin echo -n "$1" | command base64;  };  _termius_get_trap() {  builtin local -a terms;  builtin eval "terms=( $(trap -p "${1:-DEBUG}") )";  builtin printf '%s' "${terms[2]:-}";  };  if [[ "$HISTCONTROL" =~ .*(erasedups|ignoreboth|ignoredups).* ]]; then  _termius_history_verify=0;  else  _termius_history_verify=1;  fi;  _termius_original_PS1="$PS1";  _termius_custom_PS1="";  _termius_in_command_execution="1";  _termius_current_command="";  _termius_update_prompt() {  if [ "$_termius_in_command_execution" = "1" ]; then  if [[ "$_termius_custom_PS1" == "" || "$_termius_custom_PS1" != "$PS1" ]]; then  _termius_original_PS1=$PS1;  _termius_custom_PS1="\[\e]4545;PromptStart\a\]$_termius_original_PS1\[\e]4545;PromptEnd\a\]";  PS1="$_termius_custom_PS1";  fi;  _termius_in_command_execution="0";  fi;  };  _termius_precmd() {  if [ "$_termius_current_command" = "" ]; then  builtin printf "\e]4545;CommandComplete\a";  else  builtin printf "\e]4545;CommandComplete;%s\a" "$_termius_status";  fi;  builtin printf "\e]4545;P;Cwd=%s\a" "$(_termius_encode "$PWD")" ;  _termius_current_command="";  _termius_update_prompt;  };  _termius_preexec() {  if [[ ! "$BASH_COMMAND" =~ ^_termius_prompt* ]]; then  if [ "$_termius_history_verify" = "1" ]; then  _termius_current_command="$(builtin history 1 | sed 's/ *[0-9]* *//')";  else  _termius_current_command=$BASH_COMMAND;  fi;  else  _termius_current_command="";  fi;  builtin printf "\e]4545;CommandOutputStart;%s\a" "$(_termius_encode "${_termius_current_command}")";  };  if [[ -n "${bash_preexec_imported:-}" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  precmd_functions+=(_termius_prompt_cmd);  preexec_functions+=(_termius_preexec_only);  else  _termius_dbg_trap="$(_termius_get_trap DEBUG)";  if [[ -z "$_termius_dbg_trap" ]]; then  _termius_preexec_only() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  _termius_preexec;  fi;  };  trap '_termius_preexec_only "$_"' DEBUG;  elif [[ "$_termius_dbg_trap" != '_termius_preexec "$_"' && "$_termius_dbg_trap" != '_termius_preexec_all "$_"' ]]; then  _termius_preexec_all() {  if [ "$_termius_in_command_execution" = "0" ]; then  _termius_in_command_execution="1";  builtin eval "${_termius_dbg_trap}";  _termius_preexec;  fi;  };  trap '_termius_preexec_all "$_"' DEBUG;  fi;  fi;  _termius_update_prompt;  _termius_restore_exit_code() {  return "$1";  };  _termius_prompt_cmd_original() {  _termius_status="$?";  _termius_restore_exit_code "${_termius_status}";  for cmd in "${_termius_original_prompt_command[@]}"; do  eval "${cmd:-}";  done;  _termius_precmd;  };  _termius_prompt_cmd() {  _termius_status="$?";  _termius_precmd;  };  _termius_original_prompt_command=$PROMPT_COMMAND;  if [[ -z "${bash_preexec_imported:-}" ]]; then  if [[ -n "$_termius_original_prompt_command" && "$_termius_original_prompt_command" != "_termius_prompt_cmd" ]]; then  PROMPT_COMMAND=_termius_prompt_cmd_original;  else  PROMPT_COMMAND=_termius_prompt_cmd;  fi;  fi;  fi
 builtin printf "\e[?1049l\e]4545;B\a"
ls -al
./debug-exploit
clear
vim interact
./exploit
./exploit
./exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
./exploit
clear
vim interact
clear
cat scaffold.py
clear
vim interact
./exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
clear
vim interact
vim interact
./exploit
clear
vim interact
./exploit
clear
vim interact
./exploit
clear
vim interact
./debug-exploit
cat interact
clear
./debug-exploit
clear
./debug-exploit
clear
cat ./debug-exploit
clear
./debug-exploit
clear
./exploit

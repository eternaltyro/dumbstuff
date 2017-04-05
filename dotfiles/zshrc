# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory promptsubst

# Use vi keybindings
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

function battery_charge {
      # Battery 0: Discharging, 94%, 03:46:34 remaining
        bat_percent=`acpi | awk -F ':' {'print $2;'} | awk -F ',' {'print $2;'} | sed -e "s/\s//" -e "s/%.*//"`

          if [ $bat_percent -lt 20 ]; then cl='%F{red}'
                elif [ $bat_percent -lt 50 ]; then cl='%F{yellow}'
                  else cl='%F{green}'
                        fi

                          filled=${(l:`expr $bat_percent / 10`::▸:)}
                            empty=${(l:`expr 10 - $bat_percent / 10`::▹:)}
                              echo $cl$filled$empty'%F{default}'
}
RPROMPT='[%*] $(battery_charge)'

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/tools-master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin

export HADOOP_HOME=/usr/local/hadoop
export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_05"
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"
lzohead () {
        hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

# Add Hadoop bin/ directory to PATH
export PATH=$PATH:$HADOOP_HOME/bin


#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/user/.gvm/bin/gvm-init.sh" ]] && source "/home/user/.gvm/bin/gvm-init.sh"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

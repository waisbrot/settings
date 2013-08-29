## Basic Bash profile

# prompt:
# <hostname>:<current dir> <username>[<shell jobs>]<history number>! <$/#>
export PS1='\h:\W \u[\j]\!!\$ '


# Get bash-completion from 
# http://bash-completion.alioth.debian.org/files/
# Assume that we're doing a userspace install with --prefix=$HOME, but adjust this variable to whatever
COMPLETION_SCRIPT=$HOME/share/bash-completion/bash_completion
if [ -f $COMPLETION_SCRIPT ]; then
  . $COMPLETION_SCRIPT
fi

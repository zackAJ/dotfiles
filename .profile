# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#my personal config

bdelete(){
    if [ $# -eq 0 ] ; then
	echo 'no branch name specified'
	return 1
    fi

    branches=$(git branch -l | grep -v $(git branch --show-current) | grep "$1")

    if [ -z "$branches" ] ; then
    	echo 'no branches found'
	return 0
    fi
	
    if [ -n "$branches" ] ; then
	tput setaf 1
	echo -e "$branches \n"
	tput sgr0  

	echo "are you sure you want to delete these branches ? y/n"
	read arg
    fi	

    if [ "$arg" != "y" ] ; then
	echo 'aborted'
	return 0
    fi

    git branch -D $(git branch -l | grep -v $(git branch --show-current) | grep "$1")
}

# this function takes file names that are in ~/dotfiles and then makes
# symlinks for them in ~
function symbulklink()
{
	files=$(ls -a ~/dotfiles| grep -vE '^\.$|^\.\.$')
	while IFS= read -r line ;
	do
	    if [ "$line" != ".git" ] && [ "$line" != ".gitignore" ] ; then
		ln -s ~/dotfiles/"$line" ~/"$line"
	    fi

	done <<< "$files"
}

export PATH="$PATH:/opt/nvim-linux64/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#OS/PC specific configs
#pc config file convention name: .{os/pc_id}rc
OS_ID="$(cat /etc/os-release | grep '^ID=' | sed 's/^ID=//')"
# echo ${OS_ID}

if [ "$OS_ID" = 'linuxmint' ] || [ "$OS_ID" = 'TODO' ]; then
source ".${OS_ID}rc"
fi

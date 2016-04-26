POWERLINEPATH=~/shells/powerline/powerline-shell

function powerline_install() {
    POWERLINESHELL=${POWERLINEPATH}/powerline-shell.py
    if [[ ! -f $POWERLINESHELL ]]; then
	echo -n "Powerline-shell does not installed, installing ... "
	cd ${POWERLINEPATH}
	./install.py > /dev/null
	if [[ "$?" == "0" ]]; then
	    echo "Done"
	else
	    echo "Failed"
	fi
	cd - > /dev/null
    fi
}

function powerline_precmd() {
    PS1="$(~/shells/powerline/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
	if [ "$s" = "powerline_precmd" ]; then
	    return
	fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    powerline_install
    install_powerline_precmd
fi

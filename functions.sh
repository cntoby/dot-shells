function mcd() {
    mkdir -p "$@" && eval cd "\"\$$#\""
}

function ssh-copy-id() {
    if [[ $# < 1 ]]; then
	echo "Usage: ssh-copy-id server"
    else
	cat ~/.ssh/id_rsa.pub |ssh $1 "[[ -e ~/.ssh ]] || mkdir ~/.ssh; cat - >> ~/.ssh/authorized_keys"
	if [[ $? == 0 ]]; then
	    echo "ssh-copy-id() success"
	else
	    echo "ssh-copy-id() failed"
	fi
    fi
}

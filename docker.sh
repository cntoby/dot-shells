if which docker-machine > /dev/null; then
    VM=$(docker-machine ls 2>/dev/null |awk 'NR==2{print $1}') # get first docker vm as default
    if [ "$VM" != "" ]; then
	STATUS=$(docker-machine status $VM) # get status of the default vm
	if [ "$STATUS" == "Stopped" ]; then # if the vm stopped then start it
	    printf "Starting ${VM} "
	    docker-machine start $VM > /dev/null
	    if [ "$?" == "0" ]; then
		printf "Done\n"
		VM_STARTED=1
	    else
		print "Failed\n"
		VM_STARTED=0
	    fi
	else
	    VM_STARTED=1
	fi
	if [ "$VM_STARTED" == "1" ]; then # if the vm start success of started already, set env in current terminal.
	    echo "Set docker envroment"
	    eval $(docker-machine env $VM)
	fi
    else
	echo "No VM"
    fi
fi

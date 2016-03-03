function backup-code() {
    CODEPATH=~/Devel/src/code
    CLOUDPATH=~/Nutstore/Nutstore/code
    pathParent=$(dirname ${CODEPATH})
    FNAME=$(basename ${CODEPATH})
    #    cd ${pathParent}
    cd ${CODEPATH} > /dev/null
    # update code
    printf "Updating Souces ... \n"

    update-git-dir *
    
    printf "Done\n"
    cd .. > /dev/null
    printf "Create Code Archive ... "
    tar cjf code.tar.bz2 ${FNAME}
    printf " Done\n"
    printf "Move Code Archive ... "
    mv code.tar.bz2 ${CLOUDPATH}
    RET=$?
    printf " Done\n"
    cd - > /dev/null
    if [[ "${RET}" = "0" ]]; then
	echo "Backup Complete"
    else
	echo "Backup Failed"
    fi
}

function update-git-dir() {
    if [[ $# < 1 ]]; then
       echo "need args"
       return 1
    fi
    for i in $@; do
	if [[ ! -d ${i} ]]; then
	    continue
	fi
	printf "updating ${i} ... "
	cd ${i} > /dev/null
	if [[ ! -d '.git' ]]; then
	    if [[ -d '.svn' ]]; then
		svn up > /dev/null
	    else
		printf " is a directory, update repo in it\n"
		update-git-dir *
	    fi
	else
	    git pull --ff -r -q
	fi
	cd .. > /dev/null
	printf "done\n"
    done
}

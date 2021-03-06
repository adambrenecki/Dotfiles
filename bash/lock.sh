unlock(){
	mkdir -p ~/$1
	encfs ~/.efsdata/$1 ~/$1
	joinlock $1
}

joinlock(){
	cd ~/$1
	source init.sh
	set-special-ps1 "lock:$1"
}

lock(){
	_lock_$1
	cd ~
	diskutil unmount ~/$1
	retcode=$?
	if [ $retcode == 0 ] ; then
		rmdir ~/$1
		exit
	else
		echo "Could not unmount the directory."
	fi
}

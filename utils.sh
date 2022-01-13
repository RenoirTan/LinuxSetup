lxspr_path() {
	echo "fs$1"
}

lxspr_echof() {
	echo "$(lxspr_path $1)" "$1"
}

lxspr_cp() {
	cp "$(lxspr_path $1)" "$1"
}

lxspr_mv() {
	mv "$(lxspr_path $1)" "$1"
}


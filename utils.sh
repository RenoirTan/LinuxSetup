lxspr_path() {
	echo -n "fs$1"
}

lxsp_path() {
	echo -n "user/$1"
}

lxspr_cp() {
	cp -r "$(lxspr_path $1)" "$1"
}

lxsp_cp() {
	cp -r "$(lxsp_path $1)" "$HOME/$1"
}

lxspr_mv() {
	mv "$(lxspr_path $1)" "$1"
}

lxsp_mv() {
	mv "$(lxsp_path $1)" "$HOME/$1"
}

lxspr_echof() {
	echo "$(lxspr_path $1)" "$1"
}

lxsp_echof() {
	echo "$(lxsp_path $1)" "$HOME/$1"
}

lxspr_backup() {
	cp -r "$1" "$1.old"
}

lxsp_backup() {
	cp -r "$1" "$1.old"
}

lxspr_replace() {
	lxspr_backup "$1"
	lxspr_cp "$1"
}

lxsp_replace() {
	lxsp_backup "$1"
	lxsp_cp "$1"
}

lxspr_restore() {
	mv "$1.old" "$1"
}

lxsp_restore() {
	mv "$1.old" "$1"
}


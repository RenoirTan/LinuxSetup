lxspr_path() {
	echo -n "fs$1"
}

lxsp_path() {
	echo -n "user/$1"
}

lxspr_cp() {
	src="$(lxspr_path $1)"
	[[ -f "$src" || -d "$src" ]] && cp -r "$src" "$1"
}

lxsp_cp() {
	src="$(lxsp_path $1)"
	[[ -f "$src" || -d "$src" ]] && cp -r "$src" "$HOME/$1"
}

lxspr_mv() {
	src="$(lxspr_path $1)"
	[[ -f "$src" || -d "$src" ]] && mv "$src" "$1"
}

lxsp_mv() {
	src="$(lxsp_path $1)"
	[[ -f "$src" || -d "$src" ]] && mv "$src" "$HOME/$1"
}

lxspr_rm() {
	target="$(lxspr_path $1)"
	[[ -f "$target" || -d "$target" ]] && rm -rf "$target"
}

lxsp_rm() {
	target="$HOME/$(lxsp_path $1)"
	[[ -f "$target" || -d "$target" ]] && rm -rf "$target"
}

lxspr_echof() {
    src="$(lxspr_path $1)"
	[[ -f "$src" || -d "$src" ]] && echo "$src" "$1"

}

lxsp_echof() {
	src="$HOME/$(lxsp_path $1)"
	[[ -f "$src" || -d "$src" ]] && echo "$(lxsp_path $1)" "$HOME/$1"
}

lxspr_backup() {
	[[ -f "$1" || -d "$1" ]] && cp -r "$1" "$1.old"
}

lxsp_backup() {
	src="$HOME/$1"
	dest="$src.old"
	[[ -f "$src" || -d "$src" ]] && cp -r "$src" "$dest"
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
	[[ -f "$1.old" || -d "$1.old" ]] && mv "$1.old" "$1"
}

lxsp_restore() {
	src="$HOME/$1"
	dest="$src.old"
	[[ -f "$src" || -d "$src" ]] && mv "$src" "$dest"
}


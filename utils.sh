lxsp_command_exists() {
	if command -v "$1" > /dev/null ; then
		echo "1"
	else
		echo "0"
	fi
}

lxsp_path_exists() {
	[[ -f "$1" || -d "$1" ]] && echo "1" || echo "0"
}

lxsp_split_str() {
	echo $1 | tr "$2" "\n"
}

# DO NOT USE
# DUMB BEHAVIOUR FROM SHELL WITH NO MEANINGFUL RECOURSE
lxsp_command_check() {
	for executable in $(lxsp_split_str "$1" "$2"); do
		if [ $(lxsp_command_exists "$executable") == "0" ]; then
			echo "0"
			return
		fi
	done
	echo "1"
}

lxsp_guess_init() {
	if [[ $(/sbin/init --version) =~ "upstart" ]]; then
		echo -n "upstart"
	elif [[ -d "/run/systemd/system" ]]; then
		echo -n "systemd"
	elif [[ -f /etc/init.d/cron && ! -h /etc/init.d/cron ]]; then
		echo -n "SysVinit"
	fi
}

lxsp_detect_init() {
	[[ $(lxsp_guess_init) == "$1" ]] && echo -n "1" || echo -n "0"
}

lxspr_path() {
	echo -n "fs$1"
}

lxsp_path() {
	echo -n "user/$1"
}

lxspr_cp() {
	src="$(lxspr_path $1)"
	end_dir="$(dirname $1)"
	[[ ! -d "$end_dir" ]] && mkdir -p "$end_dir"
	[[ -f "$src" || -d "$src" ]] && cp -r "$src" "$1"
}

lxsp_cp() {
	src="$(lxsp_path $1)"
	end_dir="$HOME/$(dirname $1)"
	[[ ! -d "$end_dir" ]] && mkdir -p "$end_dir"
	[[ -f "$src" || -d "$src" ]] && cp -r "$src" "$HOME/$1"
}

lxspr_mv() {
	src="$(lxspr_path $1)"
	end_dir="$(dirname $1)"
	[[ ! -d "$end_dir" ]] && mkdir -p "$end_dir"
	[[ -f "$src" || -d "$src" ]] && mv "$src" "$1"
}

lxsp_mv() {
	src="$(lxsp_path $1)"
	end_dir="$HOME/$(dirname $1)"
	[[ ! -d "$end_dir" ]] && mkdir -p "$end_dir"
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

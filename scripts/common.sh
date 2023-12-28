show_command() {
	echo -e '\e[1;36m' # Cyan
	echo "[command]"
	echo -e '\e[1;33m' # Yellow
	echo -e "\t$1"
	echo -e '\e[1;37m' # White
}

show_fake_command() {
	show_command "$1"
	echo -e "\e[1;32mCREATE\e[0m \e[1m$2 ($3 bytes)\e[0m"
}

create_path() {
	path=$(dirname "$1")
	file=$(basename "$1")
	echo "$path/$2/$file"
}
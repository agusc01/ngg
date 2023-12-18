ngg() {
	local path_name="$3"
	local prefix="$4"
	local default_prefix="app"
	local command=""
	local default_flags=""
	local port="4141"

	get_flags "$@"

  case "$1" in

  	g|generate)

	  	case "$2" in

			cl|class)
				default_flags="--type=class "
				command="ng generate class $path_name $flags $default_flags"
				;;

			c|component)
				command="ng generate component $path_name --prefix=${prefix:-$default_prefix} $flags $default_flags "
				;;

			P|page)
				default_flags="--type=page "
				command="ng generate component $path_name --prefix=${prefix:-$default_prefix} $flags $default_flags "
				;;

			d|directive)
				command="ng generate directive $path_name --prefix=${prefix:-$default_prefix} $flags $default_flags"
				;;

			e|num)
				default_flags="--type=enum "
				command="ng generate enum $path_name $flags $default_flags"
				;;

			en|environments)
				command="ng generate environments"
				;;

			g|guard)
				default_flags="--functional=true "
				command="ng generate guard $path_name $flags $default_flags"			
				;;

			in|interceptor)
				default_flags="--functional=true "
				command="ng generate interceptor $path_name $flags $default_flags"			
				;;

			i|interface)
				default_flags="--type=interface "
				command="ng generate interface $path_name $flags $default_flags"
				;;

			t|type)
				default_flags="--type=type "
				create_type "$@"
				return 0;
				;;

			m|module)
				command="ng generate module $path_name --module=${prefix:-$default_prefix} $flags $default_flags"
				;;

			mr|moduleroute)
				default_flags="--routing=true"
				command="ng generate module $path_name --module=${prefix:-$default_prefix} $flags $default_flags"
				;;

			p|pipe)
				command="ng generate pipe $path_name $flags $default_flags"
				;;

			r|resolver)
				default_flags="--functional=true "
				command="ng generate resolver $path_name $flags $default_flags"
				;;

			s|service)
				command="ng generate service $path_name $flags $default_flags"
				;;

			*)
				command="ng $@"
				;;
			esac
			;;

		s|serve)
			command="ng serve --port=${2:-$port} --open"
			;;

		n|new)
			default_flags=" --skip-tests=true --style=scss --standalone=false --routing=true --ssr=false"
			command="ng $@ $flags $default_flags"
			;;

		*)
			command="ng $@"
			;;

	esac

	echo -e '\e[1;36m' # Cyan
	echo "[command]"
	echo -e '\e[1;33m' # Yellow
	echo -e "\t$command"
	echo -e '\e[1;37m' # White
	$command
	return 0;
}

get_flags() {
	local flag=""
	local	value=""
	local element="$2"
	flags=""
	while [[ "$#" -gt 0 ]]; do
    		case $1 in
          -*=*|--*=*)
            flag="${1%%=*}"
            value="${1#*=}"
            flags+="$flag=$value "
            flag=""
            value=""
            ;;
				-e)
					case $element in
						c|component|P|page|d|directive|p|pipe)
							flags+="--export=true "
							;;
					esac
					;;
				-is)
					case $element in
						c|component|P|page|app|application)
							flags+="--inline-style=true "
							;;	
					esac
					;;
				-it)
					case $element in
						c|component|P|page|app|application)
							flags+="--inline-template=true "
							;;	
					esac
					;;
				-st)
					case $element in
						app|application|c|component|P|page|d|directive|p|pipe)
							flags+="--standalone=true "
							;;	
					esac
					;;
				-sk)
					case $element in
						app|application|cl|class|c|component|P|page|d|directive|g|guard|in|interceptor|p|pipe|r|resolver|s|service)
							flags+="--skip-tests=true "
							;;	
					esac
					;;
		esac

		shift
	done
}

create_type() {
	local extension=".type.ts"
	local root="src/app/"
	local path_file="$root$3"
	local path=""
	local file=""
	local name=""
	local kebab_path=$(camel_to_kebab "$path_file$extension")
	local implements=""

	# if already exists the file
	if [ -e "$kebab_path" ]; then
		echo -e "\n\e[1mNothing to be done\e[0m"
	else
 
		path=$(dirname "$path_file")
		file=$(basename "$path_file")
		name=$(to_upper_first_leter_case $file)
	
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements=$(format_string_types "$4")
  	fi
	
		mkdir -p "$path"
		echo "export type $name = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate type $3 $flags $default_flags --implements=${implements:-''}"
	
		echo -e '\e[1;36m' # Cyan
		echo "[command]"
		echo -e '\e[1;33m' # Yellow
		echo -e "\t$command"
		echo -e '\e[1;37m' # White
		
		echo -e "\e[1;32mCREATE\e[0m \e[1m$kebab_path ($size bytes)\e[0m"

	fi
}

camel_to_kebab() {
	echo "$1" | sed 's/\([a-z0-9]\)\([A-Z]\)/\1-\2/g' | tr '[:upper:]' '[:lower:]'
}

to_upper_first_leter_case() {
	echo "$1" | sed 's/./\U&/'
}

format_string_types() {
	echo "$1" | awk -F',' '{for(i=1;i<=NF;i++) {printf("\x27%s\x27 | ", $i)}}' | sed 's/ | $//'
}

# to_lower_case() {
#	echo "$1" | sed -r 's/(^|_)([A-Z])/\L\2/g; s/(^|-)([A-Z])/\L\2/g; s/([A-Z])/\L\1/g;'
# }
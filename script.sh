ngg() {
	local path_name="$3"
	local prefix="app"
	local command=""
	local default_flags=""
	local port="4141"

	if [[ ! -z "$4" && "$4" != -* && "$4" != -* ]]; then
		prefix="$4"
	else
		case "$2" in
			cl|class|c|component|P|page)
				if [[ $path_name == shared* ]]; then
					prefix="shared"
				elif [[ $path_name =~ ^modules/([^/]+) ]]; then
					prefix="${BASH_REMATCH[1]}"
				fi
			;;
		esac
	fi

	get_flags "$@"

  case "$1" in

  	g|generate)

	  	case "$2" in

			cl|class)
				default_flags="--type=class"
				command="ng generate class $(create_path $path_name "classes") $flags $default_flags"
				;;

			c|component)				
				command="ng generate component $(create_path $path_name "components") --prefix=$prefix $flags $default_flags"
				;;

			P|page)
				default_flags="--type=page"
				command="ng generate component $(create_path $path_name "pages") --prefix=$prefix $flags $default_flags"
				;;

			d|directive)
				command="ng generate directive $(create_path $path_name "directives") --prefix=$prefix $flags $default_flags"
				;;

			e|num)
				default_flags="--type=enum"
				command="ng generate enum $(create_path $path_name "enums") $flags $default_flags"
				;;

			en|environments)
				command="ng generate environments"
				;;

			g|guard)
				default_flags="--functional=true"
				command="ng generate guard $(create_path $path_name "guards") $flags $default_flags"			
				;;

			in|interceptor)
				default_flags="--functional=true"
				command="ng generate interceptor $(create_path $path_name "interceptors") $flags $default_flags"			
				;;

			i|interface)
				default_flags="--type=interface"
				command="ng generate interface $(create_path $path_name "interfaces") $flags $default_flags"
				;;

			t|type)
				default_flags="--type=type"
				create_type "$@"
				return 0;
				;;

			co|const)
				default_flags="--type=const"
				create_const "$@"
				return 0;
				;;

			m|module)
				command="ng generate module $path_name --module=$prefix $flags $default_flags"
				;;

			mr|moduleroute)
				default_flags="--routing=true"
				command="ng generate module $path_name --module=$prefix $flags $default_flags"
				;;

			p|pipe)
				command="ng generate pipe $(create_path $path_name "pipes") $flags $default_flags"
				;;

			r|resolver)
				default_flags="--functional=true"
				command="ng generate resolver $(create_path $path_name "resolvers") $flags $default_flags"
				;;

			s|service)
				command="ng generate service $(create_path $path_name "services") $flags $default_flags"
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
			default_flags="--style=scss --routing=true --ssr=false"
			command="ng new $2 $flags $default_flags"
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
	local element="";

	if [[ "$1" == "new" || "$1" == "n" ]]; then
		element="$1"
	else
		element="$2"
	fi

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
				-e0)
					case $element in
						c|component|P|page|d|directive|p|pipe)
							flags+="--export=false "
							;;
					esac
					;;
				-is)
					case $element in
						c|component|P|page|app|application|n|new)
							flags+="--inline-style=true "
							;;	
					esac
					;;
				-is0)
					case $element in
						c|component|P|page|app|application|n|new)
							flags+="--inline-style=false "
							;;	
					esac
					;;
				-it)
					case $element in
						c|component|P|page|app|application|n|new)
							flags+="--inline-template=true "
							;;	
					esac
					;;
				-it0)
					case $element in
						c|component|P|page|app|application|n|new)
							flags+="--inline-template=false "
							;;	
					esac
					;;
				-st)
					case $element in
						app|application|c|component|P|page|d|directive|p|pipe|n|new)
							flags+="--standalone=true "
							;;	
					esac
					;;
				-st0)
					case $element in
						app|application|c|component|P|page|d|directive|p|pipe|n|new)
							flags+="--standalone=false "
							;;	
					esac
					;;
				-sk)
					case $element in
						app|application|cl|class|c|component|P|page|d|directive|g|guard|in|interceptor|p|pipe|r|resolver|s|service|n|new)
							flags+="--skip-tests=true "
							;;	
					esac
					;;
				-sk0)
					case $element in
						app|application|cl|class|c|component|P|page|d|directive|g|guard|in|interceptor|p|pipe|r|resolver|s|service|n|new)
							flags+="--skip-tests=false "
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
	local path="$(dirname "$path_file")/types"
	local file=$(basename "$path_file")
	local name=$file
	local kebab_path="$(camel_to_kebab "$path/$file")$extension"
	local implements=""

	# if already exists the file
	if [ -e "$kebab_path" ]; then
		echo -e "\n\e[1mNothing to be done\e[0m"
	else
 
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements=$(format_string_type "$4")
  	fi
	
		mkdir -p "$path"
		echo "export type $name = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate type $(dirname $3)/types/$file $flags $default_flags --implements=${implements:-''}"
	
		echo -e '\e[1;36m' # Cyan
		echo "[command]"
		echo -e '\e[1;33m' # Yellow
		echo -e "\t$command"
		echo -e '\e[1;37m' # White
		
		echo -e "\e[1;32mCREATE\e[0m \e[1m$kebab_path ($size bytes)\e[0m"

	fi
}

create_const() {
	local extension=".const.ts"
	local root="src/app/"
	local path_file="$root$3"
	local path="$(dirname "$path_file")/constants"
	local file=$(basename "$path_file")
	local name=$(camel_to_snake $file)
	local kebab_path="$(camel_to_kebab "$path/$file")$extension"
	local implements=""

	# if already exists the file
	if [ -e "$kebab_path" ]; then
		echo -e "\n\e[1mNothing to be done\e[0m"
	else
	
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements=$(format_string_const "$4")
  	fi
	
		mkdir -p "$path"
		echo "export const $name = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate const $(dirname $3)/types/$file $flags $default_flags --implements=${implements:-''}"

	
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

camel_to_snake() {
	echo "$1" | sed 's/\([a-z0-9]\)\([A-Z]\)/\1_\2/g' | tr '[:lower:]' '[:upper:]'
}

to_upper_first_leter_case() {
	echo "$1" | sed 's/./\U&/'
}

format_string_type() {
    echo "$1" | awk -F',' '{
        for(i=1;i<=NF;i++) {
            value = $i;

            # Verificar si el valor es un número (entero o flotante)
            if (value ~ /^[+-]?([0-9]*[.])?[0-9]+$/) {
                printf("%s | ", value);
            } else {
                printf("\x27%s\x27 | ", value);
            }
        }
    }' | sed 's/ | $//'
}

format_string_const() {
	local result=$(echo "$1" | sed -E 's/([a-z])([A-Z])/\1_\L\2/g;')

	result=$(echo "$result" | awk -F',' '{
		for(i=1; i<=NF; i++) {
			split($i, partes, ":");
			key = toupper(partes[1]);
			value = partes[2];
			
			# Verificar si el valor es un número
			if (value ~ /^[+-]?([0-9]*[.])?[0-9]+$/) {
				printf "\t%s: %s%s\n", key, value, (i==NF)?"":", ";
			} else {
					printf "\t%s: \x27%s\x27%s\n", key, value, (i==NF)?"":", ";
			}
		}
		print "";
	}')

	echo -e "{\n$result\n}"
}

msg_fake_command() {
		echo -e '\e[1;36m' # Cyan
		echo "[command]"
		echo -e '\e[1;33m' # Yellow
		echo -e "\t$1"
		echo -e '\e[1;37m' # White
		echo -e "\e[1;32mCREATE\e[0m \e[1m$2 ($3 bytes)\e[0m"
}

create_path() {
	path=$(dirname "$1")
	file=$(basename "$1")
	echo "$path/$2/$file"
}
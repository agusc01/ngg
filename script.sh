ngg() {
	local path_name="$3"
	local prefix="app"
	local command=""
	local default_flags=""
	local port="4141"
	local export=""
	local route=""
	local rm=""
	root="src/app/"

	if [[ ! -z "$4" && "$4" != -* && "$4" != --* ]]; then
		prefix="$4"
	else
		case "$2" in
			cl|class|c|component|P|page|d|directive|p|pipe|mr|moduleroute)
				if [[ $path_name == shared* ]]; then
					prefix="shared"
					export="--export=true"
				elif [[ $path_name == auth* ]]; then
					route="--route=auth"
				elif [[ $path_name =~ ^modules/([^/]+) ]]; then
					if [[ $2 != 'mr' && $2 != 'moduleroute' ]]; then
						prefix="${BASH_REMATCH[1]}"
					fi
					route="--route=${BASH_REMATCH[1]}"
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
				command="ng generate class $(create_path $path_name "classes") $export $default_flags $flags"
				;;

			c|component)				
				command="ng generate component $(create_path $path_name "components") --prefix=$prefix $export $default_flags $flags"
				;;

			P|page)
				default_flags="--type=page"
				command="ng generate component $(create_path $path_name "pages") --prefix=$prefix $export $default_flags $flags"
				;;

			d|directive)
				command="ng generate directive $(create_path $path_name "directives") --prefix=$prefix $export $default_flags $flags"
				;;

			e|num)
				default_flags="--type=enum"
				command="ng generate enum $(create_path $path_name "enums") $default_flags $flags"
				;;

			en|environments)
				command="ng generate environments"
				;;

			g|guard)
				default_flags="--functional=true"
				command="ng generate guard $(create_path $path_name "guards") $default_flags $flags"			
				;;

			in|interceptor)
				default_flags="--functional=true"
				command="ng generate interceptor $(create_path $path_name "interceptors") $default_flags $flags"			
				;;

			i|interface)
				default_flags="--type=interface"
				command="ng generate interface $(create_path $path_name "interfaces") $default_flags $flags"
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
				command="ng generate module $path_name --module=$prefix $default_flags $flags"
				;;

			mr|moduleroute)
				default_flags="--routing=true $route"
				command="ng generate module $path_name --module=$prefix $default_flags $flags"
				show_command "$command"
				$command
				rm="rm -rf $root$path_name/**.component**"
				show_command "$rm"
				$rm

				return 0;
				;;

			p|pipe)
				command="ng generate pipe $(create_path $path_name "pipes") $export $default_flags $flags"
				;;

			r|resolver)
				default_flags="--functional=true"
				command="ng generate resolver $(create_path $path_name "resolvers") $default_flags $flags"
				;;

			s|service)
				command="ng generate service $(create_path $path_name "services") $default_flags $flags"
				;;

			*)
				command="ng $@"
				;;
			esac
			;;

		s|serve)
			command="ng serve --port=${2:-$port}"
			;;

		n|new)
			default_flags="--style=scss --routing=true --ssr=false"
			command="ng new $2 $default_flags $flags"
			;;

		*)
			command="ng $@"
			;;

	esac

	show_command "$command"
	# echo -e '\e[1;36m' # Cyan
	# echo "[command]"
	# echo -e '\e[1;33m' # Yellow
	# echo -e "\t$command"
	# echo -e '\e[1;37m' # White
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

		echo "export type ${name^} = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate type $(dirname $3)/types/$file $default_flags $flags --implements=${implements:-''}"
	
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
		echo "export const ${name^} = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate const $(dirname $3)/constants/$file $default_flags $flags --implements=${implements:-''}"

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

show_command() {
		echo -e '\e[1;36m' # Cyan
		echo "[command]"
		echo -e '\e[1;33m' # Yellow
		echo -e "\t$1"
		echo -e '\e[1;37m' # White
}

create_path() {
	path=$(dirname "$1")
	file=$(basename "$1")
	echo "$path/$2/$file"
}
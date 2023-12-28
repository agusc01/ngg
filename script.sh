if [ -f ~/ngg/scripts/get_flags.sh ]; then
  . ~/ngg/scripts/get_flags.sh
fi

if [ -f ~/ngg/scripts/common.sh ]; then
  . ~/ngg/scripts/common.sh
fi

if [ -f ~/ngg/scripts/transforms_strings.sh ]; then
  . ~/ngg/scripts/transforms_strings.sh
fi

if [ -f ~/ngg/scripts/create.sh ]; then
  . ~/ngg/scripts/create.sh
fi

ngg() {
	local path_name="$3"
	local prefix="app"
	local command=""
	local default_flags=""
	local port="4141"
	local export=""
	local route=""
	local rm=""
	local dont_created_msg="\n\e[1mNothing to be done\e[0m" 
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
			
			v|validator)
				create_validator "$@"
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
				if [[ $flags == *"--implements=httpClient"* ]]; then
					flags=$(echo "$flags" | sed 's/-h/--implements=httpCliente/g')
					create_service_http "$@"
					return 0;
				fi
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
	$command
	return 0;
}

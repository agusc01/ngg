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
			-h)
				case $element in
					s|service)
						flags+="--implements=httpClient"
						;;
				esac
				;;
			-as)
				case $element in
					v|validator)
						flags+="--implements=AsyncValidatorFn"
						;;
				esac
				;;
			-as0)
					case $element in
						v|validator)
							flags+="--implements=ValidatorFn"
							;;
					esac
				;;
		esac

		shift
	done
}


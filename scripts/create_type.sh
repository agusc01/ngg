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
		echo -e	"$dont_created_msg" 
	else
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements=$(format_string_type "$4")
  	fi
	
		mkdir -p "$path"

		echo "export type ${name^} = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate type $(dirname $3)/types/$file $default_flags $flags --implements=${implements:-''}"

		show_fake_command "$command" "$kebab_path" "$size"
	fi
}

format_string_type() {
	echo "$1" | awk -F',' '{
		for(i=1;i<=NF;i++) {
			value = $i;

			# Check if a number ( int or float )
			if (value ~ /^[+-]?([0-9]*[.])?[0-9]+$/) {
				printf("%s | ", value);
			} else {
				printf("\x27%s\x27 | ", value);
			}
		}
	}' | sed 's/ | $//'
}
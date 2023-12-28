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
		echo -e	"$dont_created_msg" 
	else
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements=$(format_string_const "$4")
  	fi
	
		mkdir -p "$path"
		echo "export const ${name^} = ${implements:-''};" > "$kebab_path"
	
  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate const $(dirname $3)/constants/$file $default_flags $flags --implements=${implements:-''}"

		show_fake_command "$command" "$kebab_path" "$size"
	fi
}

format_string_const() {
	local result=$(echo "$1" | sed -E 's/([a-z])([A-Z])/\1_\L\2/g;')

	result=$(echo "$result" | awk -F',' '{
		for(i=1; i<=NF; i++) {
			split($i, partes, ":");
			key = toupper(partes[1]);
			value = partes[2];
			
			# Check if a number ( int or float )
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
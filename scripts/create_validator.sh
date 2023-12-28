create_validator() {
	local extension=".validator.ts"
	default_flags="--type=validator"

	if [[ $flags == "" ]]; then
		extension=".service.ts"
		default_flags="--type=service"
	fi

	local path_file="$root$3"
	local path="$(dirname "$path_file")/validators"
	local file=$(basename "$path_file")
	local name=$file
	local kebab_path="$(camel_to_kebab "$path/$file")$extension"
	local implements=""
	local data=""

	# if already exists the file
	if [ -e "$kebab_path" ]; then
		echo -e	"$dont_created_msg" 
	else
		mkdir -p "$path"
		if [[ $flags == *"--implements=AsyncValidatorFn"* ]]; then
			data+="import { AsyncValidatorFn } from '@angular/forms';"
			data+="\nimport { of } from 'rxjs';"
			data+="\n\nexport const ${name}Validator: AsyncValidatorFn = (control) => {"
			data+="\n\treturn of(null);"
			data+="\n};"
		elif [[ $flags == *"--implements=ValidatorFn"* ]]; then
			data+="import { ValidatorFn } from '@angular/forms';"
			data+="\n\nexport const ${name}Validator: ValidatorFn = (control) => {"
			data+="\n\treturn null;"
			data+="\n};"
		else
			data+="import { Injectable } from '@angular/core';"
			data+="\n\n@Injectable({	providedIn: 'root' })"
			data+="\nexport class ${name^}Service {"
			data+="\n\n\tconstructor() { }"
			data+="\n\n}"
		fi

		echo -e "$data" >> "$kebab_path"

  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate validator $(dirname $3)/validators/$file $default_flags $flags"
	
		show_fake_command "$command" "$kebab_path" "$size"
	fi
}
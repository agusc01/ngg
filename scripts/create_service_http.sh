# TODO: --skip-tests
# TODO: --flat & --project
create_service_http() {
	local extension=".service.ts"
	local path_file="$root$3"
	local path="$(dirname "$path_file")/services"
	local file=$(basename "$path_file")
	local name=$file
	local kebab_path="$(camel_to_kebab "$path/$file")$extension"
	local implements=""
	local data=""

	# if already exists the file
	if [ -e "$kebab_path" ]; then
		echo -e	"$dont_created_msg" 
	else
		# check if the fourth parameters is present
		if [ ! -z "$4" ]; then
			implements="$4"
  	fi
	
		mkdir -p "$path"

		data+="import { HttpClient } from '@angular/common/http';"
		data+="\nimport { Injectable } from '@angular/core';"
		data+="\n\n@Injectable({	providedIn: 'root' })"
		data+="\nexport class ${name^}Service {"
		data+="\n\n\tconstructor(private http: HttpClient) { }"
		data+="\n\n}"
		
		echo -e "$data" >> "$kebab_path"

  	size=$(stat -c %s $kebab_path)
		command="fake:ng generate service $(dirname $3)/services/$file $default_flags $flags"
	
		show_fake_command "$command" "$kebab_path" "$size"
	fi
}
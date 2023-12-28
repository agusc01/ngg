camel_to_kebab() {
	echo "$1" | sed 's/\([a-z0-9]\)\([A-Z]\)/\1-\2/g' | tr '[:upper:]' '[:lower:]'
}

camel_to_snake() {
	echo "$1" | sed 's/\([a-z0-9]\)\([A-Z]\)/\1_\2/g' | tr '[:lower:]' '[:upper:]'
}

to_upper_first_leter_case() {
	echo "$1" | sed 's/./\U&/'
}
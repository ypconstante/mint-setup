#!/bin/bash

source "$(dirname "$0")/_base.sh"

list_links() {
	find . -maxdepth 1 -type f -not -name '_*' -not -name 'routine_*' \
		-exec egrep 'my_link_file|^\w+=.*[^\\]$' {} \;
}

list_links | while read line ; do
	case "$line" in
	    *my_link_file*)
			words=($line)
			original_from=$(eval echo ${words[1]})
			original_to=$(eval echo ${words[2]})
			if [ -f $original_to  ] && [ ! -L $original_to ]; then
				echo "syncing back '$original_to' to '$original_from'"
				cp $original_to $original_from
				my_link_file $original_from $original_to
			fi
		;;
	    *)
			eval $line
		;;
	esac

done

#!/bin/bash

# This is a shortening url CLI for github

error() { echo -e "$1" && exit; }

[ $EUID -eq 0 ] && error "Do not run this script as root."

tmpfile="/tmp/git.io.tmp"
curl_cmd=(curl -s https://git.io/ -i)

checkInternet() {
    if which wget > /dev/null; then
		wget --hsts-file="$HOME/.cache/wget-hsts" --quiet --spider google.com || {
			echo "No internet!"
			exit
		}
	fi
}

usage() {
    echo "Usage: git.io <option> <argument>
                    [-l | --link <github url>]
                    [-c | --code <custom code>]
                    [-h | --help]"
    exit
}

PARSED_ARGUMENTS=$(getopt -a -n $0 -o l:c:h --long link:,code:,help -- "$@")
[ $? -ne 0 ] && usage

while :; do
    case "${1}" in
        -l | --link)	link=${2} ; shift 2 ;;
        -c | --code)	code=${2} ; shift 2 ;;
        -- | '')		shift; break ;;
        -h | --help)	usage ;;
        *) echo "Unexpected option: $1 is not a valid option." ; usage ;;
    esac
done

[ -z "$link" ] && echo "You must give git.io a github URL." && usage || curl_cmd+=( -F url="$link")
[ -n "$code" ] && curl_cmd+=( -F code="$code")

checkInternet
"${curl_cmd[@]}" | sed -e "s/\r//g" > "$tmpfile" 			# use sed to get rid of annoying ^M character

status="$(grep "Status" "$tmpfile" | cut -d' ' -f3)"
[ "$status" != "Created" ] && echo "Your URL is not a github URL." && exit
location="$(grep "Location" "$tmpfile" | cut -d' ' -f2)"

code2="$(echo "$location" | cut -d'/' -f4)"

if [ -n "$code" ] && [ "$code2" != "$code" ]; then
	echo "Sorry. This URL has already been set to $location"
else
	echo "Your shortened URL: $location"
fi
printf "$location" | xclip -se c 2> /dev/null && echo "The shortened URL is copied to your clipboard!"

exit 0

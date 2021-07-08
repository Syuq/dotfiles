#!/bin/bash

# This is a shortening url CLI for github

error() { echo -e "$1" && exit; }

[ $EUID -eq 0 ] && error "Do not run this script as root."

_tmpfile="/tmp/git.io.tmp"
_curl_cmd=(curl -s https://git.io/ -i)

checkInternet() {
    if which wget > /dev/null; then
        wget --quiet --spider google.com || { echo "No internet!"; exit; }
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
        -l | --link)	_link=${2} ; shift 2 ;;
        -c | --code)	_code=${2} ; shift 2 ;;
        -h | --help)	usage ;;
        -- | '')        shift; break ;;
        *) echo "Unexpected option: $1 is not a valid option." ; usage ;;
    esac
done

[ -z "$_link" ] && _link="$(command -v xclip > /dev/null && xclip -o)" ; _curl_cmd+=( -F url="$_link")
[ -n "$_code" ] && _curl_cmd+=( -F code="$_code")

checkInternet
"${_curl_cmd[@]}" | sed -e "s/\r//g" > "$_tmpfile"                # use sed to get rid of annoying ^M character

_status="$(grep "Status" "$_tmpfile" | cut -d' ' -f3)"
[ "$_status" != "Created" ] && echo "Your URL is not a github URL." && exit
_location="$(grep "Location" "$_tmpfile" | cut -d' ' -f2)"

_code2="$(echo "$_location" | cut -d'/' -f4)"

if [ -n "$_code" ] && [ "$_code2" != "$_code" ]; then
    echo "Sorry. This URL has already been set to $_location"
else
    echo "Your shortened URL: $_location"
fi

command -v xclip > /dev/null && printf "$_location" | xclip -se c 2> /dev/null && echo "The shortened URL is copied to your clipboard!"

exit 0

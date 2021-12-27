#!/bin/bash

# This is a shortening url CLI for github
# Optional: install xclip or xsel for copy-to-clipboard feature

TMP_FILE="/tmp/git.io.tmp"

error() { echo -e "${1}" && exit 1; }

check_command() { command -v "${1}" > /dev/null; }

check_dependency() {
    while [ -n "${1}" ]; do
        check_command "${1}" || error "This script required ${1} to work, so install it first!"
        shift
    done
}

check_internet() {
    if which wget > /dev/null; then
        wget --quiet --spider google.com || error "No internet!"
    fi
}

usage() {
    echo "Usage: git.io <option> <argument>
                    [-l | --link <github url>]
                    [-c | --code <custom code>]
                    [-h | --help]"
    exit
}

get_check_status() {
    local status="$(grep "Status" "${TMP_FILE}" | cut -d' ' -f3)"
    if cat "${TMP_FILE}" | grep -q "Invalid url"; then
        error "Invalid URL"
    elif cat "${TMP_FILE}" | grep -q "Must be a GitHub.com"; then
        error "Your URL is not a github URL."
    elif cat "${TMP_FILE}" | grep -q "existing"; then
        error "The code ${code} is already being used!\nPlease choose a different one."
    elif [ "${status}" != "Created" ]; then
        error "Invalid URL"
    fi
}

xclip_xsel() {
    if check_command xclip; then
        printf "${shortened_url}" | xclip -se c 2> /dev/null
    elif check_command xsel; then
        printf "${shortened_url}" | xsel --clipboard 2> /dev/null
    else
        exit 0
    fi
    echo "The shortened URL is copied to your clipboard!"
}

main() {
    check_dependency wget curl

    PARSEDARGUMENTS=$(getopt -a -n ${0} -o l:c:h --long link:,code:,help -- "$@")
    [ $? -ne 0 ] && usage

    while :; do
        case "${1}" in
            -l | --link)    link=${2} ; shift 2 ;;
            -c | --code)    code=${2} ; shift 2 ;;
            -h | --help)    usage ;;
            -- | '')        shift; break ;;
            *) echo "Unexpected option: ${1} is not a valid option." ; usage ;;
        esac
    done

    local curl_cmd=(curl -s https://git.io/ -i)
    if [ -z "${link}" ]; then
        if check_command xclip; then
            link="`xclip -o`"
        elif check_command xsel; then
            link="`xsel -o`"
        else
            error "Must supply a github link!"
        fi
    fi
    curl_cmd+=( -F url="${link}")
    [ -n "${code}" ] && curl_cmd+=( -F code="${code}")

    check_internet

    # use sed to get rid of annoying ^M character
    "${curl_cmd[@]}" | sed -e "s/\r//g" > "${TMP_FILE}"

    get_check_status
    shortened_url="$(grep "Location" "${TMP_FILE}" | cut -d' ' -f2)"

    real_code="$(echo "${shortened_url}" | cut -d'/' -f4)"

    if [ -n "${code}" ] && [ "${real_code}" != "${code}" ]; then
        echo "Sorry. This URL has already been set to ${shortened_url}"
    else
        echo "Your shortened URL: ${shortened_url}"
    fi

    xclip_xsel

    exit 0
}

main "$@"

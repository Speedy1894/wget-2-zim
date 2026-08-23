# bash completion for wget-2-zim
# https://github.com/ballerburg9005/wget-2-zim

_wget-2-zim_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    COMPREPLY=()

    local flags='--include-zip --include-exe --include-any --no-overreach-media --overreach-any --turbo --skip-download --timestamp -h --help'
    local fileoptions='--output --working-dir'
    local options='--any-max --not-media-max --picture-max --document-max --music-max --video-max --wget-depth --creator --publisher --description --long-description --language'

    if [[ " $fileoptions " =~ " $prev " ]]; then
        compgen -V COMPREPLY -f
    elif [[ " $options " =~ " $prev " ]]; then
        :
    elif [[ "${cur::1}" = '-' ]]; then
        compgen -V COMPREPLY -W "$flags $fileoptions $options" -- "$cur"
    else
        compgen -V COMPREPLY -W 'https:// http:// ftp://' -- "$cur"
    fi
}
complete -F _wget-2-zim_completions wget-2-zim

#!/bin/zsh
#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2026-01-06 12:25:41
# Reference:    8ucchiman.github.io
# Description:  ---
#



function _usage() {
}


while getopts :i:c:g OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        g) gpu_flag=true;;
        c) container_name=$OPTARG;;
        :|\?) _usage;;
    esac
done


{{_cursor_}}


return

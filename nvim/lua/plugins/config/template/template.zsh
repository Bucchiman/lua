#!/bin/zsh
#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#


function func_lst () {
    echo "***********************************"
    echo "The following function is prepared."
    echo "***********************************"
    cat go | awk '/^function/ {printf "| %s\n", $2}'
    echo "***********************************"
}

########################################
#function main01 () {
#
#    eval $@
#}
#
#main01 $@
########################################



########################################
while getopts :i:c:g OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        g) gpu_flag=true;;
        c) container_name=$OPTARG;;
        :|\?) _usage;;
    esac
done
function _usage () {
    echo 
}
function help () {

}


function main02 () {
    
}
########################################

return

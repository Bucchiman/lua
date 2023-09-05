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
    cat $0 | awk '/^function/ {printf "| %s\n", $2}'
    echo "***********************************"
}


########################################
# while getopts :i:c:g OPT
# do
#     case $OPT in
#         i) image_name=$OPTARG;;
#         g) gpu_flag=true;;
#         c) container_name=$OPTARG;;
#         :|\?) _usage;;
#     esac
# done
# function _usage () {
#     echo 
# }
# function help () {
# 
# }
# 
# 
# function main02 () {
#     
# }
########################################

typset -A SUBMODULES
function set_variables () {
    #
    #
    #
    #
    echo "******************************"
    echo "* set_variables              *"
    echo "******************************"
    BASE_DIR=$PWD
    SUBMODULES=(yolostereo3D https://github.com/Owen-Liuyuxuan/visualDet3D.git)
}



function default () {
    #
    # this is default setting
    # you can run this function without no arguments.
    #
    echo "******************************"
    echo "* default                    *"
    echo "******************************"
    echo "this is default setting"
    echo "you can run this function without no arguments."

}


#######################################
function main01 () {
    set_viriables
    if [[ $@ == "" ]]; then
        default
    else
        eval $@
    fi

}

ME=$0
main01 $@
#######################################


return

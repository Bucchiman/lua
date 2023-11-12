#!/bin/zsh
#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#


# set -ex        # 途中のエラーで実行中断


#@
function update_submodules () {
    $(cd $BASE_DIR; git submodule update --init --recursive)   # cloneした後submoduleをclone 
}

#@
function submodule_add () {
    typeset -A platforms
    platforms=(
        github git@github.com:Bucchiman/
        gitlab git@gitlab.com:Bucchiman/
    )
    local target_platform=`array_fzf "${(k)platforms[*]}"`
    echo -n "project name> ${platforms[$target_platform]}"
    read project_name
    local repository_url=${platforms[$target_platform]}${project_name}.git
    cd ${BASE_DIR}/submodules; git submodule add $repository_url ${project_name}
}

#@
function fzf_install () {
}

#@
function set_variables () {
    #
    #
    #
    #
    echo "******************************"
    echo "* set_variables              *"
    echo "******************************"
    BASE_DIR=$PWD
    BMODS_PATH=$HOME/Bmods
    ### you can write
    typeset -A -g SUBMODULES=(
        repo_name https://github.com/ # blablabla ...
    )
    typeset -A -g Reference_lst=(
        ref_name https:// # blablabla ...
    )
    echo "BASE_DIR=$PWD"
}

#@
function open () {
    lopen
}

#@ archive
function setup () {
    if [[ -e $BASE_DIR/local ]]; then
        source local
    fi
}

#@ archive
function build () {
    lbuild
}

#@ archive
function run () {
    lrun
}

#@ archive
function clean () {
    lclean
}


#@ archive
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
    #build
    run
}


#######################################
#@ archive
function main01 () {
    set_variables
    setup
    source $BMODS_PATH
    if [[ $@ == "" ]]; then
        default
    elif [[ $@ == "." ]]; then
        local target_func=`choose_local_function $BASE_DIR/Brun`
        eval $target_func
    else
        eval $@
    fi

}

ME=$0
main01 $@
#######################################


return

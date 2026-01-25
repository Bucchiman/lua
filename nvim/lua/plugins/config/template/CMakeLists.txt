#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2026-01-22 00:59:54
# Command:      cmake -S . -B build -DBUILD_SHARED_LIBS=ON    # 共有ライブラリ指定
# Reference:    https://qiita.com/shohirose/items/45fb49c6b429e8b204ac
#               https://cmake.org/cmake/help/git-master/prop_gbl/CMAKE_CXX_KNOWN_FEATURES.html#prop_gbl:CMAKE_CXX_KNOWN_FEATURES
#               8ucchiman.github.io
# Description:  ---
#


cmake_minimum_required(VERSION 3.13)
project(8ucchiman_project CXX)   # 8ucchiman_projectをc++で作成
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(SOURCE_FILE main.cpp)

# set executable
add_executable(main ${SOURCE_FILE})


{{_cursor_}}


#
# FileName:     {{_file_name_}}
# Author: 		{{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-12-15 11:36:49
# Reference: 	https://qiita.com/chibi929/items/b8c5f36434d5d3fbfa4a
# Description:	---
#



CXXFLAGS = -g -Wall -std=c++11
# Reference: https://stackoverflow.com/questions/17052006/make-ldlibs-deprecated
LDLIBS = -lglfw3 -lGLEW -Xrandr -lXinerama -lXcursor -lXi -lX11 -lrt -lm -ldl
OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
TARGET = main

.PHONY: all run clean debug

all:
	echo hoge

$(TARGET): $(OBJECTS)




run:
	{{_cursor_}}

debug:


clean:
	rm 


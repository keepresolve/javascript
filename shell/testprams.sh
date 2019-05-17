#!/bin/bash

filename=$1
if [ -f ${filename} ];then
        if [ -f "${filename}.md5" ];then
                echo "find file ${filename}"
                file_md5_new=`md5sum $filename|awk -F ' ' '{print $1}'`
                file_md5_old=`cat ${filename}.md5`
                if [ "$file_md5_new" = "$file_md5_old" ];then
                        echo "file md5 match"
                else
                        echo "file md5 not match"
                        echo "new $file_md5_new"
                        echo "old $file_md5_old"
                        /usr/bin/sox ${filename} -e signed-integer -c 1 -b 16 -r 8000 -L ${filename}.wav 
                        if [ $? -eq 0 ];then
                                mv -f ${filename}.wav ${filename}
                                echo `md5sum ${filename}|awk -F ' ' '{print $1}'` > ${filename}.md5
                        fi
                fi
        else
                echo "md5 file not exist"
                /usr/bin/sox ${filename} -e signed-integer -c 1 -b 16 -r 8000 -L ${filename}.wav 
                if [ $? -eq 0 ];then
                        mv -f ${filename}.wav ${filename}
                        echo `md5sum ${filename}|awk -F ' ' '{print $1}'` > ${filename}.md5
                fi
        fi
else
        echo "file $filename not exist"
fi

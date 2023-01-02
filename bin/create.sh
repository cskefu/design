#! /bin/bash 
###########################################
#
###########################################

# constants
baseDir=$(cd `dirname "$0"`;pwd)
cwdDir=$PWD
export PYTHONUNBUFFERED=1
export PATH=/opt/miniconda3/envs/venv-py3/bin:$PATH
export TS=$(date +%Y%m%d%H%M%S)
export DATE=`date "+%Y_%m_%d"`
export DATE_WITH_TIME=`date "+%Y%m%d-%H%M%S"` #add %3N as we want millisecond too

# functions
function printUsage(){
    echo "$0 PROJECT_NAME"
    echo "e.g. $0 CSKEFU_PERMISSIONS"
}

function init_with_gitee(){
    # Clone method 1
    cd $baseDir/../tmp
    wget https://gitee.com/chatopera_admin/markdown2word-doc-template/repository/archive/master.zip -O $DATE_WITH_TIME.zip
    unzip -d $1 $DATE_WITH_TIME.zip
    cd $1
    mv markdown2word-doc-template-master/* .
    mv markdown2word-doc-template-master/.gitignore .
    rm -rf markdown2word-doc-template-master
    mv README.eddx $2.eddx
    mv README.pptx $2.pptx
    mv README.xmind $2.xmind
    # echo `pwd`
    cd $baseDir/../tmp
    rm $DATE_WITH_TIME.zip
}

# main 
[ -z "${BASH_SOURCE[0]}" -o "${BASH_SOURCE[0]}" = "$0" ] || return
cd $baseDir/..

if [ ! $# -gt 0 ]; then
    echo $*
    printUsage
    exit 1
fi

PROJECT_NAME=$1
PROJECT_DIR=$baseDir/../docs/${DATE}_${PROJECT_NAME}

echo $PROJECT_DIR

if [ -e $PROJECT_DIR ]; then
    echo "File or Dir exists" $PROJECT_DIR
    exit 2
fi

if [ ! -d $baseDir/../tmp ]; then
    mkdir $baseDir/../tmp
fi

init_with_gitee $PROJECT_DIR $PROJECT_NAME

cd $PROJECT_DIR
rm -rf .obsidian

echo "Project created" `pwd`
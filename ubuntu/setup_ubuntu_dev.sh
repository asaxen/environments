#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
    printf "${YELLOW}Ubuntu Dev environment set up script${NC}\n"
    echo ""
    echo "Available parameters:"
    echo "  [--basics] Install useful paths etc."
    echo "  [--python] Setup python 2 and 3, pip and pipenv"
    echo "  [--spark] Setup latest Spark"
    echo "  [--all] All above"
}

setup_basics() {
    printf "${YELLOW}Installing basics${NC}\n"
    # Add .local bin to PATH
    echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
    sudo apt-get install openjdk-8-jdk -y 
}

setup_python() {
    printf "${YELLOW}Installing python, pip and pipenv${NC}"
    sudo apt install git -y
    sudo apt install python -y
    sudo apt install python-pip -y
    sudo apt install python3-pip -y
    sudo apt install pipenv -y 
}

setup_spark() {
    printf "${YELLOW}Installing Spark${NC}\n"
    SPARK_PATH="/opt"
    SPARK_VERSION="spark-2.3.1-bin-hadoop2.7"
    wget "http://apache.mirrors.spacedump.net/spark/spark-2.3.1/${SPARK_VERSION}.tgz"
    sudo tar zxvf $SPARK_VERSION.tgz -C $SPARK_PATH > /dev/null
    sudo chmod -R 777 $SPARK_PATH/$SPARK_VERSION
    rm $SPARK_VERSION.tgz

    if [ -z "$(grep '# Exports for spark' ~/.bashrc)" ]; then
        echo '# Exports for spark' >> $HOME/.bashrc
        echo "export SPARK_HOME=${SPARK_PATH}/${SPARK_VERSION}" >> ~/.bashrc
        echo '# Exports for spark console' >> $HOME/.bashrc
        echo "export SPARK_HOME=${SPARK_PATH}/${SPARK_VERSION}" >> ~/.bashrc
        echo "export PYTHONPATH=${SPARK_HOME}/python:${SPARK_HOME}/python/build:$PYTHONPATH" >> ~/.bashrc
        echo "export PYSPARK_PYTHON=python3" >> ~/.bashrc
        echo "export PATH=$SPARK_HOME/bin:$PATH" >> ~/.bashrc
    else
        printf "${YELLOW}Export Spark variables are already updated${NC}\n"
    fi
}

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

while [ $# -gt 0 ]
do
    key="$1"

    case $key in
        --all)
            setup_basics
            setup_python
            setup_spark
            shift
            ;;
        --python)
            setup_python
            shift
            ;;
        --spark)
            setup_spark
            shift
            ;;
        *)
            usage
            ;;
    esac
shift
done


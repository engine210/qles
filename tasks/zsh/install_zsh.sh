#!/bin/bash

# Global variables
SRC_PATH=$HOME/.pkg/sources
INSTALL_PATH=$HOME/.pkg/

NCURSES_NAME=ncurses-6.1
NCURSES_URL="ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz"

ZSH_NAME=zsh
ZSH_URL="https://sourceforge.net/projects/zsh/files/latest/download"

#######################################
# Create directory if it doesn't exist.
# If DELETE_EXISTED is true and folder 
#   exist, delete and create it again.
# Arguments:
#   FOLDER_PATH
#   DELETE_EXISTED (false if not specified)
#######################################
function create_dir() {
    if [[ ! -d "$1" ]]; then
        echo "Create directory $1"
        mkdir -p "$1"
    else
        if [[ "$2" = true ]]; then
            echo "Recreate original directory $1"
            rm -rf "$1"
            mkdir -p "$1"
        fi
    fi
}

#######################################
# Download file and decompress to SRC_PATH
# Globals:
#   SRC_PATH
# Arguments:
#   PKG_NAME
#   PKG_URL
#######################################
function download_decompress() {
    PKG_NAME=$1
    PKG_URL=$2

    create_dir $SRC_PATH && cd $SRC_PATH
    if [ -x "$(command -v wget)" ]; then
        wget -L $PKG_URL -O tmp
    else
        curl -L $PKG_URL -o tmp
    fi
    create_dir $SRC_PATH/$PKG_NAME true
    tar xf tmp -C $SRC_PATH/$PKG_NAME --strip-components 1
    rm tmp
}

#######################################
# Install ncurses development package (ncurses-devel) from sourse.
# Globals:
#   INSTALL_PATH
#   NCURSES_NAME
#   NCURSES_URL
#######################################
function install_ncurses() {
    download_decompress $NCURSES_NAME $NCURSES_URL
    cd $SRC_PATH/$NCURSES_NAME
    create_dir $INSTALL_PATH/$NCURSES_NAME
    ./configure --prefix=$INSTALL_PATH/$NCURSES_NAME CXXFLAGS="-fPIC" CFLAGS="-fPIC"
    make -j && make install
}

#######################################
# Install zsh from sourse.
# Globals:
#   ZSH_SRC_NAME
#   ZSH_PACK_DIR
#   ZSH_LINK
#   NCURSES_NAME
# Arguments:
#   None
#######################################
function install_zsh() {
    download_decompress $ZSH_NAME $ZSH_URL
    cd $SRC_PATH/$ZSH_NAME
    create_dir $INSTALL_PATH/$ZSH_NAME
    ./configure --prefix=$INSTALL_PATH/$ZSH_NAME \
        CPPFLAGS="-I$INSTALL_PATH/$NCURSES_NAME/include" \
        LDFLAGS="-L$INSTALL_PATH/$NCURSES_NAME/lib"
    make -j && make install
}

if [[ -f /usr/include/ncurses.h ]]; then
    install_ncurses
fi
install_zsh
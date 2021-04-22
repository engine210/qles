#!/bin/bash
set -e
# Global variables
SRC_PATH=$HOME/.pkg/sources
INSTALL_PATH=$HOME/.pkg

NCURSES_NAME=ncurses-6.1
NCURSES_URL="ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz"
ZSH_NAME=zsh
ZSH_URL="https://sourceforge.net/projects/zsh/files/latest/download"

LBLUE='\033[1;34m' # Light blue
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
    printf "Downloading $PKG_URL..."
    if [ -x "$(command -v wget)" ]; then
        wget -L $PKG_URL -O tmp &> /dev/null
    else
        curl -L $PKG_URL -o tmp &> /dev/null
    fi
    printf "done\n"
    create_dir $SRC_PATH/$PKG_NAME true
    printf "tar $SRC_PATH/$PKG_NAME..."
    tar xf tmp -C $SRC_PATH/$PKG_NAME --strip-components 1
    rm tmp
    printf "done\n"
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
    printf "Configuring..."
    ./configure --prefix=$INSTALL_PATH/$NCURSES_NAME CXXFLAGS="-fPIC" CFLAGS="-fPIC" &> $BAK_DIR/ncurses_configure.log
    printf "done\n"
    printf "Running make..."
    make -j &> $BAK_DIR/ncurses_make.log
    printf "done\n"
    printf "Running make install..."
    make install &> $BAK_DIR/ncurses_make_install.log
    printf "done\n"
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

    printf "Configuring..."
    if [[ -f /usr/include/ncurses.h ]]; then
        ./configure --prefix=$INSTALL_PATH/$ZSH_NAME &> $BAK_DIR/zsh_configure.log
    else
        ./configure --prefix=$INSTALL_PATH/$ZSH_NAME \
            CPPFLAGS="-I$INSTALL_PATH/$NCURSES_NAME/include" \
            LDFLAGS="-L$INSTALL_PATH/$NCURSES_NAME/lib" &> $BAK_DIR/zsh_configure.log
    fi
    printf "done\n"

    printf "Running make..."
    make -j &> $BAK_DIR/zsh_make.log
    printf "done\n"
    printf "Running make install..."
    make install &> $BAK_DIR/zsh_make_install.log
    printf "done\n"
}


if [[ ! -f /usr/include/ncurses.h ]]; then
    printf "${YELLOW}zsh's dependence ncurses not found\n${NC}"
    printf "${LBLUE}Install ncurses from source...\n${NC}"
    install_ncurses
    printf "${LBLIE}Done install ncurses from source\n${NC}"
fi

printf "${LBLUE}Install zsh from source...\n${NC}"
install_zsh
printf "Done install zsh from source\n"

# set environment variable
export PATH=$PATH:$INSTALL_PATH/$ZSH_NAME/bin
[ -f "$HOME/.bash_profile" ] && cp $HOME/.bash_profile $BAK_DIR
echo "export PATH=$PATH:$INSTALL_PATH/$ZSH_NAME/bin" >> $HOME/.bash_profile
echo "export SHELL=$INSTALL_PATH/$ZSH_NAME/bin/zsh" >> $HOME/.bash_profile
echo '[ -z "$ZSH_VERSION" ] && exec $SHELL -l' >> $HOME/.bash_profile
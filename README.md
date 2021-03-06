# [VIM - Vi IMproved](http://www.vim.org/)

<https://github.com/vim-jp/vim>

## Install

```sh
% brew install vim 
```

or

```sh
% git clone https://github.com/vim/vim.git 
% cd vim/src
% ./configure --prefix=${HOME}/bin \
  --with-features=huge \
  --enable-multibyte \
  --enable-xim \
  --enable-fontset \
  --disable-selinux \
  --disable-gui \
  --with-tlib=ncurses \
  --enable-rubyinterp \
  --enable-luainterp \
  --without-x

% make && make install
```

## Starting without vimrc & plugin

compatible on

```sh
% vim -u NONE
```

compatible off

```sh
% vim -u NONE -N
```

## Language Server

### php

```sh
% npm i intelephense -g
```

```json
{
  "languageserver": {
    "intelephense": {
      "command": "intelephense",
      "args": ["--stdio"],
      "filetypes": ["php"],
      "initializationOptions": {
        "storagePath": "/tmp/intelephense"
      }
    }
  }
}
```

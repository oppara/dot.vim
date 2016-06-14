# [VIM - Vi IMproved](http://www.vim.org/)

<https://github.com/vim-jp/vim>

## Install

    % brew install vim --with-lua --with-luajit

or

    % git https://github.com/vim/vim.git 
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


### MacVim-KaoriYa

<https://code.google.com/p/macvim-kaoriya/>

    % brew tap caskroom/homebrew-versions
    % brew cask install macvim-kaoriya

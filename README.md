# sci.vim
Yet another vim theme :)

![sci theme](./screenshot.png)

## Install
With the last vim 8

    $ mkdir -p ~/.vim/pack/supercolors/start
    $ git clone https://github.com/szorfein/sci.vim ~/.vim/pack/supercolors/start/sci

## Vimrc
Into your `~/.vimrc`:

    packadd! sci
    colorscheme sci

## Lightline
The theme include a lightline theme, you can add into your `~/.vimrc` again:

    let g:lightline.colorscheme = "sci"

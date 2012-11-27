Installation of plugin as submodule:

    git clone git://github.com/nelstrom/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Update plugins (submodules)

    cd ~/.vim
    git submodule foreach git pull origin master

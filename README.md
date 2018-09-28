## Bootstrap

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/nedm2/dotfiles/master/bootstrap.sh)"

    cd $HOME
    sudo apt-get install git zsh
    git clone https://github.com/nedm2/dotfiles .dotfiles
    .dotfiles/install.py

## Vim Compile
    
    ./configure --with-features=huge  --enable-pythoninterp=yes
    make
    sudo make install

## Inlcude gitconfig

    [include]
        path = .dotfiles/.gitconfig

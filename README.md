## About

This repo provides a customized .zshrc and .zsh/ config folder.

## Setup

In order use this repo, do the following in your home directory

Backup (or delete, if you haven't made any changes so far) your current .zshrc and, if present, .zsh/ directory

* Backup:

        mv ~/.zshrc ~/.zshrc.bak
        mv ~/.zsh/ ~/.zsh.bak/

* Delete:

        rm ~/.zshrc
        rm -rf ~/.zsh/


Then, clone the repo using

        git clone git://github.com/hackstedt/.zsh.git ~/.zsh

Finally (and this might be an inconvenient solution, but i'm open for suggestions), softlink the repos' .zshrc to the $HOME/.zshrc:

        ln -s ~/.zsh/.zshrc ~/.zshrc

## License

This .zshrc is, obviously, free software and licensed under GPL v3

## Quick note

Make zsh the default shell:

        chsh -s $(which zsh)

Make the plugin directory:

        mkdir ~/.zsh/plugins 

Follow the instructions on this side, to install (in the folder you just made) the zsh-syntax-highlighting:

https://github.com/zsh-users/zsh-syntax-highlighting

To to tweak the plugin mentioned above (also in the plugin folder):

https://github.com/zsh-users/zsh-syntax-highlighting

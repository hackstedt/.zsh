## About

This repo provides a customized .zshrc and .zsh/ config folder.

## Setup

In order to use this repo, do the following in your home directory

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

Create the plugin directory (if it's not created automatically by the steps below):

        mkdir ~/.zsh/plugins/

and for the plugins below (if it's not created automatically by the steps below):

        mkdir ~/.zsh/plugins/zsh-syntax-highlighting
        mkdir ~/.zsh/plugins/zsh-history-substring-search
        mkdir ~/.zsh/plugins/LS_COLORS

Follow the instructions on this side, to install (in the folder you just made) the zsh-syntax-highlighting:

https://github.com/zsh-users/zsh-syntax-highlighting

Shortcut:

        git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting

Follow the instructions on this side, to install (in the folder you just made) the zsh-history-substring-search:

https://github.com/zsh-users/zsh-history-substring-search

Shortcut:

        git clone git://github.com/zsh-users/zsh-history-substring-search.git ~/.zsh/plugins/zsh-history-substring-search

Follow the instructions on this side, to install (in the folder you just made) the LS_COLORS:

https://github.com/trapd00r/LS_COLORS

Shortcut:

        git clone git://github.com/trapd00r/LS_COLORS.git ~/.zsh/plugins/LS_COLORS

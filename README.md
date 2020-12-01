# Management
This repository is managed through a bare git repository. This used to be a bare git repository that was migrated from [stow](https://www.gnu.org/software/stow/) that used to use [yadm](https://thelocehiliosan.github.io/yadm/) that switched back to a bare git repository. Original bare repository ideas were taken from [Hacker News](https://news.ycombinator.com/item?id=11070797) with aliases and snippets from [jaagr's dotfiles](https://github.com/jaagr/dots).


## Git-only Bare Repository

#### Alias
~~~ sh
alias dots="git --git-dir=$HOME/.dots/repo.git/ --work-tree=$HOME"
~~~

#### Configuration
~~~ sh
dots config status.showUntrackedFiles no

# This config is not needed if you whitelist your files through .gitignore
~~~

#### Replication (Existing Remote Repository)
~~~ sh
git clone --bare <url> $HOME/.dots/repo.git

# Checkout existing files
dots checkout HEAD -- $HOME

# Change remote URL if needed
dots remote set-url origin <url>
~~~

#### Setup (No Existing Remote Repository)
~~~ sh
git init --bare $HOME/.dots/repo.git
dots remote add origin <url>
dots push -u origin master
~~~

#### Usage
~~~ sh
# Use the dots alias like you would use the git command
dots status
dots add -u ...
dots commit -m "..."
dots push

# Listing files (not tracked by git)
dots status -u
dots status -u ~/.config/

# Listing files (tracked by git)
dots ls-files
dots ls-files ~/.config/
~~~


#### How to use
This setup is pretty agnostic to dotfile configuration, it only assumes the following:
* If something in this directory is a plain file, it should be linked in $HOME
* otherwise, if is a directory, linked in $HOME/.config
The script `symlink.sh` does just that, `--help` for more info.

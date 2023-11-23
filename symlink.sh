#!/bin/sh 

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
        echo "Usage: symlink.sh [FILE...]"
        echo "Creates link for specified dotfile:"
        echo "  - in \$HOME if is file,"
        echo "  - or in \$HOME/.config if is directory."
        echo "If none specified, links all files in current dir."
        exit 0
fi

main() {
        for FILE in $ARGUMENTS; do
                create_symlink $FILE
        done
}

create_symlink() {
        FILE=${1}
        FILENAME=${FILE##*/}
        SYMLINK_DIRECTORY="${HOME}"
        CONFIG_DIRECTORY=".config"

        if test -d "${FILE}"; then
                SYMLINK_DIRECTORY+="/${CONFIG_DIRECTORY}"
        fi

        echo "ln -sf ${FILE} ${SYMLINK_DIRECTORY}/${FILENAME}"
}

ARGUMENTS="$@"
if test -z "$ARGUMENTS"; then
        SCRIPT_NAME=$(basename "$0")
	SCRIPT_DIR=$(dirname -- "$0")
	SCRIPT_PATH=$(realpath -- "$SCRIPT_DIR")
        ARGUMENTS=$(find "$SCRIPT_PATH" -maxdepth 1 -mindepth 1 ! -name '.git*' ! -name "$SCRIPT_NAME")
fi
main "$@"

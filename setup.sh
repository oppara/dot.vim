#!/bin/sh

set -eu

CURRENT=$(cd $(dirname $0) && pwd)

dotfiles=$(ls $CURRENT | grep '^dot\.')

for file in $dotfiles
do

    org=${file}

    src="${CURRENT}/${org}"
    target="${HOME}/${file#dot}"

    # ファイルやディレクトリが存在する場合はスキップ
    if test -e "$target" && ! test -L "$target" ; then
        echo "file or directory already exists!! [${target}] "
        continue
    fi

    if test -L "$target" ; then
        rm "$target"
    fi

    ln -s "$src" "$target"
    echo "ln -s $src ${target}"

done

echo "done."

# bin/bash

CONF_DIR="$(pwd)/.config"
for dotfile in "$CONF_DIR"/*; do
  [[ "$dotfile" == "${CONF_DIR}/.git" || "$dotfile" == "${CONF_DIR}/.github" || "$dotfile" == "${CONF_DIR}/.DS_Store" ]] && continue
  ln -sfnv "$dotfile" "$HOME/.config"
done

HOMEFILE_DIR="$(pwd)/.home"
for dotfile in "${HOMEFILE_DIR}"/.??*; do
  [[ "$dotfile" == "${HOMEFILE_DIR}/.git" || "$dotfile" == "${HOMEFILE_DIR}/.github" || "$dotfile" == "${HOMEFILE_DIR}/.DS_Store" ]] && continue
  ln -fnsv "$dotfile" "$HOME"
done

if [ "$(uname)" = "Darwin" ]; then
  ln -fnsv $(pwd)/.exc/settings.json $HOME/Library/Application\ Support/Code/User
elif [ "$(uname -s)" = "Linux" ]; then
  ln -fnsv $(pwd)/.exc/settings.json $HOME/.config/Code/User
else
  exit 1
fi

# check brew
command brew -v

if [ $? = 0 ]; then
  echo "done"
else
  echo "something wrong"
fi

rm -f .$CONF_DIR

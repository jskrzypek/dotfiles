# path, the 0 in the filename causes this to load first

pathRemove() {
  # Removes the passed parameter from the path
  PATH=${${PATH//$1:/}//:$1/}
}

pathReplace() {
  # Replaces the first passed parameter with the second
  PATH=${${PATH//$1:/$2:}//:$1/:$2}
}

pathPrepend() {
  # Shifts entry to the start of the path and removes it if present
  PATH=$1:${${PATH##$1:}//:$1/}
}

pathAppend() {
  # Only adds to the path if it's not already there
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    PATH=$PATH:$1
  fi
}

# Make versions for use outside the zsh init system
pathExport() {
  export PATH
}
pathRemove!() {
  pathRemove "$@"
  pathExport
}
pathReplace!() {
  pathReplace "$@"
  pathExport
}
pathPrepend!() {
  pathPrepend "$@"
  pathExport
}
pathAppend!() {
  pathAppend "$@"
  pathExport
}

# Remove duplicate entries from PATH:
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

# Use brew make & ruby by preference
pathPrepend "/opt/homebrew/opt/make/libexec/gnubin"
pathPrepend "/opt/homebrew/lib/ruby/gems/3.1.0/bin"
pathPrepend "/opt/homebrew/opt/ruby/bin"
pathPrepend "/usr/local/bin"
pathPrepend "/opt/homebrew/bin"
pathPrepend "/opt/homebrew/sbin"


pathAppend "$HOME/.yadr/bin"
pathAppend "$HOME/.yadr/bin/yadr"
pathAppend "/nix/var/nix/profiles/default/bin"
pathAppend "$HOME/.nix-profile"

# npm_global_bin="$FNM_DIR/node-versions/$(fnm current || fnm ls | grep "default" | head -1 | cut -d' ' -f2)/installation/bin"
# if [[ -d $npm_global_bin ]]; then
#   pathPrepend "$npm_global_bin"
# fi

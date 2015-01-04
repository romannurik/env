# Load bashrc (local env)
if [[ -d ~/.bashrc.d ]]; then
  for f in $(ls ~/.bashrc.d); do
    source ~/.bashrc.d/$f
  done
fi

# Load bashrc (version controlled env)
BASHRC_DIR=`dirname $BASH_SOURCE`/bashrc.d
BASHRC_DIR="`cd "${BASHRC_DIR}";pwd`"

if [[ -d "$BASHRC_DIR" ]]; then
  for f in $(ls $BASHRC_DIR); do
    source $BASHRC_DIR/$f
  done
fi

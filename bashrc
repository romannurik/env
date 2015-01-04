BASHRC_DIR=`dirname $BASH_SOURCE`/bashrc.d
BASHRC_DIR_NORMALIZED="`cd "${BASHRC_DIR}";pwd`"

if [[ -d "$BASHRC_DIR_NORMALIZED" ]]; then
  for f in $(ls $BASHRC_DIR_NORMALIZED); do
    source $BASHRC_DIR_NORMALIZED/$f
  done
fi

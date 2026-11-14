#!/usr/bin/env zsh
# Installs every skill in this pack into Claude Code's personal skills folder,
# so they are available in all projects.
#
#   zsh scripts/install.zsh           link each skill (edits and git pull take effect at once)
#   zsh scripts/install.zsh --copy    copy instead of linking
#   add --force to replace a skill folder that already exists
set -e
root=${0:A:h:h}
src=$root/plugins/data-lifecycle/skills
dest=${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills
mode=link
done_word=linked
force=0
for arg in "$@"; do
  case $arg in
    --copy) mode=copy; done_word=copied ;;
    --force) force=1 ;;
    *) print "unknown option: $arg"; exit 1 ;;
  esac
done

mkdir -p $dest
for dir in $src/*(/); do
  name=${dir:t}
  target=$dest/$name
  if [[ -e $target && ! -L $target && $force -eq 0 ]]; then
    print "skipped  $name  ($target already exists; rerun with --force to replace it)"
    continue
  fi
  rm -rf $target
  if [[ $mode == copy ]]; then
    cp -R $dir $target
  else
    ln -s $dir $target
  fi
  print "$done_word  $name"
done
print "\nInstalled into $dest. Start a new Claude Code session to pick them up."

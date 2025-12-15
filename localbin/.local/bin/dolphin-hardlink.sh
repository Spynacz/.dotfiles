#!/usr/bin/env bash
src="$1"
destdir="$(kdialog --getexistingdirectory .)"
[ -z "$destdir" ] && exit 0
ln "$src" "$destdir/$(basename "$src")"


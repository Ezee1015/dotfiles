#!/bin/bash

ROFI_COMMAND="rofi -dmenu -i"

# BROWSER_COMMAND="firefox"
# BROWSER_COMMAND="flatpak run org.mozilla.firefox"
BROWSER_COMMAND="flatpak run io.gitlab.librewolf-community"

# BROWSER_INFO_FOLDER="$HOME/.mozilla"
# BROWSER_INFO_FOLDER="$HOME/.var/app/org.mozilla.firefox/.mozilla"
BROWSER_INFO_FOLDER="$HOME/.var/app/io.gitlab.librewolf-community/.librewolf"

EXCLUDE_FOLDERS="'Mozilla Firefox', 'Manjaro Linux'"

get_bookmarks() {
  DB="$(find $BROWSER_INFO_FOLDER -iname '*places.sqlite')"
  BOOKMARKS_TXT="/tmp/bookmarks.txt"

  # If the bookmarks list already exist
  if [[ -f "$BOOKMARKS_TXT" ]]; then
    SHASUM_DB="$(cat "$DB" | shasum)"
    SHASUM_TXT="$(cat "$BOOKMARKS_TXT" | head -n 1)"

    # echo "SHASUM DB : $SHASUM_DB"
    # echo "SHASUM TXT: $SHASUM_TXT"

    # If the bookmarks didn't change
    if [[ "$SHASUM_DB" == "$SHASUM_TXT" ]]; then
      BOOKMARKS="$(cat $BOOKMARKS_TXT | tail -n +2)"
    else
      echo "- Bookmarks file updated. Reloading bookmarks..."
      rm "$BOOKMARKS_TXT"
      get_bookmarks
    fi
  else
    echo "- Creating bookmarks list..."
    cp "$DB" "/tmp"

    SQL_EXCLUDE_FOLDERS="
      SELECT moz_bookmarks.id
      FROM moz_bookmarks
      WHERE type=2 AND title IN ($EXCLUDE_FOLDERS)" # type=2 means folder
    SQL="
      SELECT moz_places.url, moz_bookmarks.title
      FROM moz_bookmarks
      JOIN moz_places
      ON moz_bookmarks.fk = moz_places.id
      WHERE moz_bookmarks.parent NOT IN ($SQL_EXCLUDE_FOLDERS)"

    BOOKMARKS="$(sqlite3 -line "/tmp/places.sqlite" "$SQL")"

    cat "/tmp/places.sqlite" | shasum > $BOOKMARKS_TXT
    echo "$BOOKMARKS" >> $BOOKMARKS_TXT

    rm "/tmp/places.sqlite"
  fi
}

parse_bookmarks() {
  BOOKMARKS_TITLES="$(echo "$BOOKMARKS" | grep 'title' | awk '{$1=$2=""; print $0}' | sed 's/^ *//g')"
  BOOKMARKS_URLS="$(echo "$BOOKMARKS" | grep 'url' | awk '{$1=$2=""; print $0}' | sed 's/^ *//g')"

  BOOKMARKS=$(paste -d "," -- <(echo "$BOOKMARKS_TITLES") <(echo "$BOOKMARKS_URLS") | awk -F ',' '{print $1 " (" $2 ")"}')
}

rofi_bookmarks() {
  BOOKMARK_SELECTED=$(echo "$BOOKMARKS" | $ROFI_COMMAND)

  if [[ -z "$BOOKMARK_SELECTED" ]]; then
    exit 0
  fi

  WEBPAGE=$(echo "$BOOKMARK_SELECTED" | sed 's/.*(\(\(http:\/\/\|https:\/\/\|ext+container:\).*\))$/\1/g')

  echo "Opening with $BROWSER_COMMAND: $WEBPAGE"

  $BROWSER_COMMAND "$WEBPAGE"
}

get_bookmarks
parse_bookmarks
rofi_bookmarks

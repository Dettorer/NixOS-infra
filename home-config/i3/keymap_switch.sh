#!/usr/bin/env zsh

# Get current keymap
SETKEYMAP="/usr/bin/setxkbmap"
get_keymap() {
    QUERY="$SETKEYMAP -query"
    KEYMAP=`eval $QUERY | grep 'layout' | sed 's/^layout:     //'`
    VARIANT=`eval $QUERY | grep 'variant' | sed 's/^variant:    //'`
}

# Switch between keymaps in this order :
# bépo
#   ↓
# qwerty
#   ↓
# azerty
#   ↓
# dvorak
cycle_switch() {
    case $KEYMAP in
    "us") NEWMAP="fr oss" ;;
    "fr")
        case $VARIANT in
            "oss") NEWMAP="dvorak" ;;
            "bepo") NEWMAP="us intl" ;;
            *) NEWMAP="fr bepo" ;; # No idea what is going on, fallback on bepo
        esac ;;
    "dvorak") NEWMAP="fr bepo" ;;
    *) NEWMAP="fr bepo" ;; # No idea what is going on, fallback on bepo
    esac
}

if [[ $# -gt 0 ]]
then
    NEWMAP=$*
else
    get_keymap
    cycle_switch
fi

# Change keymap
eval "$SETKEYMAP $NEWMAP"

# setxkbmap broke the caps lock / escape swap
setxkbmap -option caps:swapescape

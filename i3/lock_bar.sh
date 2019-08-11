#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#ff00ffcc'  # default
T='#ee00eeee'  # text
W='#880000bb'  # wrong
V='#bb00bbbb'  # verifying

# format: rrggbbaa
insidecolor=00000000
ringcolor=ffffffff
keyhlcolor=d23c3dff
bshlcolor=d23c3dff
separatorcolor=00000000
insidevercolor=00000000
insidewrongcolor=d23c3dff
ringvercolor=999999dd
ringwrongcolor=990000dd
verifcolor=ffffffff
wrongcolor=ffffffff
timecolor=0088ffff
datecolor=ff9900ff
loginbox=00000066
barcolor=000000cc
keyhlcolor=cc6600cc

barheight=10
font="sans-serif"
locktext='Type password to unlock...'
# default value
lockImage="./lockscreen_background"

f_lockblur() {
    i3lock-color \
        --blur 5 \
        --bar-indicator \
        --bar-position h \
        --bar-direction 1 \
        --bar-max-height $barheight \
        --bar-base-width $barheight \
        --bar-color $barcolor \
        --keyhlcolor $keyhlcolor \
        --bar-periodic-step 150 \
        --bar-step 5 \
        --bar-width 100 \
        --redraw-thread \
        \
        --clock \
        --force-clock \
        --timepos 5:h-80 \
        --timecolor $timecolor \
        --datepos tx+5:ty+15 \
        --datecolor $datecolor \
        --date-align 1 \
        --time-align 1 \
        --ringvercolor $ringvercolor \
        --ringwrongcolor $ringwrongcolor \
        --statuspos 5:h-16 \
        --verif-align 1 \
        --wrong-align 1 \
        --verifcolor $verifcolor \
        --wrongcolor $wrongcolor \
        --modifpos -50:-50 \
        \
        --screen 1
}

f_blurbg() {
    i3lock-color \
        -t -i ~/Pictures/Wallpapers/alena-aenami-s1k.jpg \
        --blur 5 \
        --bar-indicator \
        --bar-position h \
        --bar-direction 1 \
        --bar-max-height $barheight \
        --bar-base-width $barheight \
        --bar-color $barcolor \
        --keyhlcolor $keyhlcolor \
        --bar-periodic-step 150 \
        --bar-step 5 \
        --bar-width 100 \
        --redraw-thread \
        \
        --clock \
        --force-clock \
        --timepos 5:h-80 \
        --timecolor $timecolor \
        --datepos tx+5:ty+15 \
        --datecolor $datecolor \
        --date-align 1 \
        --time-align 1 \
        --ringvercolor $ringvercolor \
        --ringwrongcolor $ringwrongcolor \
        --statuspos 5:h-16 \
        --verif-align 1 \
        --wrong-align 1 \
        --verifcolor $verifcolor \
        --wrongcolor $wrongcolor \
        --modifpos -50:-50 \
        \
        --screen 1
}

# parse arguments
for i in "$@"
do
    case "$1" in
        -t|--type)
            shift
            lockType="$1"
            ;;
        -i|--image)
            shift
            lockImage="$1"
            ;;
        *)
            shift
            ;;
    esac
done

case "$lockType" in 
    blur)
        f_lockblur
        ;;
    bg)
        f_blurbg
        ;;
    *)
        f_lockblur
        ;;
esac

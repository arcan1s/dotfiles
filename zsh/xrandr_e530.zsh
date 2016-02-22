# xrandr functions for ThinkPad E530
# functions to contorl xrandr
# EXAMPLE: projctl 1024x768
projctl() {
  local MONITORS="$(xrandr | grep connected | cut -d ' ' -f 1 | tr '\n' ' ')"
  echo "Available monitors are: ${MONITORS}"
  local FIRSTMON="LVDS1"
  local SECONDMON="VGA1"
  local RESOLUTION="1366x768"
  until [ -z $1 ]; do
    case "$1" in
      "-h" | "--help"    ) echo "Usage: projctl [ off/resol ] [ -o MON | --output MON ]" && return 0 ;;
      "-o" | "--output"  ) [ -z "$2" ] || SECONDMON="$2" && shift                                    ;;
      *                  ) RESOLUTION="$1"                                                           ;;
    esac
    shift
  done
  if [[ "${RESOLUTION}" == "off" ]]; then
    echo "Disable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --mode ${RESOLUTION} --output ${SECONDMON} --off
  else
    echo "Using resolution: ${RESOLUTION}"
    xrandr --output ${FIRSTMON} --mode ${RESOLUTION} --output ${SECONDMON} --mode ${RESOLUTION}
  fi
}

twinmon() {
  local MONITORS="$(xrandr | grep connected | cut -d ' ' -f 1 | tr '\n' ' ')"
  echo "Available monitors are: ${MONITORS}"
  local FIRSTMON="LVDS1"
  local SECONDMON="VGA1"
  local MODE="on"
  until [ -z $1 ]; do
    case "$1" in
      "-h" | "--help"    ) echo "Usage: twinmon [ off ] [ -o MON | --output MON ]" && return 0 ;;
      "-o" | "--output"  ) [ -z "$2" ] || SECONDMON="$2" && shift                              ;;
      "off"              ) MODE="off"                                                          ;;
    esac
    shift
  done
  if [[ "${MODE}" == "off" ]]; then
    echo "Disable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --auto --primary --output ${SECONDMON} --off
  else
    echo "Enable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --auto --primary --output ${SECONDMON} --auto --left-of ${FIRSTMON}
  fi
}

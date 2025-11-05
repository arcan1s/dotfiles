GARMIN_SDK_CONFIG="$HOME/.Garmin/ConnectIQ/current-sdk.cfg"
if [ -f "$GARMIN_SDK_CONFIG" ]; then
  export PATH="$(cat "$GARMIN_SDK_CONFIG")/bin:$PATH"
fi

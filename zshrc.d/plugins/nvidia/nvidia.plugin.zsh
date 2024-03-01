#
# Functions
#

function nvidia-set-fan() {
  echo "Setting fan speed to $1 percent."
  sudo nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=$1"
}

function nvidia-get-fan() {
  nvidia-settings -q "[fan:0]/GPUTargetFanSpeed"
}

function nvidia-core-temp () {
  nvidia-settings -q "[gpu:0]/GPUCoreTemp"
}

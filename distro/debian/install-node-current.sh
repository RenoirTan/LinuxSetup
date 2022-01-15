source ../utils.sh

apt install curl software-properties-common
curl -sL https://deb.nodesource.com/setup_current.x | bash -
apt update && apt install nodejs


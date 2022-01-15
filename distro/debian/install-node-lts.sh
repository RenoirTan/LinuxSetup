source ../utils.sh

apt install curl software-properties-common
curl -sL https://deb.nodesource.com/setup_lts.x | bash -
apt update && apt install nodejs


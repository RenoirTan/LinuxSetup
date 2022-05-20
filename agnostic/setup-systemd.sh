source ../utils.sh

lxspr_backup /etc/systemd/logind.conf
sed 's/^\s*NAutoVTs.*/#&/' logind.conf > /tmp/logind.conf
echo 'NAutoVTs=12' | tee -a /tmp/logind.conf >/dev/null
mv /tmp/logind.conf /etc/systemd/logind.conf

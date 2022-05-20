source ../utils.sh

lxspr_backup /etc/systemd/logind.conf
sed 's/^\s*NAutoVTs.*/#&/' /etc/systemd/logind.conf > /tmp/logind.conf
echo 'NAutoVTs=12' | tee -a /tmp/logind.conf >/dev/null
mv /tmp/logind.conf /etc/systemd/logind.conf

lxspr_backup /etc/systemd/journald.conf
sed 's/^\s*SystemMaxUse*/#&/' /etc/systemd/journald.conf > /tmp/journald.conf
echo 'SystemMaxUse=100M' | tee -a /etc/systemd/journald.conf >/dev/null
mv /tmp/journald.conf /etc/systemd/journald.conf

source ../utils.sh


required_exec="openssl"
for executable in $(lxsp_split_str "$required_exec" ";"); do
    if [ $(lxsp_command_exists "$executable") == "0" ]; then
        echo "Could not find $executable"
        exit 1
    fi
done


keys_dir="/etc/efi-keys"
mok_key="$keys_dir/MOK.key"
mok_crt="$keys_dir/MOK.crt"
mok_cer="$keys_dir/MOK.cer"


mkdir -p "$keys_dir"


openssl req -newkey rsa:4096 -nodes -keyout "$mok_key" -new -x509 -sha256 -days 3650 -subj "/CN=Renoir Machine Owner Key/" -out "$mok_crt"
openssl x509 -outform DER -in "$mok_crt" -out "$mok_cer"

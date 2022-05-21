source ../utils.sh


required_exec="openssl"
for executable in $(lxsp_split_str "$required_exec" ";"); do
    if [ $(lxsp_command_exists "$executable") == "0" ]; then
        echo "Could not find $executable"
        exit 1
    fi
done

echo -n "What do you want to name the Machine Owner Keys? "
read mok_name
if [ -z $mok_name ]; then
    echo "No name was given. Aborting!"
    exit 1
fi
echo -n "How long do you want the keys to last? "
read shelf_life
if echo $shelf_life | grep -E '^[0-9]+$' &>/dev/null; then
    echo "Expected a positive integer!"
    exit 1
fi

keys_dir="/etc/efi-keys"
mok_key="$keys_dir/MOK.key"
mok_crt="$keys_dir/MOK.crt"
mok_cer="$keys_dir/MOK.cer"


mkdir -p "$keys_dir"


openssl req -newkey rsa:4096 -nodes -keyout "$mok_key" -new -x509 -sha256 -days $shelf_life -subj "/CN=$mok_name/" -out "$mok_crt"
openssl x509 -outform DER -in "$mok_crt" -out "$mok_cer"


echo "You can find the keys under '$keys_dir'"
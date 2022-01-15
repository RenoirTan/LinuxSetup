source ../utils.sh

if ! command -v sdk > /dev/null; then
	echo "SDK Man has not been installed!"
	exit 1
fi


while IFS= read -r line; do
	candidate=""
	identifier=""
	tline=$(echo $line | tr " " "\n")
	for part in $tline; do
		if [ "$candidate" == "" ]; then
			candidate=$part
		elif [ "$identifier" == "" ]; then
			identifier=""
		else
			echo "Invalid line in agnostic/sdkman-packages.txt: $line"
			exit 1
		fi
	done
done < "./sdkman-packages.txt"


source ../utils.sh

if ! command -v code > /dev/null; then
	echo "Visual Studio Code has not been installed!"
	exit 1
fi

while IFS= read -r line; do
	code --install-extension "$line"
done < vscode-extensions.txt


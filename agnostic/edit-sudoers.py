import re
import sys

groups_regex = "|".join(sys.argv[1:])
print(f"{groups_regex=}")

original = open("/etc/sudoers", "r")
new = open("/tmp/sudoers", "w")

for line in original:
    if re.search(f"^[^#]*%.*NOPASSWD", line) is not None:
        line = "# " + line
    elif (
        re.search(f"^\s*#\s*%({groups_regex}).*$", line) is not None and
        "NOPASSWD" not in line
    ):
        line = re.sub("\s*#\s*", "", line, 1)
    new.write(line)

original.close()
new.close()

# LinuxSetup
Repository for setting up a working linux environment, mainly focused on what I prefer.

There are scripts, configurations and patch files for each distro that modify the system to fix things like audio and setup things like secure boot (for distros that don't do it out of the box for you). For each distro under the `distro/` directory, there are also scripts for installing certain packages (or group of packages). Currently, there are scripts specific to Arch Linux, Debian and Ubuntu.

Each setup script usually starts with either `install-*` or `setup-*` and apply some change to the system. Some have a corresponding `restore-*` or `clean-*` script that undo those changes. For example, `agnostic/setup-sddm.sh` sets up [SDDM](https://github.com/sddm/sddm) with the base settings that I like and creates a backup (.old suffix) for any previous configurations while `agnostic/restore-sddm.sh` undoes those changes and resets the settings to those backed up configurations.

For more information about what kind of scripts are available, you can refer to the [Repository Structure](#repository-structure).


## Repository Structure

```
.
├─ distro/ # distro specific files
│  │
│  └─ <distro name>.../ # Name of the linux distribution
│     │
│     ├─ <installation files>... # Relevant scripts used to setup the system
│     │                          # for that specific distro
│     │
│     └─ fs/ # The directory representing the root filesystem of the system
│
├─ agnostic/ # distro-agnostic files
│  │
│  ├─ <installation files>... # Relevant scripts used to setup the system
│  │
│  ├─ fs/ # The directory representing the root filesystem
│  │
│  └─ user/ # My user home folder
│
├─ README.md # Readme for documentation
│
├─ LICENSE # Open source license
│
├─ setup.sh # Run one of the scripts in the distro or agnostic folders
│
├─ utils.sh # Bash script containing useful definitions that is sourced by
│           # other scripts
│
└─ <other>... 
```


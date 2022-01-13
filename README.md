# LinuxSetup
Repository for setting up a working linux environment tailored for my use.


# Repository Structure

```
.
├─ distro/ # distro specific files
│  └─ <distro name>.../ # Name of the linux distribution
│     ├─ <installation files>... # Relevant scripts used to setup the system
│     │                          # for that specific distro
│     └─ fs/ # The directory representing the root filesystem of the system
├─ agnostic/ # distro agnostic files
│  ├─ <installation files>... # Relevant scripts used to setup the system
│  ├─ fs/ # The directory representing the root filesystem
│  └─ user/ # My user home folder
├─ README.md # Readme for documentation
├─ LICENSE # Open source license
└─ <other>... 
```


# Setup for Arch Linux

Continue reading this document to setup Arch Linux.

## First steps

Read and follow the instructions in [Arch Linux Install Guide](https://wiki.archlinux.org/title/Installation_guide) before you can start the setup. Do remember the directory you used for *`esp`* as you will need it to install `grub`.

Some extra packages you should probably install in the *`chroot`* system include:

 1. `networkmanager` Enable `NetworkManager.service` for internet.
 2. `git` To clone this repository on the new installation.
 3. `neovim` To edit files.

Now you're ready to begin the setup.

## Getting started

In `chroot`:

```bash
# Should be fine as long as it doesn't interfere with other directories.
cd /
git clone https://github.com/RenoirTan/LinuxSetup
cd LinuxSetup
# You should now be in `/LinuxSetup`.
```

## Warming up

Just to make the installation process a little bit faster, run

```bash
./setup.sh distro/arch/setup-pacman.sh
```

which applies a patch that allows parallel downloads. This patch also enables the `[multilib]` repository.

Optionally, install `reflector` to access the fastest mirrors.

```bash
./setup.sh distro/arch/install-reflector.sh
```

## Install basic packages

Now, install some basic packages. Without them, the system wouldn't be able to boot by itself.

```bash
./setup.sh distro/arch/install-packages.sh basic
```

Adding `"basic"` to the end of the above command tells the `install-packages.sh` script to install the packages listed in `distro/arch/packages/basic-packages.txt`. You can replace `basic` with any other `<word>` as long as `<word>-packages.txt` exists.

## Sudo

Run `EDITOR=nvim visudo /etc/sudoers` and uncomment the line `# %wheel ALL=(ALL:ALL) ALL`.

Now you can add a user under the `wheel` group for the following steps.

## Create a non-root user

Add a user using the following commands, substituting in your own name where applicable.

```bash
useradd renoir -m -s /usr/bin/zsh -G wheel
passwd renoir # Enter your password here
```

Exit `chroot` and enter it again as the new user:

```bash
arch-chroot /mnt -u renoir
```

Confirm you're logged in as the new user by running `whoami`.

Now, move `LinuxSetup` to a folder inside the new home folder.

```bash
# Optional, this is just how I organise my things.
mkdir -p ~/Code/remote/github.com/RenoirTan && cd ~/Code/remote/github.com/RenoirTan

sudo mv /LinuxSetup ./LinuxSetup
# Fix permissions
sudo chown renoir -R ./LinuxSetup
sudo chgrp renoir -R ./LinuxSetup
cd LinuxSetup
```

## The AUR (optional)

Some of the following steps require packages from the AUR although they are not strictly necessary for a fully functioning system. If you do choose to skip out on AUR support, all you will lose is secure boot, and a few applications like Tor Browser.

For this guide, I will use [paru](https://github.com/Morganamilo/paru) as my AUR helper of choice. Get started by running this command and wait for it to compile. This will probably take a while as `rustc` isn't exactly fast.

```bash
./setup.sh distro/arch/install-paru.sh
```

## Grub

**SKIP IF YOU WANT TO USE SECURE BOOT**

If you don't need secure boot support, this step should be relatively straightforward. Run

```bash
./setup.sh agnostic/install-grub.sh
```

Answer the prompts and you should be set. This is where the `esp` directory from earlier should come in.

### Secure boot (needs AUR)

**SKIP IF YOU DON'T WANT TO USE SECURE BOOT**

***TODO: Separate Plymouth from secure boot***

For secure boot, I have chosen `shim` as it doesn't require you to modify key exchange keys (KEK) and other complicated mechanisms I don't feel comfortable touching. `shim` is signed by Microsoft (or something like that), so installation should only require copying the correct files to the correct destinations.

Install `shim` with

```bash
./setup.sh distro/arch/install-packages.sh aur-boot
```

Create a Machine Owner Key:

```bash
./setup.sh agnostic/setup-machine-owner-keys.sh
```

Install grub with secure boot support and answer the prompts:

```bash
./setup.sh agnostic/install-grub-secure-boot.sh
```

You will need to find where the file `grubx64.efi` was installed to. If your `esp` is `/boot` and `Arch Linux` as your EFI label, this file should be located under `/boot/EFI/Arch Linux/grubx64.efi`.

Install `shim` bootloader on top of grub. At some point, the script will ask which drive and partition `shim` will be installed to. If your `esp` directory was mounted from `/dev/sda1` for example, use `/dev/sda` as the drive and `1` as the partition.

The script will instruct you to enrol a new certificate during boot. Remember the instructions as you will need them on the next reboot.

## Reboot

At this point, your new system should be ready for a reboot. Follow the arch install guide on how to unmount your drives and reboot. If you have installed `shim`, go and enable secure boot in your BIOS. Unplug the USB containing the Arch Linux install medium so that you will boot into the new system.

## Exploring your barebones system

If all goes according to plan, you should see a basic login prompt in the terminal. Loginas your non-root user before continuing. A few basic things to check:

 1. Make sure your shell is `zsh`. Run `echo $SHELL` to confirm this.
 2. Access to an internet connection. If you haven't enabled and started `NetworkManager.service`, do it now.

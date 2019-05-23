# GIST Arch linux setup

## Prep from live usb
Boot to live environment in order to prepare disk with partitions.

1. Ensure that a internet connection exists
```sh
ping google.com
```
 - If it does not work:
    ```sh
    $ ip link # Check the name if the wired network interface
    $ nano /etc/systemd/network/enp0s31f6.network # Create file for interface with contents:
    [Match]
    name=en*
    [Network]
    DHCP=yes

    $ systemctl restart systemd-networkd
    $ systemctl enable systemd-networkd
    $ nano /etc/resolv.conf # Add DNS 
    nameserver 8.8.8.8,
    nameserver 8.8.4.4
    ```


2. Update system clock
```sh
timedatectl set-ntp true
```

3. Prepare disk
    - Make sure you have a clean GPT patition table
    ``` sh
    gdisk /dev/sdx
    gdisk o #o option creates new GPT table
    ```
    - Partition disk
    ```sh
    gdisk d # Delete all existing partitions (if any)
    gdisk n # Create new parition for efi boot (512 MiB)
    gdisk t 1 ef00 # Change partition 1 to EFI System
    gdisk n # Create new partition for swap (2 GiB)
    gdisk n # Create new parition for root (remaining disk size)
    gdisk w #w options writes changes to disk
    ```
    - Format partitions
    ```sh
    mkfs.fat /dev/sdx/sdx1 # EFI should have filesystem supported by many OS:es
    mkfs.ext4 /dev/sdx/sdx3 # Root partition is ext4
    mkswap /dev/sdx2
    swapon /dev/sdx2
    ```

4. Mount file system
```sh
mount /dev/sdx3 /mnt
mkdir /mnt/efi
mount /dev/sdx1 /mnt/efi
```

5. Install arch linux
```sh
pacstrap /mnt base base-devel
```

6. Generate a fstab file
```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

7. Change root directory
```sh
arch-chroot /mnt
```

8. Set time zone and set hardware clock to UTC
```sh
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
```

9. Localization
```sh
# Uncomment en_US.UTF-8 UTF-8 and other needed locales in /etc/locale.gen, and generate them with:
locale-gen
# Set LANG variable
nano /etc/locale.conf 
LANG=en_US.UTF-8
```

10. Network Config
```sh
$ nano /etc/hostname
<myhostname>
$ nano /etc/hosts
<
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname>
```

11. Root password
```sh
passwd
```

12. Add user
```sh
useradd -m adam
passwd adam
pacman -S sudo # Install sudo
nano /etc/sudoers # Add line for new user (copy root user privileges)
```

12. Install GRUB bootloader
```sh
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

13. Install Gnome
```sh
pacman -S xorg xorg-server
pacman -S gnome gnome-extra
systemctl start gdm.service
systemctl enable gdm.service
```

14. Reboot

Everything base wise should now be set up

## First boot
You should be able to login with the user you created!

### Wireless
1. Check if firmware for Wifi has been installed
```sh
lspci -k # Look for wifi card
```

```sh
ip link # look for wlan0 or wlp or similar
```

2. Use netctl to set up wifi (profiles)
```sh
$ cp /etc/netctl/examples/wireless-wpa /etc/netctl/home_wifi
$ nano /etc/netctl/home_wifi # Change the SSID and password to that of your wifi 
```
Repeat above for more profiles

3. Enable netctl-auto
The netctl-auto tool will automatically select between available profiles when connecting to WIFI

```sh 
# Enable netctl in systemctl. Note that wlp58s0 is the name of your wifi interface, it will prbly differ
sudo systemctl enable netctl-auto@wlp58s0
sudo systemctl start netctl-auto@wlp58s0
```

Check if WIFI has been connected:
```sh
ping google.com
ip addr
```

Troubleshooting
```sh
systemctl # Se if the netctl-auto is running
# If it has failed. check the logs:
sudo journalctl  --no-pager | grep netctl
```

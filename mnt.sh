cryptsetup luksOpen /dev/disk/by-partlabel/LUKS cryptroot
mount /dev/disk/by-label/NixOS /mnt
umount /mnt
mount -o subvol=root,compress=zstd /dev/disk/by-label/NixOS /mnt
mkdir -p /mnt/boot/efi /mnt/home /mnt/swap
mount /dev/disk/by-label/EFI /mnt/boot/efi
mount -o subvol=home,compress=zstd /dev/disk/by-label/NixOS /mnt/home
mount -o subvol=swap /dev/disk/by-label/NixOS /mnt/swap

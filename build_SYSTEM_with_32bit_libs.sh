#!/bin/sh

# mounts the two squash fs image files
mkdir ./s1
mount -t squashfs -o loop ./SYSTEM_64bit ./s1
mkdir ./s2
mount -t squashfs -o loop ./SYSTEM_32bit ./s2

# creates a destination folder for the combined filesystem and copies the right files to the right places
mkdir ./system_final
cp -rp ./s1/* ./system_final
mkdir ./system_final/lib32
mkdir ./system_final/usr/lib32
cp -rp ./s2/lib/* ./system_final/lib32
cp -rp ./s2/usr/lib32/* ./system_final/usr/lib32
cp -rp ./src/* ./system_final

# creates a final SYSTEM quashfs image file with the contents from the combined folder
mkdir ./target
mksquashfs ./system_final ./target/SYSTEM -noappend -b 131072 -no-xattrs -comp lzo

# creates mdsum for the file
md5sum target/SYSTEM > target/SYSTEM.md5

  



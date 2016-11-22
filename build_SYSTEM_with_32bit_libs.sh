#!/bin/sh

HAS_BASE=0
mkdir -p ./target

if [ `id -u` -ne 0 ]; then
	echo "This script needs to be executed as root. Aborting..."
	rmdir ./target
	exit 0
fi

# Fixing ownership of folders downloaded via git
chown -R root:root ./src/*
# mounts the two squash fs image files
echo "Mounting the two squash filesystems into temporary folders..."
mkdir ./s1
mount -t squashfs -o loop ./SYSTEM_64bit ./s1
mkdir ./s2
mount -t squashfs -o loop ./SYSTEM_32bit ./s2
if [ -f ./SYSTEM_32bit_base ]; then
	HAS_BASE=1
	mkdir ./s3
	mount -t squashfs -o loop ./SYSTEM_32bit_base ./s3
fi

# creates a destination folder for the combined filesystem and copies the right files to the right places
echo "Creating the final folder..."
mkdir ./system_final
echo "Copying contents from original AARCH64 distro into final folder..."
cp -rp ./s1/* ./system_final
umount ./s1
echo "Creatng folders to host the 32 bit libraries..."
mkdir ./system_final/lib32
mkdir ./system_final/usr/lib32
echo "Copying the 32 bit libraries into final folder..."
# First copy libs from the base distro (which should have all . older veersions of the libs)
if [ $HAS_BASE -eq 1 ]; then
	cp -rp ./s3/lib/* ./system_final/lib32
	cp -rp ./s3/usr/lib/* ./system_final/usr/lib32
	umount ./s3
	rm -rf ./s3
fi
# and copy the more recenet libs on top
cp -rp ./s2/lib/* ./system_final/lib32
cp -rp ./s2/usr/lib/* ./system_final/usr/lib32
umount ./s2

echo "Copying the additional scripts and symbolic link to final folder..."
cp -rp ./src/* ./system_final

# creates a final SYSTEM quashfs image file with the contents from the combined folder
echo "Creating the final SYSTEM image file..."
mkdir -p ./target
mksquashfs ./system_final ./target/SYSTEM -noappend -b 131072 -no-xattrs -comp lzo
chmod 777 ./target/SYSTEM

# creates mdsum for the file
echo "Creating the MD5 checksum file..."
md5sum target/SYSTEM > target/SYSTEM.md5
chmod 777 ./target/SYSTEM.md5

# clean the temp folders
echo "Cleaning up temporary folders"
rm -rf ./s1 ./s2 ./system_final

echo "Completed. The final SYSTEM should be under target directory:"
ls -l ./target

  


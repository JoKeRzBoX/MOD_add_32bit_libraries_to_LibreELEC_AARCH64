# MOD_add_32bit_libraries_to_LibreELEC_AARCH64
Simple instructions and additional files to combine 32 bit ARM libraries to a 64 bit AARCH64 LibreELEC Build.

## Introduction
This is a simple manipulation of LibreELEC binaries to pack the 32 bit ARM libraries into the SYSTEM partition for a 64 bit AARCH64 build of LibreELEC.
In a nutshell, that this does is:

I have tested this with AMLogic S905 unnoficial LibreELEC builds made by kszaq using the builds for S805 as source for the 32 bit libraries. 

Although I hevn't tested, this can potentially be used to mod OpeneELEC AARCH64 SYSTEM partitions as well and add 32 bit libraries.

This is provided with no warranties so USE AT YOUR OWN RISK.


## Pre-Requirements

- required tools to run this on your linux environment: squashfs-tools
you can installl them as root via apt-get install squashfs-tools

- also please note for proper UID on the generated suqashfs image file, I recommend running these steps below as root:


## Instructions

1) Extract the SYSTEM file (sqhashfs image) from the original 64bit build you want to update. The zip or tar dsitributions are ideal for that but can also be extracted from the img.gz too (need to mount the img file from correct offset to access the files).

2) Similarly, extract the SYSTEM file (sqhashfs image) from the ARM 32bit build you want to use the 32 bit libraries from. The zip or tar distributions are ideal for that but can also be extracted from the img.gz too (need to mount the img file from correct offset to access the files). If you want tp also have anotehr source for older lib 32 libraries ou can extract such SYSTEM (optional)

3) from steps 1 and 3 above, copy the SYSTEM files to this folder renamed as per below:

   SYSTEM file from 64bit buld should be named: **SYSTEM_64bit**

   SYSTEM file from 32bit buld should be named: **SYSTEM_32bit**

   (optional) SYSTME file from older 32bit build (to retrieve older version of libraries) should be named **SYSTEM_32bit_base**

4) run the build script: **_sh ./build_SYSTEM_with_32bit_libs.sh_**

   The script will generate a SYSTEM and SYSTEM.md5 files under _target_ subdirectory which you should use to repack back into an update script. The easiest would be to crate a tar file for that which needs to include 4 files KERNEL (from original 64 bit, KERNEL.md5 (from original 64 bit), SYSTEM (just created) and SYSTEM.md5 (just created).



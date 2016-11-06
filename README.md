# MOD_add_32bit_libraries_to_LibreELEC_AARCH64
Simple instructions and additional files to combine 32 bit ARM libraries to a 64 bit AARCH64 LibreELEC Build.


## Pre-Requirements

required tools to run this on your linux environment: squashfs-tools
you can installl them as root via apt-get install squashfs-tools


## Instructions

1) Extract the SYSTEM file (sqhashfs image) from the original 64bit build you want to update. The zip or tar dsitributions are ideal for that but can also be extracted from the img.gz too (need to mount the img file from correct offset to access the files).

2) Similarly, extract the SYSTEM file (sqhashfs image) from the ARM 32bit build you want to use the 32 bit libraries from. The zip or tar distributions are ideal for that but can also be extracted from the img.gz too (need to mount the img file from correct offset to access the files).

3) from steps 1 and 3 above, copy the SYSTEM files to this folder renamed as per below:
   SYSTEM file from 64bit buld should be named: **SYSTEM_64bit**
   SYSTEM file from 32bit buld should be named: **SYSTEM_32bit**

4) run the build script: **_./build_SYSTEM_with_32bit_libs.sh_**
   The script will generate a SYSTEM and SYSTEM.md5 files under _target_ subdirectory which you should use to repack back into an update script. The easiest would be to crate a tar file for that which needs to include 4 files KERNEL (from original 64 bit, KERNEL.md5 (from original 64 bit), SYSTEM (just created) and SYSTEM.md5 (just created).





export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=$PATH:/home/user/Xilinx/Vitis/2023.1/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export VIVADO_SETTINGS=/home/user/Xilinx/Vivado/2023.1/settings64.sh
export VIVADO_VERSION=2023.1
export FORCE_UNSAFE_CONFIGURE=1
cd plutoplus
./scripts/apply.sh
cd plutosdr-fw

Apply this patch to m4 package:
https://github.com/buildroot/buildroot/commit/b2a1e959ea6da4ddfc6ffbe9877de9826a832684

make
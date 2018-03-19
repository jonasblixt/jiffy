cd ../../xvisor && make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- && cp build/vmm.bin ../jiffy/loader && cd ../jiffy/loader && make clean && make

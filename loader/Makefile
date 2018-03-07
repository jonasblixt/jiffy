# Makefile

PACKAGE:=loader

CROSS_COMPILE ?= arm-linux-gnueabihf-

CC=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy

CFLAGS:=-g -Os -nostartfiles -nostdlib -march=armv7ve -mtune=cortex-a7
LDFLAGS:= -g -Ttext 0 -X -Map loader.map

SRCS:= script.lds start.S
CSRCS:= tee.c vmm.c
OBJS:=$(SRCS:.S=.o)
COBJS:=$(CSRCS:.c=.o)

all: blobs $(PACKAGE).bin

$(PACKAGE).bin: $(PACKAGE)
	$(OBJCOPY) -O binary -R .bss -R .comment $< $@
	@mkimage -n imximage.cfg -T imximage -e 0xbfaffc00 -d loader.bin boot.imx

$(PACKAGE): $(OBJS) $(COBJS)
	$(LD) $(LDFLAGS) $(OBJS)  $(COBJS) -o $@

%.o: %.S
	$(CC) -c $(CFLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@


%.s: %.c
	$(CC) -S $(CFLAGS) $< -o $@


.PHONY: clean distclean
clean:
	@-rm -rf *.o $(PACKAGE) $(PACKAGE).bin *.map out

blobs:
	@./blobify tee.bin tee
	@./blobify vmm.bin vmm

prog:
	@imx_usb ./boot.imx

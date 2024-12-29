
# Toolchain
AS = as
CC = gcc
LD = ld
grub-mkrescue = grub-mkrescue
QEMU = qemu-system-x86_64

# Flags
ASFLAGS =
CFLAGS = -m64 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld --oformat=elf64-x86-64

# Files
KERNEL_ELF = kernel.elf
BOOT_OBJ = boot.o
KERNEL_OBJ = kernel.o
ISO_DIR = iso
ISO_FILE = iso.iso
GRUB_CFG = $(ISO_DIR)/boot/grub/grub.cfg

# Targets
all: $(ISO_FILE)

$(BOOT_OBJ): boot.S
	$(AS) $(ASFLAGS) -o $@ $<

$(KERNEL_OBJ): kernel.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(KERNEL_ELF): $(BOOT_OBJ) $(KERNEL_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

$(ISO_FILE): $(KERNEL_ELF) grub.cfg
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_ELF) $(ISO_DIR)/boot/kernel.elf
	cp grub.cfg $(GRUB_CFG)
	$(grub-mkrescue) -o $@ $(ISO_DIR)

run: $(ISO_FILE)
	$(QEMU) -cdrom $<

clean:
	rm -f $(BOOT_OBJ) $(KERNEL_OBJ) $(KERNEL_ELF)
	rm -rf $(ISO_DIR)
	rm -f $(ISO_FILE)

.PHONY: all clean run

.global _start
.section .multiboot
.align 4
.long 0x1BADB002       # magic number
.long 0x0              # flags
.long -(0x1BADB002)    # checksum

.section .text
.align 4
_start:
    cli                 # Disable interrupts

    # Remove segment loads unless a GDT is set up
    # mov $0x28, %ax
    # mov %ax, %ds
    # mov %ax, %es
    # mov %ax, %fs
    # mov %ax, %gs

    lea kernel_main(%rip), %rbx # Load kernel entry point
    jmp *%rbx

.global kernel_main

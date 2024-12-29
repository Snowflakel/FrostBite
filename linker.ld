ENTRY(_start)
SECTIONS
{
    /* Multiboot header must be in the first 8 KiB */
    . = 0x100000;

    .text : {
    *(.multiboot)
    *(.text)
    }

    .rodata : {
        *(.rodata)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
        *(COMMON)
    }

    /DISCARD/ : {
        *(.eh_frame)
        *(.note*)
        *(.comment)
    }
}

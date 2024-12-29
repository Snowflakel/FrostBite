#include <stddef.h>
#include <stdint.h>

extern void kernel_main(void);

// Text-mode VGA buffer
volatile uint16_t* vga_buffer = (uint16_t*)0xB8000;

void kernel_main(void) {
    const char* message = "Hello, I have been birthed in a 64-bit world!";
    size_t i = 0;

    // Clear the screen with blank characters
    for (size_t j = 0; j < 80 * 25; ++j) {
        vga_buffer[j] = (uint16_t)' ' | (0x0F << 8); // White text on black background
    }

    // Write message to VGA buffer
    while (message[i] != '\0') {
        vga_buffer[i] = (uint16_t)message[i] | (0x0F << 8); // White text on black backgrond
        i++;
    }

    // Infinite loop to halt the CPU
    while (1) {
        __asm__("hlt"); // Halt the CPU
    }
}

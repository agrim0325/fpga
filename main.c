#include <stdint.h>

#define LED_BASE  0x30000000UL
#define LED_REG   (*(volatile uint32_t *)LED_BASE)

int main(void)
{
    while (1) {
        LED_REG = 0xF;
        for (volatile int i = 0; i < 2000000; i++);
        LED_REG = 0x0;
        for (volatile int i = 0; i < 2000000; i++);
    }
}

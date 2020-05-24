#include <stdio.h>
#include <cstdint>
#include <memory.h>
#include "gpio.h"

#define UNUSED(x) (void)(x)

#define SHORT_DELAY (0x10000/2)
#define MEDIUM_DELAY (SHORT_DELAY << 1)
#define LONG_DELAY (MEDIUM_DELAY << 1)

#define LED_0 1
int main(int argc, char **argv)
{
	UNUSED(argc);
	UNUSED(argv);

	GPIO_SET_TOGGLE_REG  = LED_0;
	while(true)
	{
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
			GPIO_SET_TOGGLE_REG  = LED_0;
	}

}

extern "C"
 [[ noreturn ]] void exit( int rc)
{
	UNUSED(rc);
	for( ;; );
}


extern "C"
void isr(void)
{

}



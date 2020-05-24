#include <stdio.h>
#include <cstdint>
#include <memory.h>
#include "gpio.h"
#include "fastserial.h"

#define UNUSED(x) (void)(x)
#define SLOW_DELAY 32000
#define LED_0 1
#define LED_7 (1<<7)
#define LED_4 (1<<4)
int main(int argc, char **argv)
{
	UNUSED(argc);
	UNUSED(argv);


	uint32_t led7Delay =0;
	while(true)
	{
		uint32_t val =0;
		#if 0
		
		while ( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
		{
			GPIO_SET_TOGGLE_REG  = LED_0;
		}

		for (int outchar = '0'; outchar <= '9'; ++outchar )
				FASTSERIAL_TX_REG = (uint32_t)outchar;
		FASTSERIAL_TX_REG = (uint32_t)0x0D;
		FASTSERIAL_TX_REG = (uint32_t)0x0A;
		#else
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
		{
			val &= 0xFF;
			if (val == '0')
			{
				GPIO_SET_TOGGLE_REG  = LED_0;
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
				
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
			}
		}

		#endif
		if (led7Delay++ == SLOW_DELAY)
		{
			GPIO_SET_TOGGLE_REG  = LED_7;
			led7Delay = 0;
		}

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



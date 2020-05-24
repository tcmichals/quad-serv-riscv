#include <stdio.h>
#include <cstdint>
#include <memory.h>
#include "gpio.h"
#include "timer.h"

#define UNUSED(x) (void)(x)
#define ONE_SECOND_IN_US (1 * 1000000) 


#define LED_0 1
#define LED_1 (1<<1)
int main(int argc, char **argv)
{
	UNUSED(argc);
	UNUSED(argv);
	/* turn timer on */
	TIMER_STATUS_REG = TIMER_STATUS_REG_ENABLE;

	while(true)
	{
		uint32_t expire_value = TIMER_VALUE_REG + ONE_SECOND_IN_US;
		while((int32_t)(expire_value - TIMER_VALUE_REG )>0 );
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



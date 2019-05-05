#include "uart.h"

#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif

void kernel_main(unsigned long r0, unsigned long r1, unsigned long atags)
{
	init_uart();

	send('H');
	send('E');
	send('L');
	send('L');
	send('O');
	
	while(1){
		send(receive());
	}
}

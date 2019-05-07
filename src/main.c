#include "uart.h"

#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif

void kernel_main(unsigned long r0, unsigned long r1, unsigned long atags)
{
	int size = 0;
	char* kernel = 0x80000;
	init_uart();

	send('S');
	send(3);
	send(3);
	send(3);

	size = receive();
	size |= receive() << 8;
	size |= receive() << 16;
	size |= receive() << 24;
	
	send('O');
	send('K');

	while(size--){
		*kernel++ = receive();
	}
	kernel = 0x80000;
	asm("mov lr, #0x80000");
	asm("ret");
}

.section ".text.boot"

.globl _start

_start:
    mov x10, x0
    mov x11, x1
    mov x12, x2
    mov x13, x3

    mrs x0, mpidr_el1   //retrieves core registers info on processor affinity
    and x0, x0, #3      //Checks if not processor 0
    cbz x0, 1f          //branch to 1
hang:
    b hang

1:

    adr x0, __bss_start //Defined in linker.ld
    adr x1, __bss_end   //Defined in linker.ld
    sub x1, x1, x0

    bl  memzero    

    ldr x1, =__start
    
    eret
5:
    mov sp, x1
    bl  kernel_main     //jump to main function
    b   hang            //main should never return


memzero:
	str xzr, [x0], #8
	subs x1, x1, #8
	b.gt memzero
	ret

#define relocation  2048

.section ".text.boot"

.globl _start

_start:
    mrs x0, mpidr_el1   //retrieves core registers info on processor affinity
    and x0, x0, #3      //Checks if not processor 0
    cbz x0, 1f          //branch to 1
hang:
    b hang

1:

    //relocate -2048
    ldr x0, =_start
    ldr x1, =_start-relocation
    ldr x3, =relocation
reloc:
    ldr x2, [x0], #8
    str x2, [x1], #8
    sub x3, x3, #8
    cbnz x3, reloc
    
    adr x0, __bss_start-relocation //Defined in linker.ld
    adr x1, __bss_end-relocation   //Defined in linker.ld
    sub x1, x1, x0

    bl  memzero-relocation

    ldr x1, =__start-relocation

5:
    mov sp, x1
    bl  kernel_main-relocation     //jump to main function
    b hang

memzero:
	str xzr, [x0], #8
	subs x1, x1, #8
	b.gt memzero
	ret

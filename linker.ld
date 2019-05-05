ENTRY(_start)

SECTIONS
{
	. = 0x80000 - 1024;
	__start = .;

	.text : {
		KEEP(*(.text.boot))
		*(.text)
	}

	.rodata : {
		*(.rodata);
	}

	.data : {
		*(.data);
	}

	.bss :	{
		*(.bss);
	}

	__end = .;

}

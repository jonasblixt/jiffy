OUTPUT_ARCH(arm)
EXTERN(start)
ENTRY(start)


MEMORY 
{ 
 loader : ORIGIN = 0x00000000, LENGTH = 0x400 
 vmm : ORIGIN = 0x400, LENGTH = 0x100000
 tee : ORIGIN = 0x100400, LENGTH = 0x80000
}

SECTIONS
{
	. = 0x0;  
	.text : {
		*(.text)
		*(.rodata)
    	*(.boot)
       
	} > loader = 0x00

    .vmm : {
        __vmm_entry = .;
        *(.vmm)
    } > vmm = 0x00
    

    .tee : {
        __tee_entry = .;
        *(.tee)
    } > tee = 0x00
 
    . = ALIGN (4);
	/* Segments we don't want */
	/DISCARD/ . : {
		*(.fixup)
		*(.glue_7)
		*(.glue_7t)
		*(.data)
		*(.bss)
	}
	. = ALIGN (4);
}

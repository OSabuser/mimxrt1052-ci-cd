/*INCLUDE "template_project_lib.ld"
INCLUDE "template_project_mem.ld"
*/
GROUP (
  "libcr_c.a"
  "libcr_eabihelpers.a"
  "libgcc.a"
)

MEMORY
{
  /* Define each memory region */
  TFT_FLASH (rx) : ORIGIN = 0x60002000, LENGTH = 0xffe000 /* 16376K bytes (alias Flash) */  
  TFT_SDRAM (rwx) : ORIGIN = 0x80000000, LENGTH = 0x1000000 /* 16M bytes (alias RAM) */  
  NCACHE_REGION (rwx) : ORIGIN = 0x81000000, LENGTH = 0x1000000 /* 16M bytes (alias RAM2) */  
  SRAM_DTC (rwx) : ORIGIN = 0x20000000, LENGTH = 0x20000 /* 128K bytes (alias RAM3) */  
  SRAM_ITC (rwx) : ORIGIN = 0x0, LENGTH = 0x20000 /* 128K bytes (alias RAM4) */  
  SRAM_OC (rwx) : ORIGIN = 0x20200000, LENGTH = 0x40000 /* 256K bytes (alias RAM5) */  
}

  /* Define a symbol for the top of each memory region */
  __base_TFT_FLASH = 0x60002000  ; /* TFT_FLASH */  
  __base_Flash = 0x60002000 ; /* Flash */  
  __top_TFT_FLASH = 0x60002000 + 0xffe000 ; /* 16376K bytes */  
  __top_Flash = 0x60002000 + 0xffe000 ; /* 16376K bytes */  
  __base_TFT_SDRAM = 0x80000000  ; /* TFT_SDRAM */  
  __base_RAM = 0x80000000 ; /* RAM */  
  __top_TFT_SDRAM = 0x80000000 + 0x1000000 ; /* 16M bytes */  
  __top_RAM = 0x80000000 + 0x1000000 ; /* 16M bytes */  
  __base_NCACHE_REGION = 0x81000000  ; /* NCACHE_REGION */  
  __base_RAM2 = 0x81000000 ; /* RAM2 */  
  __top_NCACHE_REGION = 0x81000000 + 0x1000000 ; /* 16M bytes */  
  __top_RAM2 = 0x81000000 + 0x1000000 ; /* 16M bytes */  
  __base_SRAM_DTC = 0x20000000  ; /* SRAM_DTC */  
  __base_RAM3 = 0x20000000 ; /* RAM3 */  
  __top_SRAM_DTC = 0x20000000 + 0x20000 ; /* 128K bytes */  
  __top_RAM3 = 0x20000000 + 0x20000 ; /* 128K bytes */  
  __base_SRAM_ITC = 0x0  ; /* SRAM_ITC */  
  __base_RAM4 = 0x0 ; /* RAM4 */  
  __top_SRAM_ITC = 0x0 + 0x20000 ; /* 128K bytes */  
  __top_RAM4 = 0x0 + 0x20000 ; /* 128K bytes */  
  __base_SRAM_OC = 0x20200000  ; /* SRAM_OC */  
  __base_RAM5 = 0x20200000 ; /* RAM5 */  
  __top_SRAM_OC = 0x20200000 + 0x40000 ; /* 256K bytes */  
  __top_RAM5 = 0x20200000 + 0x40000 ; /* 256K bytes */  


  
ENTRY(ResetISR)

SECTIONS
{
     /* MAIN TEXT SECTION */
    .text : ALIGN(4)
    {
        FILL(0xff)
        __vectors_start__ = ABSOLUTE(.) ;
        KEEP(*(.isr_vector))
        /* Global Section Table */
        . = ALIGN(4) ;
        __section_table_start = .;
        __data_section_table = .;
        LONG(LOADADDR(.data));
        LONG(    ADDR(.data));
        LONG(  SIZEOF(.data));
        LONG(LOADADDR(.data_RAM2));
        LONG(    ADDR(.data_RAM2));
        LONG(  SIZEOF(.data_RAM2));
        LONG(LOADADDR(.data_RAM3));
        LONG(    ADDR(.data_RAM3));
        LONG(  SIZEOF(.data_RAM3));
        LONG(LOADADDR(.data_RAM4));
        LONG(    ADDR(.data_RAM4));
        LONG(  SIZEOF(.data_RAM4));
        LONG(LOADADDR(.data_RAM5));
        LONG(    ADDR(.data_RAM5));
        LONG(  SIZEOF(.data_RAM5));
        __data_section_table_end = .;
        __bss_section_table = .;
        LONG(    ADDR(.bss));
        LONG(  SIZEOF(.bss));
        LONG(    ADDR(.bss_RAM2));
        LONG(  SIZEOF(.bss_RAM2));
        LONG(    ADDR(.bss_RAM3));
        LONG(  SIZEOF(.bss_RAM3));
        LONG(    ADDR(.bss_RAM4));
        LONG(  SIZEOF(.bss_RAM4));
        LONG(    ADDR(.bss_RAM5));
        LONG(  SIZEOF(.bss_RAM5));
        __bss_section_table_end = .;
        __section_table_end = . ;
        /* End of Global Section Table */

        *(.after_vectors*)

       *(.text*)
       *(.rodata .rodata.* .constdata .constdata.*)
       . = ALIGN(4);
    } > TFT_FLASH
    /*
     * for exception handling/unwind - some Newlib functions (in common
     * with C++ and STDC++) use this.
     */
    .ARM.extab : ALIGN(4)
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > TFT_FLASH

    .ARM.exidx : ALIGN(4)
    {
        __exidx_start = .;
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        __exidx_end = .;
    } > TFT_FLASH
 
    _etext = .;
        
    /* DATA section for NCACHE_REGION */

    .data_RAM2 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM2 = .) ;
        PROVIDE(__start_data_NCACHE_REGION = .) ;
        *(.ramfunc.$RAM2)
        *(.ramfunc.$NCACHE_REGION)
       *(NonCacheable.init)
        *(.data.$RAM2)
        *(.data.$NCACHE_REGION)
        *(.data.$RAM2.*)
        *(.data.$NCACHE_REGION.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM2 = .) ;
        PROVIDE(__end_data_NCACHE_REGION = .) ;
     } > NCACHE_REGION AT>TFT_FLASH

    /* DATA section for SRAM_DTC */

    .data_RAM3 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM3 = .) ;
        PROVIDE(__start_data_SRAM_DTC = .) ;
        *(.ramfunc.$RAM3)
        *(.ramfunc.$SRAM_DTC)
        *(.data.$RAM3)
        *(.data.$SRAM_DTC)
        *(.data.$RAM3.*)
        *(.data.$SRAM_DTC.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM3 = .) ;
        PROVIDE(__end_data_SRAM_DTC = .) ;
     } > SRAM_DTC AT>TFT_FLASH

    /* DATA section for SRAM_ITC */

    .data_RAM4 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM4 = .) ;
        PROVIDE(__start_data_SRAM_ITC = .) ;
        *(.ramfunc.$RAM4)
        *(.ramfunc.$SRAM_ITC)
        *(.data.$RAM4)
        *(.data.$SRAM_ITC)
        *(.data.$RAM4.*)
        *(.data.$SRAM_ITC.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM4 = .) ;
        PROVIDE(__end_data_SRAM_ITC = .) ;
     } > SRAM_ITC AT>TFT_FLASH

    /* DATA section for SRAM_OC */

    .data_RAM5 : ALIGN(4)
    {
        FILL(0xff)
        PROVIDE(__start_data_RAM5 = .) ;
        PROVIDE(__start_data_SRAM_OC = .) ;
        *(.ramfunc.$RAM5)
        *(.ramfunc.$SRAM_OC)
        *(.data.$RAM5)
        *(.data.$SRAM_OC)
        *(.data.$RAM5.*)
        *(.data.$SRAM_OC.*)
        . = ALIGN(4) ;
        PROVIDE(__end_data_RAM5 = .) ;
        PROVIDE(__end_data_SRAM_OC = .) ;
     } > SRAM_OC AT>TFT_FLASH

    /* MAIN DATA SECTION */
    .uninit_RESERVED (NOLOAD) : ALIGN(4)
    {
        _start_uninit_RESERVED = .;
        KEEP(*(.bss.$RESERVED*))
       . = ALIGN(4) ;
        _end_uninit_RESERVED = .;
    } > TFT_SDRAM AT> TFT_SDRAM

    /* Main DATA section (TFT_SDRAM) */
    .data : ALIGN(4)
    {
       FILL(0xff)
       _data = . ;
       PROVIDE(__start_data_RAM = .) ;
       PROVIDE(__start_data_TFT_SDRAM = .) ;
       *(vtable)
       *(.ramfunc*)
       KEEP(*(CodeQuickAccess))
       KEEP(*(DataQuickAccess))
       *(RamFunction)
       *(.data*)
       . = ALIGN(4) ;
       _edata = . ;
       PROVIDE(__end_data_RAM = .) ;
       PROVIDE(__end_data_TFT_SDRAM = .) ;
    } > TFT_SDRAM AT>TFT_FLASH

    /* BSS section for NCACHE_REGION */
    .bss_RAM2 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM2 = .) ;
       PROVIDE(__start_bss_NCACHE_REGION = .) ;
       *(NonCacheable)
       *(.bss.$RAM2)
       *(.bss.$NCACHE_REGION)
       *(.bss.$RAM2.*)
       *(.bss.$NCACHE_REGION.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM2 = .) ;
       PROVIDE(__end_bss_NCACHE_REGION = .) ;
    } > NCACHE_REGION AT> NCACHE_REGION

    /* BSS section for SRAM_DTC */
    .bss_RAM3 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM3 = .) ;
       PROVIDE(__start_bss_SRAM_DTC = .) ;
       *(.bss.$RAM3)
       *(.bss.$SRAM_DTC)
       *(.bss.$RAM3.*)
       *(.bss.$SRAM_DTC.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM3 = .) ;
       PROVIDE(__end_bss_SRAM_DTC = .) ;
    } > SRAM_DTC AT> SRAM_DTC

    /* BSS section for SRAM_ITC */
    .bss_RAM4 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM4 = .) ;
       PROVIDE(__start_bss_SRAM_ITC = .) ;
       *(.bss.$RAM4)
       *(.bss.$SRAM_ITC)
       *(.bss.$RAM4.*)
       *(.bss.$SRAM_ITC.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM4 = .) ;
       PROVIDE(__end_bss_SRAM_ITC = .) ;
    } > SRAM_ITC AT> SRAM_ITC

    /* BSS section for SRAM_OC */
    .bss_RAM5 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_bss_RAM5 = .) ;
       PROVIDE(__start_bss_SRAM_OC = .) ;
       *(.bss.$RAM5)
       *(.bss.$SRAM_OC)
       *(.bss.$RAM5.*)
       *(.bss.$SRAM_OC.*)
       . = ALIGN (. != 0 ? 4 : 1) ; /* avoid empty segment */
       PROVIDE(__end_bss_RAM5 = .) ;
       PROVIDE(__end_bss_SRAM_OC = .) ;
    } > SRAM_OC AT> SRAM_OC

    /* MAIN BSS SECTION */
    .bss (NOLOAD) : ALIGN(4)
    {
        _bss = .;
        PROVIDE(__start_bss_RAM = .) ;
        PROVIDE(__start_bss_TFT_SDRAM = .) ;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4) ;
        _ebss = .;
        PROVIDE(__end_bss_RAM = .) ;
        PROVIDE(__end_bss_TFT_SDRAM = .) ;
        PROVIDE(end = .);
    } > TFT_SDRAM AT> TFT_SDRAM

    /* NOINIT section for NCACHE_REGION */
    .noinit_RAM2 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM2 = .) ;
       PROVIDE(__start_noinit_NCACHE_REGION = .) ;
       *(.noinit.$RAM2)
       *(.noinit.$NCACHE_REGION)
       *(.noinit.$RAM2.*)
       *(.noinit.$NCACHE_REGION.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM2 = .) ;
       PROVIDE(__end_noinit_NCACHE_REGION = .) ;
    } > NCACHE_REGION AT> NCACHE_REGION

    /* NOINIT section for SRAM_DTC */
    .noinit_RAM3 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM3 = .) ;
       PROVIDE(__start_noinit_SRAM_DTC = .) ;
       *(.noinit.$RAM3)
       *(.noinit.$SRAM_DTC)
       *(.noinit.$RAM3.*)
       *(.noinit.$SRAM_DTC.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM3 = .) ;
       PROVIDE(__end_noinit_SRAM_DTC = .) ;
    } > SRAM_DTC AT> SRAM_DTC

    /* NOINIT section for SRAM_ITC */
    .noinit_RAM4 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM4 = .) ;
       PROVIDE(__start_noinit_SRAM_ITC = .) ;
       *(.noinit.$RAM4)
       *(.noinit.$SRAM_ITC)
       *(.noinit.$RAM4.*)
       *(.noinit.$SRAM_ITC.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM4 = .) ;
       PROVIDE(__end_noinit_SRAM_ITC = .) ;
    } > SRAM_ITC AT> SRAM_ITC

    /* NOINIT section for SRAM_OC */
    .noinit_RAM5 (NOLOAD) : ALIGN(4)
    {
       PROVIDE(__start_noinit_RAM5 = .) ;
       PROVIDE(__start_noinit_SRAM_OC = .) ;
       *(.noinit.$RAM5)
       *(.noinit.$SRAM_OC)
       *(.noinit.$RAM5.*)
       *(.noinit.$SRAM_OC.*)
       . = ALIGN(4) ;
       PROVIDE(__end_noinit_RAM5 = .) ;
       PROVIDE(__end_noinit_SRAM_OC = .) ;
    } > SRAM_OC AT> SRAM_OC

    /* DEFAULT NOINIT SECTION */
    .noinit (NOLOAD): ALIGN(4)
    {
        _noinit = .;
        PROVIDE(__start_noinit_RAM = .) ;
        PROVIDE(__start_noinit_TFT_SDRAM = .) ;
        *(.noinit*)
         . = ALIGN(4) ;
        _end_noinit = .;
       PROVIDE(__end_noinit_RAM = .) ;
       PROVIDE(__end_noinit_TFT_SDRAM = .) ;        
    } > TFT_SDRAM AT> TFT_SDRAM

    /* Reserve and place Heap within memory map */
    _HeapSize = 0x5000;
    .heap (NOLOAD) :  ALIGN(4)
    {
        _pvHeapStart = .;
        . += _HeapSize;
        . = ALIGN(4);
        _pvHeapLimit = .;
    } > TFT_SDRAM

     _StackSize = 0x1000;
     /* Reserve space in memory for Stack */
    .heap2stackfill (NOLOAD) :
    {
        . += _StackSize;
    } > TFT_SDRAM
    /* Locate actual Stack in memory map */
    .stack ORIGIN(TFT_SDRAM) + LENGTH(TFT_SDRAM) - _StackSize - 0 (NOLOAD) :  ALIGN(4)
    {
        _vStackBase = .;
        . = ALIGN(4);
        _vStackTop = . + _StackSize;
    } > TFT_SDRAM

    /* Provide basic symbols giving location and size of main text
     * block, including initial values of RW data sections. Note that
     * these will need extending to give a complete picture with
     * complex images (e.g multiple Flash banks).
     */
    _image_start = LOADADDR(.text);
    _image_end = LOADADDR(.data) + SIZEOF(.data);
    _image_size = _image_end - _image_start;
}
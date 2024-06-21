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

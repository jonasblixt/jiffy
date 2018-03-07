

#define PAD_CTL_HYS		(1 << 16)
#define PAD_CTL_PUS_47K_UP	(1 << 14)
#define PAD_CTL_PUS_100K_UP	(2 << 14)

#define PAD_CTL_PUE		(1 << 13)
#define PAD_CTL_PKE		(1 << 12)
#define PAD_CTL_SPEED_LOW	(1 << 6)
#define PAD_CTL_SPEED_MED	(2 << 6)
#define PAD_CTL_DSE_DISABLE	(0 << 3)
#define PAD_CTL_DSE_240ohm	(1 << 3)
#define PAD_CTL_DSE_120ohm	(2 << 3)
#define PAD_CTL_DSE_80ohm	(3 << 3)
#define PAD_CTL_DSE_60ohm	(4 << 3)
#define PAD_CTL_DSE_48ohm	(5 << 3)
#define PAD_CTL_DSE_40ohm	(6 << 3)
#define PAD_CTL_DSE_34ohm	(7 << 3)
#define PAD_CTL_SRE_FAST	(1 << 0)
#define PAD_CTL_SRE_SLOW	(0 << 0)


#define UART_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |            \
		PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED |               \
		PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)



#define AIPS1_ARB_BASE_ADDR             0x02000000
#define AIPS2_ARB_BASE_ADDR             0x02100000
#define ATZ1_BASE_ADDR              AIPS1_ARB_BASE_ADDR
#define ATZ2_BASE_ADDR              AIPS2_ARB_BASE_ADDR
#define AIPS1_OFF_BASE_ADDR         (ATZ1_BASE_ADDR + 0x80000)
#define ANATOP_BASE_ADDR            (AIPS1_OFF_BASE_ADDR + 0x48000)


/* Register definitions */
#define URXD  0x0  /* Receiver Register */
#define UTXD  0x40 /* Transmitter Register */
#define UCR1  0x80 /* Control Register 1 */
#define UCR2  0x84 /* Control Register 2 */
#define UCR3  0x88 /* Control Register 3 */
#define UCR4  0x8c /* Control Register 4 */
#define UFCR  0x90 /* FIFO Control Register */
#define USR1  0x94 /* Status Register 1 */
#define USR2  0x98 /* Status Register 2 */
#define UESC  0x9c /* Escape Character Register */
#define UTIM  0xa0 /* Escape Timer Register */
#define UBIR  0xa4 /* BRM Incremental Register */
#define UBMR  0xa8 /* BRM Modulator Register */
#define UBRC  0xac /* Baud Rate Count Register */
#define UTS   0xb4 /* UART Test Register (mx31) */

#define UART_PHYS  (ATZ2_BASE_ADDR + 0xE8000)

#define  UCR2_ESCI	 (1<<15) /* Escape seq interrupt enable */
#define  UCR2_IRTS	 (1<<14) /* Ignore RTS pin */
#define  UCR2_CTSC	 (1<<13) /* CTS pin control */
#define  UCR2_CTS        (1<<12) /* Clear to send */
#define  UCR2_ESCEN      (1<<11) /* Escape enable */
#define  UCR2_PREN       (1<<8)  /* Parity enable */
#define  UCR2_PROE       (1<<7)  /* Parity odd/even */
#define  UCR2_STPB       (1<<6)	 /* Stop */
#define  UCR2_WS         (1<<5)	 /* Word size */
#define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
#define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
#define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
#define  UCR2_SRST	 (1<<0)	 /* SW reset */

#define  UCR1_UARTEN     (1<<0)	 /* UART enabled */

.text
    .globl start

start:
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  ldr r4,=5
  ldr r5,=#0x020E00FC
  str r4,[r5]

  ldr r4,=#0x4000
  ldr r5,=#0x020A0004
  str r4,[r5]

  ldr r4,=#0x0000
  ldr r5,=#0x020A0000
  str r4,[r5]

  @ ------ Configure UART1 PAD's ----------------------------------------------
  ldr r4,=0
  ldr r5,=#0x020E0094
  str r4,[r5]

  ldr r4,=0
  ldr r5,=#0x020E0098
  str r4,[r5]


  ldr r4,=UART_PAD_CTRL
  ldr r5,=#0x020E0320
  str r4,[r5]

  ldr r4,=UART_PAD_CTRL
  ldr r5,=#0x020E0324
  str r4,[r5]

  @ ------- END OF UART1 PAD CONFIG -------------------------------------------


  ldr r4,=0
  ldr r5,=UART_PHYS+UCR1
  str r4,[r5]

  ldr r4,=0
  ldr r5,=UART_PHYS+UCR2
  str r4,[r5]

uart_reset_wait:
  ldr r5,=UART_PHYS+UCR2
  ldr r4,[r5]
  and r9,r4,#(UCR2_SRST) @ wait until SRST bit is set
  cmp r9,#0
  beq uart_reset_wait

  ldr r4,=#0x0704
  ldr r5,=UART_PHYS+UCR3
  str r4,[r5]

  ldr r4,=#0x8000
  ldr r5,=UART_PHYS+UCR4
  str r4,[r5]

  ldr r4,=#0x002b
  ldr r5,=UART_PHYS+UESC
  str r4,[r5]

  ldr r4,=0
  ldr r5,=UART_PHYS+UTIM
  str r4,[r5]


  ldr r4,=0
  ldr r5,=UART_PHYS+UTS
  str r4,[r5]

  ldr r4,=(4 << 7)
  ldr r5,=UART_PHYS+UFCR
  str r4,[r5]


  ldr r4,=#0x0f
  ldr r5,=UART_PHYS+UBIR
  str r4,[r5]


  ldr r4,=80000000 / (2 * 115200)
  ldr r5,=UART_PHYS+UBMR
  str r4,[r5]

  ldr r4,=(UCR2_WS | UCR2_IRTS | UCR2_RXEN | UCR2_TXEN | UCR2_SRST)
  ldr r5,=UART_PHYS+UCR2
  str r4,[r5]


  ldr r4,=UCR1_UARTEN
  ldr r5,=UART_PHYS+UCR1
  str r4,[r5]

  @ ---- END OF UART CONFIG ---------------------------------------------------

  @ldr r4,=#0x4000
  @ldr r5,=#0x020A0000
  @str r4,[r5]

  bl __tee_entry
  b __vmm_entry


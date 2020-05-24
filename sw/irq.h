
/* from zephyr */
//rv32i
#define SOC_MSTATUS_IEN              (1 << 3) /* Machine Interrupt Enable bit */


/*
 https://content.riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
*/



/*
 * use atomic instruction csrrc to lock global irq
 * csrrc: atomic read and clear bits in CSR register
 */
inline unsigned int z_arch_irq_lock(void)
{
	unsigned int key, mstatus;

	__asm__ volatile ("csrrc %0, mstatus, %1"
			  : "=r" (mstatus)
			  : "r" (SOC_MSTATUS_IEN)
			  : "memory");

	key = (mstatus & SOC_MSTATUS_IEN);
	return key;
}

/*
 * use atomic instruction csrrs to unlock global irq
 * csrrs: atomic read and set bits in CSR register
 */
inline void z_arch_irq_unlock(unsigned int key)
{
	unsigned int mstatus;

	__asm__ volatile ("csrrs %0, mstatus, %1"
			  : "=r" (mstatus)
			  : "r" (key & SOC_MSTATUS_IEN)
			  : "memory");
}


inline void soc_interrupt_init(void)
{
	/* ensure that all interrupts are disabled */
	(void)z_arch_irq_lock();

	__asm__ volatile ("csrwi mie, 0\n"
			  "csrwi mip, 0\n");
}

inline void z_arch_irq_enable(unsigned int irq)
{
	uint32_t mie;

	/*
	 * CSR mie register is updated using atomic instruction csrrs
	 * (atomic read and set bits in CSR register)
	 */
	__asm__ volatile ("csrrs %0, mie, %1\n"
			  : "=r" (mie)
			  : "r" (1 << irq));
}

inline void z_arch_irq_disable(unsigned int irq)
{
	uint32_t mie;

	/*
	 * Use atomic instruction csrrc to disable device interrupt in mie CSR.
	 * (atomic read and clear bits in CSR register)
	 */
	__asm__ volatile ("csrrc %0, mie, %1\n"
			  : "=r" (mie)
			  : "r" (1 << irq));
};

inline int z_arch_irq_is_enabled(unsigned int irq)
{
	uint32_t mie;

	__asm__ volatile ("csrr %0, mie" : "=r" (mie));

	return (mie & (1 << irq));
}


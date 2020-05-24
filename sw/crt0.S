#ifndef GPIO_BASE
#define GPIO_BASE 0x91000000
#endif

.section  .isr_vector,"a",%progbits

	.global _start_reset_vector
_start_reset_vector:

	j reset_vector

reset_vector:

    # Disable global interrupt. */
    csrci mstatus, 8

	.option push
	.option norelax
	la gp, __global_pointer$
	.option pop

	la sp, _fstack
	sw x0, 0(sp)
	sw x0, 4(sp)

	la t0, trap_vector
	csrw mtvec, t0

	//initialize C data 
	la a0, _sidata  /*from */
	la a1, _sdata   /* to */
	la a2, _edata  /* end */
	beq	a1,a2, DONE
TOP:	
	lw	t0, (a0)
	sw t0, (a1)
	addi a0,a0,4
	addi a1,a2,4
	bltu a1,a2, TOP
DONE:	

	call _start
LOOP:	j LOOP

trap_vector:
	addi sp, sp, -16*4
	sw ra,  0*4(sp)
	sw t0,  1*4(sp)
	sw t1,  2*4(sp)
	sw t2,  3*4(sp)
	sw a0,  4*4(sp)
	sw a1,  5*4(sp)
	sw a2,  6*4(sp)
	sw a3,  7*4(sp)
	sw a4,  8*4(sp)
	sw a5,  9*4(sp)
	sw a6, 10*4(sp)
	sw a7, 11*4(sp)
	sw t3, 12*4(sp)
	sw t4, 13*4(sp)
	sw t5, 14*4(sp)
	sw t6, 15*4(sp)
	call isr
	lw ra,  0*4(sp)
	lw t0,  1*4(sp)
	lw t1,  2*4(sp)
	lw t2,  3*4(sp)
	lw a0,  4*4(sp)
	lw a1,  5*4(sp)
	lw a2,  6*4(sp)
	lw a3,  7*4(sp)
	lw a4,  8*4(sp)
	lw a5,  9*4(sp)
	lw a6, 10*4(sp)
	lw a7, 11*4(sp)
	lw t3, 12*4(sp)
	lw t4, 13*4(sp)
	lw t5, 14*4(sp)
	lw t6, 15*4(sp)
	addi sp, sp, 16*4
	mret

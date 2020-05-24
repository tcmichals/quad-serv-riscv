
./bin/exampleFastSerial.elf:     file format elf32-littleriscv


Disassembly of section .isr_vector:

00000000 <_start_reset_vector>:
   0:	0040006f          	j	4 <reset_vector>

00000004 <reset_vector>:
   4:	30047073          	csrci	mstatus,8
    # Disable global interrupt. */
    csrci mstatus, 8

	.option push
	.option norelax
	la gp, __global_pointer$
   8:	10000197          	auipc	gp,0x10000
   c:	7f818193          	addi	gp,gp,2040 # 10000800 <__global_pointer$>
	.option pop

	la sp, _fstack
  10:	22018113          	addi	sp,gp,544 # 10000a20 <_fstack>
  14:	00012023          	sw	zero,0(sp)
	sw x0, 0(sp)
  18:	00012223          	sw	zero,4(sp)
	sw x0, 4(sp)
  1c:	05400293          	li	t0,84

	la t0, trap_vector
  20:	30529073          	csrw	mtvec,t0
  24:	36c00513          	li	a0,876
	csrw mtvec, t0
  28:	10000597          	auipc	a1,0x10000

	//initialize C data 
	la a0, _sidata  /*from */
  2c:	fd858593          	addi	a1,a1,-40 # 10000000 <_sdata>
  30:	80418613          	addi	a2,gp,-2044 # 10000004 <_edata>
	la a1, _sdata   /* to */
  34:	00c58c63          	beq	a1,a2,4c <DONE>

00000038 <TOP>:
  38:	00052283          	lw	t0,0(a0)
	la a2, _edata  /* end */
  3c:	0055a023          	sw	t0,0(a1)
  40:	00450513          	addi	a0,a0,4
	beq	a1,a2, DONE
  44:	00460593          	addi	a1,a2,4
TOP:	
	lw	t0, (a0)
  48:	fec5e8e3          	bltu	a1,a2,38 <TOP>

0000004c <DONE>:
  4c:	098000ef          	jal	ra,e4 <_start>

00000050 <LOOP>:
  50:	0000006f          	j	50 <LOOP>

00000054 <trap_vector>:
  54:	fc010113          	addi	sp,sp,-64
	sw t0, (a1)
	addi a0,a0,4
	addi a1,a2,4
	bltu a1,a2, TOP
  58:	00112023          	sw	ra,0(sp)
DONE:	

	call _start
  5c:	00512223          	sw	t0,4(sp)
  60:	00612423          	sw	t1,8(sp)
LOOP:	j LOOP
  64:	00712623          	sw	t2,12(sp)

trap_vector:
	addi sp, sp, -16*4
  68:	00a12823          	sw	a0,16(sp)
	sw ra,  0*4(sp)
  6c:	00b12a23          	sw	a1,20(sp)
	sw t0,  1*4(sp)
  70:	00c12c23          	sw	a2,24(sp)
	sw t1,  2*4(sp)
  74:	00d12e23          	sw	a3,28(sp)
	sw t2,  3*4(sp)
  78:	02e12023          	sw	a4,32(sp)
	sw a0,  4*4(sp)
  7c:	02f12223          	sw	a5,36(sp)
	sw a1,  5*4(sp)
  80:	03012423          	sw	a6,40(sp)
	sw a2,  6*4(sp)
  84:	03112623          	sw	a7,44(sp)
	sw a3,  7*4(sp)
  88:	03c12823          	sw	t3,48(sp)
	sw a4,  8*4(sp)
  8c:	03d12a23          	sw	t4,52(sp)
	sw a5,  9*4(sp)
  90:	03e12c23          	sw	t5,56(sp)
	sw a6, 10*4(sp)
  94:	03f12e23          	sw	t6,60(sp)
	sw a7, 11*4(sp)
  98:	240000ef          	jal	ra,2d8 <isr>
	sw t3, 12*4(sp)
  9c:	00012083          	lw	ra,0(sp)
	sw t4, 13*4(sp)
  a0:	00412283          	lw	t0,4(sp)
	sw t5, 14*4(sp)
  a4:	00812303          	lw	t1,8(sp)
	sw t6, 15*4(sp)
  a8:	00c12383          	lw	t2,12(sp)
	call isr
  ac:	01012503          	lw	a0,16(sp)
  b0:	01412583          	lw	a1,20(sp)
	lw ra,  0*4(sp)
  b4:	01812603          	lw	a2,24(sp)
	lw t0,  1*4(sp)
  b8:	01c12683          	lw	a3,28(sp)
	lw t1,  2*4(sp)
  bc:	02012703          	lw	a4,32(sp)
	lw t2,  3*4(sp)
  c0:	02412783          	lw	a5,36(sp)
	lw a0,  4*4(sp)
  c4:	02812803          	lw	a6,40(sp)
	lw a1,  5*4(sp)
  c8:	02c12883          	lw	a7,44(sp)
	lw a2,  6*4(sp)
  cc:	03012e03          	lw	t3,48(sp)
	lw a3,  7*4(sp)
  d0:	03412e83          	lw	t4,52(sp)
	lw a4,  8*4(sp)
  d4:	03812f03          	lw	t5,56(sp)
	lw a5,  9*4(sp)
  d8:	03c12f83          	lw	t6,60(sp)
	lw a6, 10*4(sp)
  dc:	04010113          	addi	sp,sp,64
	lw a7, 11*4(sp)
  e0:	30200073          	mret

Disassembly of section .text:

000000e4 <_start>:
	lw t3, 12*4(sp)
  e4:	10000197          	auipc	gp,0x10000
	lw t4, 13*4(sp)
  e8:	71c18193          	addi	gp,gp,1820 # 10000800 <__global_pointer$>
	lw t5, 14*4(sp)
  ec:	80418513          	addi	a0,gp,-2044 # 10000004 <_edata>
	lw t6, 15*4(sp)
  f0:	82018613          	addi	a2,gp,-2016 # 10000020 <_end>
	addi sp, sp, 16*4
  f4:	40a60633          	sub	a2,a2,a0
	mret
  f8:	00000593          	li	a1,0
  fc:	038000ef          	jal	ra,134 <memset>
 100:	00000517          	auipc	a0,0x0
 104:	f0050513          	addi	a0,a0,-256 # 0 <_start_reset_vector>
 108:	00050a63          	beqz	a0,11c <_start+0x38>
 10c:	00000517          	auipc	a0,0x0
 110:	ef450513          	addi	a0,a0,-268 # 0 <_start_reset_vector>
 114:	00000097          	auipc	ra,0x0
 118:	000000e7          	jalr	zero # 0 <_start_reset_vector>
 11c:	1c0000ef          	jal	ra,2dc <__libc_init_array>
 120:	00012503          	lw	a0,0(sp)
 124:	00410593          	addi	a1,sp,4
 128:	00000613          	li	a2,0
 12c:	154000ef          	jal	ra,280 <main>
 130:	1a40006f          	j	2d4 <exit>

00000134 <memset>:
 134:	00f00313          	li	t1,15
 138:	00050713          	mv	a4,a0
 13c:	02c37e63          	bgeu	t1,a2,178 <memset+0x44>
 140:	00f77793          	andi	a5,a4,15
 144:	0a079063          	bnez	a5,1e4 <memset+0xb0>
 148:	08059263          	bnez	a1,1cc <memset+0x98>
 14c:	ff067693          	andi	a3,a2,-16
 150:	00f67613          	andi	a2,a2,15
 154:	00e686b3          	add	a3,a3,a4
 158:	00b72023          	sw	a1,0(a4)
 15c:	00b72223          	sw	a1,4(a4)
 160:	00b72423          	sw	a1,8(a4)
 164:	00b72623          	sw	a1,12(a4)
 168:	01070713          	addi	a4,a4,16
 16c:	fed766e3          	bltu	a4,a3,158 <memset+0x24>
 170:	00061463          	bnez	a2,178 <memset+0x44>
 174:	00008067          	ret
 178:	40c306b3          	sub	a3,t1,a2
 17c:	00269693          	slli	a3,a3,0x2
 180:	00000297          	auipc	t0,0x0
 184:	005686b3          	add	a3,a3,t0
 188:	00c68067          	jr	12(a3)
 18c:	00b70723          	sb	a1,14(a4)
 190:	00b706a3          	sb	a1,13(a4)
 194:	00b70623          	sb	a1,12(a4)
 198:	00b705a3          	sb	a1,11(a4)
 19c:	00b70523          	sb	a1,10(a4)
 1a0:	00b704a3          	sb	a1,9(a4)
 1a4:	00b70423          	sb	a1,8(a4)
 1a8:	00b703a3          	sb	a1,7(a4)
 1ac:	00b70323          	sb	a1,6(a4)
 1b0:	00b702a3          	sb	a1,5(a4)
 1b4:	00b70223          	sb	a1,4(a4)
 1b8:	00b701a3          	sb	a1,3(a4)
 1bc:	00b70123          	sb	a1,2(a4)
 1c0:	00b700a3          	sb	a1,1(a4)
 1c4:	00b70023          	sb	a1,0(a4)
 1c8:	00008067          	ret
 1cc:	0ff5f593          	andi	a1,a1,255
 1d0:	00859693          	slli	a3,a1,0x8
 1d4:	00d5e5b3          	or	a1,a1,a3
 1d8:	01059693          	slli	a3,a1,0x10
 1dc:	00d5e5b3          	or	a1,a1,a3
 1e0:	f6dff06f          	j	14c <memset+0x18>
 1e4:	00279693          	slli	a3,a5,0x2
 1e8:	00000297          	auipc	t0,0x0
 1ec:	005686b3          	add	a3,a3,t0
 1f0:	00008293          	mv	t0,ra
 1f4:	fa0680e7          	jalr	-96(a3)
 1f8:	00028093          	mv	ra,t0
 1fc:	ff078793          	addi	a5,a5,-16
 200:	40f70733          	sub	a4,a4,a5
 204:	00f60633          	add	a2,a2,a5
 208:	f6c378e3          	bgeu	t1,a2,178 <memset+0x44>
 20c:	f3dff06f          	j	148 <memset+0x14>

00000210 <__do_global_dtors_aux>:
 210:	81c1c783          	lbu	a5,-2020(gp) # 1000001c <__bss_end__>
 214:	04079263          	bnez	a5,258 <__do_global_dtors_aux+0x48>
 218:	00000797          	auipc	a5,0x0
 21c:	de878793          	addi	a5,a5,-536 # 0 <_start_reset_vector>
 220:	02078663          	beqz	a5,24c <__do_global_dtors_aux+0x3c>
 224:	ff010113          	addi	sp,sp,-16
 228:	36000513          	li	a0,864
 22c:	00112623          	sw	ra,12(sp)
 230:	00000097          	auipc	ra,0x0
 234:	000000e7          	jalr	zero # 0 <_start_reset_vector>
 238:	00c12083          	lw	ra,12(sp)
 23c:	00100793          	li	a5,1
 240:	80f18e23          	sb	a5,-2020(gp) # 1000001c <__bss_end__>
 244:	01010113          	addi	sp,sp,16
 248:	00008067          	ret
 24c:	00100793          	li	a5,1
 250:	80f18e23          	sb	a5,-2020(gp) # 1000001c <__bss_end__>
 254:	00008067          	ret
 258:	00008067          	ret

0000025c <frame_dummy>:
 25c:	00000797          	auipc	a5,0x0
 260:	da478793          	addi	a5,a5,-604 # 0 <_start_reset_vector>
 264:	00078c63          	beqz	a5,27c <frame_dummy+0x20>
 268:	10000597          	auipc	a1,0x10000
 26c:	d9c58593          	addi	a1,a1,-612 # 10000004 <_edata>
 270:	36000513          	li	a0,864
 274:	00000317          	auipc	t1,0x0
 278:	00000067          	jr	zero # 0 <_start_reset_vector>
 27c:	00008067          	ret

00000280 <main>:
#define SLOW_DELAY 32000
#define LED_0 1
#define LED_7 (1<<7)
#define LED_4 (1<<4)
int main(int argc, char **argv)
{
 280:	000088b7          	lui	a7,0x8
		for (int outchar = '0'; outchar <= '9'; ++outchar )
				FASTSERIAL_TX_REG = (uint32_t)outchar;
		FASTSERIAL_TX_REG = (uint32_t)0x0D;
		FASTSERIAL_TX_REG = (uint32_t)0x0A;
		#else
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 284:	930007b7          	lui	a5,0x93000
		{
			val &= 0xFF;
			if (val == '0')
 288:	03000593          	li	a1,48
			{
				GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	91000637          	lui	a2,0x91000
 290:	00100313          	li	t1,1
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
				
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 294:	03100513          	li	a0,49
		}

		#endif
		if (led7Delay++ == SLOW_DELAY)
		{
			GPIO_SET_TOGGLE_REG  = LED_7;
 298:	08000813          	li	a6,128
{
 29c:	d0188693          	addi	a3,a7,-767 # 7d01 <_Min_Stack_Size+0x7501>
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 2a0:	0007a703          	lw	a4,0(a5) # 93000000 <_fstack+0x82fff5e0>
 2a4:	10077e13          	andi	t3,a4,256
 2a8:	000e0e63          	beqz	t3,2c4 <main+0x44>
			val &= 0xFF;
 2ac:	0ff77713          	andi	a4,a4,255
			if (val == '0')
 2b0:	00b71a63          	bne	a4,a1,2c4 <main+0x44>
				GPIO_SET_TOGGLE_REG  = LED_0;
 2b4:	00662623          	sw	t1,12(a2) # 9100000c <_fstack+0x80fff5ec>
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
 2b8:	00b7a223          	sw	a1,4(a5)
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2bc:	00a7a223          	sw	a0,4(a5)
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2c0:	00a7a223          	sw	a0,4(a5)
		if (led7Delay++ == SLOW_DELAY)
 2c4:	fff68693          	addi	a3,a3,-1
 2c8:	fc069ce3          	bnez	a3,2a0 <main+0x20>
			GPIO_SET_TOGGLE_REG  = LED_7;
 2cc:	01062623          	sw	a6,12(a2)
			led7Delay = 0;
 2d0:	fcdff06f          	j	29c <main+0x1c>

000002d4 <exit>:

extern "C"
 [[ noreturn ]] void exit( int rc)
{
	UNUSED(rc);
	for( ;; );
 2d4:	0000006f          	j	2d4 <exit>

000002d8 <isr>:

extern "C"
void isr(void)
{

}
 2d8:	00008067          	ret

000002dc <__libc_init_array>:
 2dc:	ff010113          	addi	sp,sp,-16
 2e0:	00812423          	sw	s0,8(sp)
 2e4:	01212023          	sw	s2,0(sp)
 2e8:	36400413          	li	s0,868
 2ec:	36400913          	li	s2,868
 2f0:	40890933          	sub	s2,s2,s0
 2f4:	00112623          	sw	ra,12(sp)
 2f8:	00912223          	sw	s1,4(sp)
 2fc:	40295913          	srai	s2,s2,0x2
 300:	00090e63          	beqz	s2,31c <__libc_init_array+0x40>
 304:	00000493          	li	s1,0
 308:	00042783          	lw	a5,0(s0)
 30c:	00148493          	addi	s1,s1,1
 310:	00440413          	addi	s0,s0,4
 314:	000780e7          	jalr	a5
 318:	fe9918e3          	bne	s2,s1,308 <__libc_init_array+0x2c>
 31c:	36400413          	li	s0,868
 320:	36800913          	li	s2,872
 324:	40890933          	sub	s2,s2,s0
 328:	40295913          	srai	s2,s2,0x2
 32c:	00090e63          	beqz	s2,348 <__libc_init_array+0x6c>
 330:	00000493          	li	s1,0
 334:	00042783          	lw	a5,0(s0)
 338:	00148493          	addi	s1,s1,1
 33c:	00440413          	addi	s0,s0,4
 340:	000780e7          	jalr	a5
 344:	fe9918e3          	bne	s2,s1,334 <__libc_init_array+0x58>
 348:	00c12083          	lw	ra,12(sp)
 34c:	00812403          	lw	s0,8(sp)
 350:	00412483          	lw	s1,4(sp)
 354:	00012903          	lw	s2,0(sp)
 358:	01010113          	addi	sp,sp,16
 35c:	00008067          	ret

00000360 <__EH_FRAME_BEGIN__>:
 360:	0000                	unimp
	...

Disassembly of section .init_array:

00000364 <__frame_dummy_init_array_entry>:
 364:	025c                	addi	a5,sp,260
	...

Disassembly of section .fini_array:

00000368 <__do_global_dtors_aux_fini_array_entry>:
 368:	0210                	addi	a2,sp,256
	...

Disassembly of section .sdata:

10000000 <__dso_handle>:
10000000:	0000                	unimp
	...

Disassembly of section .bss:

10000004 <__bss_start__>:
	...

Disassembly of section .sbss.completed.5456:

1000001c <completed.5456>:
	...

Disassembly of section ._user_heap_stack:

1000001d <_end-0x3>:
1000001d:	0000                	unimp
	...

10000020 <_end>:
	...

Disassembly of section .debug_info:

00000000 <.debug_info>:
	j reset_vector
   0:	0d21                	addi	s10,s10,8
   2:	0000                	unimp
    csrci mstatus, 8
   4:	0004                	0x4
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	0000                	unimp
   a:	0104                	addi	s1,sp,128
   c:	01c0                	addi	s0,sp,196
   e:	0000                	unimp
	la sp, _fstack
  10:	3b04                	fld	fs1,48(a4)
  12:	0000                	unimp
  14:	1400                	addi	s0,sp,544
  16:	18000003          	lb	zero,384(zero) # 180 <memset+0x4c>
	...
	la t0, trap_vector
  22:	0000                	unimp
  24:	0200                	addi	s0,sp,256
  26:	00b9                	addi	ra,ra,14
	csrw mtvec, t0
  28:	0000                	unimp
  2a:	2902                	fld	fs2,0(sp)
	la a0, _sidata  /*from */
  2c:	00003117          	auipc	sp,0x3
  30:	0300                	addi	s0,sp,384
  32:	0601                	addi	a2,a2,0
	la a1, _sdata   /* to */
  34:	043d                	addi	s0,s0,15
  36:	0000                	unimp
  38:	3102                	fld	ft2,32(sp)
  3a:	0000                	unimp
	la a2, _edata  /* end */
  3c:	0200                	addi	s0,sp,256
  3e:	0044182b          	0x44182b
  42:	0000                	unimp
	beq	a1,a2, DONE
  44:	3b080103          	lb	sp,944(a6)
	lw	t0, (a0)
  48:	0004                	0x4
  4a:	0200                	addi	s0,sp,256
	sw t0, (a1)
  4c:	023c                	addi	a5,sp,264
  4e:	0000                	unimp
	addi a0,a0,4
  50:	3702                	fld	fa4,32(sp)
  52:	5718                	lw	a4,40(a4)
	addi a1,a2,4
  54:	0000                	unimp
  56:	0300                	addi	s0,sp,384
	bltu a1,a2, TOP
  58:	0502                	c.slli64	a0
  5a:	00000457          	0x457
	call _start
  5e:	3002                	fld	ft0,32(sp)
  60:	0005                	c.nop	1
  62:	0200                	addi	s0,sp,256
LOOP:	j LOOP
  64:	1939                	addi	s2,s2,-18
  66:	006a                	c.slli	zero,0x1a
	addi sp, sp, -16*4
  68:	0000                	unimp
  6a:	da070203          	lb	tp,-608(a4)
	sw ra,  0*4(sp)
  6e:	0002                	c.slli64	zero
	sw t0,  1*4(sp)
  70:	0200                	addi	s0,sp,256
  72:	0000053b          	0x53b
	sw t1,  2*4(sp)
  76:	4d02                	lw	s10,0(sp)
	sw t2,  3*4(sp)
  78:	7d18                	flw	fa4,56(a0)
  7a:	0000                	unimp
	sw a0,  4*4(sp)
  7c:	0300                	addi	s0,sp,384
  7e:	0504                	addi	s1,sp,640
	sw a1,  5*4(sp)
  80:	000000ef          	jal	ra,80 <trap_vector+0x2c>
	sw a2,  6*4(sp)
  84:	9a02                	jalr	s4
  86:	0001                	nop
	sw a3,  7*4(sp)
  88:	0200                	addi	s0,sp,256
  8a:	0090194f          	fnmadd.s	fs2,ft0,fs1,ft0,rtz
	sw a4,  8*4(sp)
  8e:	0000                	unimp
	sw a5,  9*4(sp)
  90:	89070403          	lb	s0,-1904(a4)
	sw a6, 10*4(sp)
  94:	0000                	unimp
  96:	0200                	addi	s0,sp,256
	sw a7, 11*4(sp)
  98:	00a4                	addi	s1,sp,72
  9a:	0000                	unimp
	sw t3, 12*4(sp)
  9c:	6702                	flw	fa4,0(sp)
  9e:	a318                	fsd	fa4,0(a4)
	sw t4, 13*4(sp)
  a0:	0000                	unimp
  a2:	0300                	addi	s0,sp,384
	sw t5, 14*4(sp)
  a4:	0508                	addi	a0,sp,640
  a6:	00ea                	slli	ra,ra,0x1a
	sw t6, 15*4(sp)
  a8:	0000                	unimp
  aa:	eb02                	fsw	ft0,148(sp)
	call isr
  ac:	02000003          	lb	zero,32(zero) # 20 <reset_vector+0x1c>
  b0:	1969                	addi	s2,s2,-6
  b2:	00b6                	slli	ra,ra,0xd
	lw ra,  0*4(sp)
  b4:	0000                	unimp
  b6:	84070803          	lb	a6,-1984(a4)
	lw t0,  1*4(sp)
  ba:	0000                	unimp
	lw t1,  2*4(sp)
  bc:	0200                	addi	s0,sp,256
  be:	05f1                	addi	a1,a1,28
	lw t2,  3*4(sp)
  c0:	0000                	unimp
  c2:	8602                	jr	a2
	lw a0,  4*4(sp)
  c4:	311d                	jal	fffffcea <_fstack+0xeffff2ca>
  c6:	0000                	unimp
	lw a1,  5*4(sp)
  c8:	0200                	addi	s0,sp,256
  ca:	01b0                	addi	a2,sp,200
	lw a2,  6*4(sp)
  cc:	0000                	unimp
  ce:	8802                	jr	a6
	lw a3,  7*4(sp)
  d0:	441e                	lw	s0,196(sp)
  d2:	0000                	unimp
	lw a4,  8*4(sp)
  d4:	0200                	addi	s0,sp,256
  d6:	0275                	addi	tp,tp,29
	lw a5,  9*4(sp)
  d8:	0000                	unimp
  da:	a002                	fsd	ft0,0(sp)
	lw a6, 10*4(sp)
  dc:	571e                	lw	a4,228(sp)
  de:	0000                	unimp
	lw a7, 11*4(sp)
  e0:	0200                	addi	s0,sp,256
  e2:	0592                	slli	a1,a1,0x4
	lw t3, 12*4(sp)
  e4:	0000                	unimp
  e6:	a202                	fsd	ft0,256(sp)
	lw t4, 13*4(sp)
  e8:	6a1f 0000 0200      	0x20000006a1f
	lw t5, 14*4(sp)
  ee:	0579                	addi	a0,a0,30
	lw t6, 15*4(sp)
  f0:	0000                	unimp
  f2:	b602                	fsd	ft0,296(sp)
	addi sp, sp, 16*4
  f4:	7d1e                	flw	fs10,228(sp)
  f6:	0000                	unimp
	mret
  f8:	0200                	addi	s0,sp,256
  fa:	028a                	slli	t0,t0,0x2
  fc:	0000                	unimp
  fe:	b802                	fsd	ft0,48(sp)
 100:	901f 0000 0200      	0x2000000901f
 106:	00d1                	addi	ra,ra,20
 108:	0000                	unimp
 10a:	c802                	sw	zero,16(sp)
 10c:	a31e                	fsd	ft7,384(sp)
 10e:	0000                	unimp
 110:	0200                	addi	s0,sp,256
 112:	042a                	slli	s0,s0,0xa
 114:	0000                	unimp
 116:	ca02                	sw	zero,20(sp)
 118:	b61f 0000 0200      	0x2000000b61f
 11e:	02fc                	addi	a5,sp,332
 120:	0000                	unimp
 122:	d602                	sw	zero,44(sp)
 124:	a319                	j	62a <_sidata+0x2be>
 126:	0000                	unimp
 128:	0200                	addi	s0,sp,256
 12a:	0556                	slli	a0,a0,0x15
 12c:	0000                	unimp
 12e:	de02                	sw	zero,60(sp)
 130:	b61a                	fsd	ft6,296(sp)
 132:	0000                	unimp
 134:	0200                	addi	s0,sp,256
 136:	01a5                	addi	gp,gp,9
 138:	0000                	unimp
 13a:	e602                	fsw	ft0,12(sp)
 13c:	4119                	li	sp,6
 13e:	0001                	nop
 140:	0400                	addi	s0,sp,512
 142:	0504                	addi	s1,sp,640
 144:	6e69                	lui	t3,0x1a
 146:	0074                	addi	a3,sp,12
 148:	9402                	jalr	s0
 14a:	0004                	0x4
 14c:	0200                	addi	s0,sp,256
 14e:	1ae8                	addi	a0,sp,380
 150:	0154                	addi	a3,sp,132
 152:	0000                	unimp
 154:	8e070403          	lb	s0,-1824(a4)
 158:	0000                	unimp
 15a:	0300                	addi	s0,sp,384
 15c:	0410                	addi	a2,sp,512
 15e:	03b5                	addi	t2,t2,13
 160:	0000                	unimp
 162:	8905                	andi	a0,a0,1
 164:	06000003          	lb	zero,96(zero) # 60 <trap_vector+0xc>
 168:	037a                	slli	t1,t1,0x1e
 16a:	0000                	unimp
 16c:	17016503          	0x17016503
 170:	0154                	addi	a3,sp,132
 172:	0000                	unimp
 174:	e402                	fsw	ft0,8(sp)
 176:	04000003          	lb	zero,64(zero) # 40 <TOP+0x8>
 17a:	0e2e                	slli	t3,t3,0xb
 17c:	007d                	c.nop	31
 17e:	0000                	unimp
 180:	1f02                	slli	t5,t5,0x20
 182:	0005                	c.nop	1
 184:	0400                	addi	s0,sp,512
 186:	0e74                	addi	a3,sp,796
 188:	007d                	c.nop	31
 18a:	0000                	unimp
 18c:	0002                	c.slli64	zero
 18e:	0006                	c.slli	zero,0x1
 190:	0400                	addi	s0,sp,512
 192:	01411793          	slli	a5,sp,0x14
 196:	0000                	unimp
 198:	a3040807          	0xa3040807
 19c:	5601                	li	a2,-32
 19e:	0000                	unimp
 1a0:	e200                	fsw	fs0,0(a2)
 1a2:	0001                	nop
 1a4:	0800                	addi	s0,sp,16
 1a6:	0404                	addi	s1,sp,512
 1a8:	03a6                	slli	t2,t2,0x9
 1aa:	000001c7          	fmsub.s	ft3,ft0,ft0,ft0,rne
 1ae:	6c09                	lui	s8,0x2
 1b0:	04000003          	lb	zero,64(zero) # 40 <TOP+0x8>
 1b4:	01670ca7          	0x1670ca7
 1b8:	0000                	unimp
 1ba:	9b09                	andi	a4,a4,-30
 1bc:	0002                	c.slli64	zero
 1be:	0400                	addi	s0,sp,512
 1c0:	1ba8                	addi	a0,sp,504
 1c2:	01e2                	slli	gp,gp,0x18
 1c4:	0000                	unimp
 1c6:	0a00                	addi	s0,sp,272
 1c8:	0502                	c.slli64	a0
 1ca:	0000                	unimp
 1cc:	a404                	fsd	fs1,8(s0)
 1ce:	00014107          	flq	ft2,0(sp) # 302c <_Min_Stack_Size+0x282c>
 1d2:	0000                	unimp
 1d4:	110a                	slli	sp,sp,0x22
 1d6:	0005                	c.nop	1
 1d8:	0400                	addi	s0,sp,512
 1da:	05a9                	addi	a1,a1,10
 1dc:	01a5                	addi	gp,gp,9
 1de:	0000                	unimp
 1e0:	0004                	0x4
 1e2:	0000440b          	0x440b
 1e6:	f200                	fsw	fs0,32(a2)
 1e8:	0001                	nop
 1ea:	0c00                	addi	s0,sp,528
 1ec:	0154                	addi	a3,sp,132
 1ee:	0000                	unimp
 1f0:	58020003          	lb	zero,1408(tp) # 580 <_sidata+0x214>
 1f4:	0000                	unimp
 1f6:	0400                	addi	s0,sp,512
 1f8:	03aa                	slli	t2,t2,0xa
 1fa:	0198                	addi	a4,sp,192
 1fc:	0000                	unimp
 1fe:	040d                	addi	s0,s0,3
 200:	a802                	fsd	ft0,16(sp)
 202:	0005                	c.nop	1
 204:	0500                	addi	s0,sp,640
 206:	1916                	slli	s2,s2,0x25
 208:	0090                	addi	a2,sp,64
 20a:	0000                	unimp
 20c:	7202                	flw	ft4,32(sp)
 20e:	06000003          	lb	zero,96(zero) # 60 <trap_vector+0xc>
 212:	1922                	slli	s2,s2,0x28
 214:	0218                	addi	a4,sp,256
 216:	0000                	unimp
 218:	040e                	slli	s0,s0,0x3
 21a:	021e                	slli	tp,tp,0x7
 21c:	0000                	unimp
 21e:	00050a0f          	0x50a0f
 222:	0200                	addi	s0,sp,256
 224:	0621                	addi	a2,a2,8
 226:	0000                	unimp
 228:	2305                	jal	748 <_sidata+0x3dc>
 22a:	00020c1b          	0x20c1b
 22e:	1000                	addi	s0,sp,32
 230:	024e                	slli	tp,tp,0x13
 232:	0000                	unimp
 234:	0518                	addi	a4,sp,640
 236:	0834                	addi	a3,sp,24
 238:	0289                	addi	t0,t0,2
 23a:	0000                	unimp
 23c:	a50a                	fsd	ft2,136(sp)
 23e:	0004                	0x4
 240:	0500                	addi	s0,sp,640
 242:	1336                	slli	t1,t1,0x2d
 244:	0289                	addi	t0,t0,2
 246:	0000                	unimp
 248:	1100                	addi	s0,sp,160
 24a:	6b5f 0500 0737      	0x73705006b5f
 250:	0141                	addi	sp,sp,16
 252:	0000                	unimp
 254:	0a04                	addi	s1,sp,272
 256:	04ed                	addi	s1,s1,27
 258:	0000                	unimp
 25a:	3705                	jal	17a <memset+0x46>
 25c:	0001410b          	0x1410b
 260:	0800                	addi	s0,sp,16
 262:	220a                	fld	ft4,128(sp)
 264:	0000                	unimp
 266:	0500                	addi	s0,sp,640
 268:	01411437          	lui	s0,0x1411
 26c:	0000                	unimp
 26e:	0a0c                	addi	a1,sp,272
 270:	05e2                	slli	a1,a1,0x18
 272:	0000                	unimp
 274:	3705                	jal	194 <memset+0x60>
 276:	0001411b          	0x1411b
 27a:	1000                	addi	s0,sp,32
 27c:	5f11                	li	t5,-28
 27e:	0078                	addi	a4,sp,12
{
 280:	3805                	jal	fffffab0 <_fstack+0xeffff090>
 282:	00028f0f          	0x28f0f
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 286:	1400                	addi	s0,sp,544
			if (val == '0')
 288:	0e00                	addi	s0,sp,784
 28a:	2f04                	fld	fs1,24(a4)
				GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	0002                	c.slli64	zero
 28e:	0b00                	addi	s0,sp,400
 290:	0200                	addi	s0,sp,256
 292:	0000                	unimp
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 294:	029f 0000 540c      	0x540c0000029f
			GPIO_SET_TOGGLE_REG  = LED_7;
 29a:	0001                	nop
{
 29c:	0000                	unimp
 29e:	1000                	addi	s0,sp,32
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 2a0:	0285                	addi	t0,t0,1
 2a2:	0000                	unimp
 2a4:	0524                	addi	s1,sp,648
 2a6:	083c                	addi	a5,sp,24
 2a8:	0322                	slli	t1,t1,0x8
 2aa:	0000                	unimp
			val &= 0xFF;
 2ac:	e10a                	fsw	ft2,128(sp)
 2ae:	0000                	unimp
			if (val == '0')
 2b0:	0500                	addi	s0,sp,640
 2b2:	093e                	slli	s2,s2,0xf
				GPIO_SET_TOGGLE_REG  = LED_0;
 2b4:	0141                	addi	sp,sp,16
 2b6:	0000                	unimp
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
 2b8:	0a00                	addi	s0,sp,272
 2ba:	00000527          	0x527
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2be:	3f05                	jal	1ee <memset+0xba>
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2c0:	4109                	li	sp,2
 2c2:	0001                	nop
		if (led7Delay++ == SLOW_DELAY)
 2c4:	0400                	addi	s0,sp,512
 2c6:	120a                	slli	tp,tp,0x22
 2c8:	0001                	nop
 2ca:	0500                	addi	s0,sp,640
			GPIO_SET_TOGGLE_REG  = LED_7;
 2cc:	0940                	addi	s0,sp,148
 2ce:	0141                	addi	sp,sp,16
			led7Delay = 0;
 2d0:	0000                	unimp
 2d2:	0a08                	addi	a0,sp,272
	for( ;; );
 2d4:	066d                	addi	a2,a2,27
 2d6:	0000                	unimp
}
 2d8:	4105                	li	sp,1
 2da:	4109                	li	sp,2
 2dc:	0001                	nop
 2de:	0c00                	addi	s0,sp,528
 2e0:	c80a                	sw	sp,16(sp)
 2e2:	05000003          	lb	zero,80(zero) # 50 <LOOP>
 2e6:	0942                	slli	s2,s2,0x10
 2e8:	0141                	addi	sp,sp,16
 2ea:	0000                	unimp
 2ec:	0a10                	addi	a2,sp,272
 2ee:	03a2                	slli	t2,t2,0x8
 2f0:	0000                	unimp
 2f2:	4305                	li	t1,1
 2f4:	4109                	li	sp,2
 2f6:	0001                	nop
 2f8:	1400                	addi	s0,sp,544
 2fa:	e70a                	fsw	ft2,140(sp)
 2fc:	0005                	c.nop	1
 2fe:	0500                	addi	s0,sp,640
 300:	0944                	addi	s1,sp,148
 302:	0141                	addi	sp,sp,16
 304:	0000                	unimp
 306:	0a18                	addi	a4,sp,272
 308:	0461                	addi	s0,s0,24
 30a:	0000                	unimp
 30c:	4505                	li	a0,1
 30e:	4109                	li	sp,2
 310:	0001                	nop
 312:	1c00                	addi	s0,sp,560
 314:	3d0a                	fld	fs10,160(sp)
 316:	0006                	c.slli	zero,0x1
 318:	0500                	addi	s0,sp,640
 31a:	0946                	slli	s2,s2,0x11
 31c:	0141                	addi	sp,sp,16
 31e:	0000                	unimp
 320:	0020                	addi	s0,sp,8
 322:	2112                	fld	ft2,256(sp)
 324:	0001                	nop
 326:	0800                	addi	s0,sp,16
 328:	0501                	addi	a0,a0,0
 32a:	0367084f          	fnmadd.d	fa6,fa4,fs6,ft0,rne
 32e:	0000                	unimp
 330:	8d0a                	mv	s10,sp
 332:	0001                	nop
 334:	0500                	addi	s0,sp,640
 336:	1e50                	addi	a2,sp,820
 338:	00000367          	jalr	t1,zero # 0 <_start_reset_vector>
 33c:	0a00                	addi	s0,sp,272
 33e:	0000                	unimp
 340:	0000                	unimp
 342:	5105                	li	sp,-31
 344:	6721                	lui	a4,0x8
 346:	80000003          	lb	zero,-2048(zero) # fffff800 <_fstack+0xefffede0>
 34a:	00058913          	mv	s2,a1
 34e:	0500                	addi	s0,sp,640
 350:	02000a53          	fadd.d	fs4,ft0,ft0,rne
 354:	0000                	unimp
 356:	0100                	addi	s0,sp,128
 358:	00014613          	xori	a2,sp,0
 35c:	0500                	addi	s0,sp,640
 35e:	0a56                	slli	s4,s4,0x15
 360:	0200                	addi	s0,sp,256
 362:	0000                	unimp
 364:	0104                	addi	s1,sp,128
 366:	0b00                	addi	s0,sp,400
 368:	01fe                	slli	gp,gp,0x1f
 36a:	0000                	unimp
 36c:	00000377          	0x377
 370:	540c                	lw	a1,40(s0)
 372:	0001                	nop
 374:	1f00                	addi	s0,sp,944
 376:	1200                	addi	s0,sp,288
 378:	03d1                	addi	t2,t2,20
 37a:	0000                	unimp
 37c:	0190                	addi	a2,sp,192
 37e:	6205                	lui	tp,0x1
 380:	ba08                	fsd	fa0,48(a2)
 382:	0a000003          	lb	zero,160(zero) # a0 <trap_vector+0x4c>
 386:	04a5                	addi	s1,s1,9
 388:	0000                	unimp
 38a:	6305                	lui	t1,0x1
 38c:	ba12                	fsd	ft4,304(sp)
 38e:	00000003          	lb	zero,0(zero) # 0 <_start_reset_vector>
 392:	bd0a                	fsd	ft2,184(sp)
 394:	0004                	0x4
 396:	0500                	addi	s0,sp,640
 398:	0664                	addi	s1,sp,780
 39a:	0141                	addi	sp,sp,16
 39c:	0000                	unimp
 39e:	0a04                	addi	s1,sp,272
 3a0:	0195                	addi	gp,gp,5
 3a2:	0000                	unimp
 3a4:	6605                	lui	a2,0x1
 3a6:	c021                	beqz	s0,3e6 <_sidata+0x7a>
 3a8:	08000003          	lb	zero,128(zero) # 80 <trap_vector+0x2c>
 3ac:	210a                	fld	ft2,128(sp)
 3ae:	0001                	nop
 3b0:	0500                	addi	s0,sp,640
 3b2:	03221e67          	0x3221e67
 3b6:	0000                	unimp
 3b8:	0088                	addi	a0,sp,64
 3ba:	040e                	slli	s0,s0,0x3
 3bc:	00000377          	0x377
 3c0:	0003d00b          	0x3d00b
 3c4:	d000                	sw	s0,32(s0)
 3c6:	0c000003          	lb	zero,192(zero) # c0 <trap_vector+0x6c>
 3ca:	0154                	addi	a3,sp,132
 3cc:	0000                	unimp
 3ce:	001f 040e 03d6      	0x3d6040e001f
 3d4:	0000                	unimp
 3d6:	1014                	addi	a3,sp,32
 3d8:	0000046b          	0x46b
 3dc:	0508                	addi	a0,sp,640
 3de:	087a                	slli	a6,a6,0x1e
 3e0:	03ff                	0x3ff
 3e2:	0000                	unimp
 3e4:	fe0a                	fsw	ft2,60(sp)
 3e6:	0000                	unimp
 3e8:	0500                	addi	s0,sp,640
 3ea:	03ff117b          	0x3ff117b
 3ee:	0000                	unimp
 3f0:	0a00                	addi	s0,sp,272
 3f2:	000c                	0xc
 3f4:	0000                	unimp
 3f6:	7c05                	lui	s8,0xfffe1
 3f8:	4106                	lw	sp,64(sp)
 3fa:	0001                	nop
 3fc:	0400                	addi	s0,sp,512
 3fe:	0e00                	addi	s0,sp,784
 400:	4404                	lw	s1,8(s0)
 402:	0000                	unimp
 404:	1000                	addi	s0,sp,32
 406:	047f                	0x47f
 408:	0000                	unimp
 40a:	0568                	addi	a0,sp,652
 40c:	08ba                	slli	a7,a7,0xe
 40e:	0548                	addi	a0,sp,644
 410:	0000                	unimp
 412:	5f11                	li	t5,-28
 414:	0070                	addi	a2,sp,12
 416:	bb05                	j	146 <memset+0x12>
 418:	ff12                	fsw	ft4,188(sp)
 41a:	00000003          	lb	zero,0(zero) # 0 <_start_reset_vector>
 41e:	5f11                	li	t5,-28
 420:	0072                	c.slli	zero,0x1c
 422:	bc05                	j	fffffe52 <_fstack+0xeffff432>
 424:	00014107          	flq	ft2,0(sp)
 428:	0400                	addi	s0,sp,512
 42a:	5f11                	li	t5,-28
 42c:	bd050077          	0xbd050077
 430:	00014107          	flq	ft2,0(sp)
 434:	0800                	addi	s0,sp,16
 436:	3f0a                	fld	ft10,160(sp)
 438:	0001                	nop
 43a:	0500                	addi	s0,sp,640
 43c:	09be                	slli	s3,s3,0xf
 43e:	00000057          	0x57
 442:	0a0c                	addi	a1,sp,272
 444:	000002c3          	fmadd.s	ft5,ft0,ft0,ft0,rne
 448:	bf05                	j	378 <_sidata+0xc>
 44a:	5709                	li	a4,-30
 44c:	0000                	unimp
 44e:	0e00                	addi	s0,sp,784
 450:	5f11                	li	t5,-28
 452:	6662                	flw	fa2,24(sp)
 454:	0500                	addi	s0,sp,640
 456:	11c0                	addi	s0,sp,228
 458:	000003d7          	0x3d7
 45c:	0a10                	addi	a2,sp,272
 45e:	0000009b          	0x9b
 462:	c105                	beqz	a0,482 <_sidata+0x116>
 464:	00014107          	flq	ft2,0(sp)
 468:	1800                	addi	s0,sp,48
 46a:	2f0a                	fld	ft10,128(sp)
 46c:	0001                	nop
 46e:	0500                	addi	s0,sp,640
 470:	0ac8                	addi	a0,sp,340
 472:	01fe                	slli	gp,gp,0x1f
 474:	0000                	unimp
 476:	0a1c                	addi	a5,sp,272
 478:	0265                	addi	tp,tp,25
 47a:	0000                	unimp
 47c:	cb05                	beqz	a4,4ac <_sidata+0x140>
 47e:	2d29                	jal	a98 <_Min_Stack_Size+0x298>
 480:	0008                	0x8
 482:	2000                	fld	fs0,0(s0)
 484:	9b0a                	add	s6,s6,sp
 486:	05000003          	lb	zero,80(zero) # 50 <LOOP>
 48a:	22ce                	fld	ft5,208(sp)
 48c:	00000857          	0x857
 490:	0a24                	addi	s1,sp,280
 492:	0519                	addi	a0,a0,6
 494:	0000                	unimp
 496:	cf05                	beqz	a4,4ce <_sidata+0x162>
 498:	7b3a                	flw	fs6,172(sp)
 49a:	0008                	0x8
 49c:	2800                	fld	fs0,16(s0)
 49e:	570a                	lw	a4,160(sp)
 4a0:	0006                	c.slli	zero,0x1
 4a2:	0500                	addi	s0,sp,640
 4a4:	29d0                	fld	fa2,144(a1)
 4a6:	0895                	addi	a7,a7,5
 4a8:	0000                	unimp
 4aa:	112c                	addi	a1,sp,168
 4ac:	755f 0062 d305      	0xd3050062755f
 4b2:	d711                	beqz	a4,3be <_sidata+0x52>
 4b4:	30000003          	lb	zero,768(zero) # 300 <__libc_init_array+0x24>
 4b8:	5f11                	li	t5,-28
 4ba:	7075                	c.lui	zero,0xffffd
 4bc:	0500                	addi	s0,sp,640
 4be:	12d4                	addi	a3,sp,356
 4c0:	03ff                	0x3ff
 4c2:	0000                	unimp
 4c4:	1138                	addi	a4,sp,168
 4c6:	755f 0072 d505      	0xd5050072755f
 4cc:	00014107          	flq	ft2,0(sp)
 4d0:	3c00                	fld	fs0,56(s0)
 4d2:	f80a                	fsw	ft2,48(sp)
 4d4:	0000                	unimp
 4d6:	0500                	addi	s0,sp,640
 4d8:	18d8                	addi	a4,sp,116
 4da:	0000089b          	0x89b
 4de:	0a40                	addi	s0,sp,276
 4e0:	062a                	slli	a2,a2,0xa
 4e2:	0000                	unimp
 4e4:	d905                	beqz	a0,414 <_sidata+0xa8>
 4e6:	ab18                	fsd	fa4,16(a4)
 4e8:	0008                	0x8
 4ea:	4300                	lw	s0,0(a4)
 4ec:	5f11                	li	t5,-28
 4ee:	626c                	flw	fa1,68(a2)
 4f0:	0500                	addi	s0,sp,640
 4f2:	11dc                	addi	a5,sp,228
 4f4:	000003d7          	0x3d7
 4f8:	0a44                	addi	s1,sp,276
 4fa:	0155                	addi	sp,sp,21
 4fc:	0000                	unimp
 4fe:	df05                	beqz	a4,436 <_sidata+0xca>
 500:	00014107          	flq	ft2,0(sp)
 504:	4c00                	lw	s0,24(s0)
 506:	660a                	flw	fa2,128(sp)
 508:	0001                	nop
 50a:	0500                	addi	s0,sp,640
 50c:	0ae0                	addi	s0,sp,348
 50e:	0174                	addi	a3,sp,140
 510:	0000                	unimp
 512:	0a50                	addi	a2,sp,276
 514:	00000063          	beqz	zero,514 <_sidata+0x1a8>
 518:	e305                	bnez	a4,538 <_sidata+0x1cc>
 51a:	6612                	flw	fa2,4(sp)
 51c:	0005                	c.nop	1
 51e:	5400                	lw	s0,40(s0)
 520:	0b0a                	slli	s6,s6,0x2
 522:	0005                	c.nop	1
 524:	0500                	addi	s0,sp,640
 526:	02230ce7          	jalr	s9,34(t1) # 1022 <_Min_Stack_Size+0x822>
 52a:	0000                	unimp
 52c:	0a58                	addi	a4,sp,276
 52e:	0028                	addi	a0,sp,8
 530:	0000                	unimp
 532:	e905                	bnez	a0,562 <_sidata+0x1f6>
 534:	f20e                	fsw	ft3,36(sp)
 536:	0001                	nop
 538:	5c00                	lw	s0,56(s0)
 53a:	810a                	mv	sp,sp
 53c:	05000003          	lb	zero,80(zero) # 50 <LOOP>
 540:	09ea                	slli	s3,s3,0x1a
 542:	0141                	addi	sp,sp,16
 544:	0000                	unimp
 546:	0064                	addi	s1,sp,12
 548:	8c15                	sub	s0,s0,a3
 54a:	0001                	nop
 54c:	6600                	flw	fs0,8(a2)
 54e:	0005                	c.nop	1
 550:	1600                	addi	s0,sp,800
 552:	0566                	slli	a0,a0,0x19
 554:	0000                	unimp
 556:	fe16                	fsw	ft5,60(sp)
 558:	0001                	nop
 55a:	1600                	addi	s0,sp,800
 55c:	0000081b          	0x81b
 560:	4116                	lw	sp,68(sp)
 562:	0001                	nop
 564:	0000                	unimp
 566:	040e                	slli	s0,s0,0x3
 568:	0571                	addi	a0,a0,28
 56a:	0000                	unimp
 56c:	00056617          	auipc	a2,0x56
 570:	1800                	addi	s0,sp,48
 572:	04f5                	addi	s1,s1,29
 574:	0000                	unimp
 576:	0428                	addi	a0,sp,520
 578:	6505                	lui	a0,0x1
 57a:	0802                	c.slli64	a6
 57c:	0000081b          	0x81b
 580:	f019                	bnez	s0,486 <_sidata+0x11a>
 582:	8405                	srai	s0,s0,0x1
 584:	0502                	c.slli64	a0
 586:	06e1                	addi	a3,a3,24
 588:	0000                	unimp
 58a:	d01a                	sw	t1,32(sp)
 58c:	8605                	srai	a2,a2,0x1
 58e:	0902                	c.slli64	s2
 590:	069f 0000 d51b      	0xd51b0000069f
 596:	0005                	c.nop	1
 598:	0500                	addi	s0,sp,640
 59a:	54180287          	0x54180287
 59e:	0001                	nop
 5a0:	0000                	unimp
 5a2:	0005621b          	0x5621b
 5a6:	0500                	addi	s0,sp,640
 5a8:	0288                	addi	a0,sp,320
 5aa:	1b12                	slli	s6,s6,0x24
 5ac:	0008                	0x8
 5ae:	0400                	addi	s0,sp,512
 5b0:	0003071b          	0x3071b
 5b4:	0500                	addi	s0,sp,640
 5b6:	0289                	addi	t0,t0,2
 5b8:	5630                	lw	a2,104(a2)
 5ba:	0009                	c.nop	2
 5bc:	0800                	addi	s0,sp,16
 5be:	0006481b          	0x6481b
 5c2:	0500                	addi	s0,sp,640
 5c4:	028a                	slli	t0,t0,0x2
 5c6:	00029f17          	auipc	t5,0x29
 5ca:	2400                	fld	fs0,8(s0)
 5cc:	0002561b          	0x2561b
 5d0:	0500                	addi	s0,sp,640
 5d2:	410f028b          	0x410f028b
 5d6:	0001                	nop
 5d8:	4800                	lw	s0,16(s0)
 5da:	0004a01b          	0x4a01b
 5de:	0500                	addi	s0,sp,640
 5e0:	028c                	addi	a1,sp,320
 5e2:	b62c                	fsd	fa1,104(a2)
 5e4:	0000                	unimp
 5e6:	5000                	lw	s0,32(s0)
 5e8:	00065e1b          	0x65e1b
 5ec:	0500                	addi	s0,sp,640
 5ee:	028d                	addi	t0,t0,3
 5f0:	0d1a                	slli	s10,s10,0x6
 5f2:	0009                	c.nop	2
 5f4:	5800                	lw	s0,48(s0)
 5f6:	0004ab1b          	0x4ab1b
 5fa:	0500                	addi	s0,sp,640
 5fc:	028e                	slli	t0,t0,0x3
 5fe:	f216                	fsw	ft5,36(sp)
 600:	0001                	nop
 602:	6800                	flw	fs0,16(s0)
 604:	0006131b          	0x6131b
 608:	0500                	addi	s0,sp,640
 60a:	f216028f          	0xf216028f
 60e:	0001                	nop
 610:	7000                	flw	fs0,32(s0)
 612:	00040e1b          	0x40e1b
 616:	0500                	addi	s0,sp,640
 618:	0290                	addi	a2,sp,320
 61a:	f216                	fsw	ft5,36(sp)
 61c:	0001                	nop
 61e:	7800                	flw	fs0,48(s0)
 620:	0006091b          	0x6091b
 624:	0500                	addi	s0,sp,640
 626:	0291                	addi	t0,t0,4
 628:	0009661b          	0x9661b
 62c:	8000                	0x8000
 62e:	0000781b          	0x781b
 632:	0500                	addi	s0,sp,640
 634:	0292                	slli	t0,t0,0x4
 636:	762e                	flw	fa2,232(sp)
 638:	0009                	c.nop	2
 63a:	8800                	0x8800
 63c:	0005b01b          	0x5b01b
 640:	0500                	addi	s0,sp,640
 642:	410f0293          	addi	t0,t5,1040 # 299d6 <_Min_Stack_Size+0x291d6>
 646:	0001                	nop
 648:	a000                	fsd	fs0,0(s0)
 64a:	00017f1b          	0x17f1b
 64e:	0500                	addi	s0,sp,640
 650:	0294                	addi	a3,sp,320
 652:	f216                	fsw	ft5,36(sp)
 654:	0001                	nop
 656:	a400                	fsd	fs0,8(s0)
 658:	0000c21b          	0xc21b
 65c:	0500                	addi	s0,sp,640
 65e:	0295                	addi	t0,t0,5
 660:	f216                	fsw	ft5,36(sp)
 662:	0001                	nop
 664:	ac00                	fsd	fs0,24(s0)
 666:	00016e1b          	0x16e1b
 66a:	0500                	addi	s0,sp,640
 66c:	0296                	slli	t0,t0,0x5
 66e:	f216                	fsw	ft5,36(sp)
 670:	0001                	nop
 672:	b400                	fsd	fs0,40(s0)
 674:	0000691b          	0x691b
 678:	0500                	addi	s0,sp,640
 67a:	f2160297          	auipc	t0,0xf2160
 67e:	0001                	nop
 680:	bc00                	fsd	fs0,56(s0)
 682:	0002a21b          	0x2a21b
 686:	0500                	addi	s0,sp,640
 688:	0298                	addi	a4,sp,320
 68a:	f216                	fsw	ft5,36(sp)
 68c:	0001                	nop
 68e:	c400                	sw	s0,8(s0)
 690:	00044e1b          	0x44e1b
 694:	0500                	addi	s0,sp,640
 696:	0299                	addi	t0,t0,6
 698:	4108                	lw	a0,0(a0)
 69a:	0001                	nop
 69c:	cc00                	sw	s0,24(s0)
 69e:	1a00                	addi	s0,sp,304
 6a0:	05f0                	addi	a2,sp,716
 6a2:	029f c609 0006      	0x6c609029f
 6a8:	1b00                	addi	s0,sp,432
 6aa:	03c1                	addi	t2,t2,16
 6ac:	0000                	unimp
 6ae:	a105                	j	ace <_Min_Stack_Size+0x2ce>
 6b0:	2a02                	fld	fs4,0(sp)
 6b2:	0986                	slli	s3,s3,0x1
 6b4:	0000                	unimp
 6b6:	1b00                	addi	s0,sp,432
 6b8:	03ac                	addi	a1,sp,456
 6ba:	0000                	unimp
 6bc:	a205                	j	7dc <_sidata+0x470>
 6be:	2902                	fld	fs2,0(sp)
 6c0:	0996                	slli	s3,s3,0x5
 6c2:	0000                	unimp
 6c4:	0078                	addi	a4,sp,12
 6c6:	f51c                	fsw	fa5,40(a0)
 6c8:	0004                	0x4
 6ca:	0500                	addi	s0,sp,640
 6cc:	029a                	slli	t0,t0,0x6
 6ce:	00058a0b          	0x58a0b
 6d2:	1c00                	addi	s0,sp,560
 6d4:	0630                	addi	a2,sp,776
 6d6:	0000                	unimp
 6d8:	a305                	j	bf8 <_Min_Stack_Size+0x3f8>
 6da:	0b02                	c.slli64	s6
 6dc:	069f 0000 1b00      	0x1b000000069f
 6e2:	0450                	addi	a2,sp,516
 6e4:	0000                	unimp
 6e6:	6705                	lui	a4,0x1
 6e8:	0702                	c.slli64	a4
 6ea:	0141                	addi	sp,sp,16
 6ec:	0000                	unimp
 6ee:	1b00                	addi	s0,sp,432
 6f0:	014e                	slli	sp,sp,0x13
 6f2:	0000                	unimp
 6f4:	6c05                	lui	s8,0x1
 6f6:	0b02                	c.slli64	s6
 6f8:	00000907          	0x907
 6fc:	1b04                	addi	s1,sp,432
 6fe:	000002b3          	add	t0,zero,zero
 702:	6c05                	lui	s8,0x1
 704:	1402                	slli	s0,s0,0x20
 706:	00000907          	0x907
 70a:	1b08                	addi	a0,sp,432
 70c:	0246                	slli	tp,tp,0x11
 70e:	0000                	unimp
 710:	6c05                	lui	s8,0x1
 712:	1e02                	slli	t3,t3,0x20
 714:	00000907          	0x907
 718:	1b0c                	addi	a1,sp,432
 71a:	04b8                	addi	a4,sp,584
 71c:	0000                	unimp
 71e:	6e05                	lui	t3,0x1
 720:	0802                	c.slli64	a6
 722:	0141                	addi	sp,sp,16
 724:	0000                	unimp
 726:	1b10                	addi	a2,sp,432
 728:	0545                	addi	a0,a0,17
 72a:	0000                	unimp
 72c:	6f05                	lui	t5,0x1
 72e:	2802                	fld	fa6,0(sp)
 730:	09a6                	slli	s3,s3,0x9
 732:	0000                	unimp
 734:	1b14                	addi	a3,sp,432
 736:	04d4                	addi	a3,sp,580
 738:	0000                	unimp
 73a:	7205                	lui	tp,0xfffe1
 73c:	0702                	c.slli64	a4
 73e:	0141                	addi	sp,sp,16
 740:	0000                	unimp
 742:	1b30                	addi	a2,sp,440
 744:	04c2                	slli	s1,s1,0x10
 746:	0000                	unimp
 748:	7305                	lui	t1,0xfffe1
 74a:	1602                	slli	a2,a2,0x20
 74c:	000009bb          	0x9bb
 750:	1b34                	addi	a3,sp,440
 752:	03d9                	addi	t2,t2,22
 754:	0000                	unimp
 756:	7505                	lui	a0,0xfffe1
 758:	0702                	c.slli64	a4
 75a:	0141                	addi	sp,sp,16
 75c:	0000                	unimp
 75e:	1b38                	addi	a4,sp,440
 760:	04ca                	slli	s1,s1,0x12
 762:	0000                	unimp
 764:	7705                	lui	a4,0xfffe1
 766:	2502                	fld	fa0,0(sp)
 768:	09cc                	addi	a1,sp,212
 76a:	0000                	unimp
 76c:	1b3c                	addi	a5,sp,440
 76e:	0364                	addi	s1,sp,396
 770:	0000                	unimp
 772:	7a05                	lui	s4,0xfffe1
 774:	1302                	slli	t1,t1,0x20
 776:	0289                	addi	t0,t0,2
 778:	0000                	unimp
 77a:	1b40                	addi	s0,sp,436
 77c:	0000026b          	0x26b
 780:	7b05                	lui	s6,0xfffe1
 782:	0702                	c.slli64	a4
 784:	0141                	addi	sp,sp,16
 786:	0000                	unimp
 788:	1b44                	addi	s1,sp,436
 78a:	00000663          	beqz	zero,796 <_sidata+0x42a>
 78e:	7c05                	lui	s8,0xfffe1
 790:	1302                	slli	t1,t1,0x20
 792:	0289                	addi	t0,t0,2
 794:	0000                	unimp
 796:	1b48                	addi	a0,sp,436
 798:	03f6                	slli	t2,t2,0x1d
 79a:	0000                	unimp
 79c:	7d05                	lui	s10,0xfffe1
 79e:	1402                	slli	s0,s0,0x20
 7a0:	09d2                	slli	s3,s3,0x14
 7a2:	0000                	unimp
 7a4:	1b4c                	addi	a1,sp,436
 7a6:	000002bb          	0x2bb
 7aa:	8005                	srli	s0,s0,0x1
 7ac:	0702                	c.slli64	a4
 7ae:	0141                	addi	sp,sp,16
 7b0:	0000                	unimp
 7b2:	1b50                	addi	a2,sp,436
 7b4:	015e                	slli	sp,sp,0x17
 7b6:	0000                	unimp
 7b8:	8105                	srli	a0,a0,0x1
 7ba:	0902                	c.slli64	s2
 7bc:	0000081b          	0x81b
 7c0:	1b54                	addi	a3,sp,436
 7c2:	0449                	addi	s0,s0,18
 7c4:	0000                	unimp
 7c6:	a405                	j	9e6 <_Min_Stack_Size+0x1e6>
 7c8:	0702                	c.slli64	a4
 7ca:	0580                	addi	s0,sp,704
 7cc:	0000                	unimp
 7ce:	1d58                	addi	a4,sp,692
 7d0:	03d1                	addi	t2,t2,20
 7d2:	0000                	unimp
 7d4:	a805                	j	804 <_Min_Stack_Size+0x4>
 7d6:	1302                	slli	t1,t1,0x20
 7d8:	03ba                	slli	t2,t2,0xe
 7da:	0000                	unimp
 7dc:	0148                	addi	a0,sp,132
 7de:	f31d                	bnez	a4,704 <_sidata+0x398>
 7e0:	0002                	c.slli64	zero
 7e2:	0500                	addi	s0,sp,640
 7e4:	02a9                	addi	t0,t0,10
 7e6:	7712                	flw	fa4,36(sp)
 7e8:	4c000003          	lb	zero,1216(zero) # 4c0 <_sidata+0x154>
 7ec:	1d01                	addi	s10,s10,-32
 7ee:	02d0                	addi	a2,sp,324
 7f0:	0000                	unimp
 7f2:	ad05                	j	e22 <_Min_Stack_Size+0x622>
 7f4:	1b02                	slli	s6,s6,0x20
 7f6:	000009e3          	beqz	zero,1008 <_Min_Stack_Size+0x808>
 7fa:	02dc                	addi	a5,sp,324
 7fc:	371d                	jal	722 <_sidata+0x3b6>
 7fe:	0001                	nop
 800:	0500                	addi	s0,sp,640
 802:	02b2                	slli	t0,t0,0xc
 804:	c810                	sw	a2,16(s0)
 806:	0008                	0x8
 808:	e000                	fsw	fs0,0(s0)
 80a:	1d02                	slli	s10,s10,0x20
 80c:	011c                	addi	a5,sp,128
 80e:	0000                	unimp
 810:	b405                	j	230 <__do_global_dtors_aux+0x20>
 812:	1002                	c.slli	zero,0x20
 814:	000009ef          	jal	s3,814 <_Min_Stack_Size+0x14>
 818:	02ec                	addi	a1,sp,332
 81a:	0e00                	addi	s0,sp,784
 81c:	2104                	fld	fs1,0(a0)
 81e:	0008                	0x8
 820:	0300                	addi	s0,sp,384
 822:	0801                	addi	a6,a6,0
 824:	0444                	addi	s1,sp,516
 826:	0000                	unimp
 828:	00082117          	auipc	sp,0x82
 82c:	0e00                	addi	s0,sp,784
 82e:	4804                	lw	s1,16(s0)
 830:	0005                	c.nop	1
 832:	1500                	addi	s0,sp,672
 834:	018c                	addi	a1,sp,192
 836:	0000                	unimp
 838:	0851                	addi	a6,a6,20
 83a:	0000                	unimp
 83c:	6616                	flw	fa2,68(sp)
 83e:	0005                	c.nop	1
 840:	1600                	addi	s0,sp,800
 842:	01fe                	slli	gp,gp,0x1f
 844:	0000                	unimp
 846:	5116                	lw	sp,100(sp)
 848:	0008                	0x8
 84a:	1600                	addi	s0,sp,800
 84c:	0141                	addi	sp,sp,16
 84e:	0000                	unimp
 850:	0e00                	addi	s0,sp,784
 852:	2804                	fld	fs1,16(s0)
 854:	0008                	0x8
 856:	0e00                	addi	s0,sp,784
 858:	3304                	fld	fs1,32(a4)
 85a:	0008                	0x8
 85c:	1500                	addi	s0,sp,672
 85e:	0180                	addi	s0,sp,192
 860:	0000                	unimp
 862:	0000087b          	0x87b
 866:	6616                	flw	fa2,68(sp)
 868:	0005                	c.nop	1
 86a:	1600                	addi	s0,sp,800
 86c:	01fe                	slli	gp,gp,0x1f
 86e:	0000                	unimp
 870:	8016                	c.mv	zero,t0
 872:	0001                	nop
 874:	1600                	addi	s0,sp,800
 876:	0141                	addi	sp,sp,16
 878:	0000                	unimp
 87a:	0e00                	addi	s0,sp,784
 87c:	5d04                	lw	s1,56(a0)
 87e:	0008                	0x8
 880:	1500                	addi	s0,sp,672
 882:	0141                	addi	sp,sp,16
 884:	0000                	unimp
 886:	0895                	addi	a7,a7,5
 888:	0000                	unimp
 88a:	6616                	flw	fa2,68(sp)
 88c:	0005                	c.nop	1
 88e:	1600                	addi	s0,sp,800
 890:	01fe                	slli	gp,gp,0x1f
 892:	0000                	unimp
 894:	0e00                	addi	s0,sp,784
 896:	8104                	0x8104
 898:	0008                	0x8
 89a:	0b00                	addi	s0,sp,400
 89c:	0044                	addi	s1,sp,4
 89e:	0000                	unimp
 8a0:	000008ab          	0x8ab
 8a4:	540c                	lw	a1,40(s0)
 8a6:	0001                	nop
 8a8:	0200                	addi	s0,sp,256
 8aa:	0b00                	addi	s0,sp,400
 8ac:	0044                	addi	s1,sp,4
 8ae:	0000                	unimp
 8b0:	000008bb          	0x8bb
 8b4:	540c                	lw	a1,40(s0)
 8b6:	0001                	nop
 8b8:	0000                	unimp
 8ba:	0600                	addi	s0,sp,768
 8bc:	0478                	addi	a4,sp,524
 8be:	0000                	unimp
 8c0:	2405                	jal	ae0 <_Min_Stack_Size+0x2e0>
 8c2:	1a01                	addi	s4,s4,-32
 8c4:	0405                	addi	s0,s0,1
 8c6:	0000                	unimp
 8c8:	ed1e                	fsw	ft7,152(sp)
 8ca:	0002                	c.slli64	zero
 8cc:	0c00                	addi	s0,sp,528
 8ce:	2805                	jal	8fe <_Min_Stack_Size+0xfe>
 8d0:	0801                	addi	a6,a6,0
 8d2:	0901                	addi	s2,s2,0
 8d4:	0000                	unimp
 8d6:	0004a51b          	0x4a51b
 8da:	0500                	addi	s0,sp,640
 8dc:	012a                	slli	sp,sp,0xa
 8de:	0111                	addi	sp,sp,4
 8e0:	0009                	c.nop	2
 8e2:	0000                	unimp
 8e4:	0002c91b          	0x2c91b
 8e8:	0500                	addi	s0,sp,640
 8ea:	4107012b          	0x4107012b
 8ee:	0001                	nop
 8f0:	0400                	addi	s0,sp,512
 8f2:	0004721b          	0x4721b
 8f6:	0500                	addi	s0,sp,640
 8f8:	012c                	addi	a1,sp,136
 8fa:	0009070b          	0x9070b
 8fe:	0800                	addi	s0,sp,16
 900:	0e00                	addi	s0,sp,784
 902:	c804                	sw	s1,16(s0)
 904:	0008                	0x8
 906:	0e00                	addi	s0,sp,784
 908:	bb04                	fsd	fs1,48(a4)
 90a:	0008                	0x8
 90c:	1e00                	addi	s0,sp,816
 90e:	0012                	c.slli	zero,0x4
 910:	0000                	unimp
 912:	050e                	slli	a0,a0,0x3
 914:	0144                	addi	s1,sp,132
 916:	4608                	lw	a0,8(a2)
 918:	0009                	c.nop	2
 91a:	1b00                	addi	s0,sp,432
 91c:	04fc                	addi	a5,sp,588
 91e:	0000                	unimp
 920:	4505                	li	a0,1
 922:	1901                	addi	s2,s2,-32
 924:	0946                	slli	s2,s2,0x11
 926:	0000                	unimp
 928:	1b00                	addi	s0,sp,432
 92a:	0550                	addi	a2,sp,644
 92c:	0000                	unimp
 92e:	4605                	li	a2,1
 930:	1901                	addi	s2,s2,-32
 932:	0946                	slli	s2,s2,0x11
 934:	0000                	unimp
 936:	1b06                	slli	s6,s6,0x21
 938:	000005a3          	sb	zero,11(zero) # b <reset_vector+0x7>
 93c:	4705                	li	a4,1
 93e:	1201                	addi	tp,tp,-32
 940:	006a                	c.slli	zero,0x1a
 942:	0000                	unimp
 944:	000c                	0xc
 946:	00006a0b          	0x6a0b
 94a:	5600                	lw	s0,40(a2)
 94c:	0009                	c.nop	2
 94e:	0c00                	addi	s0,sp,528
 950:	0154                	addi	a3,sp,132
 952:	0000                	unimp
 954:	0002                	c.slli64	zero
 956:	0008210b          	0x8210b
 95a:	6600                	flw	fs0,8(a2)
 95c:	0009                	c.nop	2
 95e:	0c00                	addi	s0,sp,528
 960:	0154                	addi	a3,sp,132
 962:	0000                	unimp
 964:	0019                	c.nop	6
 966:	0008210b          	0x8210b
 96a:	7600                	flw	fs0,40(a2)
 96c:	0009                	c.nop	2
 96e:	0c00                	addi	s0,sp,528
 970:	0154                	addi	a3,sp,132
 972:	0000                	unimp
 974:	210b0007          	0x210b0007
 978:	0008                	0x8
 97a:	8600                	0x8600
 97c:	0009                	c.nop	2
 97e:	0c00                	addi	s0,sp,528
 980:	0154                	addi	a3,sp,132
 982:	0000                	unimp
 984:	ff0b0017          	auipc	zero,0xff0b0
 988:	96000003          	lb	zero,-1696(zero) # fffff960 <_fstack+0xefffef40>
 98c:	0009                	c.nop	2
 98e:	0c00                	addi	s0,sp,528
 990:	0154                	addi	a3,sp,132
 992:	0000                	unimp
 994:	001d                	c.nop	7
 996:	0001540b          	0x1540b
 99a:	a600                	fsd	fs0,8(a2)
 99c:	0009                	c.nop	2
 99e:	0c00                	addi	s0,sp,528
 9a0:	0154                	addi	a3,sp,132
 9a2:	0000                	unimp
 9a4:	001d                	c.nop	7
 9a6:	0008210b          	0x8210b
 9aa:	b600                	fsd	fs0,40(a2)
 9ac:	0009                	c.nop	2
 9ae:	0c00                	addi	s0,sp,528
 9b0:	0154                	addi	a3,sp,132
 9b2:	0000                	unimp
 9b4:	0018                	0x18
 9b6:	0000ae0f          	0xae0f
 9ba:	0e00                	addi	s0,sp,784
 9bc:	b604                	fsd	fs1,40(a2)
 9be:	0009                	c.nop	2
 9c0:	1f00                	addi	s0,sp,944
 9c2:	09cc                	addi	a1,sp,212
 9c4:	0000                	unimp
 9c6:	6616                	flw	fa2,68(sp)
 9c8:	0005                	c.nop	1
 9ca:	0000                	unimp
 9cc:	040e                	slli	s0,s0,0x3
 9ce:	09c1                	addi	s3,s3,16
 9d0:	0000                	unimp
 9d2:	040e                	slli	s0,s0,0x3
 9d4:	0289                	addi	t0,t0,2
 9d6:	0000                	unimp
 9d8:	e31f 0009 1600      	0x16000009e31f
 9de:	0141                	addi	sp,sp,16
 9e0:	0000                	unimp
 9e2:	0e00                	addi	s0,sp,784
 9e4:	e904                	fsw	fs1,16(a0)
 9e6:	0009                	c.nop	2
 9e8:	0e00                	addi	s0,sp,784
 9ea:	d804                	sw	s1,48(s0)
 9ec:	0009                	c.nop	2
 9ee:	0b00                	addi	s0,sp,400
 9f0:	000008bb          	0x8bb
 9f4:	09ff                	0x9ff
 9f6:	0000                	unimp
 9f8:	540c                	lw	a1,40(s0)
 9fa:	0001                	nop
 9fc:	0200                	addi	s0,sp,256
 9fe:	2000                	fld	fs0,0(s0)
 a00:	05c4                	addi	s1,sp,708
 a02:	0000                	unimp
 a04:	3305                	jal	724 <_sidata+0x3b8>
 a06:	05661703          	lh	a4,86(a2) # 565c2 <_Min_Stack_Size+0x55dc2>
 a0a:	0000                	unimp
 a0c:	bd20                	fsd	fs0,120(a0)
 a0e:	0005                	c.nop	1
 a10:	0500                	addi	s0,sp,640
 a12:	0334                	addi	a3,sp,392
 a14:	6c1d                	lui	s8,0x7
 a16:	0005                	c.nop	1
 a18:	0200                	addi	s0,sp,256
 a1a:	000000bb          	0xbb
 a1e:	25121407          	0x25121407
 a22:	0000                	unimp
 a24:	0200                	addi	s0,sp,256
 a26:	00000033          	add	zero,zero,zero
 a2a:	38131807          	0x38131807
 a2e:	0000                	unimp
 a30:	0200                	addi	s0,sp,256
 a32:	023e                	slli	tp,tp,0xf
 a34:	0000                	unimp
 a36:	4b132007          	flw	ft0,1201(t1) # fffe14b1 <_fstack+0xeffe0a91>
 a3a:	0000                	unimp
 a3c:	0200                	addi	s0,sp,256
 a3e:	0532                	slli	a0,a0,0xc
 a40:	0000                	unimp
 a42:	5e142407          	flw	fs0,1505(s0) # 14115e1 <_Min_Stack_Size+0x1410de1>
 a46:	0000                	unimp
 a48:	0200                	addi	s0,sp,256
 a4a:	053d                	addi	a0,a0,15
 a4c:	0000                	unimp
 a4e:	71132c07          	flw	fs8,1809(t1)
 a52:	0000                	unimp
 a54:	0200                	addi	s0,sp,256
 a56:	019c                	addi	a5,sp,192
 a58:	0000                	unimp
 a5a:	84143007          	fld	ft0,-1983(s0)
 a5e:	0000                	unimp
 a60:	0200                	addi	s0,sp,256
 a62:	00a6                	slli	ra,ra,0x9
 a64:	0000                	unimp
 a66:	97133807          	fld	fa6,-1679(t1)
 a6a:	0000                	unimp
 a6c:	0200                	addi	s0,sp,256
 a6e:	03ed                	addi	t2,t2,27
 a70:	0000                	unimp
 a72:	aa143c07          	fld	fs8,-1375(s0)
 a76:	0000                	unimp
 a78:	0200                	addi	s0,sp,256
 a7a:	02fe                	slli	t0,t0,0x1f
 a7c:	0000                	unimp
 a7e:	1d144307          	flq	ft6,465(s0)
 a82:	0001                	nop
 a84:	0200                	addi	s0,sp,256
 a86:	0558                	addi	a4,sp,644
 a88:	0000                	unimp
 a8a:	29154807          	flq	fa6,657(a0) # fffe1291 <_fstack+0xeffe0871>
 a8e:	0001                	nop
 a90:	0200                	addi	s0,sp,256
 a92:	000001a7          	0x1a7
 a96:	35144d07          	flq	fs10,849(s0)
 a9a:	0001                	nop
 a9c:	0200                	addi	s0,sp,256
 a9e:	0496                	slli	s1,s1,0x5
 aa0:	0000                	unimp
 aa2:	48155207          	0x48155207
 aa6:	0001                	nop
 aa8:	2100                	fld	fs0,0(a0)
 aaa:	00647473          	csrrci	s0,0x6,8
 aae:	0ba7000b          	0xba7000b
 ab2:	0000                	unimp
 ab4:	1a22                	slli	s4,s4,0x28
 ab6:	0000                	unimp
 ab8:	0900                	addi	s0,sp,144
 aba:	0104                	addi	s1,sp,128
 abc:	2341                	jal	103c <_Min_Stack_Size+0x83c>
 abe:	0409                	addi	s0,s0,2
 ac0:	4101                	li	sp,0
 ac2:	0ab4                	addi	a3,sp,344
 ac4:	0000                	unimp
 ac6:	0824                	addi	s1,sp,24
 ac8:	0b30                	addi	a2,sp,408
 aca:	0a19                	addi	s4,s4,6
 acc:	0000                	unimp
 ace:	0824                	addi	s1,sp,24
 ad0:	0b31                	addi	s6,s6,12
 ad2:	0a31                	addi	s4,s4,12
 ad4:	0000                	unimp
 ad6:	0824                	addi	s1,sp,24
 ad8:	0b32                	slli	s6,s6,0xc
 ada:	0a49                	addi	s4,s4,18
 adc:	0000                	unimp
 ade:	0824                	addi	s1,sp,24
 ae0:	0a610b33          	0xa610b33
 ae4:	0000                	unimp
 ae6:	0824                	addi	s1,sp,24
 ae8:	0b35                	addi	s6,s6,13
 aea:	00000c27          	0xc27
 aee:	0824                	addi	s1,sp,24
 af0:	0b36                	slli	s6,s6,0xd
 af2:	00000c3f 0b370824 	0xb37082400000c3f
 afa:	00000c57          	0xc57
 afe:	0824                	addi	s1,sp,24
 b00:	0b38                	addi	a4,sp,408
 b02:	00000c6f          	jal	s8,b02 <_Min_Stack_Size+0x302>
 b06:	0824                	addi	s1,sp,24
 b08:	0b3a                	slli	s6,s6,0xe
 b0a:	00000bc7          	fmsub.s	fs7,ft0,ft0,ft0,rne
 b0e:	0824                	addi	s1,sp,24
 b10:	0bdf0b3b          	0xbdf0b3b
 b14:	0000                	unimp
 b16:	0824                	addi	s1,sp,24
 b18:	0b3c                	addi	a5,sp,408
 b1a:	00000bf7          	0xbf7
 b1e:	0824                	addi	s1,sp,24
 b20:	0b3d                	addi	s6,s6,15
 b22:	00000c0f          	0xc0f
 b26:	0824                	addi	s1,sp,24
 b28:	0a790b3f 08240000 	0x82400000a790b3f
 b30:	0b40                	addi	s0,sp,404
 b32:	0a91                	addi	s5,s5,4
 b34:	0000                	unimp
 b36:	0824                	addi	s1,sp,24
 b38:	0b42                	slli	s6,s6,0x10
 b3a:	0a25                	addi	s4,s4,9
 b3c:	0000                	unimp
 b3e:	0824                	addi	s1,sp,24
 b40:	0a3d0b43          	fmadd.d	fs6,fs10,ft3,ft1,rne
 b44:	0000                	unimp
 b46:	0824                	addi	s1,sp,24
 b48:	0b44                	addi	s1,sp,404
 b4a:	0a55                	addi	s4,s4,21
 b4c:	0000                	unimp
 b4e:	0824                	addi	s1,sp,24
 b50:	0b45                	addi	s6,s6,17
 b52:	0a6d                	addi	s4,s4,27
 b54:	0000                	unimp
 b56:	0824                	addi	s1,sp,24
 b58:	0c330b47          	0xc330b47
 b5c:	0000                	unimp
 b5e:	0824                	addi	s1,sp,24
 b60:	0b48                	addi	a0,sp,404
 b62:	00000c4b          	fnmsub.s	fs8,ft0,ft0,ft0,rne
 b66:	0824                	addi	s1,sp,24
 b68:	0b49                	addi	s6,s6,18
 b6a:	00000c63          	beqz	zero,b82 <_Min_Stack_Size+0x382>
 b6e:	0824                	addi	s1,sp,24
 b70:	0b4a                	slli	s6,s6,0x12
 b72:	00000c7b          	0xc7b
 b76:	0824                	addi	s1,sp,24
 b78:	0b4c                	addi	a1,sp,404
 b7a:	00000bd3          	fadd.s	fs7,ft0,ft0,rne
 b7e:	0824                	addi	s1,sp,24
 b80:	0b4d                	addi	s6,s6,19
 b82:	00000beb          	0xbeb
 b86:	0824                	addi	s1,sp,24
 b88:	0b4e                	slli	s6,s6,0x13
 b8a:	00000c03          	lb	s8,0(zero) # 0 <_start_reset_vector>
 b8e:	0824                	addi	s1,sp,24
 b90:	0c1b0b4f          	0xc1b0b4f
 b94:	0000                	unimp
 b96:	0824                	addi	s1,sp,24
 b98:	0b51                	addi	s6,s6,20
 b9a:	0a85                	addi	s5,s5,1
 b9c:	0000                	unimp
 b9e:	0824                	addi	s1,sp,24
 ba0:	0b52                	slli	s6,s6,0x14
 ba2:	0a9d                	addi	s5,s5,7
 ba4:	0000                	unimp
 ba6:	2500                	fld	fs0,8(a0)
 ba8:	00000677          	0x677
 bac:	0609                	addi	a2,a2,2
 bae:	0b01                	addi	s6,s6,0
 bb0:	00000bc7          	fmsub.s	fs7,ft0,ft0,ft0,rne
 bb4:	1a22                	slli	s4,s4,0x28
 bb6:	0000                	unimp
 bb8:	0900                	addi	s0,sp,144
 bba:	0108                	addi	a0,sp,128
 bbc:	2341                	jal	113c <_Min_Stack_Size+0x93c>
 bbe:	0809                	addi	a6,a6,2
 bc0:	4101                	li	sp,0
 bc2:	0bb4                	addi	a3,sp,472
 bc4:	0000                	unimp
 bc6:	0200                	addi	s0,sp,256
 bc8:	000005f3          	0x5f3
 bcc:	150a                	slli	a0,a0,0x22
 bce:	bd18                	fsd	fa4,56(a0)
 bd0:	0000                	unimp
 bd2:	0200                	addi	s0,sp,256
 bd4:	01b2                	slli	gp,gp,0xc
 bd6:	0000                	unimp
 bd8:	160a                	slli	a2,a2,0x22
 bda:	c919                	beqz	a0,bf0 <_Min_Stack_Size+0x3f0>
 bdc:	0000                	unimp
 bde:	0200                	addi	s0,sp,256
 be0:	00000277          	0x277
 be4:	1b0a                	slli	s6,s6,0x22
 be6:	d519                	beqz	a0,af4 <_Min_Stack_Size+0x2f4>
 be8:	0000                	unimp
 bea:	0200                	addi	s0,sp,256
 bec:	0594                	addi	a3,sp,704
 bee:	0000                	unimp
 bf0:	1c0a                	slli	s8,s8,0x22
 bf2:	e11a                	fsw	ft6,128(sp)
 bf4:	0000                	unimp
 bf6:	0200                	addi	s0,sp,256
 bf8:	0000057b          	0x57b
 bfc:	210a                	fld	ft2,128(sp)
 bfe:	ed19                	bnez	a0,c1c <_Min_Stack_Size+0x41c>
 c00:	0000                	unimp
 c02:	0200                	addi	s0,sp,256
 c04:	028c                	addi	a1,sp,320
 c06:	0000                	unimp
 c08:	220a                	fld	ft4,128(sp)
 c0a:	f91a                	fsw	ft6,176(sp)
 c0c:	0000                	unimp
 c0e:	0200                	addi	s0,sp,256
 c10:	000000d3          	fadd.s	ft1,ft0,ft0,rne
 c14:	270a                	fld	fa4,128(sp)
 c16:	0519                	addi	a0,a0,6
 c18:	0001                	nop
 c1a:	0200                	addi	s0,sp,256
 c1c:	042c                	addi	a1,sp,520
 c1e:	0000                	unimp
 c20:	280a                	fld	fa6,128(sp)
 c22:	111a                	slli	sp,sp,0x26
 c24:	0001                	nop
 c26:	0200                	addi	s0,sp,256
 c28:	0488                	addi	a0,sp,576
 c2a:	0000                	unimp
 c2c:	330a                	fld	ft6,160(sp)
 c2e:	411e                	lw	sp,196(sp)
 c30:	0001                	nop
 c32:	0200                	addi	s0,sp,256
 c34:	00000487          	0x487
 c38:	340a                	fld	fs0,160(sp)
 c3a:	541f 0001 0200      	0x2000001541f
 c40:	0401                	addi	s0,s0,0
 c42:	0000                	unimp
 c44:	3d0a                	fld	fs10,160(sp)
 c46:	411f 0001 0200      	0x2000001411f
 c4c:	0400                	addi	s0,sp,512
 c4e:	0000                	unimp
 c50:	3e0a                	fld	ft8,160(sp)
 c52:	5420                	lw	s0,104(s0)
 c54:	0001                	nop
 c56:	0200                	addi	s0,sp,256
 c58:	041d                	addi	s0,s0,7
 c5a:	0000                	unimp
 c5c:	470a                	lw	a4,128(sp)
 c5e:	411f 0001 0200      	0x2000001411f
 c64:	041c                	addi	a5,sp,512
 c66:	0000                	unimp
 c68:	480a                	lw	a6,128(sp)
 c6a:	5420                	lw	s0,104(s0)
 c6c:	0001                	nop
 c6e:	0200                	addi	s0,sp,256
 c70:	0105                	addi	sp,sp,1
 c72:	0000                	unimp
 c74:	510a                	lw	sp,160(sp)
 c76:	a31f 0000 0200      	0x2000000a31f
 c7c:	0104                	addi	s1,sp,128
 c7e:	0000                	unimp
 c80:	520a                	lw	tp,160(sp)
 c82:	b620                	fsd	fs0,104(a2)
 c84:	0000                	unimp
 c86:	2600                	fld	fs0,8(a2)
 c88:	7369                	lui	t1,0xffffa
 c8a:	0072                	c.slli	zero,0x1c
 c8c:	4301                	li	t1,0
 c8e:	d806                	sw	ra,48(sp)
 c90:	0002                	c.slli64	zero
 c92:	0400                	addi	s0,sp,512
 c94:	0000                	unimp
 c96:	0100                	addi	s0,sp,128
 c98:	279c                	fld	fa5,8(a5)
 c9a:	03d4                	addi	a3,sp,452
 c9c:	0000                	unimp
 c9e:	3b01                	jal	9ae <_Min_Stack_Size+0x1ae>
 ca0:	d416                	sw	t0,40(sp)
 ca2:	0002                	c.slli64	zero
 ca4:	0400                	addi	s0,sp,512
 ca6:	0000                	unimp
 ca8:	0100                	addi	s0,sp,128
 caa:	bd9c                	fsd	fa5,56(a1)
 cac:	000c                	0xc
 cae:	2800                	fld	fs0,16(s0)
 cb0:	6372                	flw	ft6,28(sp)
 cb2:	0100                	addi	s0,sp,128
 cb4:	0141203b          	0x141203b
 cb8:	0000                	unimp
 cba:	5a01                	li	s4,-32
 cbc:	2900                	fld	fs0,16(a0)
 cbe:	0668                	addi	a0,sp,780
 cc0:	0000                	unimp
 cc2:	0c01                	addi	s8,s8,0
 cc4:	4105                	li	sp,1
 cc6:	0001                	nop
 cc8:	8000                	0x8000
 cca:	0002                	c.slli64	zero
 ccc:	5400                	lw	s0,40(s0)
 cce:	0000                	unimp
 cd0:	0100                	addi	s0,sp,128
 cd2:	1e9c                	addi	a5,sp,880
 cd4:	000d                	c.nop	3
 cd6:	2a00                	fld	fs0,16(a2)
 cd8:	0638                	addi	a4,sp,776
 cda:	0000                	unimp
 cdc:	0c01                	addi	s8,s8,0
 cde:	410e                	lw	sp,192(sp)
 ce0:	0001                	nop
 ce2:	0000                	unimp
 ce4:	0000                	unimp
 ce6:	2a00                	fld	fs0,16(a2)
 ce8:	05d0                	addi	a2,sp,708
 cea:	0000                	unimp
 cec:	0c01                	addi	s8,s8,0
 cee:	000d1e1b          	0xd1e1b
 cf2:	2100                	fld	fs0,0(a0)
 cf4:	0000                	unimp
 cf6:	2b00                	fld	fs0,16(a4)
 cf8:	0000056f          	jal	a0,cf8 <_Min_Stack_Size+0x4f8>
 cfc:	1201                	addi	tp,tp,-32
 cfe:	000a550b          	0xa550b
 d02:	4200                	lw	s0,0(a2)
 d04:	0000                	unimp
 d06:	2c00                	fld	fs0,24(s0)
 d08:	0000                	unimp
 d0a:	0000                	unimp
 d0c:	762d                	lui	a2,0xfffeb
 d0e:	6c61                	lui	s8,0x18
 d10:	0100                	addi	s0,sp,128
 d12:	0c15                	addi	s8,s8,5
 d14:	0a55                	addi	s4,s4,21
 d16:	0000                	unimp
 d18:	0095                	addi	ra,ra,5
 d1a:	0000                	unimp
 d1c:	0000                	unimp
 d1e:	040e                	slli	s0,s0,0x3
 d20:	0000081b          	0x81b
 d24:	2200                	fld	fs0,0(a2)
 d26:	0000                	unimp
 d28:	0200                	addi	s0,sp,256
 d2a:	8700                	0x8700
 d2c:	0002                	c.slli64	zero
 d2e:	0400                	addi	s0,sp,512
 d30:	fd01                	bnez	a0,c48 <_Min_Stack_Size+0x448>
 d32:	0004                	0x4
 d34:	0000                	unimp
 d36:	0000                	unimp
 d38:	e400                	fsw	fs0,8(s0)
 d3a:	0000                	unimp
 d3c:	8100                	0x8100
 d3e:	0006                	c.slli	zero,0x1
 d40:	1400                	addi	s0,sp,544
 d42:	88000003          	lb	zero,-1920(zero) # fffff880 <_fstack+0xefffee60>
 d46:	0006                	c.slli	zero,0x1
 d48:	0100                	addi	s0,sp,128
 d4a:	80              	Address 0x0000000000000d4a is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
	j reset_vector
   0:	1101                	addi	sp,sp,-32
   2:	2501                	jal	602 <_sidata+0x296>
    csrci mstatus, 8
   4:	130e                	slli	t1,t1,0x23
   6:	1b0e030b          	0x1b0e030b
	la gp, __global_pointer$
   a:	550e                	lw	a0,224(sp)
   c:	10011117          	auipc	sp,0x10011
	la sp, _fstack
  10:	02000017          	auipc	zero,0x2000
  14:	0016                	c.slli	zero,0x5
  16:	0b3a0e03          	lb	t3,179(s4) # fffe10b3 <_fstack+0xeffe0693>
	sw x0, 0(sp)
  1a:	0b390b3b          	0xb390b3b
	sw x0, 4(sp)
  1e:	1349                	addi	t1,t1,-14
	la t0, trap_vector
  20:	0000                	unimp
  22:	0b002403          	lw	s0,176(zero) # b0 <trap_vector+0x5c>
  26:	030b3e0b          	0x30b3e0b
	csrw mtvec, t0
  2a:	000e                	c.slli	zero,0x3
	la a0, _sidata  /*from */
  2c:	0400                	addi	s0,sp,512
  2e:	0024                	addi	s1,sp,8
  30:	0b3e0b0b          	0xb3e0b0b
	la a1, _sdata   /* to */
  34:	00000803          	lb	a6,0(zero) # 0 <_start_reset_vector>
  38:	3b05                	jal	fffffd68 <_fstack+0xeffff348>
  3a:	0300                	addi	s0,sp,384
	la a2, _edata  /* end */
  3c:	000e                	c.slli	zero,0x3
  3e:	0600                	addi	s0,sp,768
  40:	0016                	c.slli	zero,0x5
  42:	0b3a0e03          	lb	t3,179(s4)
	beq	a1,a2, DONE
  46:	0b39053b          	0xb39053b
	lw	t0, (a0)
  4a:	1349                	addi	t1,t1,-14
	sw t0, (a1)
  4c:	0000                	unimp
  4e:	0b011307          	0xb011307
	addi a0,a0,4
  52:	3b0b3a0b          	0x3b0b3a0b
	addi a1,a2,4
  56:	6e0b390b          	0x6e0b390b
	bltu a1,a2, TOP
  5a:	010e                	slli	sp,sp,0x3
	call _start
  5c:	08000013          	li	zero,128
  60:	0b0b0117          	auipc	sp,0xb0b0
LOOP:	j LOOP
  64:	0b3a                	slli	s6,s6,0xe
  66:	0b390b3b          	0xb390b3b
	addi sp, sp, -16*4
  6a:	1301                	addi	t1,t1,-32
	sw ra,  0*4(sp)
  6c:	0000                	unimp
  6e:	0d09                	addi	s10,s10,2
	sw t0,  1*4(sp)
  70:	0300                	addi	s0,sp,384
  72:	3a0e                	fld	fs4,224(sp)
	sw t1,  2*4(sp)
  74:	390b3b0b          	0x390b3b0b
	sw t2,  3*4(sp)
  78:	0013490b          	0x13490b
	sw a0,  4*4(sp)
  7c:	0a00                	addi	s0,sp,272
  7e:	000d                	c.nop	3
	sw a1,  5*4(sp)
  80:	0b3a0e03          	lb	t3,179(s4)
	sw a2,  6*4(sp)
  84:	0b390b3b          	0xb390b3b
	sw a3,  7*4(sp)
  88:	1349                	addi	t1,t1,-14
  8a:	0b38                	addi	a4,sp,408
	sw a4,  8*4(sp)
  8c:	0000                	unimp
  8e:	4901010b          	0x4901010b
	sw a5,  9*4(sp)
  92:	00130113          	addi	sp,t1,1 # ffffa001 <_fstack+0xefff95e1>
	sw a6, 10*4(sp)
  96:	0c00                	addi	s0,sp,528
	sw a7, 11*4(sp)
  98:	0021                	c.nop	8
  9a:	1349                	addi	t1,t1,-14
	sw t3, 12*4(sp)
  9c:	00000b2f          	0xb2f
	sw t4, 13*4(sp)
  a0:	0f0d                	addi	t5,t5,3
  a2:	0b00                	addi	s0,sp,400
	sw t5, 14*4(sp)
  a4:	0e00000b          	0xe00000b
	sw t6, 15*4(sp)
  a8:	0b0b000f          	0xb0b000f
	call isr
  ac:	1349                	addi	t1,t1,-14
  ae:	0000                	unimp
  b0:	0300130f          	0x300130f
	lw ra,  0*4(sp)
  b4:	3c0e                	fld	fs8,224(sp)
  b6:	0019                	c.nop	6
	lw t0,  1*4(sp)
  b8:	1000                	addi	s0,sp,32
  ba:	0e030113          	addi	sp,t1,224
	lw t1,  2*4(sp)
  be:	0b3a0b0b          	0xb3a0b0b
	lw t2,  3*4(sp)
  c2:	0b390b3b          	0xb390b3b
	lw a0,  4*4(sp)
  c6:	1301                	addi	t1,t1,-32
	lw a1,  5*4(sp)
  c8:	0000                	unimp
  ca:	0d11                	addi	s10,s10,4
	lw a2,  6*4(sp)
  cc:	0300                	addi	s0,sp,384
  ce:	3a08                	fld	fa0,48(a2)
	lw a3,  7*4(sp)
  d0:	390b3b0b          	0x390b3b0b
	lw a4,  8*4(sp)
  d4:	3813490b          	0x3813490b
	lw a5,  9*4(sp)
  d8:	1200000b          	0x1200000b
	lw a6, 10*4(sp)
  dc:	0e030113          	addi	sp,t1,224
	lw a7, 11*4(sp)
  e0:	0b3a050b          	0xb3a050b
	lw t3, 12*4(sp)
  e4:	0b390b3b          	0xb390b3b
	lw t4, 13*4(sp)
  e8:	1301                	addi	t1,t1,-32
  ea:	0000                	unimp
	lw t5, 14*4(sp)
  ec:	03000d13          	li	s10,48
	lw t6, 15*4(sp)
  f0:	3a0e                	fld	fs4,224(sp)
  f2:	390b3b0b          	0x390b3b0b
	addi sp, sp, 16*4
  f6:	3813490b          	0x3813490b
	mret
  fa:	0005                	c.nop	1
  fc:	1400                	addi	s0,sp,544
  fe:	0015                	c.nop	5
 100:	0000                	unimp
 102:	1515                	addi	a0,a0,-27
 104:	4901                	li	s2,0
 106:	00130113          	addi	sp,t1,1
 10a:	1600                	addi	s0,sp,800
 10c:	0005                	c.nop	1
 10e:	1349                	addi	t1,t1,-14
 110:	0000                	unimp
 112:	49002617          	auipc	a2,0x49002
 116:	18000013          	li	zero,384
 11a:	0e030113          	addi	sp,t1,224
 11e:	0b3a050b          	0xb3a050b
 122:	0b39053b          	0xb39053b
 126:	1301                	addi	t1,t1,-32
 128:	0000                	unimp
 12a:	1719                	addi	a4,a4,-26
 12c:	0b01                	addi	s6,s6,0
 12e:	3b0b3a0b          	0x3b0b3a0b
 132:	3905                	jal	fffffd62 <_fstack+0xeffff342>
 134:	0013010b          	0x13010b
 138:	1a00                	addi	s0,sp,304
 13a:	0b0b0113          	addi	sp,s6,176 # fffe10b0 <_fstack+0xeffe0690>
 13e:	0b3a                	slli	s6,s6,0xe
 140:	0b39053b          	0xb39053b
 144:	1301                	addi	t1,t1,-32
 146:	0000                	unimp
 148:	03000d1b          	0x3000d1b
 14c:	3a0e                	fld	fs4,224(sp)
 14e:	39053b0b          	0x39053b0b
 152:	3813490b          	0x3813490b
 156:	1c00000b          	0x1c00000b
 15a:	000d                	c.nop	3
 15c:	0b3a0e03          	lb	t3,179(s4)
 160:	0b39053b          	0xb39053b
 164:	1349                	addi	t1,t1,-14
 166:	0000                	unimp
 168:	0d1d                	addi	s10,s10,7
 16a:	0300                	addi	s0,sp,384
 16c:	3a0e                	fld	fs4,224(sp)
 16e:	39053b0b          	0x39053b0b
 172:	3813490b          	0x3813490b
 176:	0005                	c.nop	1
 178:	1e00                	addi	s0,sp,816
 17a:	0e030113          	addi	sp,t1,224
 17e:	0b3a0b0b          	0xb3a0b0b
 182:	0b39053b          	0xb39053b
 186:	1301                	addi	t1,t1,-32
 188:	0000                	unimp
 18a:	151f 0101 0013      	0x130101151f
 190:	2000                	fld	fs0,0(s0)
 192:	0034                	addi	a3,sp,8
 194:	0b3a0e03          	lb	t3,179(s4)
 198:	0b39053b          	0xb39053b
 19c:	1349                	addi	t1,t1,-14
 19e:	193c193f 39210000 	0x39210000193c193f
 1a6:	0301                	addi	t1,t1,0
 1a8:	3a08                	fld	fa0,48(a2)
 1aa:	010b3b0b          	0x10b3b0b
 1ae:	22000013          	li	zero,544
 1b2:	0039                	c.nop	14
 1b4:	0b3a0e03          	lb	t3,179(s4)
 1b8:	0b39053b          	0xb39053b
 1bc:	0189                	addi	gp,gp,2
 1be:	0019                	c.nop	6
 1c0:	2300                	fld	fs0,0(a4)
 1c2:	003a                	c.slli	zero,0xe
 1c4:	0b3a                	slli	s6,s6,0xe
 1c6:	0b39053b          	0xb39053b
 1ca:	1318                	addi	a4,sp,416
 1cc:	0000                	unimp
 1ce:	0824                	addi	s1,sp,24
 1d0:	3a00                	fld	fs0,48(a2)
 1d2:	390b3b0b          	0x390b3b0b
 1d6:	0013180b          	0x13180b
 1da:	2500                	fld	fs0,8(a0)
 1dc:	0139                	addi	sp,sp,14
 1de:	0b3a0e03          	lb	t3,179(s4)
 1e2:	0b39053b          	0xb39053b
 1e6:	1301                	addi	t1,t1,-32
 1e8:	0000                	unimp
 1ea:	2e26                	fld	ft8,72(sp)
 1ec:	3f00                	fld	fs0,56(a4)
 1ee:	0319                	addi	t1,t1,6
 1f0:	3a08                	fld	fa0,48(a2)
 1f2:	390b3b0b          	0x390b3b0b
 1f6:	1201110b          	0x1201110b
 1fa:	4006                	0x4006
 1fc:	9718                	0x9718
 1fe:	1942                	slli	s2,s2,0x30
 200:	0000                	unimp
 202:	3f012e27          	fsw	fa6,1020(sp) # b0b045c <_Min_Stack_Size+0xb0afc5c>
 206:	0319                	addi	t1,t1,6
 208:	3a0e                	fld	fs4,224(sp)
 20a:	390b3b0b          	0x390b3b0b
 20e:	1901870b          	0x1901870b
 212:	0111                	addi	sp,sp,4
 214:	0612                	slli	a2,a2,0x4
 216:	1840                	addi	s0,sp,52
 218:	01194297          	auipc	t0,0x1194
 21c:	28000013          	li	zero,640
 220:	0005                	c.nop	1
 222:	0b3a0803          	lb	a6,179(s4)
 226:	0b390b3b          	0xb390b3b
 22a:	1349                	addi	t1,t1,-14
 22c:	1802                	slli	a6,a6,0x20
 22e:	0000                	unimp
 230:	2e29                	jal	54a <_sidata+0x1de>
 232:	3f01                	jal	142 <memset+0xe>
 234:	0319                	addi	t1,t1,6
 236:	3a0e                	fld	fs4,224(sp)
 238:	390b3b0b          	0x390b3b0b
 23c:	1113490b          	0x1113490b
 240:	1201                	addi	tp,tp,-32
 242:	4006                	0x4006
 244:	9718                	0x9718
 246:	1942                	slli	s2,s2,0x30
 248:	1301                	addi	t1,t1,-32
 24a:	0000                	unimp
 24c:	052a                	slli	a0,a0,0xa
 24e:	0300                	addi	s0,sp,384
 250:	3a0e                	fld	fs4,224(sp)
 252:	390b3b0b          	0x390b3b0b
 256:	0213490b          	0x213490b
 25a:	2b000017          	auipc	zero,0x2b000
 25e:	0034                	addi	a3,sp,8
 260:	0b3a0e03          	lb	t3,179(s4)
 264:	0b390b3b          	0xb390b3b
 268:	1349                	addi	t1,t1,-14
 26a:	1702                	slli	a4,a4,0x20
 26c:	0000                	unimp
 26e:	0b2c                	addi	a1,sp,408
 270:	5501                	li	a0,-32
 272:	2d000017          	auipc	zero,0x2d000
 276:	0034                	addi	a3,sp,8
 278:	0b3a0803          	lb	a6,179(s4)
 27c:	0b390b3b          	0xb390b3b
{
 280:	1349                	addi	t1,t1,-14
 282:	1702                	slli	a4,a4,0x20
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 284:	0000                	unimp
 286:	0100                	addi	s0,sp,128
			if (val == '0')
 288:	0011                	c.nop	4
 28a:	0610                	addi	a2,sp,768
				GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	0111                	addi	sp,sp,4
 28e:	0112                	slli	sp,sp,0x4
 290:	0e1b0e03          	lb	t3,225(s6)
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 294:	0e25                	addi	t3,t3,9
 296:	00000513          	li	a0,0
	...

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
	j reset_vector
   0:	0280                	addi	s0,sp,320
   2:	0000                	unimp
    csrci mstatus, 8
   4:	0298                	addi	a4,sp,320
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	0001                	nop
   a:	985a                	add	a6,a6,s6
   c:	0002                	c.slli64	zero
   e:	d400                	sw	s0,40(s0)
	la sp, _fstack
  10:	0002                	c.slli64	zero
  12:	0400                	addi	s0,sp,512
  14:	f300                	fsw	fs0,32(a4)
  16:	5a01                	li	s4,-32
	sw x0, 0(sp)
  18:	009f 0000 0000      	0x9f
	sw x0, 4(sp)
  1e:	0000                	unimp
	la t0, trap_vector
  20:	8000                	0x8000
  22:	0002                	c.slli64	zero
  24:	8c00                	0x8c00
  26:	0002                	c.slli64	zero
	csrw mtvec, t0
  28:	0100                	addi	s0,sp,128
  2a:	5b00                	lw	s0,48(a4)
	la a0, _sidata  /*from */
  2c:	028c                	addi	a1,sp,320
  2e:	0000                	unimp
  30:	02d4                	addi	a3,sp,324
  32:	0000                	unimp
	la a1, _sdata   /* to */
  34:	0004                	0x4
  36:	9f5b01f3          	0x9f5b01f3
	...
	la a2, _edata  /* end */
  42:	0280                	addi	s0,sp,320
	beq	a1,a2, DONE
  44:	0000                	unimp
  46:	02a0                	addi	s0,sp,328
	lw	t0, (a0)
  48:	0000                	unimp
  4a:	0002                	c.slli64	zero
	sw t0, (a1)
  4c:	9f30                	0x9f30
  4e:	02a0                	addi	s0,sp,328
	addi a0,a0,4
  50:	0000                	unimp
  52:	02c4                	addi	s1,sp,324
	addi a1,a2,4
  54:	0000                	unimp
  56:	010a0007          	0x10a0007
	bltu a1,a2, TOP
  5a:	7d7d                	lui	s10,0xfffff
	call _start
  5c:	1c00                	addi	s0,sp,560
  5e:	c49f 0002 c800      	0xc8000002c49f
LOOP:	j LOOP
  64:	0002                	c.slli64	zero
  66:	0700                	addi	s0,sp,896
	addi sp, sp, -16*4
  68:	0a00                	addi	s0,sp,272
  6a:	7d02                	flw	fs10,32(sp)
	sw ra,  0*4(sp)
  6c:	007d                	c.nop	31
  6e:	9f1c                	0x9f1c
	sw t0,  1*4(sp)
  70:	02c8                	addi	a0,sp,324
  72:	0000                	unimp
	sw t1,  2*4(sp)
  74:	02d0                	addi	a2,sp,324
  76:	0000                	unimp
	sw t2,  3*4(sp)
  78:	010a0007          	0x10a0007
	sw a0,  4*4(sp)
  7c:	7d7d                	lui	s10,0xfffff
  7e:	1c00                	addi	s0,sp,560
	sw a1,  5*4(sp)
  80:	d09f 0002 d400      	0xd4000002d09f
	sw a2,  6*4(sp)
  86:	0002                	c.slli64	zero
	sw a3,  7*4(sp)
  88:	0200                	addi	s0,sp,256
  8a:	3000                	fld	fs0,32(s0)
	sw a4,  8*4(sp)
  8c:	009f 0000 0000      	0x9f
	sw a5,  9*4(sp)
  92:	0000                	unimp
	sw a6, 10*4(sp)
  94:	a000                	fsd	fs0,0(s0)
  96:	0002                	c.slli64	zero
	sw a7, 11*4(sp)
  98:	a400                	fsd	fs0,8(s0)
  9a:	0002                	c.slli64	zero
	sw t3, 12*4(sp)
  9c:	0200                	addi	s0,sp,256
  9e:	3000                	fld	fs0,32(s0)
	sw t4, 13*4(sp)
  a0:	a49f 0002 ac00      	0xac000002a49f
	sw t5, 14*4(sp)
  a6:	0002                	c.slli64	zero
	sw t6, 15*4(sp)
  a8:	0100                	addi	s0,sp,128
  aa:	5e00                	lw	s0,56(a2)
	call isr
  ac:	02ac                	addi	a1,sp,328
  ae:	0000                	unimp
  b0:	02b0                	addi	a2,sp,328
  b2:	0000                	unimp
	lw ra,  0*4(sp)
  b4:	0006                	c.slli	zero,0x1
  b6:	007e                	c.slli	zero,0x1f
	lw t0,  1*4(sp)
  b8:	ff08                	fsw	fa0,56(a4)
  ba:	9f1a                	add	t5,t5,t1
	lw t1,  2*4(sp)
  bc:	02b0                	addi	a2,sp,328
  be:	0000                	unimp
	lw t2,  3*4(sp)
  c0:	02d4                	addi	a3,sp,324
  c2:	0000                	unimp
	lw a0,  4*4(sp)
  c4:	0001                	nop
  c6:	005e                	c.slli	zero,0x17
	lw a1,  5*4(sp)
  c8:	0000                	unimp
  ca:	0000                	unimp
	lw a2,  6*4(sp)
  cc:	0000                	unimp
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
	j reset_vector
   0:	002c                	addi	a1,sp,8
   2:	0000                	unimp
    csrci mstatus, 8
   4:	0002                	c.slli64	zero
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	0000                	unimp
   a:	0004                	0x4
   c:	0000                	unimp
   e:	0000                	unimp
	la sp, _fstack
  10:	0280                	addi	s0,sp,320
  12:	0000                	unimp
  14:	0054                	addi	a3,sp,4
  16:	0000                	unimp
	sw x0, 0(sp)
  18:	02d4                	addi	a3,sp,324
  1a:	0000                	unimp
	sw x0, 4(sp)
  1c:	0004                	0x4
  1e:	0000                	unimp
	la t0, trap_vector
  20:	02d8                	addi	a4,sp,324
  22:	0000                	unimp
  24:	0004                	0x4
	...
	la a0, _sidata  /*from */
  2e:	0000                	unimp
  30:	001c                	0x1c
  32:	0000                	unimp
	la a1, _sdata   /* to */
  34:	0002                	c.slli64	zero
  36:	0d25                	addi	s10,s10,9
  38:	0000                	unimp
  3a:	0004                	0x4
	...
	beq	a1,a2, DONE
  44:	00fc                	addi	a5,sp,76
	...

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
	j reset_vector
   0:	0284                	addi	s1,sp,320
   2:	0000                	unimp
    csrci mstatus, 8
   4:	029c                	addi	a5,sp,320
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	02a0                	addi	s0,sp,328
   a:	0000                	unimp
   c:	02d4                	addi	a3,sp,324
	...
	la sp, _fstack
  16:	0000                	unimp
	sw x0, 0(sp)
  18:	0280                	addi	s0,sp,320
  1a:	0000                	unimp
	sw x0, 4(sp)
  1c:	02d4                	addi	a3,sp,324
  1e:	0000                	unimp
	la t0, trap_vector
  20:	02d4                	addi	a3,sp,324
  22:	0000                	unimp
  24:	02d8                	addi	a4,sp,324
  26:	0000                	unimp
	csrw mtvec, t0
  28:	02d8                	addi	a4,sp,324
  2a:	0000                	unimp
	la a0, _sidata  /*from */
  2c:	02dc                	addi	a5,sp,324
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
	j reset_vector
   0:	04f9                	addi	s1,s1,30
   2:	0000                	unimp
    csrci mstatus, 8
   4:	03970003          	lb	zero,57(a4) # fffe1039 <_fstack+0xeffe0619>
	la gp, __global_pointer$
   8:	0000                	unimp
   a:	0101                	addi	sp,sp,0
   c:	000d0efb          	0xd0efb
	la sp, _fstack
  10:	0101                	addi	sp,sp,0
  12:	0101                	addi	sp,sp,0
  14:	0000                	unimp
  16:	0100                	addi	s0,sp,128
	sw x0, 0(sp)
  18:	0000                	unimp
  1a:	6501                	0x6501
	sw x0, 4(sp)
  1c:	6178                	flw	fa4,68(a0)
  1e:	706d                	c.lui	zero,0xffffb
	la t0, trap_vector
  20:	656c                	flw	fa1,76(a0)
  22:	6146                	flw	ft2,80(sp)
  24:	65537473          	csrrci	s0,0x655,6
	csrw mtvec, t0
  28:	6972                	flw	fs2,28(sp)
  2a:	6c61                	lui	s8,0x18
	la a0, _sidata  /*from */
  2c:	2f00                	fld	fs0,24(a4)
  2e:	656d                	lui	a0,0x1b
  30:	6964                	flw	fs1,84(a0)
  32:	2f61                	jal	7ca <_sidata+0x45e>
	la a1, _sdata   /* to */
  34:	6374                	flw	fa3,68(a4)
  36:	696d                	lui	s2,0x1b
  38:	6c616863          	bltu	sp,t1,708 <_sidata+0x39c>
	la a2, _edata  /* end */
  3c:	6f572f73          	csrrs	t5,0x6f5,a4
  40:	6b72                	flw	fs6,28(sp)
  42:	6e69                	lui	t3,0x1a
	beq	a1,a2, DONE
  44:	79632f67          	0x79632f67
	lw	t0, (a0)
  48:	6e6f6c63          	bltu	t5,t1,740 <_sidata+0x3d4>
	sw t0, (a1)
  4c:	2d65                	jal	704 <_sidata+0x398>
  4e:	3031                	jal	fffff85a <_fstack+0xefffee3a>
	addi a0,a0,4
  50:	6379632f          	0x6379632f
	addi a1,a2,4
  54:	3031                	jal	fffff860 <_fstack+0xefffee40>
  56:	3030                	fld	fa2,96(s0)
	bltu a1,a2, TOP
  58:	7369722f          	0x7369722f
	call _start
  5c:	672d7663          	bgeu	s10,s2,6c8 <_sidata+0x35c>
  60:	722f6363          	bltu	t5,sp,786 <_sidata+0x41a>
LOOP:	j LOOP
  64:	7369                	lui	t1,0xffffa
  66:	6e2d7663          	bgeu	s10,sp,752 <_sidata+0x3e6>
	addi sp, sp, -16*4
  6a:	2d656e6f          	jal	t3,56340 <_Min_Stack_Size+0x55b40>
	sw ra,  0*4(sp)
  6e:	6d65                	lui	s10,0x19
	sw t0,  1*4(sp)
  70:	6562                	flw	fa0,24(sp)
  72:	2d64                	fld	fs1,216(a0)
	sw t1,  2*4(sp)
  74:	2f636367          	0x2f636367
	sw t2,  3*4(sp)
  78:	2e38                	fld	fa4,88(a2)
  7a:	2d302e33          	0x2d302e33
	sw a0,  4*4(sp)
  7e:	2e31                	jal	39a <_sidata+0x2e>
	sw a1,  5*4(sp)
  80:	2f31                	jal	79c <_sidata+0x430>
  82:	6972                	flw	fs2,28(sp)
	sw a2,  6*4(sp)
  84:	2d766373          	csrrsi	t1,0x2d7,12
	sw a3,  7*4(sp)
  88:	6f6e                	flw	ft10,216(sp)
  8a:	656e                	flw	fa0,216(sp)
	sw a4,  8*4(sp)
  8c:	652d                	lui	a0,0xb
  8e:	626d                	lui	tp,0x1b
	sw a5,  9*4(sp)
  90:	6465                	lui	s0,0x19
  92:	636e692f          	0x636e692f
	sw a6, 10*4(sp)
  96:	756c                	flw	fa1,108(a0)
	sw a7, 11*4(sp)
  98:	6564                	flw	fs1,76(a0)
  9a:	63616d2f          	0x63616d2f
	sw t3, 12*4(sp)
  9e:	6968                	flw	fa0,84(a0)
	sw t4, 13*4(sp)
  a0:	656e                	flw	fa0,216(sp)
  a2:	2f00                	fld	fs0,24(a4)
	sw t5, 14*4(sp)
  a4:	656d                	lui	a0,0x1b
  a6:	6964                	flw	fs1,84(a0)
	sw t6, 15*4(sp)
  a8:	2f61                	jal	840 <_Min_Stack_Size+0x40>
  aa:	6374                	flw	fa3,68(a4)
	call isr
  ac:	696d                	lui	s2,0x1b
  ae:	6c616863          	bltu	sp,t1,77e <_sidata+0x412>
  b2:	6f572f73          	csrrs	t5,0x6f5,a4
	lw ra,  0*4(sp)
  b6:	6b72                	flw	fs6,28(sp)
	lw t0,  1*4(sp)
  b8:	6e69                	lui	t3,0x1a
  ba:	79632f67          	0x79632f67
	lw t1,  2*4(sp)
  be:	6e6f6c63          	bltu	t5,t1,7b6 <_sidata+0x44a>
	lw t2,  3*4(sp)
  c2:	2d65                	jal	77a <_sidata+0x40e>
	lw a0,  4*4(sp)
  c4:	3031                	jal	fffff8d0 <_fstack+0xefffeeb0>
  c6:	6379632f          	0x6379632f
	lw a1,  5*4(sp)
  ca:	3031                	jal	fffff8d6 <_fstack+0xefffeeb6>
	lw a2,  6*4(sp)
  cc:	3030                	fld	fa2,96(s0)
  ce:	7369722f          	0x7369722f
	lw a3,  7*4(sp)
  d2:	672d7663          	bgeu	s10,s2,73e <_sidata+0x3d2>
	lw a4,  8*4(sp)
  d6:	722f6363          	bltu	t5,sp,7fc <_sidata+0x490>
	lw a5,  9*4(sp)
  da:	7369                	lui	t1,0xffffa
	lw a6, 10*4(sp)
  dc:	6e2d7663          	bgeu	s10,sp,7c8 <_sidata+0x45c>
	lw a7, 11*4(sp)
  e0:	2d656e6f          	jal	t3,563b6 <_Min_Stack_Size+0x55bb6>
	lw t3, 12*4(sp)
  e4:	6d65                	lui	s10,0x19
  e6:	6562                	flw	fa0,24(sp)
	lw t4, 13*4(sp)
  e8:	2d64                	fld	fs1,216(a0)
  ea:	2f636367          	0x2f636367
	lw t5, 14*4(sp)
  ee:	2e38                	fld	fa4,88(a2)
	lw t6, 15*4(sp)
  f0:	2d302e33          	0x2d302e33
	addi sp, sp, 16*4
  f4:	2e31                	jal	410 <_sidata+0xa4>
  f6:	2f31                	jal	812 <_Min_Stack_Size+0x12>
	mret
  f8:	696c                	flw	fa1,84(a0)
  fa:	2f62                	fld	ft10,24(sp)
  fc:	2f636367          	0x2f636367
 100:	6972                	flw	fs2,28(sp)
 102:	2d766373          	csrrsi	t1,0x2d7,12
 106:	6f6e                	flw	ft10,216(sp)
 108:	656e                	flw	fa0,216(sp)
 10a:	652d                	lui	a0,0xb
 10c:	626d                	lui	tp,0x1b
 10e:	6465                	lui	s0,0x19
 110:	332e382f          	0x332e382f
 114:	302e                	fld	ft0,232(sp)
 116:	636e692f          	0x636e692f
 11a:	756c                	flw	fa1,108(a0)
 11c:	6564                	flw	fs1,76(a0)
 11e:	2f00                	fld	fs0,24(a4)
 120:	656d                	lui	a0,0x1b
 122:	6964                	flw	fs1,84(a0)
 124:	2f61                	jal	8bc <_Min_Stack_Size+0xbc>
 126:	6374                	flw	fa3,68(a4)
 128:	696d                	lui	s2,0x1b
 12a:	6c616863          	bltu	sp,t1,7fa <_sidata+0x48e>
 12e:	6f572f73          	csrrs	t5,0x6f5,a4
 132:	6b72                	flw	fs6,28(sp)
 134:	6e69                	lui	t3,0x1a
 136:	79632f67          	0x79632f67
 13a:	6e6f6c63          	bltu	t5,t1,832 <_Min_Stack_Size+0x32>
 13e:	2d65                	jal	7f6 <_sidata+0x48a>
 140:	3031                	jal	fffff94c <_fstack+0xefffef2c>
 142:	6379632f          	0x6379632f
 146:	3031                	jal	fffff952 <_fstack+0xefffef32>
 148:	3030                	fld	fa2,96(s0)
 14a:	7369722f          	0x7369722f
 14e:	672d7663          	bgeu	s10,s2,7ba <_sidata+0x44e>
 152:	722f6363          	bltu	t5,sp,878 <_Min_Stack_Size+0x78>
 156:	7369                	lui	t1,0xffffa
 158:	6e2d7663          	bgeu	s10,sp,844 <_Min_Stack_Size+0x44>
 15c:	2d656e6f          	jal	t3,56432 <_Min_Stack_Size+0x55c32>
 160:	6d65                	lui	s10,0x19
 162:	6562                	flw	fa0,24(sp)
 164:	2d64                	fld	fs1,216(a0)
 166:	2f636367          	0x2f636367
 16a:	2e38                	fld	fa4,88(a2)
 16c:	2d302e33          	0x2d302e33
 170:	2e31                	jal	48c <_sidata+0x120>
 172:	2f31                	jal	88e <_Min_Stack_Size+0x8e>
 174:	6972                	flw	fs2,28(sp)
 176:	2d766373          	csrrsi	t1,0x2d7,12
 17a:	6f6e                	flw	ft10,216(sp)
 17c:	656e                	flw	fa0,216(sp)
 17e:	652d                	lui	a0,0xb
 180:	626d                	lui	tp,0x1b
 182:	6465                	lui	s0,0x19
 184:	636e692f          	0x636e692f
 188:	756c                	flw	fa1,108(a0)
 18a:	6564                	flw	fs1,76(a0)
 18c:	7379732f          	0x7379732f
 190:	2f00                	fld	fs0,24(a4)
 192:	656d                	lui	a0,0x1b
 194:	6964                	flw	fs1,84(a0)
 196:	2f61                	jal	92e <_Min_Stack_Size+0x12e>
 198:	6374                	flw	fa3,68(a4)
 19a:	696d                	lui	s2,0x1b
 19c:	6c616863          	bltu	sp,t1,86c <_Min_Stack_Size+0x6c>
 1a0:	6f572f73          	csrrs	t5,0x6f5,a4
 1a4:	6b72                	flw	fs6,28(sp)
 1a6:	6e69                	lui	t3,0x1a
 1a8:	79632f67          	0x79632f67
 1ac:	6e6f6c63          	bltu	t5,t1,8a4 <_Min_Stack_Size+0xa4>
 1b0:	2d65                	jal	868 <_Min_Stack_Size+0x68>
 1b2:	3031                	jal	fffff9be <_fstack+0xefffef9e>
 1b4:	6379632f          	0x6379632f
 1b8:	3031                	jal	fffff9c4 <_fstack+0xefffefa4>
 1ba:	3030                	fld	fa2,96(s0)
 1bc:	7369722f          	0x7369722f
 1c0:	672d7663          	bgeu	s10,s2,82c <_Min_Stack_Size+0x2c>
 1c4:	722f6363          	bltu	t5,sp,8ea <_Min_Stack_Size+0xea>
 1c8:	7369                	lui	t1,0xffffa
 1ca:	6e2d7663          	bgeu	s10,sp,8b6 <_Min_Stack_Size+0xb6>
 1ce:	2d656e6f          	jal	t3,564a4 <_Min_Stack_Size+0x55ca4>
 1d2:	6d65                	lui	s10,0x19
 1d4:	6562                	flw	fa0,24(sp)
 1d6:	2d64                	fld	fs1,216(a0)
 1d8:	2f636367          	0x2f636367
 1dc:	2e38                	fld	fa4,88(a2)
 1de:	2d302e33          	0x2d302e33
 1e2:	2e31                	jal	4fe <_sidata+0x192>
 1e4:	2f31                	jal	900 <_Min_Stack_Size+0x100>
 1e6:	6972                	flw	fs2,28(sp)
 1e8:	2d766373          	csrrsi	t1,0x2d7,12
 1ec:	6f6e                	flw	ft10,216(sp)
 1ee:	656e                	flw	fa0,216(sp)
 1f0:	652d                	lui	a0,0xb
 1f2:	626d                	lui	tp,0x1b
 1f4:	6465                	lui	s0,0x19
 1f6:	636e692f          	0x636e692f
 1fa:	756c                	flw	fa1,108(a0)
 1fc:	6564                	flw	fs1,76(a0)
 1fe:	2b2b632f          	0x2b2b632f
 202:	332e382f          	0x332e382f
 206:	302e                	fld	ft0,232(sp)
 208:	2f00                	fld	fs0,24(a4)
 20a:	656d                	lui	a0,0x1b
 20c:	6964                	flw	fs1,84(a0)
 20e:	2f61                	jal	9a6 <_Min_Stack_Size+0x1a6>
 210:	6374                	flw	fa3,68(a4)
 212:	696d                	lui	s2,0x1b
 214:	6c616863          	bltu	sp,t1,8e4 <_Min_Stack_Size+0xe4>
 218:	6f572f73          	csrrs	t5,0x6f5,a4
 21c:	6b72                	flw	fs6,28(sp)
 21e:	6e69                	lui	t3,0x1a
 220:	79632f67          	0x79632f67
 224:	6e6f6c63          	bltu	t5,t1,91c <_Min_Stack_Size+0x11c>
 228:	2d65                	jal	8e0 <_Min_Stack_Size+0xe0>
 22a:	3031                	jal	fffffa36 <_fstack+0xeffff016>
 22c:	6379632f          	0x6379632f
 230:	3031                	jal	fffffa3c <_fstack+0xeffff01c>
 232:	3030                	fld	fa2,96(s0)
 234:	7369722f          	0x7369722f
 238:	672d7663          	bgeu	s10,s2,8a4 <_Min_Stack_Size+0xa4>
 23c:	722f6363          	bltu	t5,sp,962 <_Min_Stack_Size+0x162>
 240:	7369                	lui	t1,0xffffa
 242:	6e2d7663          	bgeu	s10,sp,92e <_Min_Stack_Size+0x12e>
 246:	2d656e6f          	jal	t3,5651c <_Min_Stack_Size+0x55d1c>
 24a:	6d65                	lui	s10,0x19
 24c:	6562                	flw	fa0,24(sp)
 24e:	2d64                	fld	fs1,216(a0)
 250:	2f636367          	0x2f636367
 254:	2e38                	fld	fa4,88(a2)
 256:	2d302e33          	0x2d302e33
 25a:	2e31                	jal	576 <_sidata+0x20a>
 25c:	2f31                	jal	978 <_Min_Stack_Size+0x178>
 25e:	6972                	flw	fs2,28(sp)
 260:	2d766373          	csrrsi	t1,0x2d7,12
 264:	6f6e                	flw	ft10,216(sp)
 266:	656e                	flw	fa0,216(sp)
 268:	652d                	lui	a0,0xb
 26a:	626d                	lui	tp,0x1b
 26c:	6465                	lui	s0,0x19
 26e:	636e692f          	0x636e692f
 272:	756c                	flw	fa1,108(a0)
 274:	6564                	flw	fs1,76(a0)
 276:	2b2b632f          	0x2b2b632f
 27a:	332e382f          	0x332e382f
 27e:	302e                	fld	ft0,232(sp)
{
 280:	7369722f          	0x7369722f
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 284:	6e2d7663          	bgeu	s10,sp,970 <_Min_Stack_Size+0x170>
			if (val == '0')
 288:	2d656e6f          	jal	t3,5655e <_Min_Stack_Size+0x55d5e>
				GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	6d65                	lui	s10,0x19
 28e:	6562                	flw	fa0,24(sp)
 290:	2f64                	fld	fs1,216(a4)
 292:	7672                	flw	fa2,60(sp)
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 294:	2f693233          	0x2f693233
			GPIO_SET_TOGGLE_REG  = LED_7;
 298:	6c69                	lui	s8,0x1a
 29a:	3370                	fld	fa2,224(a4)
{
 29c:	2f32                	fld	ft10,264(sp)
 29e:	6962                	flw	fs2,24(sp)
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 2a0:	7374                	flw	fa3,100(a4)
 2a2:	2f00                	fld	fs0,24(a4)
 2a4:	656d                	lui	a0,0x1b
 2a6:	6964                	flw	fs1,84(a0)
 2a8:	2f61                	jal	a40 <_Min_Stack_Size+0x240>
 2aa:	6374                	flw	fa3,68(a4)
			val &= 0xFF;
 2ac:	696d                	lui	s2,0x1b
 2ae:	6c616863          	bltu	sp,t1,97e <_Min_Stack_Size+0x17e>
			if (val == '0')
 2b2:	6f572f73          	csrrs	t5,0x6f5,a4
				GPIO_SET_TOGGLE_REG  = LED_0;
 2b6:	6b72                	flw	fs6,28(sp)
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
 2b8:	6e69                	lui	t3,0x1a
 2ba:	79632f67          	0x79632f67
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2be:	6e6f6c63          	bltu	t5,t1,9b6 <_Min_Stack_Size+0x1b6>
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2c2:	2d65                	jal	97a <_Min_Stack_Size+0x17a>
		if (led7Delay++ == SLOW_DELAY)
 2c4:	3031                	jal	fffffad0 <_fstack+0xeffff0b0>
 2c6:	6379632f          	0x6379632f
 2ca:	3031                	jal	fffffad6 <_fstack+0xeffff0b6>
			GPIO_SET_TOGGLE_REG  = LED_7;
 2cc:	3030                	fld	fa2,96(s0)
 2ce:	7369722f          	0x7369722f
			led7Delay = 0;
 2d2:	672d7663          	bgeu	s10,s2,93e <_Min_Stack_Size+0x13e>
	for( ;; );
 2d6:	722f6363          	bltu	t5,sp,9fc <_Min_Stack_Size+0x1fc>
}
 2da:	7369                	lui	t1,0xffffa
 2dc:	6e2d7663          	bgeu	s10,sp,9c8 <_Min_Stack_Size+0x1c8>
 2e0:	2d656e6f          	jal	t3,565b6 <_Min_Stack_Size+0x55db6>
 2e4:	6d65                	lui	s10,0x19
 2e6:	6562                	flw	fa0,24(sp)
 2e8:	2d64                	fld	fs1,216(a0)
 2ea:	2f636367          	0x2f636367
 2ee:	2e38                	fld	fa4,88(a2)
 2f0:	2d302e33          	0x2d302e33
 2f4:	2e31                	jal	610 <_sidata+0x2a4>
 2f6:	2f31                	jal	a12 <_Min_Stack_Size+0x212>
 2f8:	6972                	flw	fs2,28(sp)
 2fa:	2d766373          	csrrsi	t1,0x2d7,12
 2fe:	6f6e                	flw	ft10,216(sp)
 300:	656e                	flw	fa0,216(sp)
 302:	652d                	lui	a0,0xb
 304:	626d                	lui	tp,0x1b
 306:	6465                	lui	s0,0x19
 308:	636e692f          	0x636e692f
 30c:	756c                	flw	fa1,108(a0)
 30e:	6564                	flw	fs1,76(a0)
 310:	0000                	unimp
 312:	616d                	addi	sp,sp,240
 314:	6e69                	lui	t3,0x1a
 316:	632e                	flw	ft6,200(sp)
 318:	7070                	flw	fa2,100(s0)
 31a:	0100                	addi	s0,sp,128
 31c:	0000                	unimp
 31e:	645f 6665 7561      	0x75616665645f
 324:	746c                	flw	fa1,108(s0)
 326:	745f 7079 7365      	0x73657079745f
 32c:	682e                	flw	fa6,200(sp)
 32e:	0200                	addi	s0,sp,256
 330:	0000                	unimp
 332:	64647473          	csrrci	s0,0x646,8
 336:	6665                	lui	a2,0x19
 338:	682e                	flw	fa6,200(sp)
 33a:	0300                	addi	s0,sp,384
 33c:	0000                	unimp
 33e:	745f 7079 7365      	0x73657079745f
 344:	682e                	flw	fa6,200(sp)
 346:	0400                	addi	s0,sp,512
 348:	0000                	unimp
 34a:	6572                	flw	fa0,28(sp)
 34c:	6e65                	lui	t3,0x19
 34e:	2e74                	fld	fa3,216(a2)
 350:	0068                	addi	a0,sp,12
 352:	0004                	0x4
 354:	6c00                	flw	fs0,24(s0)
 356:	2e6b636f          	jal	t1,b663c <_Min_Stack_Size+0xb5e3c>
 35a:	0068                	addi	a0,sp,12
 35c:	0004                	0x4
 35e:	5f00                	lw	s0,56(a4)
 360:	69647473          	csrrci	s0,0x696,8
 364:	746e                	flw	fs0,248(sp)
 366:	682e                	flw	fa6,200(sp)
 368:	0400                	addi	s0,sp,512
 36a:	0000                	unimp
 36c:	64747363          	bgeu	s0,t2,9b2 <_Min_Stack_Size+0x1b2>
 370:	6e69                	lui	t3,0x1a
 372:	0074                	addi	a3,sp,12
 374:	0005                	c.nop	1
 376:	6300                	flw	fs0,0(a4)
 378:	6f632b2b          	0x6f632b2b
 37c:	666e                	flw	fa2,216(sp)
 37e:	6769                	lui	a4,0x1a
 380:	682e                	flw	fa6,200(sp)
 382:	0600                	addi	s0,sp,768
 384:	0000                	unimp
 386:	69647473          	csrrci	s0,0x696,8
 38a:	746e                	flw	fs0,248(sp)
 38c:	682e                	flw	fa6,200(sp)
 38e:	0700                	addi	s0,sp,896
 390:	0000                	unimp
 392:	623c                	flw	fa5,64(a2)
 394:	6975                	lui	s2,0x1d
 396:	746c                	flw	fa1,108(s0)
 398:	692d                	lui	s2,0xb
 39a:	3e6e                	fld	ft8,248(sp)
 39c:	0000                	unimp
 39e:	0000                	unimp
 3a0:	0500                	addi	s0,sp,640
 3a2:	0001                	nop
 3a4:	0205                	addi	tp,tp,1
 3a6:	0280                	addi	s0,sp,320
 3a8:	0000                	unimp
 3aa:	05010c03          	lb	s8,80(sp)
 3ae:	0302                	c.slli64	t1
 3b0:	0901                	addi	s2,s2,0
 3b2:	0000                	unimp
 3b4:	0301                	addi	t1,t1,0
 3b6:	0901                	addi	s2,s2,0
 3b8:	0000                	unimp
 3ba:	0301                	addi	t1,t1,0
 3bc:	00000903          	lb	s2,0(zero) # 0 <_start_reset_vector>
 3c0:	0501                	addi	a0,a0,0
 3c2:	0601                	addi	a2,a2,0
 3c4:	00097b03          	0x97b03
 3c8:	0100                	addi	s0,sp,128
 3ca:	0c05                	addi	s8,s8,1
 3cc:	04091503          	lh	a0,64(s2) # b040 <_Min_Stack_Size+0xa840>
 3d0:	0100                	addi	s0,sp,128
 3d2:	0405                	addi	s0,s0,1
 3d4:	04090303          	lb	t1,64(s2)
 3d8:	0100                	addi	s0,sp,128
 3da:	1a05                	addi	s4,s4,-31
 3dc:	04090203          	lb	tp,64(s2)
 3e0:	0100                	addi	s0,sp,128
 3e2:	1705                	addi	a4,a4,-31
 3e4:	08090303          	lb	t1,128(s2)
 3e8:	0100                	addi	s0,sp,128
 3ea:	1905                	addi	s2,s2,-31
 3ec:	04090803          	lb	a6,64(s2)
 3f0:	0100                	addi	s0,sp,128
 3f2:	0105                	addi	sp,sp,1
 3f4:	04095b03          	lhu	s6,64(s2)
 3f8:	0100                	addi	s0,sp,128
 3fa:	0205                	addi	tp,tp,1
 3fc:	0306                	slli	t1,t1,0x1
 3fe:	0906                	slli	s2,s2,0x1
 400:	0004                	0x4
 402:	0501                	addi	a0,a0,0
 404:	09020303          	lb	t1,144(tp) # 1b090 <_Min_Stack_Size+0x1a890>
 408:	0000                	unimp
 40a:	0301                	addi	t1,t1,0
 40c:	090d                	addi	s2,s2,3
 40e:	0000                	unimp
 410:	0501                	addi	a0,a0,0
 412:	060c                	addi	a1,sp,768
 414:	00090003          	lb	zero,0(s2)
 418:	0100                	addi	s0,sp,128
 41a:	2105                	jal	83a <_Min_Stack_Size+0x3a>
 41c:	04090003          	lb	zero,64(s2)
 420:	0100                	addi	s0,sp,128
 422:	0305                	addi	t1,t1,1
 424:	04090003          	lb	zero,64(s2)
 428:	0100                	addi	s0,sp,128
 42a:	0405                	addi	s0,s0,1
 42c:	0306                	slli	t1,t1,0x1
 42e:	0902                	c.slli64	s2
 430:	0004                	0x4
 432:	0301                	addi	t1,t1,0
 434:	0901                	addi	s2,s2,0
 436:	0000                	unimp
 438:	0501                	addi	a0,a0,0
 43a:	0608                	addi	a0,sp,768
 43c:	00097f03          	0x97f03
 440:	0100                	addi	s0,sp,128
 442:	0405                	addi	s0,s0,1
 444:	04090103          	lb	sp,64(s2)
 448:	0100                	addi	s0,sp,128
 44a:	0505                	addi	a0,a0,1
 44c:	0306                	slli	t1,t1,0x1
 44e:	0902                	c.slli64	s2
 450:	0004                	0x4
 452:	0501                	addi	a0,a0,0
 454:	061a                	slli	a2,a2,0x6
 456:	00090003          	lb	zero,0(s2)
 45a:	0100                	addi	s0,sp,128
 45c:	0505                	addi	a0,a0,1
 45e:	0306                	slli	t1,t1,0x1
 460:	0901                	addi	s2,s2,0
 462:	0004                	0x4
 464:	0501                	addi	a0,a0,0
 466:	00030617          	auipc	a2,0x30
 46a:	0009                	c.nop	2
 46c:	0100                	addi	s0,sp,128
 46e:	0505                	addi	a0,a0,1
 470:	0306                	slli	t1,t1,0x1
 472:	0902                	c.slli64	s2
 474:	0004                	0x4
 476:	0501                	addi	a0,a0,0
 478:	00030617          	auipc	a2,0x30
 47c:	0009                	c.nop	2
 47e:	0100                	addi	s0,sp,128
 480:	0505                	addi	a0,a0,1
 482:	0306                	slli	t1,t1,0x1
 484:	0901                	addi	s2,s2,0
 486:	0004                	0x4
 488:	0501                	addi	a0,a0,0
 48a:	00030617          	auipc	a2,0x30
 48e:	0009                	c.nop	2
 490:	0100                	addi	s0,sp,128
 492:	0305                	addi	t1,t1,1
 494:	0306                	slli	t1,t1,0x1
 496:	0905                	addi	s2,s2,1
 498:	0004                	0x4
 49a:	0501                	addi	a0,a0,0
 49c:	0304                	addi	s1,sp,384
 49e:	0902                	c.slli64	s2
 4a0:	0008                	0x8
 4a2:	0501                	addi	a0,a0,0
 4a4:	0619                	addi	a2,a2,6
 4a6:	00090003          	lb	zero,0(s2)
 4aa:	0100                	addi	s0,sp,128
 4ac:	0405                	addi	s0,s0,1
 4ae:	0306                	slli	t1,t1,0x1
 4b0:	0901                	addi	s2,s2,0
 4b2:	0004                	0x4
 4b4:	0901                	addi	s2,s2,0
 4b6:	0004                	0x4
 4b8:	0100                	addi	s0,sp,128
 4ba:	0501                	addi	a0,a0,0
 4bc:	0001                	nop
 4be:	0205                	addi	tp,tp,1
 4c0:	02d4                	addi	a3,sp,324
 4c2:	0000                	unimp
 4c4:	05013b03          	0x5013b03
 4c8:	0002                	c.slli64	zero
 4ca:	0402                	c.slli64	s0
 4cc:	0301                	addi	t1,t1,0
 4ce:	0901                	addi	s2,s2,0
 4d0:	0000                	unimp
 4d2:	0001                	nop
 4d4:	0402                	c.slli64	s0
 4d6:	0301                	addi	t1,t1,0
 4d8:	0901                	addi	s2,s2,0
 4da:	0000                	unimp
 4dc:	0901                	addi	s2,s2,0
 4de:	0004                	0x4
 4e0:	0100                	addi	s0,sp,128
 4e2:	0501                	addi	a0,a0,0
 4e4:	0001                	nop
 4e6:	0205                	addi	tp,tp,1
 4e8:	02d8                	addi	a4,sp,324
 4ea:	0000                	unimp
 4ec:	0100c303          	lbu	t1,16(ra) # 240 <__do_global_dtors_aux+0x30>
 4f0:	0306                	slli	t1,t1,0x1
 4f2:	0902                	c.slli64	s2
 4f4:	0000                	unimp
 4f6:	0901                	addi	s2,s2,0
 4f8:	0004                	0x4
 4fa:	0100                	addi	s0,sp,128
 4fc:	7701                	lui	a4,0xfffe0
 4fe:	0001                	nop
 500:	0300                	addi	s0,sp,384
 502:	1d00                	addi	s0,sp,688
 504:	0000                	unimp
 506:	0100                	addi	s0,sp,128
 508:	fb01                	bnez	a4,418 <_sidata+0xac>
 50a:	0d0e                	slli	s10,s10,0x3
 50c:	0100                	addi	s0,sp,128
 50e:	0101                	addi	sp,sp,0
 510:	0001                	nop
 512:	0000                	unimp
 514:	0001                	nop
 516:	0100                	addi	s0,sp,128
 518:	6300                	flw	fs0,0(a4)
 51a:	7472                	flw	fs0,60(sp)
 51c:	2e30                	fld	fa2,88(a2)
 51e:	00000053          	fadd.s	ft0,ft0,ft0,rne
 522:	0000                	unimp
 524:	0500                	addi	s0,sp,640
 526:	0002                	c.slli64	zero
 528:	0000                	unimp
 52a:	0300                	addi	s0,sp,384
 52c:	0109                	addi	sp,sp,2
 52e:	04090503          	lb	a0,64(s2)
 532:	0100                	addi	s0,sp,128
 534:	04090403          	lb	s0,64(s2)
 538:	0100                	addi	s0,sp,128
 53a:	08090303          	lb	t1,128(s2)
 53e:	0100                	addi	s0,sp,128
 540:	08090103          	lb	sp,128(s2)
 544:	0100                	addi	s0,sp,128
 546:	04090103          	lb	sp,64(s2)
 54a:	0100                	addi	s0,sp,128
 54c:	04090203          	lb	tp,64(s2)
 550:	0100                	addi	s0,sp,128
 552:	08090103          	lb	sp,128(s2)
 556:	0100                	addi	s0,sp,128
 558:	04090303          	lb	t1,64(s2)
 55c:	0100                	addi	s0,sp,128
 55e:	08090103          	lb	sp,128(s2)
 562:	0100                	addi	s0,sp,128
 564:	08090103          	lb	sp,128(s2)
 568:	0100                	addi	s0,sp,128
 56a:	08090103          	lb	sp,128(s2)
 56e:	0100                	addi	s0,sp,128
 570:	04090203          	lb	tp,64(s2)
 574:	0100                	addi	s0,sp,128
 576:	04090103          	lb	sp,64(s2)
 57a:	0100                	addi	s0,sp,128
 57c:	04090103          	lb	sp,64(s2)
 580:	0100                	addi	s0,sp,128
 582:	04090103          	lb	sp,64(s2)
 586:	0100                	addi	s0,sp,128
 588:	04090103          	lb	sp,64(s2)
 58c:	0100                	addi	s0,sp,128
 58e:	04090303          	lb	t1,64(s2)
 592:	0100                	addi	s0,sp,128
 594:	08090103          	lb	sp,128(s2)
 598:	0100                	addi	s0,sp,128
 59a:	04090303          	lb	t1,64(s2)
 59e:	0100                	addi	s0,sp,128
 5a0:	04090103          	lb	sp,64(s2)
 5a4:	0100                	addi	s0,sp,128
 5a6:	04090103          	lb	sp,64(s2)
 5aa:	0100                	addi	s0,sp,128
 5ac:	04090103          	lb	sp,64(s2)
 5b0:	0100                	addi	s0,sp,128
 5b2:	04090103          	lb	sp,64(s2)
 5b6:	0100                	addi	s0,sp,128
 5b8:	04090103          	lb	sp,64(s2)
 5bc:	0100                	addi	s0,sp,128
 5be:	04090103          	lb	sp,64(s2)
 5c2:	0100                	addi	s0,sp,128
 5c4:	04090103          	lb	sp,64(s2)
 5c8:	0100                	addi	s0,sp,128
 5ca:	04090103          	lb	sp,64(s2)
 5ce:	0100                	addi	s0,sp,128
 5d0:	04090103          	lb	sp,64(s2)
 5d4:	0100                	addi	s0,sp,128
 5d6:	04090103          	lb	sp,64(s2)
 5da:	0100                	addi	s0,sp,128
 5dc:	04090103          	lb	sp,64(s2)
 5e0:	0100                	addi	s0,sp,128
 5e2:	04090103          	lb	sp,64(s2)
 5e6:	0100                	addi	s0,sp,128
 5e8:	04090103          	lb	sp,64(s2)
 5ec:	0100                	addi	s0,sp,128
 5ee:	04090103          	lb	sp,64(s2)
 5f2:	0100                	addi	s0,sp,128
 5f4:	04090103          	lb	sp,64(s2)
 5f8:	0100                	addi	s0,sp,128
 5fa:	04090103          	lb	sp,64(s2)
 5fe:	0100                	addi	s0,sp,128
 600:	04090103          	lb	sp,64(s2)
 604:	0100                	addi	s0,sp,128
 606:	08090103          	lb	sp,128(s2)
 60a:	0100                	addi	s0,sp,128
 60c:	04090103          	lb	sp,64(s2)
 610:	0100                	addi	s0,sp,128
 612:	04090103          	lb	sp,64(s2)
 616:	0100                	addi	s0,sp,128
 618:	04090103          	lb	sp,64(s2)
 61c:	0100                	addi	s0,sp,128
 61e:	04090103          	lb	sp,64(s2)
 622:	0100                	addi	s0,sp,128
 624:	04090103          	lb	sp,64(s2)
 628:	0100                	addi	s0,sp,128
 62a:	04090103          	lb	sp,64(s2)
 62e:	0100                	addi	s0,sp,128
 630:	04090103          	lb	sp,64(s2)
 634:	0100                	addi	s0,sp,128
 636:	04090103          	lb	sp,64(s2)
 63a:	0100                	addi	s0,sp,128
 63c:	04090103          	lb	sp,64(s2)
 640:	0100                	addi	s0,sp,128
 642:	04090103          	lb	sp,64(s2)
 646:	0100                	addi	s0,sp,128
 648:	04090103          	lb	sp,64(s2)
 64c:	0100                	addi	s0,sp,128
 64e:	04090103          	lb	sp,64(s2)
 652:	0100                	addi	s0,sp,128
 654:	04090103          	lb	sp,64(s2)
 658:	0100                	addi	s0,sp,128
 65a:	04090103          	lb	sp,64(s2)
 65e:	0100                	addi	s0,sp,128
 660:	04090103          	lb	sp,64(s2)
 664:	0100                	addi	s0,sp,128
 666:	04090103          	lb	sp,64(s2)
 66a:	0100                	addi	s0,sp,128
 66c:	04090103          	lb	sp,64(s2)
 670:	0100                	addi	s0,sp,128
 672:	0409                	addi	s0,s0,2
 674:	0000                	unimp
 676:	0101                	addi	sp,sp,0

Disassembly of section .debug_str:

00000000 <.debug_str>:
	j reset_vector
   0:	645f 6f73 685f      	0x685f6f73645f
    csrci mstatus, 8
   6:	6e61                	lui	t3,0x18
	la gp, __global_pointer$
   8:	6c64                	flw	fs1,92(s0)
   a:	0065                	c.nop	25
   c:	735f 7a69 0065      	0x657a69735f
	la sp, _fstack
  12:	725f 6e61 3464      	0x34646e61725f
	sw x0, 0(sp)
  18:	0038                	addi	a4,sp,8
  1a:	5f5f 7863 3178      	0x317878635f5f
	la t0, trap_vector
  20:	0031                	c.nop	12
  22:	735f 6769 006e      	0x6e6769735f
	csrw mtvec, t0
  28:	6d5f 7362 6174      	0x617473626d5f
	la a0, _sidata  /*from */
  2e:	6574                	flw	fa3,76(a0)
  30:	5f00                	lw	s0,56(a4)
  32:	755f 6e69 3874      	0x38746e69755f
	la a1, _sdata   /* to */
  38:	745f 6500 6178      	0x61786500745f
	la a2, _edata  /* end */
  3e:	706d                	c.lui	zero,0xffffb
  40:	656c                	flw	fa1,76(a0)
  42:	6146                	flw	ft2,80(sp)
	beq	a1,a2, DONE
  44:	65537473          	csrrci	s0,0x655,6
	lw	t0, (a0)
  48:	6972                	flw	fs2,28(sp)
  4a:	6c61                	lui	s8,0x18
	sw t0, (a1)
  4c:	69616d2f          	0x69616d2f
	addi a0,a0,4
  50:	2e6e                	fld	ft8,216(sp)
  52:	00707063          	bgeu	zero,t2,52 <LOOP+0x2>
	addi a1,a2,4
  56:	3031                	jal	fffff862 <_fstack+0xefffee42>
	bltu a1,a2, TOP
  58:	6d5f 7362 6174      	0x617473626d5f
	call _start
  5e:	6574                	flw	fa3,76(a0)
  60:	745f 5f00 6164      	0x61645f00745f
LOOP:	j LOOP
  66:	6174                	flw	fa3,68(a0)
	addi sp, sp, -16*4
  68:	5f00                	lw	s0,56(a4)
  6a:	74726377          	0x74726377
	sw ra,  0*4(sp)
  6e:	5f626d6f          	jal	s10,26664 <_Min_Stack_Size+0x25e64>
	sw t0,  1*4(sp)
  72:	74617473          	csrrci	s0,0x746,2
	sw t1,  2*4(sp)
  76:	0065                	c.nop	25
	sw t2,  3*4(sp)
  78:	735f 6769 616e      	0x616e6769735f
	sw a0,  4*4(sp)
  7e:	5f6c                	lw	a1,124(a4)
	sw a1,  5*4(sp)
  80:	7562                	flw	fa0,56(sp)
  82:	0066                	c.slli	zero,0x19
	sw a2,  6*4(sp)
  84:	6f6c                	flw	fa1,92(a4)
  86:	676e                	flw	fa4,216(sp)
	sw a3,  7*4(sp)
  88:	6c20                	flw	fs0,88(s0)
  8a:	20676e6f          	jal	t3,76290 <_Min_Stack_Size+0x75a90>
	sw a4,  8*4(sp)
  8e:	6e75                	lui	t3,0x1d
	sw a5,  9*4(sp)
  90:	6e676973          	csrrsi	s2,0x6e6,14
	sw a6, 10*4(sp)
  94:	6465                	lui	s0,0x19
  96:	6920                	flw	fs0,80(a0)
	sw a7, 11*4(sp)
  98:	746e                	flw	fs0,248(sp)
  9a:	5f00                	lw	s0,56(a4)
	sw t3, 12*4(sp)
  9c:	626c                	flw	fa1,68(a2)
  9e:	7366                	flw	ft6,120(sp)
	sw t4, 13*4(sp)
  a0:	7a69                	lui	s4,0xffffa
  a2:	0065                	c.nop	25
	sw t5, 14*4(sp)
  a4:	5f5f 6e69 3674      	0x36746e695f5f
	sw t6, 15*4(sp)
  aa:	5f34                	lw	a3,120(a4)
	call isr
  ac:	0074                	addi	a3,sp,12
  ae:	5f5f 6f6c 6163      	0x61636f6c5f5f
	lw ra,  0*4(sp)
  b4:	656c                	flw	fa1,76(a0)
  b6:	745f 5f00 695f      	0x695f5f00745f
	lw t1,  2*4(sp)
  bc:	746e                	flw	fs0,248(sp)
  be:	5f38                	lw	a4,120(a4)
	lw t2,  3*4(sp)
  c0:	0074                	addi	a3,sp,12
  c2:	6d5f 7262 6f74      	0x6f7472626d5f
	lw a1,  5*4(sp)
  c8:	735f6377          	0x735f6377
	lw a2,  6*4(sp)
  cc:	6174                	flw	fa3,68(a0)
  ce:	6574                	flw	fa3,76(a0)
	lw a3,  7*4(sp)
  d0:	5f00                	lw	s0,56(a4)
  d2:	695f 746e 6c5f      	0x6c5f746e695f
	lw a5,  9*4(sp)
  d8:	6165                	addi	sp,sp,112
  da:	34367473          	csrrci	s0,mtval,12
	lw a6, 10*4(sp)
  de:	745f 5f00 745f      	0x745f5f00745f
	lw t3, 12*4(sp)
  e4:	5f6d                	li	t5,-5
  e6:	00636573          	csrrsi	a0,0x6,6
	lw t4, 13*4(sp)
  ea:	6f6c                	flw	fa1,92(a4)
	lw t5, 14*4(sp)
  ec:	676e                	flw	fa4,216(sp)
  ee:	6c20                	flw	fs0,88(s0)
	lw t6, 15*4(sp)
  f0:	20676e6f          	jal	t3,762f6 <_Min_Stack_Size+0x75af6>
	addi sp, sp, 16*4
  f4:	6e69                	lui	t3,0x1a
  f6:	0074                	addi	a3,sp,12
	mret
  f8:	755f 7562 0066      	0x667562755f
  fe:	625f 7361 0065      	0x657361625f
 104:	6975                	lui	s2,0x1d
 106:	746e                	flw	fs0,248(sp)
 108:	665f 7361 3674      	0x36747361665f
 10e:	5f34                	lw	a3,120(a4)
 110:	0074                	addi	a3,sp,12
 112:	5f5f 6d74 685f      	0x685f6d745f5f
 118:	0072756f          	jal	a0,2791e <_Min_Stack_Size+0x2711e>
 11c:	5f5f 6673 5f00      	0x5f0066735f5f
 122:	655f6e6f          	jal	t3,f6f76 <_Min_Stack_Size+0xf6776>
 126:	6978                	flw	fa4,84(a0)
 128:	5f74                	lw	a3,124(a4)
 12a:	7261                	lui	tp,0xffff8
 12c:	5f007367          	0x5f007367
 130:	6b6f6f63          	bltu	t5,s6,7ee <_sidata+0x482>
 134:	6569                	lui	a0,0x1a
 136:	5f00                	lw	s0,56(a4)
 138:	735f 6c67 6575      	0x65756c67735f
 13e:	5f00                	lw	s0,56(a4)
 140:	6c66                	flw	fs8,88(sp)
 142:	6761                	lui	a4,0x18
 144:	695f0073          	0x695f0073
 148:	78635f73          	csrrwi	t5,0x786,6
 14c:	0061                	c.nop	24
 14e:	735f 6474 6e69      	0x6e696474735f
 154:	5f00                	lw	s0,56(a4)
 156:	6c62                	flw	fs8,24(sp)
 158:	7a69736b          	0x7a69736b
 15c:	0065                	c.nop	25
 15e:	635f 7476 7562      	0x75627476635f
 164:	0066                	c.slli	zero,0x19
 166:	6f5f 6666 6573      	0x657366666f5f
 16c:	0074                	addi	a3,sp,12
 16e:	6d5f 7362 7472      	0x747273626d5f
 174:	7363776f          	jal	a4,378aa <_Min_Stack_Size+0x370aa>
 178:	735f 6174 6574      	0x65746174735f
 17e:	5f00                	lw	s0,56(a4)
 180:	626d                	lui	tp,0x1b
 182:	6c72                	flw	fs8,28(sp)
 184:	6e65                	lui	t3,0x19
 186:	735f 6174 6574      	0x65746174735f
 18c:	5f00                	lw	s0,56(a4)
 18e:	6e66                	flw	ft8,88(sp)
 190:	7261                	lui	tp,0xffff8
 192:	5f007367          	0x5f007367
 196:	6e66                	flw	ft8,88(sp)
 198:	5f5f0073          	0x5f5f0073
 19c:	6975                	lui	s2,0x1d
 19e:	746e                	flw	fs0,248(sp)
 1a0:	745f3233          	0x745f3233
 1a4:	5f00                	lw	s0,56(a4)
 1a6:	695f 746e 7470      	0x7470746e695f
 1ac:	5f72                	lw	t5,60(sp)
 1ae:	0074                	addi	a3,sp,12
 1b0:	5f5f 6975 746e      	0x746e69755f5f
 1b6:	6c5f 6165 7473      	0x747361656c5f
 1bc:	5f38                	lw	a4,120(a4)
 1be:	0074                	addi	a3,sp,12
 1c0:	20554e47          	fmsub.s	ft8,fa0,ft5,ft4,rmm
 1c4:	312b2b43          	fmadd.s	fs6,fs6,fs2,ft6,rdn
 1c8:	2e382037          	lui	zero,0x2e382
 1cc:	20302e33          	0x20302e33
 1d0:	6d2d                	lui	s10,0xb
 1d2:	7261                	lui	tp,0xffff8
 1d4:	723d6863          	bltu	s10,gp,904 <_Min_Stack_Size+0x104>
 1d8:	3376                	fld	ft6,376(sp)
 1da:	6932                	flw	fs2,12(sp)
 1dc:	2d20                	fld	fs0,88(a0)
 1de:	616d                	addi	sp,sp,240
 1e0:	6962                	flw	fs2,24(sp)
 1e2:	693d                	lui	s2,0xf
 1e4:	706c                	flw	fa1,100(s0)
 1e6:	2d203233          	0x2d203233
 1ea:	62646767          	0x62646767
 1ee:	2d20                	fld	fs0,88(a0)
 1f0:	2d20734f          	0x2d20734f
 1f4:	3d647473          	csrrci	s0,0x3d6,8
 1f8:	322b2b63          	0x322b2b63
 1fc:	2061                	jal	284 <main+0x4>
 1fe:	662d                	lui	a2,0xb
 200:	6164                	flw	fs1,68(a0)
 202:	6174                	flw	fa3,68(a0)
 204:	732d                	lui	t1,0xfffeb
 206:	6365                	lui	t1,0x19
 208:	6974                	flw	fa3,84(a0)
 20a:	20736e6f          	jal	t3,36c10 <_Min_Stack_Size+0x36410>
 20e:	662d                	lui	a2,0xb
 210:	7566                	flw	fa0,120(sp)
 212:	636e                	flw	ft6,216(sp)
 214:	6974                	flw	fa3,84(a0)
 216:	732d6e6f          	jal	t3,d6948 <_Min_Stack_Size+0xd6148>
 21a:	6365                	lui	t1,0x19
 21c:	6974                	flw	fa3,84(a0)
 21e:	20736e6f          	jal	t3,36c24 <_Min_Stack_Size+0x36424>
 222:	662d                	lui	a2,0xb
 224:	6f6e                	flw	ft10,216(sp)
 226:	652d                	lui	a0,0xb
 228:	6378                	flw	fa4,68(a4)
 22a:	7065                	c.lui	zero,0xffff9
 22c:	6974                	flw	fa3,84(a0)
 22e:	20736e6f          	jal	t3,36c34 <_Min_Stack_Size+0x36434>
 232:	662d                	lui	a2,0xb
 234:	6f6e                	flw	ft10,216(sp)
 236:	722d                	lui	tp,0xfffeb
 238:	7474                	flw	fa3,108(s0)
 23a:	0069                	c.nop	26
 23c:	5f5f 6e69 3174      	0x31746e695f5f
 242:	5f36                	lw	t5,108(sp)
 244:	0074                	addi	a3,sp,12
 246:	735f 6474 7265      	0x72656474735f
 24c:	0072                	c.slli	zero,0x1c
 24e:	425f 6769 6e69      	0x6e696769425f
 254:	0074                	addi	a3,sp,12
 256:	675f 6d61 616d      	0x616d6d61675f
 25c:	735f 6769 676e      	0x676e6769735f
 262:	6d61                	lui	s10,0x18
 264:	5f00                	lw	s0,56(a4)
 266:	6572                	flw	fa0,28(sp)
 268:	6461                	lui	s0,0x18
 26a:	5f00                	lw	s0,56(a4)
 26c:	6572                	flw	fa0,28(sp)
 26e:	746c7573          	csrrci	a0,0x746,24
 272:	6b5f 5f00 695f      	0x695f5f006b5f
 278:	746e                	flw	fs0,248(sp)
 27a:	6c5f 6165 7473      	0x747361656c5f
{
 280:	3631                	jal	fffffd8c <_fstack+0xeffff36c>
 282:	745f 5f00 745f      	0x745f5f00745f
			if (val == '0')
 288:	006d                	c.nop	27
 28a:	5f5f 6975 746e      	0x746e69755f5f
				GPIO_SET_TOGGLE_REG  = LED_0;
 290:	6c5f 6165 7473      	0x747361656c5f
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 296:	745f3233          	0x745f3233
			GPIO_SET_TOGGLE_REG  = LED_7;
 29a:	5f00                	lw	s0,56(a4)
{
 29c:	775f 6863 0062      	0x626863775f
		if( (val = FASTSERIAL_RX_REG) & FASTSERIAL_STATUS_RX_READY)
 2a2:	775f 7363 7472      	0x74727363775f
 2a8:	73626d6f          	jal	s10,269de <_Min_Stack_Size+0x261de>
			val &= 0xFF;
 2ac:	735f 6174 6574      	0x65746174735f
			if (val == '0')
 2b2:	5f00                	lw	s0,56(a4)
				GPIO_SET_TOGGLE_REG  = LED_0;
 2b4:	6f647473          	csrrci	s0,0x6f6,8
				FASTSERIAL_TX_REG = (uint32_t)val & 0xFF;
 2b8:	7475                	lui	s0,0xffffd
 2ba:	5f00                	lw	s0,56(a4)
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2bc:	6c747663          	bgeu	s0,t2,988 <_Min_Stack_Size+0x188>
				FASTSERIAL_TX_REG = ((uint32_t)val & 0xFF) + 1;
 2c0:	6e65                	lui	t3,0x19
 2c2:	5f00                	lw	s0,56(a4)
		if (led7Delay++ == SLOW_DELAY)
 2c4:	6966                	flw	fs2,88(sp)
 2c6:	656c                	flw	fa1,76(a0)
 2c8:	5f00                	lw	s0,56(a4)
 2ca:	696e                	flw	fs2,216(sp)
			GPIO_SET_TOGGLE_REG  = LED_7;
 2cc:	0073626f          	jal	tp,36ad2 <_Min_Stack_Size+0x362d2>
			led7Delay = 0;
 2d0:	735f 6769 665f      	0x665f6769735f
	for( ;; );
 2d6:	6e75                	lui	t3,0x1d
}
 2d8:	68730063          	beq	t1,t2,958 <_Min_Stack_Size+0x158>
 2dc:	2074726f          	jal	tp,47ce2 <_Min_Stack_Size+0x474e2>
 2e0:	6e75                	lui	t3,0x1d
 2e2:	6e676973          	csrrsi	s2,0x6e6,14
 2e6:	6465                	lui	s0,0x19
 2e8:	6920                	flw	fs0,80(a0)
 2ea:	746e                	flw	fs0,248(sp)
 2ec:	5f00                	lw	s0,56(a4)
 2ee:	65756c67          	0x65756c67
 2f2:	5f00                	lw	s0,56(a4)
 2f4:	7461                	lui	s0,0xffff8
 2f6:	7865                	lui	a6,0xffff9
 2f8:	7469                	lui	s0,0xffffa
 2fa:	0030                	addi	a2,sp,8
 2fc:	5f5f 6e69 6d74      	0x6d746e695f5f
 302:	7861                	lui	a6,0xffff8
 304:	745f 5f00 7361      	0x73615f00745f
 30a:	6d697463          	bgeu	s2,s6,9d2 <_Min_Stack_Size+0x1d2>
 30e:	5f65                	li	t5,-7
 310:	7562                	flw	fa0,56(sp)
 312:	0066                	c.slli	zero,0x19
 314:	64656d2f          	0x64656d2f
 318:	6169                	addi	sp,sp,208
 31a:	6d63742f          	0x6d63742f
 31e:	6369                	lui	t1,0x1a
 320:	6168                	flw	fa0,68(a0)
 322:	736c                	flw	fa1,100(a4)
 324:	726f572f          	0x726f572f
 328:	676e696b          	0x676e696b
 32c:	6379632f          	0x6379632f
 330:	6f6c                	flw	fa1,92(a4)
 332:	656e                	flw	fa0,216(sp)
 334:	312d                	jal	ffffff5e <_fstack+0xeffff53e>
 336:	2f30                	fld	fa2,88(a4)
 338:	31637963          	bgeu	t1,s6,64a <_sidata+0x2de>
 33c:	3030                	fld	fa2,96(s0)
 33e:	2f30                	fld	fa2,88(a4)
 340:	7566                	flw	fa0,120(sp)
 342:	6f736573          	csrrsi	a0,0x6f7,6
 346:	72702e63          	0x72702e63
 34a:	63656a6f          	jal	s4,56980 <_Min_Stack_Size+0x56180>
 34e:	7374                	flw	fa3,100(a4)
 350:	726f632f          	0x726f632f
 354:	7365                	lui	t1,0xffff9
 356:	6175712f          	0x6175712f
 35a:	2d64                	fld	fs1,216(a0)
 35c:	76726573          	csrrsi	a0,0x767,4
 360:	0077732f          	0x77732f
 364:	725f 7365 6c75      	0x6c757365725f
 36a:	0074                	addi	a3,sp,12
 36c:	5f5f 6377 0068      	0x6863775f5f
 372:	4c5f 434f 5f4b      	0x5f4b434f4c5f
 378:	0054                	addi	a3,sp,4
 37a:	746e6977          	0x746e6977
 37e:	745f 5f00 6c66      	0x6c665f00745f
 384:	6761                	lui	a4,0x18
 386:	64003273          	csrrc	tp,0x640,zero
 38a:	6365                	lui	t1,0x19
 38c:	746c                	flw	fa1,108(s0)
 38e:	7079                	c.lui	zero,0xffffe
 390:	2865                	jal	448 <_sidata+0xdc>
 392:	756e                	flw	fa0,248(sp)
 394:	6c6c                	flw	fa1,92(s0)
 396:	7470                	flw	fa2,108(s0)
 398:	2972                	fld	fs2,280(sp)
 39a:	5f00                	lw	s0,56(a4)
 39c:	74697277          	0x74697277
 3a0:	0065                	c.nop	25
 3a2:	5f5f 6d74 795f      	0x795f6d745f5f
 3a8:	6165                	addi	sp,sp,112
 3aa:	0072                	c.slli	zero,0x1c
 3ac:	6e5f 616d 6c6c      	0x6c6c616d6e5f
 3b2:	6c00636f          	jal	t1,6a72 <_Min_Stack_Size+0x6272>
 3b6:	20676e6f          	jal	t3,765bc <_Min_Stack_Size+0x75dbc>
 3ba:	6f64                	flw	fs1,92(a4)
 3bc:	6275                	lui	tp,0x1d
 3be:	656c                	flw	fa1,76(a0)
 3c0:	5f00                	lw	s0,56(a4)
 3c2:	656e                	flw	fa0,216(sp)
 3c4:	7478                	flw	fa4,108(s0)
 3c6:	0066                	c.slli	zero,0x19
 3c8:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 3ce:	5f006e6f          	jal	t3,69be <_Min_Stack_Size+0x61be>
 3d2:	7461                	lui	s0,0xffff8
 3d4:	7865                	lui	a6,0xffff9
 3d6:	7469                	lui	s0,0xffffa
 3d8:	5f00                	lw	s0,56(a4)
 3da:	735f 6964 6964      	0x69646964735f
 3e0:	696e                	flw	fs2,216(sp)
 3e2:	0074                	addi	a3,sp,12
 3e4:	6f5f 6666 745f      	0x745f66666f5f
 3ea:	5f00                	lw	s0,56(a4)
 3ec:	755f 6e69 3674      	0x36746e69755f
 3f2:	5f34                	lw	a3,120(a4)
 3f4:	0074                	addi	a3,sp,12
 3f6:	665f 6572 6c65      	0x6c656572665f
 3fc:	7369                	lui	t1,0xffffa
 3fe:	0074                	addi	a3,sp,12
 400:	6975                	lui	s2,0x1d
 402:	746e                	flw	fs0,248(sp)
 404:	665f 7361 3174      	0x31747361665f
 40a:	5f36                	lw	t5,108(sp)
 40c:	0074                	addi	a3,sp,12
 40e:	775f 7463 6d6f      	0x6d6f7463775f
 414:	5f62                	lw	t5,56(sp)
 416:	74617473          	csrrci	s0,0x746,2
 41a:	0065                	c.nop	25
 41c:	6975                	lui	s2,0x1d
 41e:	746e                	flw	fs0,248(sp)
 420:	665f 7361 3374      	0x33747361665f
 426:	5f32                	lw	t5,44(sp)
 428:	0074                	addi	a3,sp,12
 42a:	5f5f 6975 746e      	0x746e69755f5f
 430:	6c5f 6165 7473      	0x747361656c5f
 436:	3436                	fld	fs0,360(sp)
 438:	745f 7500 736e      	0x736e7500745f
 43e:	6769                	lui	a4,0x1a
 440:	656e                	flw	fa0,216(sp)
 442:	2064                	fld	fs1,192(s0)
 444:	72616863          	bltu	sp,t1,b74 <_Min_Stack_Size+0x374>
 448:	5f00                	lw	s0,56(a4)
 44a:	656e                	flw	fa0,216(sp)
 44c:	685f0077          	0x685f0077
 450:	655f 7272 6f6e      	0x6f6e7272655f
 456:	7300                	flw	fs0,32(a4)
 458:	6f68                	flw	fa0,92(a4)
 45a:	7472                	flw	fs0,60(sp)
 45c:	6920                	flw	fs0,80(a0)
 45e:	746e                	flw	fs0,248(sp)
 460:	5f00                	lw	s0,56(a4)
 462:	745f 5f6d 6479      	0x64795f6d745f
 468:	7961                	lui	s2,0xffff8
 46a:	5f00                	lw	s0,56(a4)
 46c:	735f 7562 0066      	0x667562735f
 472:	695f 626f 0073      	0x73626f695f
 478:	5f5f 4946 454c      	0x454c49465f5f
 47e:	5f00                	lw	s0,56(a4)
 480:	735f 4946 454c      	0x454c4946735f
 486:	7500                	flw	fs0,40(a0)
 488:	6e69                	lui	t3,0x1a
 48a:	5f74                	lw	a3,124(a4)
 48c:	6166                	flw	ft2,88(sp)
 48e:	5f387473          	csrrci	s0,0x5f3,16
 492:	0074                	addi	a3,sp,12
 494:	5f5f 6975 746e      	0x746e69755f5f
 49a:	7470                	flw	fa2,108(s0)
 49c:	5f72                	lw	t5,60(sp)
 49e:	0074                	addi	a3,sp,12
 4a0:	725f 6e61 5f64      	0x5f646e61725f
 4a6:	656e                	flw	fa0,216(sp)
 4a8:	7478                	flw	fa4,108(s0)
 4aa:	5f00                	lw	s0,56(a4)
 4ac:	626d                	lui	tp,0x1b
 4ae:	656c                	flw	fa1,76(a0)
 4b0:	5f6e                	lw	t5,248(sp)
 4b2:	74617473          	csrrci	s0,0x746,2
 4b6:	0065                	c.nop	25
 4b8:	695f 636e 5f00      	0x5f00636e695f
 4be:	6e69                	lui	t3,0x1a
 4c0:	0064                	addi	s1,sp,12
 4c2:	6c5f 636f 6c61      	0x6c61636f6c5f
 4c8:	0065                	c.nop	25
 4ca:	5f5f 6c63 6165      	0x61656c635f5f
 4d0:	756e                	flw	fa0,248(sp)
 4d2:	0070                	addi	a2,sp,12
 4d4:	755f 736e 6570      	0x6570736e755f
 4da:	69666963          	bltu	a2,s6,b6c <_Min_Stack_Size+0x36c>
 4de:	6465                	lui	s0,0x19
 4e0:	6c5f 636f 6c61      	0x6c61636f6c5f
 4e6:	5f65                	li	t5,-7
 4e8:	6e69                	lui	t3,0x1a
 4ea:	6f66                	flw	ft10,88(sp)
 4ec:	5f00                	lw	s0,56(a4)
 4ee:	616d                	addi	sp,sp,240
 4f0:	7778                	flw	fa4,108(a4)
 4f2:	7364                	flw	fs1,100(a4)
 4f4:	5f00                	lw	s0,56(a4)
 4f6:	6572                	flw	fa0,28(sp)
 4f8:	6e65                	lui	t3,0x19
 4fa:	0074                	addi	a3,sp,12
 4fc:	735f 6565 0064      	0x646565735f
 502:	5f5f 6f63 6e75      	0x6e756f635f5f
 508:	0074                	addi	a3,sp,12
 50a:	5f5f 6f6c 6b63      	0x6b636f6c5f5f
 510:	5f00                	lw	s0,56(a4)
 512:	765f 6c61 6575      	0x65756c61765f
 518:	5f00                	lw	s0,56(a4)
 51a:	6b656573          	csrrsi	a0,0x6b6,10
 51e:	5f00                	lw	s0,56(a4)
 520:	7066                	flw	ft0,120(sp)
 522:	745f736f          	jal	t1,f8466 <_Min_Stack_Size+0xf7c66>
 526:	5f00                	lw	s0,56(a4)
 528:	745f 5f6d 696d      	0x696d5f6d745f
 52e:	006e                	c.slli	zero,0x1b
 530:	5f5f 6975 746e      	0x746e69755f5f
 536:	3631                	jal	42 <TOP+0xa>
 538:	745f 5f00 695f      	0x695f5f00745f
 53e:	746e                	flw	fs0,248(sp)
 540:	745f3233          	0x745f3233
 544:	5f00                	lw	s0,56(a4)
 546:	6d65                	lui	s10,0x19
 548:	7265                	lui	tp,0xffff9
 54a:	636e6567          	0x636e6567
 54e:	0079                	c.nop	30
 550:	6d5f 6c75 0074      	0x746c756d5f
 556:	5f5f 6975 746e      	0x746e69755f5f
 55c:	616d                	addi	sp,sp,240
 55e:	5f78                	lw	a4,124(a4)
 560:	0074                	addi	a3,sp,12
 562:	735f 7274 6f74      	0x6f747274735f
 568:	616c5f6b          	0x616c5f6b
 56c:	6c007473          	csrrci	s0,0x6c0,0
 570:	6465                	lui	s0,0x19
 572:	6c654437          	lui	s0,0x6c654
 576:	7961                	lui	s2,0xffff8
 578:	5f00                	lw	s0,56(a4)
 57a:	695f 746e 6c5f      	0x6c5f746e695f
 580:	6165                	addi	sp,sp,112
 582:	32337473          	csrrci	s0,mhpmevent3,6
 586:	745f 5f00 6e66      	0x6e665f00745f
 58c:	7974                	flw	fa3,116(a0)
 58e:	6570                	flw	fa2,76(a0)
 590:	5f5f0073          	0x5f5f0073
 594:	6975                	lui	s2,0x1d
 596:	746e                	flw	fs0,248(sp)
 598:	6c5f 6165 7473      	0x747361656c5f
 59e:	3631                	jal	aa <trap_vector+0x56>
 5a0:	745f 5f00 6461      	0x64615f00745f
 5a6:	0064                	addi	s1,sp,12
 5a8:	5f5f 4c55 6e6f      	0x6e6f4c555f5f
 5ae:	675f0067          	jr	1653(t5) # 1675 <_Min_Stack_Size+0xe75>
 5b2:	7465                	lui	s0,0xffff9
 5b4:	6164                	flw	fs1,68(a0)
 5b6:	6574                	flw	fa3,76(a0)
 5b8:	655f 7272 5f00      	0x5f007272655f
 5be:	626f6c67          	0x626f6c67
 5c2:	6c61                	lui	s8,0x18
 5c4:	695f 706d 7275      	0x7275706d695f
 5ca:	5f65                	li	t5,-7
 5cc:	7470                	flw	fa2,108(s0)
 5ce:	0072                	c.slli	zero,0x1c
 5d0:	7261                	lui	tp,0xffff8
 5d2:	5f007667          	0x5f007667
 5d6:	6e75                	lui	t3,0x1d
 5d8:	7375                	lui	t1,0xffffd
 5da:	6465                	lui	s0,0x19
 5dc:	725f 6e61 0064      	0x646e61725f
 5e2:	775f 7364 5f00      	0x5f007364775f
 5e8:	745f 5f6d 6477      	0x64775f6d745f
 5ee:	7961                	lui	s2,0xffff8
 5f0:	5f00                	lw	s0,56(a4)
 5f2:	695f 746e 6c5f      	0x6c5f746e695f
 5f8:	6165                	addi	sp,sp,112
 5fa:	5f387473          	csrrci	s0,0x5f3,16
 5fe:	0074                	addi	a3,sp,12
 600:	735f 6973 657a      	0x657a6973735f
 606:	745f 5f00 366c      	0x366c5f00745f
 60c:	6134                	flw	fa3,64(a0)
 60e:	625f 6675 5f00      	0x5f006675625f
 614:	626d                	lui	tp,0x1b
 616:	6f74                	flw	fa3,92(a4)
 618:	735f6377          	0x735f6377
 61c:	6174                	flw	fa3,68(a0)
 61e:	6574                	flw	fa3,76(a0)
 620:	5f00                	lw	s0,56(a4)
 622:	6c66                	flw	fs8,88(sp)
 624:	5f6b636f          	jal	t1,b6c1a <_Min_Stack_Size+0xb641a>
 628:	0074                	addi	a3,sp,12
 62a:	6e5f 7562 0066      	0x6675626e5f
 630:	755f 756e 6573      	0x6573756e755f
 636:	0064                	addi	s1,sp,12
 638:	7261                	lui	tp,0xffff8
 63a:	5f006367          	0x5f006367
 63e:	745f 5f6d 7369      	0x73695f6d745f
 644:	7364                	flw	fs1,100(a4)
 646:	0074                	addi	a3,sp,12
 648:	6c5f 636f 6c61      	0x6c61636f6c5f
 64e:	6974                	flw	fa3,84(a0)
 650:	656d                	lui	a0,0x1b
 652:	625f 6675 5f00      	0x5f006675625f
 658:	736f6c63          	bltu	t5,s6,d90 <_Min_Stack_Size+0x590>
 65c:	0065                	c.nop	25
 65e:	725f 3834 5f00      	0x5f003834725f
 664:	3570                	fld	fa2,232(a0)
 666:	616d0073          	0x616d0073
 66a:	6e69                	lui	t3,0x1a
 66c:	5f00                	lw	s0,56(a4)
 66e:	745f 5f6d 646d      	0x646d5f6d745f
 674:	7961                	lui	s2,0xffff8
 676:	5f00                	lw	s0,56(a4)
 678:	675f 756e 635f      	0x635f756e675f
 67e:	7878                	flw	fa4,116(s0)
 680:	6300                	flw	fs0,0(a4)
 682:	7472                	flw	fs0,60(sp)
 684:	2e30                	fld	fa2,88(a2)
 686:	4e470053          	0x4e470053
 68a:	2055                	jal	72e <_sidata+0x3c2>
 68c:	5341                	li	t1,-16
 68e:	3220                	fld	fs0,96(a2)
 690:	332e                	fld	ft6,232(sp)
 692:	0032                	c.slli	zero,0xc

Disassembly of section .comment:

00000000 <.comment>:
	j reset_vector
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
    csrci mstatus, 8
   4:	2820                	fld	fs0,80(s0)
   6:	5078                	lw	a4,100(s0)
	la gp, __global_pointer$
   8:	6361                	lui	t1,0x18
   a:	4e47206b          	0x4e47206b
   e:	2055                	jal	b2 <trap_vector+0x5e>
	la sp, _fstack
  10:	4952                	lw	s2,20(sp)
  12:	562d4353          	0x562d4353
  16:	4520                	lw	s0,72(a0)
	sw x0, 0(sp)
  18:	626d                	lui	tp,0x1b
  1a:	6465                	lui	s0,0x19
	sw x0, 4(sp)
  1c:	6564                	flw	fs1,76(a0)
  1e:	2064                	fld	fs1,192(s0)
	la t0, trap_vector
  20:	2c434347          	0x2c434347
  24:	3620                	fld	fs0,104(a2)
  26:	2d34                	fld	fa3,88(a0)
	csrw mtvec, t0
  28:	6962                	flw	fs2,24(sp)
  2a:	2974                	fld	fa3,208(a0)
	la a0, _sidata  /*from */
  2c:	3820                	fld	fs0,112(s0)
  2e:	332e                	fld	ft6,232(sp)
  30:	302e                	fld	ft0,232(sp)
	...

Disassembly of section .debug_frame:

00000000 <.debug_frame>:
	j reset_vector
   0:	000c                	0xc
   2:	0000                	unimp
    csrci mstatus, 8
   4:	ffff                	0xffff
   6:	ffff                	0xffff
	la gp, __global_pointer$
   8:	0001                	nop
   a:	7c01                	lui	s8,0xfffe0
   c:	0d01                	addi	s10,s10,0
   e:	0002                	c.slli64	zero
	la sp, _fstack
  10:	000c                	0xc
  12:	0000                	unimp
  14:	0000                	unimp
  16:	0000                	unimp
	sw x0, 0(sp)
  18:	0280                	addi	s0,sp,320
  1a:	0000                	unimp
	sw x0, 4(sp)
  1c:	0054                	addi	a3,sp,4
  1e:	0000                	unimp
	la t0, trap_vector
  20:	000c                	0xc
  22:	0000                	unimp
  24:	0000                	unimp
  26:	0000                	unimp
	csrw mtvec, t0
  28:	02d4                	addi	a3,sp,324
  2a:	0000                	unimp
	la a0, _sidata  /*from */
  2c:	0004                	0x4
  2e:	0000                	unimp
  30:	000c                	0xc
  32:	0000                	unimp
	la a1, _sdata   /* to */
  34:	0000                	unimp
  36:	0000                	unimp
  38:	02d8                	addi	a4,sp,324
  3a:	0000                	unimp
	la a2, _edata  /* end */
  3c:	0004                	0x4
  3e:	0000                	unimp
  40:	000c                	0xc
  42:	0000                	unimp
	beq	a1,a2, DONE
  44:	ffff                	0xffff
  46:	ffff                	0xffff
	lw	t0, (a0)
  48:	0001                	nop
  4a:	7c01                	lui	s8,0xfffe0
	sw t0, (a1)
  4c:	0d01                	addi	s10,s10,0
  4e:	0002                	c.slli64	zero
	addi a0,a0,4
  50:	0028                	addi	a0,sp,8
  52:	0000                	unimp
	addi a1,a2,4
  54:	0040                	addi	s0,sp,4
  56:	0000                	unimp
	bltu a1,a2, TOP
  58:	02dc                	addi	a5,sp,324
  5a:	0000                	unimp
	call _start
  5c:	0084                	addi	s1,sp,64
  5e:	0000                	unimp
  60:	0e44                	addi	s1,sp,788
  62:	4810                	lw	a2,16(s0)
LOOP:	j LOOP
  64:	0288                	addi	a0,sp,320
  66:	0492                	slli	s1,s1,0x4
	addi sp, sp, -16*4
  68:	8154                	0x8154
  6a:	8901                	andi	a0,a0,0
	sw ra,  0*4(sp)
  6c:	c1500203          	lb	tp,-1003(zero) # fffffc15 <_fstack+0xeffff1f5>
	sw t0,  1*4(sp)
  70:	c844                	sw	s1,20(s0)
  72:	c944                	sw	s1,20(a0)
	sw t1,  2*4(sp)
  74:	d244                	sw	s1,36(a2)
  76:	0e44                	addi	s1,sp,788
	sw t2,  3*4(sp)
  78:	0000                	unimp
	...


./bin/exampleLED.elf:     file format elf32-littleriscv


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
  24:	34000513          	li	a0,832
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
  98:	214000ef          	jal	ra,2ac <isr>
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
 11c:	194000ef          	jal	ra,2b0 <__libc_init_array>
 120:	00012503          	lw	a0,0(sp)
 124:	00410593          	addi	a1,sp,4
 128:	00000613          	li	a2,0
 12c:	154000ef          	jal	ra,280 <main>
 130:	1780006f          	j	2a8 <exit>

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
 228:	33400513          	li	a0,820
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
 270:	33400513          	li	a0,820
 274:	00000317          	auipc	t1,0x0
 278:	00000067          	jr	zero # 0 <_start_reset_vector>
 27c:	00008067          	ret

00000280 <main>:
int main(int argc, char **argv)
{
	UNUSED(argc);
	UNUSED(argv);

	GPIO_SET_TOGGLE_REG  = LED_0;
 280:	00100713          	li	a4,1
 284:	910007b7          	lui	a5,0x91000
 288:	00e7a623          	sw	a4,12(a5) # 9100000c <_fstack+0x80fff5ec>
	while(true)
	{
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
			GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	00100693          	li	a3,1
 290:	91000737          	lui	a4,0x91000
{
 294:	000207b7          	lui	a5,0x20
 298:	fff78793          	addi	a5,a5,-1 # 1ffff <_Min_Stack_Size+0x1f7ff>
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
 29c:	fe079ee3          	bnez	a5,298 <main+0x18>
			GPIO_SET_TOGGLE_REG  = LED_0;
 2a0:	00d72623          	sw	a3,12(a4) # 9100000c <_fstack+0x80fff5ec>
	}
 2a4:	ff1ff06f          	j	294 <main+0x14>

000002a8 <exit>:

extern "C"
 [[ noreturn ]] void exit( int rc)
{
	UNUSED(rc);
	for( ;; );
 2a8:	0000006f          	j	2a8 <exit>

000002ac <isr>:

extern "C"
void isr(void)
{

}
 2ac:	00008067          	ret

000002b0 <__libc_init_array>:
 2b0:	ff010113          	addi	sp,sp,-16
 2b4:	00812423          	sw	s0,8(sp)
 2b8:	01212023          	sw	s2,0(sp)
 2bc:	33800413          	li	s0,824
 2c0:	33800913          	li	s2,824
 2c4:	40890933          	sub	s2,s2,s0
 2c8:	00112623          	sw	ra,12(sp)
 2cc:	00912223          	sw	s1,4(sp)
 2d0:	40295913          	srai	s2,s2,0x2
 2d4:	00090e63          	beqz	s2,2f0 <__libc_init_array+0x40>
 2d8:	00000493          	li	s1,0
 2dc:	00042783          	lw	a5,0(s0)
 2e0:	00148493          	addi	s1,s1,1
 2e4:	00440413          	addi	s0,s0,4
 2e8:	000780e7          	jalr	a5
 2ec:	fe9918e3          	bne	s2,s1,2dc <__libc_init_array+0x2c>
 2f0:	33800413          	li	s0,824
 2f4:	33c00913          	li	s2,828
 2f8:	40890933          	sub	s2,s2,s0
 2fc:	40295913          	srai	s2,s2,0x2
 300:	00090e63          	beqz	s2,31c <__libc_init_array+0x6c>
 304:	00000493          	li	s1,0
 308:	00042783          	lw	a5,0(s0)
 30c:	00148493          	addi	s1,s1,1
 310:	00440413          	addi	s0,s0,4
 314:	000780e7          	jalr	a5
 318:	fe9918e3          	bne	s2,s1,308 <__libc_init_array+0x58>
 31c:	00c12083          	lw	ra,12(sp)
 320:	00812403          	lw	s0,8(sp)
 324:	00412483          	lw	s1,4(sp)
 328:	00012903          	lw	s2,0(sp)
 32c:	01010113          	addi	sp,sp,16
 330:	00008067          	ret

00000334 <__EH_FRAME_BEGIN__>:
 334:	0000                	unimp
	...

Disassembly of section .init_array:

00000338 <__frame_dummy_init_array_entry>:
 338:	025c                	addi	a5,sp,260
	...

Disassembly of section .fini_array:

0000033c <__do_global_dtors_aux_fini_array_entry>:
 33c:	0210                	addi	a2,sp,256
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
   0:	0d11                	addi	s10,s10,4
   2:	0000                	unimp
    csrci mstatus, 8
   4:	0004                	0x4
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	0000                	unimp
   a:	0104                	addi	s1,sp,128
   c:	000001af          	0x1af
	la sp, _fstack
  10:	6204                	flw	fs1,0(a2)
  12:	0006                	c.slli	zero,0x1
  14:	0300                	addi	s0,sp,384
  16:	00000003          	lb	zero,0(zero) # 0 <_start_reset_vector>
	...
	la t0, trap_vector
  22:	0000                	unimp
  24:	0200                	addi	s0,sp,256
  26:	009e                	slli	ra,ra,0x7
	csrw mtvec, t0
  28:	0000                	unimp
  2a:	2902                	fld	fs2,0(sp)
	la a0, _sidata  /*from */
  2c:	00003117          	auipc	sp,0x3
  30:	0300                	addi	s0,sp,384
  32:	0601                	addi	a2,a2,0
	la a1, _sdata   /* to */
  34:	042c                	addi	a1,sp,520
  36:	0000                	unimp
  38:	3102                	fld	ft2,32(sp)
  3a:	0000                	unimp
	la a2, _edata  /* end */
  3c:	0200                	addi	s0,sp,256
  3e:	0044182b          	0x44182b
  42:	0000                	unimp
	beq	a1,a2, DONE
  44:	2a080103          	lb	sp,672(a6)
	lw	t0, (a0)
  48:	0004                	0x4
  4a:	0200                	addi	s0,sp,256
	sw t0, (a1)
  4c:	0000022b          	0x22b
	addi a0,a0,4
  50:	3702                	fld	fa4,32(sp)
  52:	5718                	lw	a4,40(a4)
	addi a1,a2,4
  54:	0000                	unimp
  56:	0300                	addi	s0,sp,384
	bltu a1,a2, TOP
  58:	0502                	c.slli64	a0
  5a:	044c                	addi	a1,sp,516
	call _start
  5c:	0000                	unimp
  5e:	2502                	fld	fa0,0(sp)
  60:	0005                	c.nop	1
  62:	0200                	addi	s0,sp,256
LOOP:	j LOOP
  64:	1939                	addi	s2,s2,-18
  66:	006a                	c.slli	zero,0x1a
	addi sp, sp, -16*4
  68:	0000                	unimp
  6a:	c9070203          	lb	tp,-880(a4)
	sw ra,  0*4(sp)
  6e:	0002                	c.slli64	zero
	sw t0,  1*4(sp)
  70:	0200                	addi	s0,sp,256
  72:	0530                	addi	a2,sp,648
	sw t1,  2*4(sp)
  74:	0000                	unimp
  76:	4d02                	lw	s10,0(sp)
	sw t2,  3*4(sp)
  78:	7d18                	flw	fa4,56(a0)
  7a:	0000                	unimp
	sw a0,  4*4(sp)
  7c:	0300                	addi	s0,sp,384
  7e:	0504                	addi	s1,sp,640
	sw a1,  5*4(sp)
  80:	00d4                	addi	a3,sp,68
  82:	0000                	unimp
	sw a2,  6*4(sp)
  84:	8902                	jr	s2
  86:	0001                	nop
	sw a3,  7*4(sp)
  88:	0200                	addi	s0,sp,256
  8a:	0090194f          	fnmadd.s	fs2,ft0,fs1,ft0,rtz
	sw a4,  8*4(sp)
  8e:	0000                	unimp
	sw a5,  9*4(sp)
  90:	6e070403          	lb	s0,1760(a4)
	sw a6, 10*4(sp)
  94:	0000                	unimp
  96:	0200                	addi	s0,sp,256
	sw a7, 11*4(sp)
  98:	0089                	addi	ra,ra,2
  9a:	0000                	unimp
	sw t3, 12*4(sp)
  9c:	6702                	flw	fa4,0(sp)
  9e:	a318                	fsd	fa4,0(a4)
	sw t4, 13*4(sp)
  a0:	0000                	unimp
  a2:	0300                	addi	s0,sp,384
	sw t5, 14*4(sp)
  a4:	0508                	addi	a0,sp,640
  a6:	000000cf          	fnmadd.s	ft1,ft0,ft0,ft0,rne
	sw t6, 15*4(sp)
  aa:	da02                	sw	zero,52(sp)
	call isr
  ac:	02000003          	lb	zero,32(zero) # 20 <reset_vector+0x1c>
  b0:	1969                	addi	s2,s2,-6
  b2:	00b6                	slli	ra,ra,0xd
	lw ra,  0*4(sp)
  b4:	0000                	unimp
  b6:	69070803          	lb	a6,1680(a4)
	lw t0,  1*4(sp)
  ba:	0000                	unimp
	lw t1,  2*4(sp)
  bc:	0200                	addi	s0,sp,256
  be:	05dc                	addi	a5,sp,708
	lw t2,  3*4(sp)
  c0:	0000                	unimp
  c2:	8602                	jr	a2
	lw a0,  4*4(sp)
  c4:	311d                	jal	fffffcea <_fstack+0xeffff2ca>
  c6:	0000                	unimp
	lw a1,  5*4(sp)
  c8:	0200                	addi	s0,sp,256
  ca:	019f 0000 8802      	0x88020000019f
	lw a3,  7*4(sp)
  d0:	441e                	lw	s0,196(sp)
  d2:	0000                	unimp
	lw a4,  8*4(sp)
  d4:	0200                	addi	s0,sp,256
  d6:	0264                	addi	s1,sp,268
	lw a5,  9*4(sp)
  d8:	0000                	unimp
  da:	a002                	fsd	ft0,0(sp)
	lw a6, 10*4(sp)
  dc:	571e                	lw	a4,228(sp)
  de:	0000                	unimp
	lw a7, 11*4(sp)
  e0:	0200                	addi	s0,sp,256
  e2:	057d                	addi	a0,a0,31
	lw t3, 12*4(sp)
  e4:	0000                	unimp
  e6:	a202                	fsd	ft0,256(sp)
	lw t4, 13*4(sp)
  e8:	6a1f 0000 0200      	0x20000006a1f
	lw t5, 14*4(sp)
  ee:	0564                	addi	s1,sp,652
	lw t6, 15*4(sp)
  f0:	0000                	unimp
  f2:	b602                	fsd	ft0,296(sp)
	addi sp, sp, 16*4
  f4:	7d1e                	flw	fs10,228(sp)
  f6:	0000                	unimp
	mret
  f8:	0200                	addi	s0,sp,256
  fa:	0279                	addi	tp,tp,30
  fc:	0000                	unimp
  fe:	b802                	fsd	ft0,48(sp)
 100:	901f 0000 0200      	0x2000000901f
 106:	00b6                	slli	ra,ra,0xd
 108:	0000                	unimp
 10a:	c802                	sw	zero,16(sp)
 10c:	a31e                	fsd	ft7,384(sp)
 10e:	0000                	unimp
 110:	0200                	addi	s0,sp,256
 112:	0419                	addi	s0,s0,6
 114:	0000                	unimp
 116:	ca02                	sw	zero,20(sp)
 118:	b61f 0000 0200      	0x2000000b61f
 11e:	000002eb          	0x2eb
 122:	d602                	sw	zero,44(sp)
 124:	a319                	j	62a <_sidata+0x2ea>
 126:	0000                	unimp
 128:	0200                	addi	s0,sp,256
 12a:	0000054b          	fnmsub.s	fa0,ft0,ft0,ft0,rne
 12e:	de02                	sw	zero,60(sp)
 130:	b61a                	fsd	ft6,296(sp)
 132:	0000                	unimp
 134:	0200                	addi	s0,sp,256
 136:	0194                	addi	a3,sp,192
 138:	0000                	unimp
 13a:	e602                	fsw	ft0,12(sp)
 13c:	4119                	li	sp,6
 13e:	0001                	nop
 140:	0400                	addi	s0,sp,512
 142:	0504                	addi	s1,sp,640
 144:	6e69                	lui	t3,0x1a
 146:	0074                	addi	a3,sp,12
 148:	8902                	jr	s2
 14a:	0004                	0x4
 14c:	0200                	addi	s0,sp,256
 14e:	1ae8                	addi	a0,sp,380
 150:	0154                	addi	a3,sp,132
 152:	0000                	unimp
 154:	73070403          	lb	s0,1840(a4)
 158:	0000                	unimp
 15a:	0300                	addi	s0,sp,384
 15c:	0410                	addi	a2,sp,512
 15e:	03a4                	addi	s1,sp,456
 160:	0000                	unimp
 162:	7805                	lui	a6,0xfffe1
 164:	06000003          	lb	zero,96(zero) # 60 <trap_vector+0xc>
 168:	0369                	addi	t1,t1,26
 16a:	0000                	unimp
 16c:	17016503          	0x17016503
 170:	0154                	addi	a3,sp,132
 172:	0000                	unimp
 174:	d302                	sw	zero,164(sp)
 176:	04000003          	lb	zero,64(zero) # 40 <TOP+0x8>
 17a:	0e2e                	slli	t3,t3,0xb
 17c:	007d                	c.nop	31
 17e:	0000                	unimp
 180:	1402                	slli	s0,s0,0x20
 182:	0005                	c.nop	1
 184:	0400                	addi	s0,sp,512
 186:	0e74                	addi	a3,sp,796
 188:	007d                	c.nop	31
 18a:	0000                	unimp
 18c:	eb02                	fsw	ft0,148(sp)
 18e:	0005                	c.nop	1
 190:	0400                	addi	s0,sp,512
 192:	01411793          	slli	a5,sp,0x14
 196:	0000                	unimp
 198:	a3040807          	0xa3040807
 19c:	3b01                	jal	fffffeac <_fstack+0xeffff48c>
 19e:	0000                	unimp
 1a0:	e200                	fsw	fs0,0(a2)
 1a2:	0001                	nop
 1a4:	0800                	addi	s0,sp,16
 1a6:	0404                	addi	s1,sp,512
 1a8:	03a6                	slli	t2,t2,0x9
 1aa:	000001c7          	fmsub.s	ft3,ft0,ft0,ft0,rne
 1ae:	5b09                	li	s6,-30
 1b0:	04000003          	lb	zero,64(zero) # 40 <TOP+0x8>
 1b4:	01670ca7          	0x1670ca7
 1b8:	0000                	unimp
 1ba:	8a09                	andi	a2,a2,2
 1bc:	0002                	c.slli64	zero
 1be:	0400                	addi	s0,sp,512
 1c0:	1ba8                	addi	a0,sp,504
 1c2:	01e2                	slli	gp,gp,0x18
 1c4:	0000                	unimp
 1c6:	0a00                	addi	s0,sp,272
 1c8:	000004f7          	0x4f7
 1cc:	a404                	fsd	fs1,8(s0)
 1ce:	00014107          	flq	ft2,0(sp) # 302c <_Min_Stack_Size+0x282c>
 1d2:	0000                	unimp
 1d4:	060a                	slli	a2,a2,0x2
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
 1f0:	3d020003          	lb	zero,976(tp) # 3d0 <_sidata+0x90>
 1f4:	0000                	unimp
 1f6:	0400                	addi	s0,sp,512
 1f8:	03aa                	slli	t2,t2,0xa
 1fa:	0198                	addi	a4,sp,192
 1fc:	0000                	unimp
 1fe:	040d                	addi	s0,s0,3
 200:	9302                	jalr	t1
 202:	0005                	c.nop	1
 204:	0500                	addi	s0,sp,640
 206:	1916                	slli	s2,s2,0x25
 208:	0090                	addi	a2,sp,64
 20a:	0000                	unimp
 20c:	6102                	flw	ft2,0(sp)
 20e:	06000003          	lb	zero,96(zero) # 60 <trap_vector+0xc>
 212:	1922                	slli	s2,s2,0x28
 214:	0218                	addi	a4,sp,256
 216:	0000                	unimp
 218:	040e                	slli	s0,s0,0x3
 21a:	021e                	slli	tp,tp,0x7
 21c:	0000                	unimp
 21e:	0004ff0f          	0x4ff0f
 222:	0200                	addi	s0,sp,256
 224:	060c                	addi	a1,sp,768
 226:	0000                	unimp
 228:	2305                	jal	748 <_sidata+0x408>
 22a:	00020c1b          	0x20c1b
 22e:	1000                	addi	s0,sp,32
 230:	023d                	addi	tp,tp,15
 232:	0000                	unimp
 234:	0518                	addi	a4,sp,640
 236:	0834                	addi	a3,sp,24
 238:	0289                	addi	t0,t0,2
 23a:	0000                	unimp
 23c:	9a0a                	add	s4,s4,sp
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
 256:	04e2                	slli	s1,s1,0x18
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
 270:	05cd                	addi	a1,a1,19
 272:	0000                	unimp
 274:	3705                	jal	194 <memset+0x60>
 276:	0001411b          	0x1411b
 27a:	1000                	addi	s0,sp,32
 27c:	5f11                	li	t5,-28
 27e:	0078                	addi	a4,sp,12
	GPIO_SET_TOGGLE_REG  = LED_0;
 280:	3805                	jal	fffffab0 <_fstack+0xeffff090>
 282:	00028f0f          	0x28f0f
 286:	1400                	addi	s0,sp,544
 288:	0e00                	addi	s0,sp,784
 28a:	2f04                	fld	fs1,24(a4)
			GPIO_SET_TOGGLE_REG  = LED_0;
 28c:	0002                	c.slli64	zero
 28e:	0b00                	addi	s0,sp,400
 290:	0200                	addi	s0,sp,256
 292:	0000                	unimp
{
 294:	029f 0000 540c      	0x540c0000029f
 29a:	0001                	nop
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
 29c:	0000                	unimp
 29e:	1000                	addi	s0,sp,32
			GPIO_SET_TOGGLE_REG  = LED_0;
 2a0:	0274                	addi	a3,sp,268
 2a2:	0000                	unimp
	}
 2a4:	0524                	addi	s1,sp,648
 2a6:	083c                	addi	a5,sp,24
	for( ;; );
 2a8:	0322                	slli	t1,t1,0x8
 2aa:	0000                	unimp
}
 2ac:	c60a                	sw	sp,12(sp)
 2ae:	0000                	unimp
 2b0:	0500                	addi	s0,sp,640
 2b2:	093e                	slli	s2,s2,0xf
 2b4:	0141                	addi	sp,sp,16
 2b6:	0000                	unimp
 2b8:	0a00                	addi	s0,sp,272
 2ba:	051c                	addi	a5,sp,640
 2bc:	0000                	unimp
 2be:	3f05                	jal	1ee <memset+0xba>
 2c0:	4109                	li	sp,2
 2c2:	0001                	nop
 2c4:	0400                	addi	s0,sp,512
 2c6:	f70a                	fsw	ft2,172(sp)
 2c8:	0000                	unimp
 2ca:	0500                	addi	s0,sp,640
 2cc:	0940                	addi	s0,sp,148
 2ce:	0141                	addi	sp,sp,16
 2d0:	0000                	unimp
 2d2:	0a08                	addi	a0,sp,272
 2d4:	0658                	addi	a4,sp,772
 2d6:	0000                	unimp
 2d8:	4105                	li	sp,1
 2da:	4109                	li	sp,2
 2dc:	0001                	nop
 2de:	0c00                	addi	s0,sp,528
 2e0:	b70a                	fsd	ft2,424(sp)
 2e2:	05000003          	lb	zero,80(zero) # 50 <LOOP>
 2e6:	0942                	slli	s2,s2,0x10
 2e8:	0141                	addi	sp,sp,16
 2ea:	0000                	unimp
 2ec:	0a10                	addi	a2,sp,272
 2ee:	0391                	addi	t2,t2,4
 2f0:	0000                	unimp
 2f2:	4305                	li	t1,1
 2f4:	4109                	li	sp,2
 2f6:	0001                	nop
 2f8:	1400                	addi	s0,sp,544
 2fa:	d20a                	sw	sp,36(sp)
 2fc:	0005                	c.nop	1
 2fe:	0500                	addi	s0,sp,640
 300:	0944                	addi	s1,sp,148
 302:	0141                	addi	sp,sp,16
 304:	0000                	unimp
 306:	0a18                	addi	a4,sp,272
 308:	0456                	slli	s0,s0,0x15
 30a:	0000                	unimp
 30c:	4505                	li	a0,1
 30e:	4109                	li	sp,2
 310:	0001                	nop
 312:	1c00                	addi	s0,sp,560
 314:	280a                	fld	fa6,128(sp)
 316:	0006                	c.slli	zero,0x1
 318:	0500                	addi	s0,sp,640
 31a:	0946                	slli	s2,s2,0x11
 31c:	0141                	addi	sp,sp,16
 31e:	0000                	unimp
 320:	0020                	addi	s0,sp,8
 322:	0612                	slli	a2,a2,0x4
 324:	0001                	nop
 326:	0800                	addi	s0,sp,16
 328:	0501                	addi	a0,a0,0
 32a:	0367084f          	fnmadd.d	fa6,fa4,fs6,ft0,rne
 32e:	0000                	unimp
 330:	7c0a                	flw	fs8,160(sp)
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
 34a:	00057413          	andi	s0,a0,0
 34e:	0500                	addi	s0,sp,640
 350:	02000a53          	fadd.d	fs4,ft0,ft0,rne
 354:	0000                	unimp
 356:	0100                	addi	s0,sp,128
 358:	00012b13          	slti	s6,sp,0
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
 378:	03c0                	addi	s0,sp,452
 37a:	0000                	unimp
 37c:	0190                	addi	a2,sp,192
 37e:	6205                	lui	tp,0x1
 380:	ba08                	fsd	fa0,48(a2)
 382:	0a000003          	lb	zero,160(zero) # a0 <trap_vector+0x4c>
 386:	049a                	slli	s1,s1,0x6
 388:	0000                	unimp
 38a:	6305                	lui	t1,0x1
 38c:	ba12                	fsd	ft4,304(sp)
 38e:	00000003          	lb	zero,0(zero) # 0 <_start_reset_vector>
 392:	b20a                	fsd	ft2,288(sp)
 394:	0004                	0x4
 396:	0500                	addi	s0,sp,640
 398:	0664                	addi	s1,sp,780
 39a:	0141                	addi	sp,sp,16
 39c:	0000                	unimp
 39e:	0a04                	addi	s1,sp,272
 3a0:	0184                	addi	s1,sp,192
 3a2:	0000                	unimp
 3a4:	6605                	lui	a2,0x1
 3a6:	c021                	beqz	s0,3e6 <_sidata+0xa6>
 3a8:	08000003          	lb	zero,128(zero) # 80 <trap_vector+0x2c>
 3ac:	060a                	slli	a2,a2,0x2
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
 3d8:	0460                	addi	s0,sp,524
 3da:	0000                	unimp
 3dc:	0508                	addi	a0,sp,640
 3de:	087a                	slli	a6,a6,0x1e
 3e0:	03ff                	0x3ff
 3e2:	0000                	unimp
 3e4:	e30a                	fsw	ft2,132(sp)
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
 406:	0474                	addi	a3,sp,524
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
 436:	240a                	fld	fs0,128(sp)
 438:	0001                	nop
 43a:	0500                	addi	s0,sp,640
 43c:	09be                	slli	s3,s3,0xf
 43e:	00000057          	0x57
 442:	0a0c                	addi	a1,sp,272
 444:	02b2                	slli	t0,t0,0xc
 446:	0000                	unimp
 448:	bf05                	j	378 <_sidata+0x38>
 44a:	5709                	li	a4,-30
 44c:	0000                	unimp
 44e:	0e00                	addi	s0,sp,784
 450:	5f11                	li	t5,-28
 452:	6662                	flw	fa2,24(sp)
 454:	0500                	addi	s0,sp,640
 456:	11c0                	addi	s0,sp,228
 458:	000003d7          	0x3d7
 45c:	0a10                	addi	a2,sp,272
 45e:	0080                	addi	s0,sp,64
 460:	0000                	unimp
 462:	c105                	beqz	a0,482 <_sidata+0x142>
 464:	00014107          	flq	ft2,0(sp)
 468:	1800                	addi	s0,sp,48
 46a:	140a                	slli	s0,s0,0x22
 46c:	0001                	nop
 46e:	0500                	addi	s0,sp,640
 470:	0ac8                	addi	a0,sp,340
 472:	01fe                	slli	gp,gp,0x1f
 474:	0000                	unimp
 476:	0a1c                	addi	a5,sp,272
 478:	0254                	addi	a3,sp,260
 47a:	0000                	unimp
 47c:	cb05                	beqz	a4,4ac <_sidata+0x16c>
 47e:	2d29                	jal	a98 <_Min_Stack_Size+0x298>
 480:	0008                	0x8
 482:	2000                	fld	fs0,0(s0)
 484:	8a0a                	mv	s4,sp
 486:	05000003          	lb	zero,80(zero) # 50 <LOOP>
 48a:	22ce                	fld	ft5,208(sp)
 48c:	00000857          	0x857
 490:	0a24                	addi	s1,sp,280
 492:	050e                	slli	a0,a0,0x3
 494:	0000                	unimp
 496:	cf05                	beqz	a4,4ce <_sidata+0x18e>
 498:	7b3a                	flw	fs6,172(sp)
 49a:	0008                	0x8
 49c:	2800                	fld	fs0,16(s0)
 49e:	420a                	lw	tp,128(sp)
 4a0:	0006                	c.slli	zero,0x1
 4a2:	0500                	addi	s0,sp,640
 4a4:	29d0                	fld	fa2,144(a1)
 4a6:	0895                	addi	a7,a7,5
 4a8:	0000                	unimp
 4aa:	112c                	addi	a1,sp,168
 4ac:	755f 0062 d305      	0xd3050062755f
 4b2:	d711                	beqz	a4,3be <_sidata+0x7e>
 4b4:	30000003          	lb	zero,768(zero) # 300 <__libc_init_array+0x50>
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
 4d2:	dd0a                	sw	sp,184(sp)
 4d4:	0000                	unimp
 4d6:	0500                	addi	s0,sp,640
 4d8:	18d8                	addi	a4,sp,116
 4da:	0000089b          	0x89b
 4de:	0a40                	addi	s0,sp,276
 4e0:	0615                	addi	a2,a2,5
 4e2:	0000                	unimp
 4e4:	d905                	beqz	a0,414 <_sidata+0xd4>
 4e6:	ab18                	fsd	fa4,16(a4)
 4e8:	0008                	0x8
 4ea:	4300                	lw	s0,0(a4)
 4ec:	5f11                	li	t5,-28
 4ee:	626c                	flw	fa1,68(a2)
 4f0:	0500                	addi	s0,sp,640
 4f2:	11dc                	addi	a5,sp,228
 4f4:	000003d7          	0x3d7
 4f8:	0a44                	addi	s1,sp,276
 4fa:	0144                	addi	s1,sp,132
 4fc:	0000                	unimp
 4fe:	df05                	beqz	a4,436 <_sidata+0xf6>
 500:	00014107          	flq	ft2,0(sp)
 504:	4c00                	lw	s0,24(s0)
 506:	550a                	lw	a0,160(sp)
 508:	0001                	nop
 50a:	0500                	addi	s0,sp,640
 50c:	0ae0                	addi	s0,sp,348
 50e:	0174                	addi	a3,sp,140
 510:	0000                	unimp
 512:	0a50                	addi	a2,sp,276
 514:	0048                	addi	a0,sp,4
 516:	0000                	unimp
 518:	e305                	bnez	a4,538 <_sidata+0x1f8>
 51a:	6612                	flw	fa2,4(sp)
 51c:	0005                	c.nop	1
 51e:	5400                	lw	s0,40(s0)
 520:	000a                	c.slli	zero,0x2
 522:	0005                	c.nop	1
 524:	0500                	addi	s0,sp,640
 526:	02230ce7          	jalr	s9,34(t1) # 1022 <_Min_Stack_Size+0x822>
 52a:	0000                	unimp
 52c:	0a58                	addi	a4,sp,276
 52e:	0028                	addi	a0,sp,8
 530:	0000                	unimp
 532:	e905                	bnez	a0,562 <_sidata+0x222>
 534:	f20e                	fsw	ft3,36(sp)
 536:	0001                	nop
 538:	5c00                	lw	s0,56(s0)
 53a:	700a                	flw	ft0,160(sp)
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
 572:	04ea                	slli	s1,s1,0x1a
 574:	0000                	unimp
 576:	0428                	addi	a0,sp,520
 578:	6505                	lui	a0,0x1
 57a:	0802                	c.slli64	a6
 57c:	0000081b          	0x81b
 580:	f019                	bnez	s0,486 <_sidata+0x146>
 582:	8405                	srai	s0,s0,0x1
 584:	0502                	c.slli64	a0
 586:	06e1                	addi	a3,a3,24
 588:	0000                	unimp
 58a:	d01a                	sw	t1,32(sp)
 58c:	8605                	srai	a2,a2,0x1
 58e:	0902                	c.slli64	s2
 590:	069f 0000 c01b      	0xc01b0000069f
 596:	0005                	c.nop	1
 598:	0500                	addi	s0,sp,640
 59a:	54180287          	0x54180287
 59e:	0001                	nop
 5a0:	0000                	unimp
 5a2:	0005571b          	0x5571b
 5a6:	0500                	addi	s0,sp,640
 5a8:	0288                	addi	a0,sp,320
 5aa:	1b12                	slli	s6,s6,0x24
 5ac:	0008                	0x8
 5ae:	0400                	addi	s0,sp,512
 5b0:	0002f61b          	0x2f61b
 5b4:	0500                	addi	s0,sp,640
 5b6:	0289                	addi	t0,t0,2
 5b8:	5630                	lw	a2,104(a2)
 5ba:	0009                	c.nop	2
 5bc:	0800                	addi	s0,sp,16
 5be:	0006331b          	0x6331b
 5c2:	0500                	addi	s0,sp,640
 5c4:	028a                	slli	t0,t0,0x2
 5c6:	00029f17          	auipc	t5,0x29
 5ca:	2400                	fld	fs0,8(s0)
 5cc:	0002451b          	0x2451b
 5d0:	0500                	addi	s0,sp,640
 5d2:	410f028b          	0x410f028b
 5d6:	0001                	nop
 5d8:	4800                	lw	s0,16(s0)
 5da:	0004951b          	0x4951b
 5de:	0500                	addi	s0,sp,640
 5e0:	028c                	addi	a1,sp,320
 5e2:	b62c                	fsd	fa1,104(a2)
 5e4:	0000                	unimp
 5e6:	5000                	lw	s0,32(s0)
 5e8:	0006491b          	0x6491b
 5ec:	0500                	addi	s0,sp,640
 5ee:	028d                	addi	t0,t0,3
 5f0:	0d1a                	slli	s10,s10,0x6
 5f2:	0009                	c.nop	2
 5f4:	5800                	lw	s0,48(s0)
 5f6:	0004a01b          	0x4a01b
 5fa:	0500                	addi	s0,sp,640
 5fc:	028e                	slli	t0,t0,0x3
 5fe:	f216                	fsw	ft5,36(sp)
 600:	0001                	nop
 602:	6800                	flw	fs0,16(s0)
 604:	0005fe1b          	0x5fe1b
 608:	0500                	addi	s0,sp,640
 60a:	f216028f          	0xf216028f
 60e:	0001                	nop
 610:	7000                	flw	fs0,32(s0)
 612:	0003fd1b          	0x3fd1b
 616:	0500                	addi	s0,sp,640
 618:	0290                	addi	a2,sp,320
 61a:	f216                	fsw	ft5,36(sp)
 61c:	0001                	nop
 61e:	7800                	flw	fs0,48(s0)
 620:	0005f41b          	0x5f41b
 624:	0500                	addi	s0,sp,640
 626:	0291                	addi	t0,t0,4
 628:	0009661b          	0x9661b
 62c:	8000                	0x8000
 62e:	00005d1b          	0x5d1b
 632:	0500                	addi	s0,sp,640
 634:	0292                	slli	t0,t0,0x4
 636:	762e                	flw	fa2,232(sp)
 638:	0009                	c.nop	2
 63a:	8800                	0x8800
 63c:	00059b1b          	0x59b1b
 640:	0500                	addi	s0,sp,640
 642:	410f0293          	addi	t0,t5,1040 # 299d6 <_Min_Stack_Size+0x291d6>
 646:	0001                	nop
 648:	a000                	fsd	fs0,0(s0)
 64a:	00016e1b          	0x16e1b
 64e:	0500                	addi	s0,sp,640
 650:	0294                	addi	a3,sp,320
 652:	f216                	fsw	ft5,36(sp)
 654:	0001                	nop
 656:	a400                	fsd	fs0,8(s0)
 658:	0000a71b          	0xa71b
 65c:	0500                	addi	s0,sp,640
 65e:	0295                	addi	t0,t0,5
 660:	f216                	fsw	ft5,36(sp)
 662:	0001                	nop
 664:	ac00                	fsd	fs0,24(s0)
 666:	00015d1b          	0x15d1b
 66a:	0500                	addi	s0,sp,640
 66c:	0296                	slli	t0,t0,0x5
 66e:	f216                	fsw	ft5,36(sp)
 670:	0001                	nop
 672:	b400                	fsd	fs0,40(s0)
 674:	00004e1b          	0x4e1b
 678:	0500                	addi	s0,sp,640
 67a:	f2160297          	auipc	t0,0xf2160
 67e:	0001                	nop
 680:	bc00                	fsd	fs0,56(s0)
 682:	0002911b          	0x2911b
 686:	0500                	addi	s0,sp,640
 688:	0298                	addi	a4,sp,320
 68a:	f216                	fsw	ft5,36(sp)
 68c:	0001                	nop
 68e:	c400                	sw	s0,8(s0)
 690:	0004431b          	0x4431b
 694:	0500                	addi	s0,sp,640
 696:	0299                	addi	t0,t0,6
 698:	4108                	lw	a0,0(a0)
 69a:	0001                	nop
 69c:	cc00                	sw	s0,24(s0)
 69e:	1a00                	addi	s0,sp,304
 6a0:	05f0                	addi	a2,sp,716
 6a2:	029f c609 0006      	0x6c609029f
 6a8:	1b00                	addi	s0,sp,432
 6aa:	03b0                	addi	a2,sp,456
 6ac:	0000                	unimp
 6ae:	a105                	j	ace <_Min_Stack_Size+0x2ce>
 6b0:	2a02                	fld	fs4,0(sp)
 6b2:	0986                	slli	s3,s3,0x1
 6b4:	0000                	unimp
 6b6:	1b00                	addi	s0,sp,432
 6b8:	0000039b          	0x39b
 6bc:	a205                	j	7dc <_sidata+0x49c>
 6be:	2902                	fld	fs2,0(sp)
 6c0:	0996                	slli	s3,s3,0x5
 6c2:	0000                	unimp
 6c4:	0078                	addi	a4,sp,12
 6c6:	ea1c                	fsw	fa5,16(a2)
 6c8:	0004                	0x4
 6ca:	0500                	addi	s0,sp,640
 6cc:	029a                	slli	t0,t0,0x6
 6ce:	00058a0b          	0x58a0b
 6d2:	1c00                	addi	s0,sp,560
 6d4:	0000061b          	0x61b
 6d8:	a305                	j	bf8 <_Min_Stack_Size+0x3f8>
 6da:	0b02                	c.slli64	s6
 6dc:	069f 0000 1b00      	0x1b000000069f
 6e2:	0445                	addi	s0,s0,17
 6e4:	0000                	unimp
 6e6:	6705                	lui	a4,0x1
 6e8:	0702                	c.slli64	a4
 6ea:	0141                	addi	sp,sp,16
 6ec:	0000                	unimp
 6ee:	1b00                	addi	s0,sp,432
 6f0:	00000133          	add	sp,zero,zero
 6f4:	6c05                	lui	s8,0x1
 6f6:	0b02                	c.slli64	s6
 6f8:	00000907          	0x907
 6fc:	1b04                	addi	s1,sp,432
 6fe:	02a2                	slli	t0,t0,0x8
 700:	0000                	unimp
 702:	6c05                	lui	s8,0x1
 704:	1402                	slli	s0,s0,0x20
 706:	00000907          	0x907
 70a:	1b08                	addi	a0,sp,432
 70c:	0235                	addi	tp,tp,13
 70e:	0000                	unimp
 710:	6c05                	lui	s8,0x1
 712:	1e02                	slli	t3,t3,0x20
 714:	00000907          	0x907
 718:	1b0c                	addi	a1,sp,432
 71a:	04ad                	addi	s1,s1,11
 71c:	0000                	unimp
 71e:	6e05                	lui	t3,0x1
 720:	0802                	c.slli64	a6
 722:	0141                	addi	sp,sp,16
 724:	0000                	unimp
 726:	1b10                	addi	a2,sp,432
 728:	053a                	slli	a0,a0,0xe
 72a:	0000                	unimp
 72c:	6f05                	lui	t5,0x1
 72e:	2802                	fld	fa6,0(sp)
 730:	09a6                	slli	s3,s3,0x9
 732:	0000                	unimp
 734:	1b14                	addi	a3,sp,432
 736:	04c9                	addi	s1,s1,18
 738:	0000                	unimp
 73a:	7205                	lui	tp,0xfffe1
 73c:	0702                	c.slli64	a4
 73e:	0141                	addi	sp,sp,16
 740:	0000                	unimp
 742:	1b30                	addi	a2,sp,440
 744:	000004b7          	lui	s1,0x0
 748:	7305                	lui	t1,0xfffe1
 74a:	1602                	slli	a2,a2,0x20
 74c:	000009bb          	0x9bb
 750:	1b34                	addi	a3,sp,440
 752:	03c8                	addi	a0,sp,452
 754:	0000                	unimp
 756:	7505                	lui	a0,0xfffe1
 758:	0702                	c.slli64	a4
 75a:	0141                	addi	sp,sp,16
 75c:	0000                	unimp
 75e:	1b38                	addi	a4,sp,440
 760:	000004bf 25027705 	0x25027705000004bf
 768:	09cc                	addi	a1,sp,212
 76a:	0000                	unimp
 76c:	1b3c                	addi	a5,sp,440
 76e:	00000353          	fadd.s	ft6,ft0,ft0,rne
 772:	7a05                	lui	s4,0xfffe1
 774:	1302                	slli	t1,t1,0x20
 776:	0289                	addi	t0,t0,2
 778:	0000                	unimp
 77a:	1b40                	addi	s0,sp,436
 77c:	025a                	slli	tp,tp,0x16
 77e:	0000                	unimp
 780:	7b05                	lui	s6,0xfffe1
 782:	0702                	c.slli64	a4
 784:	0141                	addi	sp,sp,16
 786:	0000                	unimp
 788:	1b44                	addi	s1,sp,436
 78a:	064e                	slli	a2,a2,0x13
 78c:	0000                	unimp
 78e:	7c05                	lui	s8,0xfffe1
 790:	1302                	slli	t1,t1,0x20
 792:	0289                	addi	t0,t0,2
 794:	0000                	unimp
 796:	1b48                	addi	a0,sp,436
 798:	03e5                	addi	t2,t2,25
 79a:	0000                	unimp
 79c:	7d05                	lui	s10,0xfffe1
 79e:	1402                	slli	s0,s0,0x20
 7a0:	09d2                	slli	s3,s3,0x14
 7a2:	0000                	unimp
 7a4:	1b4c                	addi	a1,sp,436
 7a6:	02aa                	slli	t0,t0,0xa
 7a8:	0000                	unimp
 7aa:	8005                	srli	s0,s0,0x1
 7ac:	0702                	c.slli64	a4
 7ae:	0141                	addi	sp,sp,16
 7b0:	0000                	unimp
 7b2:	1b50                	addi	a2,sp,436
 7b4:	014d                	addi	sp,sp,19
 7b6:	0000                	unimp
 7b8:	8105                	srli	a0,a0,0x1
 7ba:	0902                	c.slli64	s2
 7bc:	0000081b          	0x81b
 7c0:	1b54                	addi	a3,sp,436
 7c2:	0438                	addi	a4,sp,520
 7c4:	0000                	unimp
 7c6:	a405                	j	9e6 <_Min_Stack_Size+0x1e6>
 7c8:	0702                	c.slli64	a4
 7ca:	0580                	addi	s0,sp,704
 7cc:	0000                	unimp
 7ce:	1d58                	addi	a4,sp,692
 7d0:	03c0                	addi	s0,sp,452
 7d2:	0000                	unimp
 7d4:	a805                	j	804 <_Min_Stack_Size+0x4>
 7d6:	1302                	slli	t1,t1,0x20
 7d8:	03ba                	slli	t2,t2,0xe
 7da:	0000                	unimp
 7dc:	0148                	addi	a0,sp,132
 7de:	e21d                	bnez	a2,804 <_Min_Stack_Size+0x4>
 7e0:	0002                	c.slli64	zero
 7e2:	0500                	addi	s0,sp,640
 7e4:	02a9                	addi	t0,t0,10
 7e6:	7712                	flw	fa4,36(sp)
 7e8:	4c000003          	lb	zero,1216(zero) # 4c0 <_sidata+0x180>
 7ec:	1d01                	addi	s10,s10,-32
 7ee:	000002bf 1b02ad05 	0x1b02ad05000002bf
 7f6:	000009e3          	beqz	zero,1008 <_Min_Stack_Size+0x808>
 7fa:	02dc                	addi	a5,sp,324
 7fc:	1c1d                	addi	s8,s8,-25
 7fe:	0001                	nop
 800:	0500                	addi	s0,sp,640
 802:	02b2                	slli	t0,t0,0xc
 804:	c810                	sw	a2,16(s0)
 806:	0008                	0x8
 808:	e000                	fsw	fs0,0(s0)
 80a:	1d02                	slli	s10,s10,0x20
 80c:	0101                	addi	sp,sp,0
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
 824:	00000433          	add	s0,zero,zero
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
 8bc:	046d                	addi	s0,s0,27
 8be:	0000                	unimp
 8c0:	2405                	jal	ae0 <_Min_Stack_Size+0x2e0>
 8c2:	1a01                	addi	s4,s4,-32
 8c4:	0405                	addi	s0,s0,1
 8c6:	0000                	unimp
 8c8:	dc1e                	sw	t2,56(sp)
 8ca:	0002                	c.slli64	zero
 8cc:	0c00                	addi	s0,sp,528
 8ce:	2805                	jal	8fe <_Min_Stack_Size+0xfe>
 8d0:	0801                	addi	a6,a6,0
 8d2:	0901                	addi	s2,s2,0
 8d4:	0000                	unimp
 8d6:	00049a1b          	0x49a1b
 8da:	0500                	addi	s0,sp,640
 8dc:	012a                	slli	sp,sp,0xa
 8de:	0111                	addi	sp,sp,4
 8e0:	0009                	c.nop	2
 8e2:	0000                	unimp
 8e4:	0002b81b          	0x2b81b
 8e8:	0500                	addi	s0,sp,640
 8ea:	4107012b          	0x4107012b
 8ee:	0001                	nop
 8f0:	0400                	addi	s0,sp,512
 8f2:	0004671b          	0x4671b
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
 91c:	04f1                	addi	s1,s1,28
 91e:	0000                	unimp
 920:	4505                	li	a0,1
 922:	1901                	addi	s2,s2,-32
 924:	0946                	slli	s2,s2,0x11
 926:	0000                	unimp
 928:	1b00                	addi	s0,sp,432
 92a:	0545                	addi	a0,a0,17
 92c:	0000                	unimp
 92e:	4605                	li	a2,1
 930:	1901                	addi	s2,s2,-32
 932:	0946                	slli	s2,s2,0x11
 934:	0000                	unimp
 936:	1b06                	slli	s6,s6,0x21
 938:	058e                	slli	a1,a1,0x3
 93a:	0000                	unimp
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
 9b6:	0000930f          	0x930f
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
 a00:	000005af          	0x5af
 a04:	3305                	jal	724 <_sidata+0x3e4>
 a06:	05661703          	lh	a4,86(a2) # 565c2 <_Min_Stack_Size+0x55dc2>
 a0a:	0000                	unimp
 a0c:	a820                	fsd	fs0,80(s0)
 a0e:	0005                	c.nop	1
 a10:	0500                	addi	s0,sp,640
 a12:	0334                	addi	a3,sp,392
 a14:	6c1d                	lui	s8,0x7
 a16:	0005                	c.nop	1
 a18:	0200                	addi	s0,sp,256
 a1a:	00a0                	addi	s0,sp,72
 a1c:	0000                	unimp
 a1e:	25121407          	0x25121407
 a22:	0000                	unimp
 a24:	0200                	addi	s0,sp,256
 a26:	00000033          	add	zero,zero,zero
 a2a:	38131807          	0x38131807
 a2e:	0000                	unimp
 a30:	0200                	addi	s0,sp,256
 a32:	022d                	addi	tp,tp,11
 a34:	0000                	unimp
 a36:	4b132007          	flw	ft0,1201(t1) # fffe14b1 <_fstack+0xeffe0a91>
 a3a:	0000                	unimp
 a3c:	0200                	addi	s0,sp,256
 a3e:	00000527          	0x527
 a42:	5e142407          	flw	fs0,1505(s0) # 14115e1 <_Min_Stack_Size+0x1410de1>
 a46:	0000                	unimp
 a48:	0200                	addi	s0,sp,256
 a4a:	0532                	slli	a0,a0,0xc
 a4c:	0000                	unimp
 a4e:	71132c07          	flw	fs8,1809(t1)
 a52:	0000                	unimp
 a54:	0200                	addi	s0,sp,256
 a56:	0000018b          	0x18b
 a5a:	84143007          	fld	ft0,-1983(s0)
 a5e:	0000                	unimp
 a60:	0200                	addi	s0,sp,256
 a62:	0000008b          	0x8b
 a66:	97133807          	fld	fa6,-1679(t1)
 a6a:	0000                	unimp
 a6c:	0200                	addi	s0,sp,256
 a6e:	03dc                	addi	a5,sp,452
 a70:	0000                	unimp
 a72:	aa143c07          	fld	fs8,-1375(s0)
 a76:	0000                	unimp
 a78:	0200                	addi	s0,sp,256
 a7a:	02ed                	addi	t0,t0,27
 a7c:	0000                	unimp
 a7e:	1d144307          	flq	ft6,465(s0)
 a82:	0001                	nop
 a84:	0200                	addi	s0,sp,256
 a86:	054d                	addi	a0,a0,19
 a88:	0000                	unimp
 a8a:	29154807          	flq	fa6,657(a0) # fffe1291 <_fstack+0xeffe0871>
 a8e:	0001                	nop
 a90:	0200                	addi	s0,sp,256
 a92:	0196                	slli	gp,gp,0x5
 a94:	0000                	unimp
 a96:	35144d07          	flq	fs10,849(s0)
 a9a:	0001                	nop
 a9c:	0200                	addi	s0,sp,256
 a9e:	0000048b          	0x48b
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
 ba8:	013a                	slli	sp,sp,0xe
 baa:	0000                	unimp
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
 bc8:	05de                	slli	a1,a1,0x17
 bca:	0000                	unimp
 bcc:	150a                	slli	a0,a0,0x22
 bce:	bd18                	fsd	fa4,56(a0)
 bd0:	0000                	unimp
 bd2:	0200                	addi	s0,sp,256
 bd4:	01a1                	addi	gp,gp,8
 bd6:	0000                	unimp
 bd8:	160a                	slli	a2,a2,0x22
 bda:	c919                	beqz	a0,bf0 <_Min_Stack_Size+0x3f0>
 bdc:	0000                	unimp
 bde:	0200                	addi	s0,sp,256
 be0:	0266                	slli	tp,tp,0x19
 be2:	0000                	unimp
 be4:	1b0a                	slli	s6,s6,0x22
 be6:	d519                	beqz	a0,af4 <_Min_Stack_Size+0x2f4>
 be8:	0000                	unimp
 bea:	0200                	addi	s0,sp,256
 bec:	057f                	0x57f
 bee:	0000                	unimp
 bf0:	1c0a                	slli	s8,s8,0x22
 bf2:	e11a                	fsw	ft6,128(sp)
 bf4:	0000                	unimp
 bf6:	0200                	addi	s0,sp,256
 bf8:	0566                	slli	a0,a0,0x19
 bfa:	0000                	unimp
 bfc:	210a                	fld	ft2,128(sp)
 bfe:	ed19                	bnez	a0,c1c <_Min_Stack_Size+0x41c>
 c00:	0000                	unimp
 c02:	0200                	addi	s0,sp,256
 c04:	0000027b          	0x27b
 c08:	220a                	fld	ft4,128(sp)
 c0a:	f91a                	fsw	ft6,176(sp)
 c0c:	0000                	unimp
 c0e:	0200                	addi	s0,sp,256
 c10:	00b8                	addi	a4,sp,72
 c12:	0000                	unimp
 c14:	270a                	fld	fa4,128(sp)
 c16:	0519                	addi	a0,a0,6
 c18:	0001                	nop
 c1a:	0200                	addi	s0,sp,256
 c1c:	0000041b          	0x41b
 c20:	280a                	fld	fa6,128(sp)
 c22:	111a                	slli	sp,sp,0x26
 c24:	0001                	nop
 c26:	0200                	addi	s0,sp,256
 c28:	047d                	addi	s0,s0,31
 c2a:	0000                	unimp
 c2c:	330a                	fld	ft6,160(sp)
 c2e:	411e                	lw	sp,196(sp)
 c30:	0001                	nop
 c32:	0200                	addi	s0,sp,256
 c34:	047c                	addi	a5,sp,524
 c36:	0000                	unimp
 c38:	340a                	fld	fs0,160(sp)
 c3a:	541f 0001 0200      	0x2000001541f
 c40:	03f0                	addi	a2,sp,460
 c42:	0000                	unimp
 c44:	3d0a                	fld	fs10,160(sp)
 c46:	411f 0001 0200      	0x2000001411f
 c4c:	000003ef          	jal	t2,c4c <_Min_Stack_Size+0x44c>
 c50:	3e0a                	fld	ft8,160(sp)
 c52:	5420                	lw	s0,104(s0)
 c54:	0001                	nop
 c56:	0200                	addi	s0,sp,256
 c58:	040c                	addi	a1,sp,512
 c5a:	0000                	unimp
 c5c:	470a                	lw	a4,128(sp)
 c5e:	411f 0001 0200      	0x2000001411f
 c64:	0000040b          	0x40b
 c68:	480a                	lw	a6,128(sp)
 c6a:	5420                	lw	s0,104(s0)
 c6c:	0001                	nop
 c6e:	0200                	addi	s0,sp,256
 c70:	00ea                	slli	ra,ra,0x1a
 c72:	0000                	unimp
 c74:	510a                	lw	sp,160(sp)
 c76:	a31f 0000 0200      	0x2000000a31f
 c7c:	00e9                	addi	ra,ra,26
 c7e:	0000                	unimp
 c80:	520a                	lw	tp,160(sp)
 c82:	b620                	fsd	fs0,104(a2)
 c84:	0000                	unimp
 c86:	2600                	fld	fs0,8(a2)
 c88:	7369                	lui	t1,0xffffa
 c8a:	0072                	c.slli	zero,0x1c
 c8c:	2401                	jal	e8c <_Min_Stack_Size+0x68c>
 c8e:	ac06                	fsd	ft1,24(sp)
 c90:	0002                	c.slli64	zero
 c92:	0400                	addi	s0,sp,512
 c94:	0000                	unimp
 c96:	0100                	addi	s0,sp,128
 c98:	279c                	fld	fa5,8(a5)
 c9a:	000003c3          	fmadd.s	ft7,ft0,ft0,ft0,rne
 c9e:	1c01                	addi	s8,s8,-32
 ca0:	a816                	fsd	ft5,16(sp)
 ca2:	0002                	c.slli64	zero
 ca4:	0400                	addi	s0,sp,512
 ca6:	0000                	unimp
 ca8:	0100                	addi	s0,sp,128
 caa:	bd9c                	fsd	fa5,56(a1)
 cac:	000c                	0xc
 cae:	2800                	fld	fs0,16(s0)
 cb0:	6372                	flw	ft6,28(sp)
 cb2:	0100                	addi	s0,sp,128
 cb4:	201c                	fld	fa5,0(s0)
 cb6:	0141                	addi	sp,sp,16
 cb8:	0000                	unimp
 cba:	5a01                	li	s4,-32
 cbc:	2900                	fld	fs0,16(a0)
 cbe:	00000653          	fadd.s	fa2,ft0,ft0,rne
 cc2:	0d01                	addi	s10,s10,0
 cc4:	4105                	li	sp,1
 cc6:	0001                	nop
 cc8:	8000                	0x8000
 cca:	0002                	c.slli64	zero
 ccc:	2800                	fld	fs0,16(s0)
 cce:	0000                	unimp
 cd0:	0100                	addi	s0,sp,128
 cd2:	0e9c                	addi	a5,sp,848
 cd4:	000d                	c.nop	3
 cd6:	2a00                	fld	fs0,16(a2)
 cd8:	00000623          	sb	zero,12(zero) # c <reset_vector+0x8>
 cdc:	0d01                	addi	s10,s10,0
 cde:	410e                	lw	sp,192(sp)
 ce0:	0001                	nop
 ce2:	0100                	addi	s0,sp,128
 ce4:	2a5a                	fld	fs4,400(sp)
 ce6:	000005bb          	0x5bb
 cea:	0d01                	addi	s10,s10,0
 cec:	000d0e1b          	0xd0e1b
 cf0:	0100                	addi	s0,sp,128
 cf2:	029c2b5b          	0x29c2b5b
 cf6:	0000                	unimp
 cf8:	0004                	0x4
 cfa:	0000                	unimp
 cfc:	3d2c                	fld	fa1,120(a0)
 cfe:	0004                	0x4
 d00:	0100                	addi	s0,sp,128
 d02:	1115                	addi	sp,sp,-27
 d04:	0a55                	addi	s4,s4,21
	...
 d0e:	040e                	slli	s0,s0,0x3
 d10:	0000081b          	0x81b
 d14:	2200                	fld	fs0,0(a2)
 d16:	0000                	unimp
 d18:	0200                	addi	s0,sp,256
 d1a:	7800                	flw	fs0,48(s0)
 d1c:	0002                	c.slli64	zero
 d1e:	0400                	addi	s0,sp,512
 d20:	5201                	li	tp,-32
 d22:	0004                	0x4
 d24:	0000                	unimp
 d26:	0000                	unimp
 d28:	e400                	fsw	fs0,8(s0)
 d2a:	0000                	unimp
 d2c:	7600                	flw	fs0,40(a2)
 d2e:	0006                	c.slli	zero,0x1
 d30:	0300                	addi	s0,sp,384
 d32:	7d000003          	lb	zero,2000(zero) # 7d0 <_sidata+0x490>
 d36:	0006                	c.slli	zero,0x1
 d38:	0100                	addi	s0,sp,128
 d3a:	80              	Address 0x0000000000000d3a is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
	j reset_vector
   0:	1101                	addi	sp,sp,-32
   2:	2501                	jal	602 <_sidata+0x2c2>
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
 230:	2e29                	jal	54a <_sidata+0x20a>
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
 25a:	0018                	0x18
 25c:	2b00                	fld	fs0,16(a4)
 25e:	0111010b          	0x111010b
 262:	0612                	slli	a2,a2,0x4
 264:	0000                	unimp
 266:	342c                	fld	fa1,104(s0)
 268:	0300                	addi	s0,sp,384
 26a:	3a0e                	fld	fs4,224(sp)
 26c:	390b3b0b          	0x390b3b0b
 270:	0213490b          	0x213490b
 274:	00000017          	auipc	zero,0x0
 278:	1101                	addi	sp,sp,-32
 27a:	1000                	addi	s0,sp,32
 27c:	1106                	slli	sp,sp,0x21
 27e:	1201                	addi	tp,tp,-32
	GPIO_SET_TOGGLE_REG  = LED_0;
 280:	0301                	addi	t1,t1,0
 282:	1b0e                	slli	s6,s6,0x23
 284:	250e                	fld	fa0,192(sp)
 286:	130e                	slli	t1,t1,0x23
 288:	0005                	c.nop	1
	...

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
	j reset_vector
   0:	0294                	addi	a3,sp,320
   2:	0000                	unimp
    csrci mstatus, 8
   4:	0298                	addi	a4,sp,320
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	0002                	c.slli64	zero
   a:	9f30                	0x9f30
   c:	0298                	addi	a4,sp,320
   e:	0000                	unimp
	la sp, _fstack
  10:	029c                	addi	a5,sp,320
  12:	0000                	unimp
  14:	0009                	c.nop	2
  16:	010c                	addi	a1,sp,128
	sw x0, 0(sp)
  18:	0200                	addi	s0,sp,256
  1a:	7f00                	flw	fs0,56(a4)
	sw x0, 4(sp)
  1c:	1c00                	addi	s0,sp,560
  1e:	9c9f 0002 a800      	0xa80000029c9f
	la t0, trap_vector
  24:	0002                	c.slli64	zero
  26:	0700                	addi	s0,sp,896
	csrw mtvec, t0
  28:	4000                	lw	s0,0(s0)
  2a:	243d                	jal	258 <__do_global_dtors_aux+0x48>
	la a0, _sidata  /*from */
  2c:	007f                	0x7f
  2e:	9f1c                	0x9f1c
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
  14:	0028                	addi	a0,sp,8
  16:	0000                	unimp
	sw x0, 0(sp)
  18:	02a8                	addi	a0,sp,328
  1a:	0000                	unimp
	sw x0, 4(sp)
  1c:	0004                	0x4
  1e:	0000                	unimp
	la t0, trap_vector
  20:	02ac                	addi	a1,sp,328
  22:	0000                	unimp
  24:	0004                	0x4
	...
	la a0, _sidata  /*from */
  2e:	0000                	unimp
  30:	001c                	0x1c
  32:	0000                	unimp
	la a1, _sdata   /* to */
  34:	0002                	c.slli64	zero
  36:	0d15                	addi	s10,s10,5
  38:	0000                	unimp
  3a:	0004                	0x4
	...
	beq	a1,a2, DONE
  44:	00fc                	addi	a5,sp,76
	...

Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
	j reset_vector
   0:	0280                	addi	s0,sp,320
   2:	0000                	unimp
    csrci mstatus, 8
   4:	02a8                	addi	a0,sp,328
   6:	0000                	unimp
	la gp, __global_pointer$
   8:	02a8                	addi	a0,sp,328
   a:	0000                	unimp
   c:	02ac                	addi	a1,sp,328
   e:	0000                	unimp
	la sp, _fstack
  10:	02ac                	addi	a1,sp,328
  12:	0000                	unimp
  14:	02b0                	addi	a2,sp,328
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
	j reset_vector
   0:	044e                	slli	s0,s0,0x13
   2:	0000                	unimp
    csrci mstatus, 8
   4:	03900003          	lb	zero,57(zero) # 39 <TOP+0x1>
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
  22:	454c                	lw	a1,12(a0)
  24:	0044                	addi	s1,sp,4
  26:	64656d2f          	0x64656d2f
	csrw mtvec, t0
  2a:	6169                	addi	sp,sp,208
	la a0, _sidata  /*from */
  2c:	6d63742f          	0x6d63742f
  30:	6369                	lui	t1,0x1a
  32:	6168                	flw	fa0,68(a0)
	la a1, _sdata   /* to */
  34:	736c                	flw	fa1,100(a4)
  36:	726f572f          	0x726f572f
  3a:	676e696b          	0x676e696b
	la a2, _edata  /* end */
  3e:	6379632f          	0x6379632f
  42:	6f6c                	flw	fa1,92(a4)
	beq	a1,a2, DONE
  44:	656e                	flw	fa0,216(sp)
  46:	312d                	jal	fffffc70 <_fstack+0xeffff250>
	lw	t0, (a0)
  48:	2f30                	fld	fa2,88(a4)
  4a:	31637963          	bgeu	t1,s6,35c <_sidata+0x1c>
	sw t0, (a1)
  4e:	3030                	fld	fa2,96(s0)
	addi a0,a0,4
  50:	2f30                	fld	fa2,88(a4)
  52:	6972                	flw	fs2,28(sp)
	addi a1,a2,4
  54:	2d766373          	csrrsi	t1,0x2d7,12
	bltu a1,a2, TOP
  58:	2f636367          	0x2f636367
	call _start
  5c:	6972                	flw	fs2,28(sp)
  5e:	2d766373          	csrrsi	t1,0x2d7,12
  62:	6f6e                	flw	ft10,216(sp)
LOOP:	j LOOP
  64:	656e                	flw	fa0,216(sp)
  66:	652d                	lui	a0,0xb
	addi sp, sp, -16*4
  68:	626d                	lui	tp,0x1b
  6a:	6465                	lui	s0,0x19
	sw ra,  0*4(sp)
  6c:	672d                	lui	a4,0xb
  6e:	382f6363          	bltu	t5,sp,3f4 <_sidata+0xb4>
	sw t0,  1*4(sp)
  72:	332e                	fld	ft6,232(sp)
	sw t1,  2*4(sp)
  74:	302e                	fld	ft0,232(sp)
  76:	312d                	jal	fffffca0 <_fstack+0xeffff280>
	sw t2,  3*4(sp)
  78:	312e                	fld	ft2,232(sp)
  7a:	7369722f          	0x7369722f
	sw a0,  4*4(sp)
  7e:	6e2d7663          	bgeu	s10,sp,76a <_sidata+0x42a>
	sw a1,  5*4(sp)
  82:	2d656e6f          	jal	t3,56358 <_Min_Stack_Size+0x55b58>
	sw a2,  6*4(sp)
  86:	6d65                	lui	s10,0x19
	sw a3,  7*4(sp)
  88:	6562                	flw	fa0,24(sp)
  8a:	2f64                	fld	fs1,216(a4)
	sw a4,  8*4(sp)
  8c:	6e69                	lui	t3,0x1a
  8e:	64756c63          	bltu	a0,t2,6e6 <_sidata+0x3a6>
	sw a5,  9*4(sp)
  92:	2f65                	jal	84a <_Min_Stack_Size+0x4a>
	sw a6, 10*4(sp)
  94:	616d                	addi	sp,sp,240
  96:	6e696863          	bltu	s2,t1,786 <_sidata+0x446>
	sw a7, 11*4(sp)
  9a:	0065                	c.nop	25
	sw t3, 12*4(sp)
  9c:	64656d2f          	0x64656d2f
	sw t4, 13*4(sp)
  a0:	6169                	addi	sp,sp,208
  a2:	6d63742f          	0x6d63742f
	sw t5, 14*4(sp)
  a6:	6369                	lui	t1,0x1a
	sw t6, 15*4(sp)
  a8:	6168                	flw	fa0,68(a0)
  aa:	736c                	flw	fa1,100(a4)
	call isr
  ac:	726f572f          	0x726f572f
  b0:	676e696b          	0x676e696b
	lw ra,  0*4(sp)
  b4:	6379632f          	0x6379632f
	lw t0,  1*4(sp)
  b8:	6f6c                	flw	fa1,92(a4)
  ba:	656e                	flw	fa0,216(sp)
	lw t1,  2*4(sp)
  bc:	312d                	jal	fffffce6 <_fstack+0xeffff2c6>
  be:	2f30                	fld	fa2,88(a4)
	lw t2,  3*4(sp)
  c0:	31637963          	bgeu	t1,s6,3d2 <_sidata+0x92>
	lw a0,  4*4(sp)
  c4:	3030                	fld	fa2,96(s0)
  c6:	2f30                	fld	fa2,88(a4)
	lw a1,  5*4(sp)
  c8:	6972                	flw	fs2,28(sp)
  ca:	2d766373          	csrrsi	t1,0x2d7,12
	lw a2,  6*4(sp)
  ce:	2f636367          	0x2f636367
	lw a3,  7*4(sp)
  d2:	6972                	flw	fs2,28(sp)
	lw a4,  8*4(sp)
  d4:	2d766373          	csrrsi	t1,0x2d7,12
	lw a5,  9*4(sp)
  d8:	6f6e                	flw	ft10,216(sp)
  da:	656e                	flw	fa0,216(sp)
	lw a6, 10*4(sp)
  dc:	652d                	lui	a0,0xb
  de:	626d                	lui	tp,0x1b
	lw a7, 11*4(sp)
  e0:	6465                	lui	s0,0x19
  e2:	672d                	lui	a4,0xb
	lw t3, 12*4(sp)
  e4:	382f6363          	bltu	t5,sp,46a <_sidata+0x12a>
	lw t4, 13*4(sp)
  e8:	332e                	fld	ft6,232(sp)
  ea:	302e                	fld	ft0,232(sp)
	lw t5, 14*4(sp)
  ec:	312d                	jal	fffffd16 <_fstack+0xeffff2f6>
  ee:	312e                	fld	ft2,232(sp)
	lw t6, 15*4(sp)
  f0:	62696c2f          	0x62696c2f
	addi sp, sp, 16*4
  f4:	6363672f          	0x6363672f
	mret
  f8:	7369722f          	0x7369722f
  fc:	6e2d7663          	bgeu	s10,sp,7e8 <_sidata+0x4a8>
 100:	2d656e6f          	jal	t3,563d6 <_Min_Stack_Size+0x55bd6>
 104:	6d65                	lui	s10,0x19
 106:	6562                	flw	fa0,24(sp)
 108:	2f64                	fld	fs1,216(a4)
 10a:	2e38                	fld	fa4,88(a2)
 10c:	2f302e33          	0x2f302e33
 110:	6e69                	lui	t3,0x1a
 112:	64756c63          	bltu	a0,t2,76a <_sidata+0x42a>
 116:	0065                	c.nop	25
 118:	64656d2f          	0x64656d2f
 11c:	6169                	addi	sp,sp,208
 11e:	6d63742f          	0x6d63742f
 122:	6369                	lui	t1,0x1a
 124:	6168                	flw	fa0,68(a0)
 126:	736c                	flw	fa1,100(a4)
 128:	726f572f          	0x726f572f
 12c:	676e696b          	0x676e696b
 130:	6379632f          	0x6379632f
 134:	6f6c                	flw	fa1,92(a4)
 136:	656e                	flw	fa0,216(sp)
 138:	312d                	jal	fffffd62 <_fstack+0xeffff342>
 13a:	2f30                	fld	fa2,88(a4)
 13c:	31637963          	bgeu	t1,s6,44e <_sidata+0x10e>
 140:	3030                	fld	fa2,96(s0)
 142:	2f30                	fld	fa2,88(a4)
 144:	6972                	flw	fs2,28(sp)
 146:	2d766373          	csrrsi	t1,0x2d7,12
 14a:	2f636367          	0x2f636367
 14e:	6972                	flw	fs2,28(sp)
 150:	2d766373          	csrrsi	t1,0x2d7,12
 154:	6f6e                	flw	ft10,216(sp)
 156:	656e                	flw	fa0,216(sp)
 158:	652d                	lui	a0,0xb
 15a:	626d                	lui	tp,0x1b
 15c:	6465                	lui	s0,0x19
 15e:	672d                	lui	a4,0xb
 160:	382f6363          	bltu	t5,sp,4e6 <_sidata+0x1a6>
 164:	332e                	fld	ft6,232(sp)
 166:	302e                	fld	ft0,232(sp)
 168:	312d                	jal	fffffd92 <_fstack+0xeffff372>
 16a:	312e                	fld	ft2,232(sp)
 16c:	7369722f          	0x7369722f
 170:	6e2d7663          	bgeu	s10,sp,85c <_Min_Stack_Size+0x5c>
 174:	2d656e6f          	jal	t3,5644a <_Min_Stack_Size+0x55c4a>
 178:	6d65                	lui	s10,0x19
 17a:	6562                	flw	fa0,24(sp)
 17c:	2f64                	fld	fs1,216(a4)
 17e:	6e69                	lui	t3,0x1a
 180:	64756c63          	bltu	a0,t2,7d8 <_sidata+0x498>
 184:	2f65                	jal	93c <_Min_Stack_Size+0x13c>
 186:	00737973          	csrrci	s2,0x7,6
 18a:	64656d2f          	0x64656d2f
 18e:	6169                	addi	sp,sp,208
 190:	6d63742f          	0x6d63742f
 194:	6369                	lui	t1,0x1a
 196:	6168                	flw	fa0,68(a0)
 198:	736c                	flw	fa1,100(a4)
 19a:	726f572f          	0x726f572f
 19e:	676e696b          	0x676e696b
 1a2:	6379632f          	0x6379632f
 1a6:	6f6c                	flw	fa1,92(a4)
 1a8:	656e                	flw	fa0,216(sp)
 1aa:	312d                	jal	fffffdd4 <_fstack+0xeffff3b4>
 1ac:	2f30                	fld	fa2,88(a4)
 1ae:	31637963          	bgeu	t1,s6,4c0 <_sidata+0x180>
 1b2:	3030                	fld	fa2,96(s0)
 1b4:	2f30                	fld	fa2,88(a4)
 1b6:	6972                	flw	fs2,28(sp)
 1b8:	2d766373          	csrrsi	t1,0x2d7,12
 1bc:	2f636367          	0x2f636367
 1c0:	6972                	flw	fs2,28(sp)
 1c2:	2d766373          	csrrsi	t1,0x2d7,12
 1c6:	6f6e                	flw	ft10,216(sp)
 1c8:	656e                	flw	fa0,216(sp)
 1ca:	652d                	lui	a0,0xb
 1cc:	626d                	lui	tp,0x1b
 1ce:	6465                	lui	s0,0x19
 1d0:	672d                	lui	a4,0xb
 1d2:	382f6363          	bltu	t5,sp,558 <_sidata+0x218>
 1d6:	332e                	fld	ft6,232(sp)
 1d8:	302e                	fld	ft0,232(sp)
 1da:	312d                	jal	fffffe04 <_fstack+0xeffff3e4>
 1dc:	312e                	fld	ft2,232(sp)
 1de:	7369722f          	0x7369722f
 1e2:	6e2d7663          	bgeu	s10,sp,8ce <_Min_Stack_Size+0xce>
 1e6:	2d656e6f          	jal	t3,564bc <_Min_Stack_Size+0x55cbc>
 1ea:	6d65                	lui	s10,0x19
 1ec:	6562                	flw	fa0,24(sp)
 1ee:	2f64                	fld	fs1,216(a4)
 1f0:	6e69                	lui	t3,0x1a
 1f2:	64756c63          	bltu	a0,t2,84a <_Min_Stack_Size+0x4a>
 1f6:	2f65                	jal	9ae <_Min_Stack_Size+0x1ae>
 1f8:	2f2b2b63          	0x2f2b2b63
 1fc:	2e38                	fld	fa4,88(a2)
 1fe:	00302e33          	sgtz	t3,gp
 202:	64656d2f          	0x64656d2f
 206:	6169                	addi	sp,sp,208
 208:	6d63742f          	0x6d63742f
 20c:	6369                	lui	t1,0x1a
 20e:	6168                	flw	fa0,68(a0)
 210:	736c                	flw	fa1,100(a4)
 212:	726f572f          	0x726f572f
 216:	676e696b          	0x676e696b
 21a:	6379632f          	0x6379632f
 21e:	6f6c                	flw	fa1,92(a4)
 220:	656e                	flw	fa0,216(sp)
 222:	312d                	jal	fffffe4c <_fstack+0xeffff42c>
 224:	2f30                	fld	fa2,88(a4)
 226:	31637963          	bgeu	t1,s6,538 <_sidata+0x1f8>
 22a:	3030                	fld	fa2,96(s0)
 22c:	2f30                	fld	fa2,88(a4)
 22e:	6972                	flw	fs2,28(sp)
 230:	2d766373          	csrrsi	t1,0x2d7,12
 234:	2f636367          	0x2f636367
 238:	6972                	flw	fs2,28(sp)
 23a:	2d766373          	csrrsi	t1,0x2d7,12
 23e:	6f6e                	flw	ft10,216(sp)
 240:	656e                	flw	fa0,216(sp)
 242:	652d                	lui	a0,0xb
 244:	626d                	lui	tp,0x1b
 246:	6465                	lui	s0,0x19
 248:	672d                	lui	a4,0xb
 24a:	382f6363          	bltu	t5,sp,5d0 <_sidata+0x290>
 24e:	332e                	fld	ft6,232(sp)
 250:	302e                	fld	ft0,232(sp)
 252:	312d                	jal	fffffe7c <_fstack+0xeffff45c>
 254:	312e                	fld	ft2,232(sp)
 256:	7369722f          	0x7369722f
 25a:	6e2d7663          	bgeu	s10,sp,946 <_Min_Stack_Size+0x146>
 25e:	2d656e6f          	jal	t3,56534 <_Min_Stack_Size+0x55d34>
 262:	6d65                	lui	s10,0x19
 264:	6562                	flw	fa0,24(sp)
 266:	2f64                	fld	fs1,216(a4)
 268:	6e69                	lui	t3,0x1a
 26a:	64756c63          	bltu	a0,t2,8c2 <_Min_Stack_Size+0xc2>
 26e:	2f65                	jal	a26 <_Min_Stack_Size+0x226>
 270:	2f2b2b63          	0x2f2b2b63
 274:	2e38                	fld	fa4,88(a2)
 276:	2f302e33          	0x2f302e33
 27a:	6972                	flw	fs2,28(sp)
 27c:	2d766373          	csrrsi	t1,0x2d7,12
 280:	6f6e                	flw	ft10,216(sp)
 282:	656e                	flw	fa0,216(sp)
 284:	652d                	lui	a0,0xb
 286:	626d                	lui	tp,0x1b
 288:	6465                	lui	s0,0x19
 28a:	3376722f          	0x3376722f
			GPIO_SET_TOGGLE_REG  = LED_0;
 28e:	6932                	flw	fs2,12(sp)
 290:	706c692f          	0x706c692f
{
 294:	622f3233          	0x622f3233
 298:	7469                	lui	s0,0xffffa
 29a:	6d2f0073          	0x6d2f0073
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
 29e:	6465                	lui	s0,0x19
			GPIO_SET_TOGGLE_REG  = LED_0;
 2a0:	6169                	addi	sp,sp,208
 2a2:	6d63742f          	0x6d63742f
	}
 2a6:	6369                	lui	t1,0x1a
	for( ;; );
 2a8:	6168                	flw	fa0,68(a0)
 2aa:	736c                	flw	fa1,100(a4)
}
 2ac:	726f572f          	0x726f572f
 2b0:	676e696b          	0x676e696b
 2b4:	6379632f          	0x6379632f
 2b8:	6f6c                	flw	fa1,92(a4)
 2ba:	656e                	flw	fa0,216(sp)
 2bc:	312d                	jal	fffffee6 <_fstack+0xeffff4c6>
 2be:	2f30                	fld	fa2,88(a4)
 2c0:	31637963          	bgeu	t1,s6,5d2 <_sidata+0x292>
 2c4:	3030                	fld	fa2,96(s0)
 2c6:	2f30                	fld	fa2,88(a4)
 2c8:	6972                	flw	fs2,28(sp)
 2ca:	2d766373          	csrrsi	t1,0x2d7,12
 2ce:	2f636367          	0x2f636367
 2d2:	6972                	flw	fs2,28(sp)
 2d4:	2d766373          	csrrsi	t1,0x2d7,12
 2d8:	6f6e                	flw	ft10,216(sp)
 2da:	656e                	flw	fa0,216(sp)
 2dc:	652d                	lui	a0,0xb
 2de:	626d                	lui	tp,0x1b
 2e0:	6465                	lui	s0,0x19
 2e2:	672d                	lui	a4,0xb
 2e4:	382f6363          	bltu	t5,sp,66a <_sidata+0x32a>
 2e8:	332e                	fld	ft6,232(sp)
 2ea:	302e                	fld	ft0,232(sp)
 2ec:	312d                	jal	ffffff16 <_fstack+0xeffff4f6>
 2ee:	312e                	fld	ft2,232(sp)
 2f0:	7369722f          	0x7369722f
 2f4:	6e2d7663          	bgeu	s10,sp,9e0 <_Min_Stack_Size+0x1e0>
 2f8:	2d656e6f          	jal	t3,565ce <_Min_Stack_Size+0x55dce>
 2fc:	6d65                	lui	s10,0x19
 2fe:	6562                	flw	fa0,24(sp)
 300:	2f64                	fld	fs1,216(a4)
 302:	6e69                	lui	t3,0x1a
 304:	64756c63          	bltu	a0,t2,95c <_Min_Stack_Size+0x15c>
 308:	0065                	c.nop	25
 30a:	6d00                	flw	fs0,24(a0)
 30c:	6961                	lui	s2,0x18
 30e:	2e6e                	fld	ft8,216(sp)
 310:	00707063          	bgeu	zero,t2,310 <__libc_init_array+0x60>
 314:	0001                	nop
 316:	5f00                	lw	s0,56(a4)
 318:	6564                	flw	fs1,76(a0)
 31a:	6166                	flw	ft2,88(sp)
 31c:	6c75                	lui	s8,0x1d
 31e:	5f74                	lw	a3,124(a4)
 320:	7974                	flw	fa3,116(a0)
 322:	6570                	flw	fa2,76(a0)
 324:	00682e73          	csrrs	t3,0x6,a6
 328:	0002                	c.slli64	zero
 32a:	7300                	flw	fs0,32(a4)
 32c:	6474                	flw	fa3,76(s0)
 32e:	6564                	flw	fs1,76(a0)
 330:	2e66                	fld	ft8,88(sp)
 332:	0068                	addi	a0,sp,12
 334:	5f000003          	lb	zero,1520(zero) # 5f0 <_sidata+0x2b0>
 338:	7974                	flw	fa3,116(a0)
 33a:	6570                	flw	fa2,76(a0)
 33c:	00682e73          	csrrs	t3,0x6,a6
 340:	0004                	0x4
 342:	7200                	flw	fs0,32(a2)
 344:	6565                	lui	a0,0x19
 346:	746e                	flw	fs0,248(sp)
 348:	682e                	flw	fa6,200(sp)
 34a:	0400                	addi	s0,sp,512
 34c:	0000                	unimp
 34e:	6f6c                	flw	fa1,92(a4)
 350:	682e6b63          	bltu	t3,sp,9e6 <_Min_Stack_Size+0x1e6>
 354:	0400                	addi	s0,sp,512
 356:	0000                	unimp
 358:	735f 6474 6e69      	0x6e696474735f
 35e:	2e74                	fld	fa3,216(a2)
 360:	0068                	addi	a0,sp,12
 362:	0004                	0x4
 364:	6300                	flw	fs0,0(a4)
 366:	69647473          	csrrci	s0,0x696,8
 36a:	746e                	flw	fs0,248(sp)
 36c:	0500                	addi	s0,sp,640
 36e:	0000                	unimp
 370:	632b2b63          	0x632b2b63
 374:	69666e6f          	jal	t3,66a0a <_Min_Stack_Size+0x6620a>
 378:	00682e67          	0x682e67
 37c:	0006                	c.slli	zero,0x1
 37e:	7300                	flw	fs0,32(a4)
 380:	6474                	flw	fa3,76(s0)
 382:	6e69                	lui	t3,0x1a
 384:	2e74                	fld	fa3,216(a2)
 386:	0068                	addi	a0,sp,12
 388:	3c000007          	0x3c000007
 38c:	7562                	flw	fa0,56(sp)
 38e:	6c69                	lui	s8,0x1a
 390:	2d74                	fld	fa3,216(a0)
 392:	6e69                	lui	t3,0x1a
 394:	003e                	c.slli	zero,0xf
 396:	0000                	unimp
 398:	0000                	unimp
 39a:	0105                	addi	sp,sp,1
 39c:	0500                	addi	s0,sp,640
 39e:	8002                	0x8002
 3a0:	0002                	c.slli64	zero
 3a2:	0300                	addi	s0,sp,384
 3a4:	010d                	addi	sp,sp,3
 3a6:	0205                	addi	tp,tp,1
 3a8:	00090103          	lb	sp,0(s2) # 18000 <_Min_Stack_Size+0x17800>
 3ac:	0100                	addi	s0,sp,128
 3ae:	00090103          	lb	sp,0(s2)
 3b2:	0100                	addi	s0,sp,128
 3b4:	00090203          	lb	tp,0(s2)
 3b8:	0100                	addi	s0,sp,128
 3ba:	1705                	addi	a4,a4,-31
 3bc:	0306                	slli	t1,t1,0x1
 3be:	0900                	addi	s0,sp,144
 3c0:	0000                	unimp
 3c2:	0501                	addi	a0,a0,0
 3c4:	0319                	addi	t1,t1,6
 3c6:	0904                	addi	s1,sp,144
 3c8:	000c                	0xc
 3ca:	0501                	addi	a0,a0,0
 3cc:	0602                	c.slli64	a2
 3ce:	08097d03          	0x8097d03
 3d2:	0100                	addi	s0,sp,128
 3d4:	0305                	addi	t1,t1,1
 3d6:	00090203          	lb	tp,0(s2)
 3da:	0100                	addi	s0,sp,128
 3dc:	0105                	addi	sp,sp,1
 3de:	0306                	slli	t1,t1,0x1
 3e0:	0979                	addi	s2,s2,30
 3e2:	0000                	unimp
 3e4:	0501                	addi	a0,a0,0
 3e6:	0022                	c.slli	zero,0x8
 3e8:	0402                	c.slli64	s0
 3ea:	0302                	c.slli64	t1
 3ec:	00080907          	0x80907
 3f0:	0501                	addi	a0,a0,0
 3f2:	0604                	addi	s1,sp,768
 3f4:	04090103          	lb	sp,64(s2)
 3f8:	0100                	addi	s0,sp,128
 3fa:	1905                	addi	s2,s2,-31
 3fc:	0306                	slli	t1,t1,0x1
 3fe:	0900                	addi	s0,sp,144
 400:	0000                	unimp
 402:	0501                	addi	a0,a0,0
 404:	0302                	c.slli64	t1
 406:	0901                	addi	s2,s2,0
 408:	0004                	0x4
 40a:	0901                	addi	s2,s2,0
 40c:	0004                	0x4
 40e:	0100                	addi	s0,sp,128
 410:	0501                	addi	a0,a0,0
 412:	0001                	nop
 414:	0205                	addi	tp,tp,1
 416:	02a8                	addi	a0,sp,328
 418:	0000                	unimp
 41a:	05011c03          	lh	s8,80(sp)
 41e:	0002                	c.slli64	zero
 420:	0402                	c.slli64	s0
 422:	0301                	addi	t1,t1,0
 424:	0901                	addi	s2,s2,0
 426:	0000                	unimp
 428:	0001                	nop
 42a:	0402                	c.slli64	s0
 42c:	0301                	addi	t1,t1,0
 42e:	0901                	addi	s2,s2,0
 430:	0000                	unimp
 432:	0901                	addi	s2,s2,0
 434:	0004                	0x4
 436:	0100                	addi	s0,sp,128
 438:	0501                	addi	a0,a0,0
 43a:	0001                	nop
 43c:	0205                	addi	tp,tp,1
 43e:	02ac                	addi	a1,sp,328
 440:	0000                	unimp
 442:	06012403          	lw	s0,96(sp)
 446:	00090203          	lb	tp,0(s2)
 44a:	0100                	addi	s0,sp,128
 44c:	0409                	addi	s0,s0,2
 44e:	0000                	unimp
 450:	0101                	addi	sp,sp,0
 452:	00000177          	0x177
 456:	001d0003          	lb	zero,1(s10) # 19001 <_Min_Stack_Size+0x18801>
 45a:	0000                	unimp
 45c:	0101                	addi	sp,sp,0
 45e:	000d0efb          	0xd0efb
 462:	0101                	addi	sp,sp,0
 464:	0101                	addi	sp,sp,0
 466:	0000                	unimp
 468:	0100                	addi	s0,sp,128
 46a:	0000                	unimp
 46c:	0001                	nop
 46e:	30747263          	bgeu	s0,t2,772 <_sidata+0x432>
 472:	532e                	lw	t1,232(sp)
 474:	0000                	unimp
 476:	0000                	unimp
 478:	0000                	unimp
 47a:	0205                	addi	tp,tp,1
 47c:	0000                	unimp
 47e:	0000                	unimp
 480:	03010903          	lb	s2,48(sp)
 484:	0905                	addi	s2,s2,1
 486:	0004                	0x4
 488:	0301                	addi	t1,t1,0
 48a:	0904                	addi	s1,sp,144
 48c:	0004                	0x4
 48e:	0301                	addi	t1,t1,0
 490:	00080903          	lb	s2,0(a6) # fffe1000 <_fstack+0xeffe05e0>
 494:	0301                	addi	t1,t1,0
 496:	0901                	addi	s2,s2,0
 498:	0008                	0x8
 49a:	0301                	addi	t1,t1,0
 49c:	0901                	addi	s2,s2,0
 49e:	0004                	0x4
 4a0:	0301                	addi	t1,t1,0
 4a2:	0902                	c.slli64	s2
 4a4:	0004                	0x4
 4a6:	0301                	addi	t1,t1,0
 4a8:	0901                	addi	s2,s2,0
 4aa:	0008                	0x8
 4ac:	0301                	addi	t1,t1,0
 4ae:	00040903          	lb	s2,0(s0) # 19000 <_Min_Stack_Size+0x18800>
 4b2:	0301                	addi	t1,t1,0
 4b4:	0901                	addi	s2,s2,0
 4b6:	0008                	0x8
 4b8:	0301                	addi	t1,t1,0
 4ba:	0901                	addi	s2,s2,0
 4bc:	0008                	0x8
 4be:	0301                	addi	t1,t1,0
 4c0:	0901                	addi	s2,s2,0
 4c2:	0008                	0x8
 4c4:	0301                	addi	t1,t1,0
 4c6:	0902                	c.slli64	s2
 4c8:	0004                	0x4
 4ca:	0301                	addi	t1,t1,0
 4cc:	0901                	addi	s2,s2,0
 4ce:	0004                	0x4
 4d0:	0301                	addi	t1,t1,0
 4d2:	0901                	addi	s2,s2,0
 4d4:	0004                	0x4
 4d6:	0301                	addi	t1,t1,0
 4d8:	0901                	addi	s2,s2,0
 4da:	0004                	0x4
 4dc:	0301                	addi	t1,t1,0
 4de:	0901                	addi	s2,s2,0
 4e0:	0004                	0x4
 4e2:	0301                	addi	t1,t1,0
 4e4:	00040903          	lb	s2,0(s0)
 4e8:	0301                	addi	t1,t1,0
 4ea:	0901                	addi	s2,s2,0
 4ec:	0008                	0x8
 4ee:	0301                	addi	t1,t1,0
 4f0:	00040903          	lb	s2,0(s0)
 4f4:	0301                	addi	t1,t1,0
 4f6:	0901                	addi	s2,s2,0
 4f8:	0004                	0x4
 4fa:	0301                	addi	t1,t1,0
 4fc:	0901                	addi	s2,s2,0
 4fe:	0004                	0x4
 500:	0301                	addi	t1,t1,0
 502:	0901                	addi	s2,s2,0
 504:	0004                	0x4
 506:	0301                	addi	t1,t1,0
 508:	0901                	addi	s2,s2,0
 50a:	0004                	0x4
 50c:	0301                	addi	t1,t1,0
 50e:	0901                	addi	s2,s2,0
 510:	0004                	0x4
 512:	0301                	addi	t1,t1,0
 514:	0901                	addi	s2,s2,0
 516:	0004                	0x4
 518:	0301                	addi	t1,t1,0
 51a:	0901                	addi	s2,s2,0
 51c:	0004                	0x4
 51e:	0301                	addi	t1,t1,0
 520:	0901                	addi	s2,s2,0
 522:	0004                	0x4
 524:	0301                	addi	t1,t1,0
 526:	0901                	addi	s2,s2,0
 528:	0004                	0x4
 52a:	0301                	addi	t1,t1,0
 52c:	0901                	addi	s2,s2,0
 52e:	0004                	0x4
 530:	0301                	addi	t1,t1,0
 532:	0901                	addi	s2,s2,0
 534:	0004                	0x4
 536:	0301                	addi	t1,t1,0
 538:	0901                	addi	s2,s2,0
 53a:	0004                	0x4
 53c:	0301                	addi	t1,t1,0
 53e:	0901                	addi	s2,s2,0
 540:	0004                	0x4
 542:	0301                	addi	t1,t1,0
 544:	0901                	addi	s2,s2,0
 546:	0004                	0x4
 548:	0301                	addi	t1,t1,0
 54a:	0901                	addi	s2,s2,0
 54c:	0004                	0x4
 54e:	0301                	addi	t1,t1,0
 550:	0901                	addi	s2,s2,0
 552:	0004                	0x4
 554:	0301                	addi	t1,t1,0
 556:	0901                	addi	s2,s2,0
 558:	0004                	0x4
 55a:	0301                	addi	t1,t1,0
 55c:	0901                	addi	s2,s2,0
 55e:	0008                	0x8
 560:	0301                	addi	t1,t1,0
 562:	0901                	addi	s2,s2,0
 564:	0004                	0x4
 566:	0301                	addi	t1,t1,0
 568:	0901                	addi	s2,s2,0
 56a:	0004                	0x4
 56c:	0301                	addi	t1,t1,0
 56e:	0901                	addi	s2,s2,0
 570:	0004                	0x4
 572:	0301                	addi	t1,t1,0
 574:	0901                	addi	s2,s2,0
 576:	0004                	0x4
 578:	0301                	addi	t1,t1,0
 57a:	0901                	addi	s2,s2,0
 57c:	0004                	0x4
 57e:	0301                	addi	t1,t1,0
 580:	0901                	addi	s2,s2,0
 582:	0004                	0x4
 584:	0301                	addi	t1,t1,0
 586:	0901                	addi	s2,s2,0
 588:	0004                	0x4
 58a:	0301                	addi	t1,t1,0
 58c:	0901                	addi	s2,s2,0
 58e:	0004                	0x4
 590:	0301                	addi	t1,t1,0
 592:	0901                	addi	s2,s2,0
 594:	0004                	0x4
 596:	0301                	addi	t1,t1,0
 598:	0901                	addi	s2,s2,0
 59a:	0004                	0x4
 59c:	0301                	addi	t1,t1,0
 59e:	0901                	addi	s2,s2,0
 5a0:	0004                	0x4
 5a2:	0301                	addi	t1,t1,0
 5a4:	0901                	addi	s2,s2,0
 5a6:	0004                	0x4
 5a8:	0301                	addi	t1,t1,0
 5aa:	0901                	addi	s2,s2,0
 5ac:	0004                	0x4
 5ae:	0301                	addi	t1,t1,0
 5b0:	0901                	addi	s2,s2,0
 5b2:	0004                	0x4
 5b4:	0301                	addi	t1,t1,0
 5b6:	0901                	addi	s2,s2,0
 5b8:	0004                	0x4
 5ba:	0301                	addi	t1,t1,0
 5bc:	0901                	addi	s2,s2,0
 5be:	0004                	0x4
 5c0:	0301                	addi	t1,t1,0
 5c2:	0901                	addi	s2,s2,0
 5c4:	0004                	0x4
 5c6:	0901                	addi	s2,s2,0
 5c8:	0004                	0x4
 5ca:	0100                	addi	s0,sp,128
 5cc:	01              	Address 0x00000000000005cc is out of bounds.


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
  38:	745f 3100 5f30      	0x5f303100745f
	la a2, _edata  /* end */
  3e:	626d                	lui	tp,0x1b
  40:	74617473          	csrrci	s0,0x746,2
	beq	a1,a2, DONE
  44:	5f65                	li	t5,-7
  46:	0074                	addi	a3,sp,12
	lw	t0, (a0)
  48:	645f 7461 0061      	0x617461645f
	sw t0, (a1)
  4e:	775f 7263 6f74      	0x6f747263775f
	addi a1,a2,4
  54:	626d                	lui	tp,0x1b
  56:	735f 6174 6574      	0x65746174735f
	call _start
  5c:	5f00                	lw	s0,56(a4)
  5e:	6e676973          	csrrsi	s2,0x6e6,14
  62:	6c61                	lui	s8,0x18
LOOP:	j LOOP
  64:	625f 6675 6c00      	0x6c006675625f
	addi sp, sp, -16*4
  6a:	20676e6f          	jal	t3,76270 <_Min_Stack_Size+0x75a70>
	sw ra,  0*4(sp)
  6e:	6f6c                	flw	fa1,92(a4)
	sw t0,  1*4(sp)
  70:	676e                	flw	fa4,216(sp)
  72:	7520                	flw	fs0,104(a0)
	sw t1,  2*4(sp)
  74:	736e                	flw	ft6,248(sp)
  76:	6769                	lui	a4,0x1a
	sw t2,  3*4(sp)
  78:	656e                	flw	fa0,216(sp)
  7a:	2064                	fld	fs1,192(s0)
	sw a0,  4*4(sp)
  7c:	6e69                	lui	t3,0x1a
  7e:	0074                	addi	a3,sp,12
	sw a1,  5*4(sp)
  80:	6c5f 6662 6973      	0x697366626c5f
	sw a2,  6*4(sp)
  86:	657a                	flw	fa0,156(sp)
	sw a3,  7*4(sp)
  88:	5f00                	lw	s0,56(a4)
  8a:	695f 746e 3436      	0x3436746e695f
	sw a5,  9*4(sp)
  90:	745f 5f00 6c5f      	0x6c5f5f00745f
	sw a6, 10*4(sp)
  96:	6c61636f          	jal	t1,1675c <_Min_Stack_Size+0x15f5c>
	sw a7, 11*4(sp)
  9a:	5f65                	li	t5,-7
	sw t3, 12*4(sp)
  9c:	0074                	addi	a3,sp,12
  9e:	5f5f 6e69 3874      	0x38746e695f5f
	sw t5, 14*4(sp)
  a4:	745f 5f00 626d      	0x626d5f00745f
	sw t6, 15*4(sp)
  aa:	7472                	flw	fs0,60(sp)
	call isr
  ac:	5f63776f          	jal	a4,376a2 <_Min_Stack_Size+0x36ea2>
  b0:	74617473          	csrrci	s0,0x746,2
	lw ra,  0*4(sp)
  b4:	0065                	c.nop	25
  b6:	5f5f 6e69 5f74      	0x5f746e695f5f
	lw t1,  2*4(sp)
  bc:	656c                	flw	fa1,76(a0)
  be:	7361                	lui	t1,0xffff8
	lw t2,  3*4(sp)
  c0:	3674                	fld	fa3,232(a2)
  c2:	5f34                	lw	a3,120(a4)
	lw a0,  4*4(sp)
  c4:	0074                	addi	a3,sp,12
  c6:	5f5f 6d74 735f      	0x735f6d745f5f
	lw a2,  6*4(sp)
  cc:	6365                	lui	t1,0x19
  ce:	6c00                	flw	fs0,24(s0)
	lw a3,  7*4(sp)
  d0:	20676e6f          	jal	t3,762d6 <_Min_Stack_Size+0x75ad6>
	lw a4,  8*4(sp)
  d4:	6f6c                	flw	fa1,92(a4)
  d6:	676e                	flw	fa4,216(sp)
	lw a5,  9*4(sp)
  d8:	6920                	flw	fs0,80(a0)
  da:	746e                	flw	fs0,248(sp)
	lw a6, 10*4(sp)
  dc:	5f00                	lw	s0,56(a4)
  de:	6275                	lui	tp,0x1d
	lw a7, 11*4(sp)
  e0:	6675                	lui	a2,0x1d
  e2:	5f00                	lw	s0,56(a4)
	lw t3, 12*4(sp)
  e4:	6162                	flw	ft2,24(sp)
  e6:	75006573          	csrrsi	a0,0x750,0
	lw t4, 13*4(sp)
  ea:	6e69                	lui	t3,0x1a
	lw t5, 14*4(sp)
  ec:	5f74                	lw	a3,124(a4)
  ee:	6166                	flw	ft2,88(sp)
	lw t6, 15*4(sp)
  f0:	34367473          	csrrci	s0,mtval,12
	addi sp, sp, 16*4
  f4:	745f 5f00 745f      	0x745f5f00745f
	mret
  fa:	5f6d                	li	t5,-5
  fc:	6f68                	flw	fa0,92(a4)
  fe:	7275                	lui	tp,0xffffd
 100:	5f00                	lw	s0,56(a4)
 102:	735f 0066 6f5f      	0x6f5f0066735f
 108:	5f6e                	lw	t5,248(sp)
 10a:	7865                	lui	a6,0xffff9
 10c:	7469                	lui	s0,0xffffa
 10e:	615f 6772 0073      	0x736772615f
 114:	635f 6f6f 696b      	0x696b6f6f635f
 11a:	0065                	c.nop	25
 11c:	5f5f 6773 756c      	0x756c67735f5f
 122:	0065                	c.nop	25
 124:	665f 616c 7367      	0x7367616c665f
 12a:	5f00                	lw	s0,56(a4)
 12c:	7369                	lui	t1,0xffffa
 12e:	635f 6178 5f00      	0x5f006178635f
 134:	69647473          	csrrci	s0,0x696,8
 138:	006e                	c.slli	zero,0x1b
 13a:	5f5f 6e67 5f75      	0x5f756e675f5f
 140:	00787863          	bgeu	a6,t2,150 <memset+0x1c>
 144:	625f 6b6c 6973      	0x69736b6c625f
 14a:	657a                	flw	fa0,156(sp)
 14c:	5f00                	lw	s0,56(a4)
 14e:	62747663          	bgeu	s0,t2,77a <_sidata+0x43a>
 152:	6675                	lui	a2,0x1d
 154:	5f00                	lw	s0,56(a4)
 156:	7366666f          	jal	a2,6688c <_Min_Stack_Size+0x6608c>
 15a:	7465                	lui	s0,0xffff9
 15c:	5f00                	lw	s0,56(a4)
 15e:	626d                	lui	tp,0x1b
 160:	6f747273          	csrrci	tp,0x6f7,8
 164:	5f736377          	0x5f736377
 168:	74617473          	csrrci	s0,0x746,2
 16c:	0065                	c.nop	25
 16e:	6d5f 7262 656c      	0x656c72626d5f
 174:	5f6e                	lw	t5,248(sp)
 176:	74617473          	csrrci	s0,0x746,2
 17a:	0065                	c.nop	25
 17c:	665f 616e 6772      	0x6772616e665f
 182:	665f0073          	0x665f0073
 186:	736e                	flw	ft6,248(sp)
 188:	5f00                	lw	s0,56(a4)
 18a:	755f 6e69 3374      	0x33746e69755f
 190:	5f32                	lw	t5,44(sp)
 192:	0074                	addi	a3,sp,12
 194:	5f5f 6e69 7074      	0x70746e695f5f
 19a:	7274                	flw	fa3,100(a2)
 19c:	745f 5f00 755f      	0x755f5f00745f
 1a2:	6e69                	lui	t3,0x1a
 1a4:	5f74                	lw	a3,124(a4)
 1a6:	656c                	flw	fa1,76(a0)
 1a8:	7361                	lui	t1,0xffff8
 1aa:	3874                	fld	fa3,240(s0)
 1ac:	745f 4700 554e      	0x554e4700745f
 1b2:	4320                	lw	s0,64(a4)
 1b4:	37312b2b          	0x37312b2b
 1b8:	3820                	fld	fs0,112(s0)
 1ba:	332e                	fld	ft6,232(sp)
 1bc:	302e                	fld	ft0,232(sp)
 1be:	2d20                	fld	fs0,88(a0)
 1c0:	616d                	addi	sp,sp,240
 1c2:	6372                	flw	ft6,28(sp)
 1c4:	3d68                	fld	fa0,248(a0)
 1c6:	7672                	flw	fa2,60(sp)
 1c8:	20693233          	0x20693233
 1cc:	6d2d                	lui	s10,0xb
 1ce:	6261                	lui	tp,0x18
 1d0:	3d69                	jal	6a <trap_vector+0x16>
 1d2:	6c69                	lui	s8,0x1a
 1d4:	3370                	fld	fa2,224(a4)
 1d6:	2032                	fld	ft0,264(sp)
 1d8:	672d                	lui	a4,0xb
 1da:	20626467          	0x20626467
 1de:	4f2d                	li	t5,11
 1e0:	732d2073          	csrs	0x732,s10
 1e4:	6474                	flw	fa3,76(s0)
 1e6:	633d                	lui	t1,0xf
 1e8:	61322b2b          	0x61322b2b
 1ec:	2d20                	fld	fs0,88(a0)
 1ee:	6466                	flw	fs0,88(sp)
 1f0:	7461                	lui	s0,0xffff8
 1f2:	2d61                	jal	88a <_Min_Stack_Size+0x8a>
 1f4:	74636573          	csrrsi	a0,0x746,6
 1f8:	6f69                	lui	t5,0x1a
 1fa:	736e                	flw	ft6,248(sp)
 1fc:	2d20                	fld	fs0,88(a0)
 1fe:	6666                	flw	fa2,88(sp)
 200:	6e75                	lui	t3,0x1d
 202:	6f697463          	bgeu	s2,s6,8ea <_Min_Stack_Size+0xea>
 206:	2d6e                	fld	fs10,216(sp)
 208:	74636573          	csrrsi	a0,0x746,6
 20c:	6f69                	lui	t5,0x1a
 20e:	736e                	flw	ft6,248(sp)
 210:	2d20                	fld	fs0,88(a0)
 212:	6e66                	flw	ft8,88(sp)
 214:	78652d6f          	jal	s10,5299a <_Min_Stack_Size+0x5219a>
 218:	74706563          	bltu	zero,t2,962 <_Min_Stack_Size+0x162>
 21c:	6f69                	lui	t5,0x1a
 21e:	736e                	flw	ft6,248(sp)
 220:	2d20                	fld	fs0,88(a0)
 222:	6e66                	flw	ft8,88(sp)
 224:	74722d6f          	jal	s10,2316a <_Min_Stack_Size+0x2296a>
 228:	6974                	flw	fa3,84(a0)
 22a:	5f00                	lw	s0,56(a4)
 22c:	695f 746e 3631      	0x3631746e695f
 232:	745f 5f00 7473      	0x74735f00745f
 238:	6564                	flw	fs1,76(a0)
 23a:	7272                	flw	ft4,60(sp)
 23c:	5f00                	lw	s0,56(a4)
 23e:	6942                	flw	fs2,16(sp)
 240:	746e6967          	0x746e6967
 244:	5f00                	lw	s0,56(a4)
 246:	6d6d6167          	0x6d6d6167
 24a:	5f61                	li	t5,-8
 24c:	6e676973          	csrrsi	s2,0x6e6,14
 250:	006d6167          	0x6d6167
 254:	725f 6165 0064      	0x646165725f
 25a:	725f 7365 6c75      	0x6c757365725f
 260:	5f74                	lw	a3,124(a4)
 262:	5f5f006b          	0x5f5f006b
 266:	6e69                	lui	t3,0x1a
 268:	5f74                	lw	a3,124(a4)
 26a:	656c                	flw	fa1,76(a0)
 26c:	7361                	lui	t1,0xffff8
 26e:	3174                	fld	fa3,224(a0)
 270:	5f36                	lw	t5,108(sp)
 272:	0074                	addi	a3,sp,12
 274:	5f5f 6d74 5f00      	0x5f006d745f5f
 27a:	755f 6e69 5f74      	0x5f746e69755f
	GPIO_SET_TOGGLE_REG  = LED_0;
 280:	656c                	flw	fa1,76(a0)
 282:	7361                	lui	t1,0xffff8
 284:	3374                	fld	fa3,224(a4)
 286:	5f32                	lw	t5,44(sp)
 288:	0074                	addi	a3,sp,12
 28a:	5f5f 6377 6268      	0x626863775f5f
			GPIO_SET_TOGGLE_REG  = LED_0;
 290:	5f00                	lw	s0,56(a4)
 292:	72736377          	0x72736377
{
 296:	6f74                	flw	fa3,92(a4)
 298:	626d                	lui	tp,0x1b
 29a:	74735f73          	csrrwi	t5,0x747,6
		for (uint32_t delay = 0; delay < LONG_DELAY; ++delay);
 29e:	7461                	lui	s0,0xffff8
			GPIO_SET_TOGGLE_REG  = LED_0;
 2a0:	0065                	c.nop	25
 2a2:	735f 6474 756f      	0x756f6474735f
	for( ;; );
 2a8:	0074                	addi	a3,sp,12
 2aa:	635f 7476 656c      	0x656c7476635f
 2b0:	006e                	c.slli	zero,0x1b
 2b2:	665f 6c69 0065      	0x656c69665f
 2b8:	6e5f 6f69 7362      	0x73626f696e5f
 2be:	5f00                	lw	s0,56(a4)
 2c0:	5f676973          	csrrsi	s2,0x5f6,14
 2c4:	7566                	flw	fa0,120(sp)
 2c6:	636e                	flw	ft6,216(sp)
 2c8:	7300                	flw	fs0,32(a4)
 2ca:	6f68                	flw	fa0,92(a4)
 2cc:	7472                	flw	fs0,60(sp)
 2ce:	7520                	flw	fs0,104(a0)
 2d0:	736e                	flw	ft6,248(sp)
 2d2:	6769                	lui	a4,0x1a
 2d4:	656e                	flw	fa0,216(sp)
 2d6:	2064                	fld	fs1,192(s0)
 2d8:	6e69                	lui	t3,0x1a
 2da:	0074                	addi	a3,sp,12
 2dc:	675f 756c 0065      	0x65756c675f
 2e2:	615f 6574 6978      	0x69786574615f
 2e8:	3074                	fld	fa3,224(s0)
 2ea:	5f00                	lw	s0,56(a4)
 2ec:	695f 746e 616d      	0x616d746e695f
 2f2:	5f78                	lw	a4,124(a4)
 2f4:	0074                	addi	a3,sp,12
 2f6:	615f 6373 6974      	0x69746373615f
 2fc:	656d                	lui	a0,0x1b
 2fe:	625f 6675 2f00      	0x2f006675625f
 304:	656d                	lui	a0,0x1b
 306:	6964                	flw	fs1,84(a0)
 308:	2f61                	jal	aa0 <_Min_Stack_Size+0x2a0>
 30a:	6374                	flw	fa3,68(a4)
 30c:	696d                	lui	s2,0x1b
 30e:	6c616863          	bltu	sp,t1,9de <_Min_Stack_Size+0x1de>
 312:	6f572f73          	csrrs	t5,0x6f5,a4
 316:	6b72                	flw	fs6,28(sp)
 318:	6e69                	lui	t3,0x1a
 31a:	79632f67          	0x79632f67
 31e:	6e6f6c63          	bltu	t5,t1,a16 <_Min_Stack_Size+0x216>
 322:	2d65                	jal	9da <_Min_Stack_Size+0x1da>
 324:	3031                	jal	fffffb30 <_fstack+0xeffff110>
 326:	6379632f          	0x6379632f
 32a:	3031                	jal	fffffb36 <_fstack+0xeffff116>
 32c:	3030                	fld	fa2,96(s0)
 32e:	7375662f          	0x7375662f
 332:	7365                	lui	t1,0xffff9
 334:	702e636f          	jal	t1,e6a36 <_Min_Stack_Size+0xe6236>
 338:	6f72                	flw	ft10,28(sp)
 33a:	656a                	flw	fa0,152(sp)
 33c:	2f737463          	bgeu	t1,s7,624 <_sidata+0x2e4>
 340:	65726f63          	bltu	tp,s7,99e <_Min_Stack_Size+0x19e>
 344:	75712f73          	csrrs	t5,0x757,sp
 348:	6461                	lui	s0,0x18
 34a:	732d                	lui	t1,0xfffeb
 34c:	7265                	lui	tp,0xffff9
 34e:	2f76                	fld	ft10,344(sp)
 350:	5f007773          	csrrci	a4,0x5f0,0
 354:	6572                	flw	fa0,28(sp)
 356:	746c7573          	csrrci	a0,0x746,24
 35a:	5f00                	lw	s0,56(a4)
 35c:	775f 6863 5f00      	0x5f006863775f
 362:	4f4c                	lw	a1,28(a4)
 364:	545f4b43          	0x545f4b43
 368:	7700                	flw	fs0,40(a4)
 36a:	6e69                	lui	t3,0x1a
 36c:	5f74                	lw	a3,124(a4)
 36e:	0074                	addi	a3,sp,12
 370:	665f 616c 7367      	0x7367616c665f
 376:	0032                	c.slli	zero,0xc
 378:	6564                	flw	fs1,76(a0)
 37a:	79746c63          	bltu	s0,s7,b12 <_Min_Stack_Size+0x312>
 37e:	6570                	flw	fa2,76(a0)
 380:	6e28                	flw	fa0,88(a2)
 382:	6c75                	lui	s8,0x1d
 384:	706c                	flw	fa1,100(s0)
 386:	7274                	flw	fa3,100(a2)
 388:	0029                	c.nop	10
 38a:	775f 6972 6574      	0x65746972775f
 390:	5f00                	lw	s0,56(a4)
 392:	745f 5f6d 6579      	0x65795f6d745f
 398:	7261                	lui	tp,0xffff8
 39a:	5f00                	lw	s0,56(a4)
 39c:	6d6e                	flw	fs10,216(sp)
 39e:	6c61                	lui	s8,0x18
 3a0:	6f6c                	flw	fa1,92(a4)
 3a2:	6f6c0063          	beq	s8,s6,a82 <_Min_Stack_Size+0x282>
 3a6:	676e                	flw	fa4,216(sp)
 3a8:	6420                	flw	fs0,72(s0)
 3aa:	6c62756f          	jal	a0,27a70 <_Min_Stack_Size+0x27270>
 3ae:	0065                	c.nop	25
 3b0:	6e5f 7865 6674      	0x667478656e5f
 3b6:	5f00                	lw	s0,56(a4)
 3b8:	745f 5f6d 6f6d      	0x6f6d5f6d745f
 3be:	006e                	c.slli	zero,0x1b
 3c0:	615f 6574 6978      	0x69786574615f
 3c6:	0074                	addi	a3,sp,12
 3c8:	5f5f 6473 6469      	0x646964735f5f
 3ce:	6e69                	lui	t3,0x1a
 3d0:	7469                	lui	s0,0xffffa
 3d2:	5f00                	lw	s0,56(a4)
 3d4:	5f66666f          	jal	a2,669ca <_Min_Stack_Size+0x661ca>
 3d8:	0074                	addi	a3,sp,12
 3da:	5f5f 6975 746e      	0x746e69755f5f
 3e0:	3436                	fld	fs0,360(sp)
 3e2:	745f 5f00 7266      	0x72665f00745f
 3e8:	6565                	lui	a0,0x19
 3ea:	696c                	flw	fa1,84(a0)
 3ec:	75007473          	csrrci	s0,0x750,0
 3f0:	6e69                	lui	t3,0x1a
 3f2:	5f74                	lw	a3,124(a4)
 3f4:	6166                	flw	ft2,88(sp)
 3f6:	36317473          	csrrci	s0,0x363,2
 3fa:	745f 5f00 6377      	0x63775f00745f
 400:	6f74                	flw	fa3,92(a4)
 402:	626d                	lui	tp,0x1b
 404:	735f 6174 6574      	0x65746174735f
 40a:	7500                	flw	fs0,40(a0)
 40c:	6e69                	lui	t3,0x1a
 40e:	5f74                	lw	a3,124(a4)
 410:	6166                	flw	ft2,88(sp)
 412:	32337473          	csrrci	s0,mhpmevent3,6
 416:	745f 5f00 755f      	0x755f5f00745f
 41c:	6e69                	lui	t3,0x1a
 41e:	5f74                	lw	a3,124(a4)
 420:	656c                	flw	fa1,76(a0)
 422:	7361                	lui	t1,0xffff8
 424:	3674                	fld	fa3,232(a2)
 426:	5f34                	lw	a3,120(a4)
 428:	0074                	addi	a3,sp,12
 42a:	6e75                	lui	t3,0x1d
 42c:	6e676973          	csrrsi	s2,0x6e6,14
 430:	6465                	lui	s0,0x19
 432:	6320                	flw	fs0,64(a4)
 434:	6168                	flw	fa0,68(a0)
 436:	0072                	c.slli	zero,0x1c
 438:	6e5f 7765 6400      	0x640077656e5f
 43e:	6c65                	lui	s8,0x19
 440:	7961                	lui	s2,0xffff8
 442:	5f00                	lw	s0,56(a4)
 444:	5f68                	lw	a0,124(a4)
 446:	7265                	lui	tp,0xffff9
 448:	6e72                	flw	ft8,28(sp)
 44a:	6873006f          	j	312d0 <_Min_Stack_Size+0x30ad0>
 44e:	2074726f          	jal	tp,47e54 <_Min_Stack_Size+0x47654>
 452:	6e69                	lui	t3,0x1a
 454:	0074                	addi	a3,sp,12
 456:	5f5f 6d74 795f      	0x795f6d745f5f
 45c:	6164                	flw	fs1,68(a0)
 45e:	0079                	c.nop	30
 460:	5f5f 6273 6675      	0x667562735f5f
 466:	5f00                	lw	s0,56(a4)
 468:	6f69                	lui	t5,0x1a
 46a:	7362                	flw	ft6,56(sp)
 46c:	5f00                	lw	s0,56(a4)
 46e:	465f 4c49 0045      	0x454c49465f
 474:	5f5f 4673 4c49      	0x4c4946735f5f
 47a:	0045                	c.nop	17
 47c:	6975                	lui	s2,0x1d
 47e:	746e                	flw	fs0,248(sp)
 480:	665f 7361 3874      	0x38747361665f
 486:	745f 5f00 755f      	0x755f5f00745f
 48c:	6e69                	lui	t3,0x1a
 48e:	7074                	flw	fa3,100(s0)
 490:	7274                	flw	fa3,100(a2)
 492:	745f 5f00 6172      	0x61725f00745f
 498:	646e                	flw	fs0,216(sp)
 49a:	6e5f 7865 0074      	0x7478656e5f
 4a0:	6d5f 6c62 6e65      	0x6e656c626d5f
 4a6:	735f 6174 6574      	0x65746174735f
 4ac:	5f00                	lw	s0,56(a4)
 4ae:	6e69                	lui	t3,0x1a
 4b0:	695f0063          	beq	t5,s5,b30 <_Min_Stack_Size+0x330>
 4b4:	646e                	flw	fs0,216(sp)
 4b6:	5f00                	lw	s0,56(a4)
 4b8:	6f6c                	flw	fa1,92(a4)
 4ba:	656c6163          	bltu	s8,s6,afc <_Min_Stack_Size+0x2fc>
 4be:	5f00                	lw	s0,56(a4)
 4c0:	635f 656c 6e61      	0x6e61656c635f
 4c6:	7075                	c.lui	zero,0xffffd
 4c8:	5f00                	lw	s0,56(a4)
 4ca:	6e75                	lui	t3,0x1d
 4cc:	63657073          	csrci	0x636,10
 4d0:	6669                	lui	a2,0x1a
 4d2:	6569                	lui	a0,0x1a
 4d4:	5f64                	lw	s1,124(a4)
 4d6:	6f6c                	flw	fa1,92(a4)
 4d8:	656c6163          	bltu	s8,s6,b1a <_Min_Stack_Size+0x31a>
 4dc:	695f 666e 006f      	0x6f666e695f
 4e2:	6d5f 7861 6477      	0x647778616d5f
 4e8:	725f0073          	0x725f0073
 4ec:	6565                	lui	a0,0x19
 4ee:	746e                	flw	fs0,248(sp)
 4f0:	5f00                	lw	s0,56(a4)
 4f2:	64656573          	csrrsi	a0,0x646,10
 4f6:	5f00                	lw	s0,56(a4)
 4f8:	635f 756f 746e      	0x746e756f635f
 4fe:	5f00                	lw	s0,56(a4)
 500:	6c5f 636f 006b      	0x6b636f6c5f
 506:	5f5f 6176 756c      	0x756c61765f5f
 50c:	0065                	c.nop	25
 50e:	735f 6565 006b      	0x6b6565735f
 514:	665f 6f70 5f73      	0x5f736f70665f
 51a:	0074                	addi	a3,sp,12
 51c:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 522:	6e69                	lui	t3,0x1a
 524:	5f00                	lw	s0,56(a4)
 526:	755f 6e69 3174      	0x31746e69755f
 52c:	5f36                	lw	t5,108(sp)
 52e:	0074                	addi	a3,sp,12
 530:	5f5f 6e69 3374      	0x33746e695f5f
 536:	5f32                	lw	t5,44(sp)
 538:	0074                	addi	a3,sp,12
 53a:	655f 656d 6772      	0x6772656d655f
 540:	6e65                	lui	t3,0x19
 542:	5f007963          	bgeu	zero,a6,b34 <_Min_Stack_Size+0x334>
 546:	756d                	lui	a0,0xffffb
 548:	746c                	flw	fa1,108(s0)
 54a:	5f00                	lw	s0,56(a4)
 54c:	755f 6e69 6d74      	0x6d746e69755f
 552:	7861                	lui	a6,0xffff8
 554:	745f 5f00 7473      	0x74735f00745f
 55a:	7472                	flw	fs0,60(sp)
 55c:	6c5f6b6f          	jal	s6,f7420 <_Min_Stack_Size+0xf6c20>
 560:	7361                	lui	t1,0xffff8
 562:	0074                	addi	a3,sp,12
 564:	5f5f 6e69 5f74      	0x5f746e695f5f
 56a:	656c                	flw	fa1,76(a0)
 56c:	7361                	lui	t1,0xffff8
 56e:	3374                	fld	fa3,224(a4)
 570:	5f32                	lw	t5,44(sp)
 572:	0074                	addi	a3,sp,12
 574:	665f 746e 7079      	0x7079746e665f
 57a:	7365                	lui	t1,0xffff9
 57c:	5f00                	lw	s0,56(a4)
 57e:	755f 6e69 5f74      	0x5f746e69755f
 584:	656c                	flw	fa1,76(a0)
 586:	7361                	lui	t1,0xffff8
 588:	3174                	fld	fa3,224(a0)
 58a:	5f36                	lw	t5,108(sp)
 58c:	0074                	addi	a3,sp,12
 58e:	615f 6464 5f00      	0x5f006464615f
 594:	555f 6f4c 676e      	0x676e6f4c555f
 59a:	5f00                	lw	s0,56(a4)
 59c:	64746567          	0x64746567
 5a0:	7461                	lui	s0,0xffff8
 5a2:	5f65                	li	t5,-7
 5a4:	7265                	lui	tp,0xffff9
 5a6:	0072                	c.slli	zero,0x1c
 5a8:	675f 6f6c 6162      	0x61626f6c675f
 5ae:	5f6c                	lw	a1,124(a4)
 5b0:	6d69                	lui	s10,0x1a
 5b2:	7570                	flw	fa2,108(a0)
 5b4:	6572                	flw	fa0,28(sp)
 5b6:	705f 7274 6100      	0x61007274705f
 5bc:	6772                	flw	fa4,28(sp)
 5be:	0076                	c.slli	zero,0x1d
 5c0:	755f 756e 6573      	0x6573756e755f
 5c6:	5f64                	lw	s1,124(a4)
 5c8:	6172                	flw	ft2,28(sp)
 5ca:	646e                	flw	fs0,216(sp)
 5cc:	5f00                	lw	s0,56(a4)
 5ce:	00736477          	0x736477
 5d2:	5f5f 6d74 775f      	0x775f6d745f5f
 5d8:	6164                	flw	fs1,68(a0)
 5da:	0079                	c.nop	30
 5dc:	5f5f 6e69 5f74      	0x5f746e695f5f
 5e2:	656c                	flw	fa1,76(a0)
 5e4:	7361                	lui	t1,0xffff8
 5e6:	3874                	fld	fa3,240(s0)
 5e8:	745f 5f00 7373      	0x73735f00745f
 5ee:	7a69                	lui	s4,0xffffa
 5f0:	5f65                	li	t5,-7
 5f2:	0074                	addi	a3,sp,12
 5f4:	6c5f 3436 5f61      	0x5f6134366c5f
 5fa:	7562                	flw	fa0,56(sp)
 5fc:	0066                	c.slli	zero,0x19
 5fe:	6d5f 7462 776f      	0x776f74626d5f
 604:	74735f63          	bge	t1,t2,d62 <_Min_Stack_Size+0x562>
 608:	7461                	lui	s0,0xffff8
 60a:	0065                	c.nop	25
 60c:	665f 6f6c 6b63      	0x6b636f6c665f
 612:	745f 5f00 626e      	0x626e5f00745f
 618:	6675                	lui	a2,0x1d
 61a:	5f00                	lw	s0,56(a4)
 61c:	6e75                	lui	t3,0x1d
 61e:	7375                	lui	t1,0xffffd
 620:	6465                	lui	s0,0x19
 622:	6100                	flw	fs0,0(a0)
 624:	6772                	flw	fa4,28(sp)
 626:	5f5f0063          	beq	t5,s5,c06 <_Min_Stack_Size+0x406>
 62a:	6d74                	flw	fa3,92(a0)
 62c:	695f 6473 7473      	0x74736473695f
 632:	5f00                	lw	s0,56(a4)
 634:	6f6c                	flw	fa1,92(a4)
 636:	746c6163          	bltu	s8,t1,d78 <_Min_Stack_Size+0x578>
 63a:	6d69                	lui	s10,0x1a
 63c:	5f65                	li	t5,-7
 63e:	7562                	flw	fa0,56(sp)
 640:	0066                	c.slli	zero,0x19
 642:	635f 6f6c 6573      	0x65736f6c635f
 648:	5f00                	lw	s0,56(a4)
 64a:	3472                	fld	fs0,312(sp)
 64c:	0038                	addi	a4,sp,8
 64e:	705f 7335 6d00      	0x6d007335705f
 654:	6961                	lui	s2,0x18
 656:	006e                	c.slli	zero,0x1b
 658:	5f5f 6d74 6d5f      	0x6d5f6d745f5f
 65e:	6164                	flw	fs1,68(a0)
 660:	0079                	c.nop	30
 662:	7865                	lui	a6,0xffff9
 664:	6d61                	lui	s10,0x18
 666:	6c70                	flw	fa2,92(s0)
 668:	4c65                	li	s8,25
 66a:	4445                	li	s0,17
 66c:	69616d2f          	0x69616d2f
 670:	2e6e                	fld	ft8,216(sp)
 672:	00707063          	bgeu	zero,t2,672 <_sidata+0x332>
 676:	30747263          	bgeu	s0,t2,97a <_Min_Stack_Size+0x17a>
 67a:	532e                	lw	t1,232(sp)
 67c:	4700                	lw	s0,8(a4)
 67e:	554e                	lw	a0,240(sp)
 680:	4120                	lw	s0,64(a0)
 682:	2e322053          	0x2e322053
 686:	          	snez	tp,zero

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
  1c:	0028                	addi	a0,sp,8
  1e:	0000                	unimp
	la t0, trap_vector
  20:	000c                	0xc
  22:	0000                	unimp
  24:	0000                	unimp
  26:	0000                	unimp
	csrw mtvec, t0
  28:	02a8                	addi	a0,sp,328
  2a:	0000                	unimp
	la a0, _sidata  /*from */
  2c:	0004                	0x4
  2e:	0000                	unimp
  30:	000c                	0xc
  32:	0000                	unimp
	la a1, _sdata   /* to */
  34:	0000                	unimp
  36:	0000                	unimp
  38:	02ac                	addi	a1,sp,328
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
  58:	02b0                	addi	a2,sp,328
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

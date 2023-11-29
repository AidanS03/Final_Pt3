_TIM1_ISR:
;Final_Pt3.c,20 :: 		void TIM1_ISR() iv IVT_INT_TIM1_UP {
;Final_Pt3.c,21 :: 		TIM1_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;Final_Pt3.c,22 :: 		GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_LX	[R0, ByteOffset(GPIOA_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;Final_Pt3.c,23 :: 		TIM1count++;
MOVW	R1, #lo_addr(_TIM1count+0)
MOVT	R1, #hi_addr(_TIM1count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,24 :: 		}
L_end_TIM1_ISR:
BX	LR
; end of _TIM1_ISR
_main:
;Final_Pt3.c,30 :: 		void main() {
;Final_Pt3.c,31 :: 		initGPIO();
BL	_initGPIO+0
;Final_Pt3.c,32 :: 		initTIM1();
BL	_initTIM1+0
;Final_Pt3.c,33 :: 		TIM1count = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,34 :: 		for(;;){
L_main0:
;Final_Pt3.c,35 :: 		if(TIM1count >= 100){TIM1count = 0;}
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #100
IT	LT
BLT	L_main3
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
L_main3:
;Final_Pt3.c,36 :: 		find7segVal(TIM1count);
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
BL	_find7segVal+0
;Final_Pt3.c,37 :: 		GPIOD_ODR = leftNum[leftIDX];
MOVW	R0, #lo_addr(_leftIDX+0)
MOVT	R0, #hi_addr(_leftIDX+0)
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_leftNum+0)
MOVT	R0, #hi_addr(_leftNum+0)
ADDS	R0, R0, R1
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,38 :: 		delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;Final_Pt3.c,39 :: 		GPIOD_ODR = rightNum[rightIDX];
MOVW	R0, #lo_addr(_rightIDX+0)
MOVT	R0, #hi_addr(_rightIDX+0)
LDRSH	R0, [R0, #0]
LSLS	R1, R0, #1
MOVW	R0, #lo_addr(_rightNum+0)
MOVT	R0, #hi_addr(_rightNum+0)
ADDS	R0, R0, R1
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,40 :: 		delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
;Final_Pt3.c,41 :: 		}
IT	AL
BAL	L_main0
;Final_Pt3.c,42 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_initTIM1:
;Final_Pt3.c,44 :: 		void initTIM1(){
;Final_Pt3.c,45 :: 		RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,46 :: 		TIM1_CR1 = 0x0000; //clear control register for initialization
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,47 :: 		TIM1_PSC = 7999; //1 second if counting to 9000
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;Final_Pt3.c,49 :: 		TIM1_ARR = 9000;  //target value for the counter
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,50 :: 		NVIC_ISER0.B25 = 1; //Enable update interrupt for TIM1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER0+0)
MOVT	R1, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #1
STR	R0, [R1, #0]
;Final_Pt3.c,51 :: 		TIM1_DIER.UIE = 1; //enable update interrupts for our timer
MOVW	R0, #lo_addr(TIM1_DIER+0)
MOVT	R0, #hi_addr(TIM1_DIER+0)
_SX	[R0, ByteOffset(TIM1_DIER+0)]
;Final_Pt3.c,52 :: 		TIM1_CR1 = 0x0001;     //enable timer
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,53 :: 		}
L_end_initTIM1:
BX	LR
; end of _initTIM1
_initGPIO:
;Final_Pt3.c,55 :: 		void initGPIO(){  //starts the clocks for GPIO
;Final_Pt3.c,56 :: 		RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,57 :: 		RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,58 :: 		RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,59 :: 		RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,60 :: 		RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,62 :: 		GPIOA_CRL = 0x3; // sets PA0 as an output
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,63 :: 		GPIOD_CRH = 0x33333333; //set PortE/H as an output
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,64 :: 		}
L_end_initGPIO:
BX	LR
; end of _initGPIO
_find7segVal:
;Final_Pt3.c,66 :: 		void find7segVal(int sec){
; sec start address is: 0 (R0)
; sec end address is: 0 (R0)
; sec start address is: 0 (R0)
;Final_Pt3.c,67 :: 		leftIDX = (sec/10);
MOVS	R1, #10
SXTH	R1, R1
SDIV	R2, R0, R1
SXTH	R2, R2
MOVW	R1, #lo_addr(_leftIDX+0)
MOVT	R1, #hi_addr(_leftIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,68 :: 		rightIDX = sec - (leftIDX*10);
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
SUB	R2, R0, R1
; sec end address is: 0 (R0)
MOVW	R1, #lo_addr(_rightIDX+0)
MOVT	R1, #hi_addr(_rightIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,69 :: 		}
L_end_find7segVal:
BX	LR
; end of _find7segVal

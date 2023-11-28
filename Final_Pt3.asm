_TIM1_ISR:
;Final_Pt3.c,17 :: 		void TIM1_ISR() iv IVT_INT_TIM1_CC {
;Final_Pt3.c,18 :: 		TIM1_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;Final_Pt3.c,19 :: 		GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_LX	[R0, ByteOffset(GPIOA_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;Final_Pt3.c,20 :: 		}
L_end_TIM1_ISR:
BX	LR
; end of _TIM1_ISR
_main:
;Final_Pt3.c,23 :: 		void main() {
;Final_Pt3.c,24 :: 		initGPIO();
BL	_initGPIO+0
;Final_Pt3.c,25 :: 		initTIM1();
BL	_initTIM1+0
;Final_Pt3.c,26 :: 		for(;;){
L_main0:
;Final_Pt3.c,28 :: 		}
IT	AL
BAL	L_main0
;Final_Pt3.c,29 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_initTIM1:
;Final_Pt3.c,31 :: 		void initTIM1(){
;Final_Pt3.c,32 :: 		RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,33 :: 		TIM1_CR1 = 0x0000; //clear control register for initialization
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,34 :: 		TIM1_PSC = 14399; //1 second if counting to 5000
MOVW	R1, #14399
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;Final_Pt3.c,36 :: 		TIM1_ARR = 5000;  //target value for the counter
MOVW	R1, #5000
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,37 :: 		NVIC_ISER0 |= 1 << 24; //Enable break interrupt for TIM1
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;Final_Pt3.c,38 :: 		TIM1_DIER.UIE = 1; //enable update interrupts for our timer
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_DIER+0)
MOVT	R0, #hi_addr(TIM1_DIER+0)
_SX	[R0, ByteOffset(TIM1_DIER+0)]
;Final_Pt3.c,39 :: 		TIM1_CR1 = 0x0001;     //enable timer
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,40 :: 		}
L_end_initTIM1:
BX	LR
; end of _initTIM1
_initGPIO:
;Final_Pt3.c,42 :: 		void initGPIO(){  //starts the clocks for GPIO
;Final_Pt3.c,43 :: 		RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,44 :: 		RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,45 :: 		RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,46 :: 		RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,47 :: 		RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,49 :: 		GPIOA_CRL = 0x3; // sets PortA/L as an output
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,50 :: 		}
L_end_initGPIO:
BX	LR
; end of _initGPIO

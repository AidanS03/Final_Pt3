_TIM1_ISR:
;Final_Pt3.c,26 :: 		void TIM1_ISR() iv IVT_INT_TIM1_UP {
;Final_Pt3.c,27 :: 		TIM1_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;Final_Pt3.c,28 :: 		GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_LX	[R0, ByteOffset(GPIOA_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;Final_Pt3.c,29 :: 		TIM1count++;
MOVW	R1, #lo_addr(_TIM1count+0)
MOVT	R1, #hi_addr(_TIM1count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,30 :: 		pressCounts[5]++;
MOVW	R1, #lo_addr(_pressCounts+10)
MOVT	R1, #hi_addr(_pressCounts+10)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,31 :: 		}
L_end_TIM1_ISR:
BX	LR
; end of _TIM1_ISR
_main:
;Final_Pt3.c,35 :: 		void main() {
;Final_Pt3.c,36 :: 		initGPIO();
BL	_initGPIO+0
;Final_Pt3.c,37 :: 		initTIM1();
BL	_initTIM1+0
;Final_Pt3.c,38 :: 		TIM1count = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,39 :: 		for(;;){
L_main0:
;Final_Pt3.c,40 :: 		if(TIM1count >= 100){
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #100
IT	LT
BLT	L_main3
;Final_Pt3.c,41 :: 		TIM1count = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,42 :: 		}
L_main3:
;Final_Pt3.c,43 :: 		find7segVal(TIM1count);
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
BL	_find7segVal+0
;Final_Pt3.c,44 :: 		GPIOD_ODR = leftNum[leftIDX];
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
;Final_Pt3.c,45 :: 		delay_ms(1);
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
;Final_Pt3.c,46 :: 		GPIOD_ODR = rightNum[rightIDX];
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
;Final_Pt3.c,47 :: 		delay_ms(1);
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
;Final_Pt3.c,48 :: 		if(recieved == 'Q'){
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
LDRSH	R0, [R0, #0]
CMP	R0, #81
IT	NE
BNE	L_main8
;Final_Pt3.c,50 :: 		for(i = 0; i < 38; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main9:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #38
IT	GE
BGE	L_main10
;Final_Pt3.c,51 :: 		sendChar(CountMessage[i]); //sends the data title
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_CountMessage+0)
MOVT	R0, #hi_addr(_CountMessage+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_sendChar+0
;Final_Pt3.c,50 :: 		for(i = 0; i < 38; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,52 :: 		}
IT	AL
BAL	L_main9
L_main10:
;Final_Pt3.c,53 :: 		for(i = 0; i < 5; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main12:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #5
IT	GE
BGE	L_main13
;Final_Pt3.c,54 :: 		sendPressCount(i); //sends the label and data for each direction
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
BL	_sendPressCount+0
;Final_Pt3.c,53 :: 		for(i = 0; i < 5; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,55 :: 		}
IT	AL
BAL	L_main12
L_main13:
;Final_Pt3.c,56 :: 		}
L_main8:
;Final_Pt3.c,57 :: 		recieved = 0; //clears the pause/unpause variable, needed to prevent looping
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,58 :: 		}
IT	AL
BAL	L_main0
;Final_Pt3.c,60 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_initTIM1:
;Final_Pt3.c,63 :: 		void initTIM1(){
;Final_Pt3.c,64 :: 		RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,65 :: 		TIM1_CR1 = 0x0000; //clear control register for initialization
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,66 :: 		TIM1_PSC = 7999; //1 second if counting to 9000
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;Final_Pt3.c,68 :: 		TIM1_ARR = 9000;  //target value for the counter
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,69 :: 		NVIC_ISER0.B25 = 1; //Enable update interrupt for TIM1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER0+0)
MOVT	R1, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #1
STR	R0, [R1, #0]
;Final_Pt3.c,70 :: 		TIM1_DIER.UIE = 1; //enable update interrupts for our timer
MOVW	R0, #lo_addr(TIM1_DIER+0)
MOVT	R0, #hi_addr(TIM1_DIER+0)
_SX	[R0, ByteOffset(TIM1_DIER+0)]
;Final_Pt3.c,71 :: 		TIM1_CR1 = 0x0001;     //enable timer
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,72 :: 		}
L_end_initTIM1:
BX	LR
; end of _initTIM1
_initGPIO:
;Final_Pt3.c,74 :: 		void initGPIO(){  //starts the clocks for GPIO
;Final_Pt3.c,75 :: 		RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,76 :: 		RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,77 :: 		RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,78 :: 		RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,79 :: 		RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,81 :: 		GPIOA_CRL = 0x3; // sets PA0 as an output
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,82 :: 		GPIOD_CRH = 0x33333333; //set PortE/H as an output
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,83 :: 		}
L_end_initGPIO:
BX	LR
; end of _initGPIO
_find7segVal:
;Final_Pt3.c,85 :: 		void find7segVal(int sec){
; sec start address is: 0 (R0)
; sec end address is: 0 (R0)
; sec start address is: 0 (R0)
;Final_Pt3.c,86 :: 		leftIDX = (sec/10);
MOVS	R1, #10
SXTH	R1, R1
SDIV	R2, R0, R1
SXTH	R2, R2
MOVW	R1, #lo_addr(_leftIDX+0)
MOVT	R1, #hi_addr(_leftIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,87 :: 		rightIDX = sec - (leftIDX*10);
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
SUB	R2, R0, R1
; sec end address is: 0 (R0)
MOVW	R1, #lo_addr(_rightIDX+0)
MOVT	R1, #hi_addr(_rightIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,88 :: 		}
L_end_find7segVal:
BX	LR
; end of _find7segVal
_sendChar:
;Final_Pt3.c,90 :: 		void sendChar(char message){ //sends one character over USART
; message start address is: 0 (R0)
; message end address is: 0 (R0)
; message start address is: 0 (R0)
;Final_Pt3.c,91 :: 		if(USART1_SR.B7 == 1){
MOVW	R1, #lo_addr(USART1_SR+0)
MOVT	R1, #hi_addr(USART1_SR+0)
_LX	[R1, ByteOffset(USART1_SR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_sendChar15
;Final_Pt3.c,92 :: 		USART1_DR = message;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; message end address is: 0 (R0)
;Final_Pt3.c,93 :: 		}
L_sendChar15:
;Final_Pt3.c,94 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_sendChar16:
SUBS	R7, R7, #1
BNE	L_sendChar16
NOP
NOP
NOP
;Final_Pt3.c,95 :: 		}
L_end_sendChar:
BX	LR
; end of _sendChar
_sendPressCount:
;Final_Pt3.c,97 :: 		void sendPressCount(int idx){    //sends the direction label and count through USART
; idx start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R4, R0
; idx end address is: 0 (R0)
; idx start address is: 16 (R4)
;Final_Pt3.c,98 :: 		sendChar(letter1[idx]);
MOVW	R1, #lo_addr(_letter1+0)
MOVT	R1, #hi_addr(_letter1+0)
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,99 :: 		sendChar(letter2[idx]);
MOVW	R1, #lo_addr(_letter2+0)
MOVT	R1, #hi_addr(_letter2+0)
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,100 :: 		sendChar(':');
MOVS	R0, #58
BL	_sendChar+0
;Final_Pt3.c,101 :: 		sendChar(' ');
MOVS	R0, #32
BL	_sendChar+0
;Final_Pt3.c,102 :: 		sendChar((pressCounts[idx]/100) + 48);
LSLS	R2, R4, #1
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
ADDS	R1, R1, R2
LDRSH	R2, [R1, #0]
MOVS	R1, #100
SXTH	R1, R1
SDIV	R1, R2, R1
SXTH	R1, R1
ADDS	R1, #48
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,103 :: 		temp = (pressCounts[idx]/100) * 100;
LSLS	R2, R4, #1
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
ADDS	R3, R1, R2
LDRSH	R2, [R3, #0]
MOVS	R1, #100
SXTH	R1, R1
SDIV	R2, R2, R1
SXTH	R2, R2
MOVS	R1, #100
SXTH	R1, R1
MULS	R2, R1, R2
SXTH	R2, R2
MOVW	R1, #lo_addr(_temp+0)
MOVT	R1, #hi_addr(_temp+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,104 :: 		sendChar((pressCounts[idx] - temp)/10 + 48);
LDRSH	R1, [R3, #0]
SUB	R2, R1, R2
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
SDIV	R1, R2, R1
SXTH	R1, R1
ADDS	R1, #48
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,105 :: 		temp = (pressCounts[idx]/10) * 10;
LSLS	R2, R4, #1
; idx end address is: 16 (R4)
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
ADDS	R3, R1, R2
LDRSH	R2, [R3, #0]
MOVS	R1, #10
SXTH	R1, R1
SDIV	R2, R2, R1
SXTH	R2, R2
MOVS	R1, #10
SXTH	R1, R1
MULS	R2, R1, R2
SXTH	R2, R2
MOVW	R1, #lo_addr(_temp+0)
MOVT	R1, #hi_addr(_temp+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,106 :: 		sendChar(pressCounts[idx] - temp + 48);
LDRSH	R1, [R3, #0]
SUB	R1, R1, R2
SXTH	R1, R1
ADDS	R1, #48
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,107 :: 		sendChar(13);
MOVS	R0, #13
BL	_sendChar+0
;Final_Pt3.c,108 :: 		sendChar(10);
MOVS	R0, #10
BL	_sendChar+0
;Final_Pt3.c,109 :: 		sendChar(13);
MOVS	R0, #13
BL	_sendChar+0
;Final_Pt3.c,110 :: 		sendChar(10);
MOVS	R0, #10
BL	_sendChar+0
;Final_Pt3.c,111 :: 		}
L_end_sendPressCount:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendPressCount

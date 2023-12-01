_TIM1_ISR:
;Final_Pt3.c,31 :: 		void TIM1_ISR() iv IVT_INT_TIM1_UP {
;Final_Pt3.c,32 :: 		TIM1_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;Final_Pt3.c,33 :: 		TIM1count++;
MOVW	R1, #lo_addr(_TIM1count+0)
MOVT	R1, #hi_addr(_TIM1count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,34 :: 		pressCounts[5]++;
MOVW	R1, #lo_addr(_pressCounts+10)
MOVT	R1, #hi_addr(_pressCounts+10)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,35 :: 		}
L_end_TIM1_ISR:
BX	LR
; end of _TIM1_ISR
_TIM3_ISR:
;Final_Pt3.c,37 :: 		void TIM3_ISR() iv IVT_INT_TIM3 ics ICS_OFF {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Final_Pt3.c,38 :: 		GPIOE_CRH = 0x33333333; // sets PE14 as an output for buzzer
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,39 :: 		TIM3_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
_SX	[R0, ByteOffset(TIM3_SR+0)]
;Final_Pt3.c,40 :: 		initTIM3(); //will read pot and update the ARR to change timer speed
BL	_initTIM3+0
;Final_Pt3.c,41 :: 		GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PA0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_LX	[R0, ByteOffset(GPIOA_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;Final_Pt3.c,42 :: 		GPIOE_ODR.B14 = ~GPIOE_ODR.B14;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,46 :: 		}
L_end_TIM3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIM3_ISR
_main:
;Final_Pt3.c,49 :: 		void main() {
;Final_Pt3.c,50 :: 		initUSART(); //starts USART1
BL	_initUSART+0
;Final_Pt3.c,51 :: 		initGPIO(); //initializes GPIO
BL	_initGPIO+0
;Final_Pt3.c,52 :: 		initTIM1(); //Initializes TIM1
BL	_initTIM1+0
;Final_Pt3.c,53 :: 		initTIM3();
BL	_initTIM3+0
;Final_Pt3.c,54 :: 		TIM1count = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,55 :: 		buzzerOn = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_buzzerOn+0)
MOVT	R0, #hi_addr(_buzzerOn+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,56 :: 		for(;;){
L_main0:
;Final_Pt3.c,57 :: 		if(TIM1count >= 100){
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #100
IT	LT
BLT	L_main3
;Final_Pt3.c,58 :: 		TIM1count = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,59 :: 		}
L_main3:
;Final_Pt3.c,60 :: 		find7segVal(TIM1count);
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
BL	_find7segVal+0
;Final_Pt3.c,61 :: 		GPIOD_ODR = leftNum[leftIDX];
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
;Final_Pt3.c,62 :: 		delay_ms(1);
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
;Final_Pt3.c,63 :: 		GPIOD_ODR = rightNum[rightIDX];
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
;Final_Pt3.c,64 :: 		delay_ms(1);
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
;Final_Pt3.c,65 :: 		if(USART1_SR.B5 == 1){
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
_LX	[R0, ByteOffset(USART1_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main8
;Final_Pt3.c,66 :: 		recieved = USART1_DR; //check if reciever data register is empty and update if it is
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,67 :: 		}
L_main8:
;Final_Pt3.c,68 :: 		if(recieved == 'Q'){
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
LDRSH	R0, [R0, #0]
CMP	R0, #81
IT	NE
BNE	L_main9
;Final_Pt3.c,70 :: 		for(i = 0; i < 38; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main10:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #38
IT	GE
BGE	L_main11
;Final_Pt3.c,71 :: 		sendChar(CountMessage[i]); //sends the data title
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_CountMessage+0)
MOVT	R0, #hi_addr(_CountMessage+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_sendChar+0
;Final_Pt3.c,70 :: 		for(i = 0; i < 38; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,72 :: 		}
IT	AL
BAL	L_main10
L_main11:
;Final_Pt3.c,73 :: 		for(i = 0; i < 6; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main13:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #6
IT	GE
BGE	L_main14
;Final_Pt3.c,74 :: 		sendPressCount(i); //sends the label and data for each direction
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
BL	_sendPressCount+0
;Final_Pt3.c,73 :: 		for(i = 0; i < 6; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,75 :: 		}
IT	AL
BAL	L_main13
L_main14:
;Final_Pt3.c,76 :: 		}
L_main9:
;Final_Pt3.c,77 :: 		recieved = 0; //clears the pause/unpause variable, needed to prevent looping
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,78 :: 		joy = joyRead(); //reads what direction the joystick is in and returns 0-5
BL	_joyRead+0
MOVW	R1, #lo_addr(_joy+0)
MOVT	R1, #hi_addr(_joy+0)
STRH	R0, [R1, #0]
;Final_Pt3.c,79 :: 		switch(joy){
IT	AL
BAL	L_main16
;Final_Pt3.c,80 :: 		case 0: //no press do nothing
L_main18:
;Final_Pt3.c,81 :: 		sent = 0; //sent variable is used to avoid the message from being sent multiple times for one press
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,82 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,83 :: 		case 1: //up press, send UP
L_main19:
;Final_Pt3.c,84 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main20
;Final_Pt3.c,85 :: 		sendChar('U');
MOVS	R0, #85
BL	_sendChar+0
;Final_Pt3.c,86 :: 		sendChar('P');  //sends the message, updates the sent variable and adds one to the count
MOVS	R0, #80
BL	_sendChar+0
;Final_Pt3.c,87 :: 		sendPressed();  //same process for each direction
BL	_sendPressed+0
;Final_Pt3.c,88 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,89 :: 		pressCounts[0] = pressCounts[0] + 1;
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,90 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,91 :: 		}
L_main20:
;Final_Pt3.c,92 :: 		case 2: //right press, send RT
L_main21:
;Final_Pt3.c,93 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main22
;Final_Pt3.c,94 :: 		sendChar('R');
MOVS	R0, #82
BL	_sendChar+0
;Final_Pt3.c,95 :: 		sendChar('T');
MOVS	R0, #84
BL	_sendChar+0
;Final_Pt3.c,96 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,97 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,98 :: 		pressCounts[1] = pressCounts[1] + 1;
MOVW	R1, #lo_addr(_pressCounts+2)
MOVT	R1, #hi_addr(_pressCounts+2)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,99 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,100 :: 		}
L_main22:
;Final_Pt3.c,101 :: 		case 3: //down press, send DN
L_main23:
;Final_Pt3.c,102 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main24
;Final_Pt3.c,103 :: 		sendChar('D');
MOVS	R0, #68
BL	_sendChar+0
;Final_Pt3.c,104 :: 		sendChar('N');
MOVS	R0, #78
BL	_sendChar+0
;Final_Pt3.c,105 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,106 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,107 :: 		pressCounts[2] = pressCounts[2] + 1;
MOVW	R1, #lo_addr(_pressCounts+4)
MOVT	R1, #hi_addr(_pressCounts+4)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,108 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,109 :: 		}
L_main24:
;Final_Pt3.c,110 :: 		case 4: //left press, send LT
L_main25:
;Final_Pt3.c,111 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main26
;Final_Pt3.c,112 :: 		sendChar('L');
MOVS	R0, #76
BL	_sendChar+0
;Final_Pt3.c,113 :: 		sendChar('T');
MOVS	R0, #84
BL	_sendChar+0
;Final_Pt3.c,114 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,115 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,116 :: 		pressCounts[3] = pressCounts[3] + 1;
MOVW	R1, #lo_addr(_pressCounts+6)
MOVT	R1, #hi_addr(_pressCounts+6)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,117 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,118 :: 		}
L_main26:
;Final_Pt3.c,119 :: 		case 5: //click press, send CK
L_main27:
;Final_Pt3.c,120 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main28
;Final_Pt3.c,121 :: 		sendChar('C');
MOVS	R0, #67
BL	_sendChar+0
;Final_Pt3.c,122 :: 		sendChar('K');
MOVS	R0, #75
BL	_sendChar+0
;Final_Pt3.c,123 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,124 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,125 :: 		pressCounts[4] = pressCounts[4] + 1;
MOVW	R1, #lo_addr(_pressCounts+8)
MOVT	R1, #hi_addr(_pressCounts+8)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,126 :: 		break;
IT	AL
BAL	L_main17
;Final_Pt3.c,127 :: 		}
L_main28:
;Final_Pt3.c,128 :: 		}
IT	AL
BAL	L_main17
L_main16:
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main18
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_main19
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_main21
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_main23
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_main25
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_main27
L_main17:
;Final_Pt3.c,129 :: 		}
IT	AL
BAL	L_main0
;Final_Pt3.c,131 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_initTIM1:
;Final_Pt3.c,134 :: 		void initTIM1(){
;Final_Pt3.c,135 :: 		RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,136 :: 		TIM1_CR1 = 0x0000; //clear control register for initialization
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,137 :: 		TIM1_PSC = 7999; //1 second if counting to 9000
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;Final_Pt3.c,139 :: 		TIM1_ARR = 9000;  //target value for the counter
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,140 :: 		NVIC_ISER0.B25 = 1; //Enable update interrupt for TIM1
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER0+0)
MOVT	R1, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #25, #1
STR	R0, [R1, #0]
;Final_Pt3.c,141 :: 		TIM1_DIER.UIE = 1; //enable update interrupts for our timer
MOVW	R0, #lo_addr(TIM1_DIER+0)
MOVT	R0, #hi_addr(TIM1_DIER+0)
_SX	[R0, ByteOffset(TIM1_DIER+0)]
;Final_Pt3.c,142 :: 		TIM1_CR1 = 0x0001;     //enable timer
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,143 :: 		}
L_end_initTIM1:
BX	LR
; end of _initTIM1
_initTIM3:
;Final_Pt3.c,145 :: 		void initTIM3(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Final_Pt3.c,146 :: 		RCC_APB1ENR |= 1 << 1; //enable clock for TIM3
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,147 :: 		TIM3_CR1 = 0; //clear control register for configuration
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,148 :: 		TIM3_PSC = 7199; // 1 second if ARR = 10,000
MOVW	R1, #7199
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;Final_Pt3.c,150 :: 		TIM3_ARR = -90.90909090 * analogRead() + 10090.90909090; //timer 3 target value needs to be variable based on analog read
BL	_analogRead+0
BL	__SignedIntegralToFloat+0
MOVW	R2, #53620
MOVT	R2, #49845
BL	__Mul_FP+0
MOVW	R2, #43939
MOVT	R2, #17949
BL	__Add_FP+0
BL	__FloatToUnsignedIntegral+0
MOVW	R1, #lo_addr(TIM3_ARR+0)
MOVT	R1, #hi_addr(TIM3_ARR+0)
STR	R0, [R1, #0]
;Final_Pt3.c,151 :: 		NVIC_ISER0.B29 = 1; //Enable update interrupt for TIM3
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER0+0)
MOVT	R1, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #29, #1
STR	R0, [R1, #0]
;Final_Pt3.c,152 :: 		TIM3_DIER.UIE = 1; //enable update interrupts for our timer
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
_SX	[R0, ByteOffset(TIM3_DIER+0)]
;Final_Pt3.c,153 :: 		TIM3_CR1 = 1; //enable timer
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,154 :: 		}
L_end_initTIM3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initTIM3
_initGPIO:
;Final_Pt3.c,156 :: 		void initGPIO(){  //starts the clocks for GPIO
;Final_Pt3.c,157 :: 		RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,158 :: 		RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,159 :: 		RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,160 :: 		RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,161 :: 		RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,163 :: 		GPIOA_CRL = 0x3; // sets PA0 as an output
MOVS	R1, #3
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,164 :: 		GPIOD_CRH = 0x33333333; //set PortD/H as an output
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,165 :: 		}
L_end_initGPIO:
BX	LR
; end of _initGPIO
_find7segVal:
;Final_Pt3.c,167 :: 		void find7segVal(int sec){
; sec start address is: 0 (R0)
; sec end address is: 0 (R0)
; sec start address is: 0 (R0)
;Final_Pt3.c,168 :: 		leftIDX = (sec/10);
MOVS	R1, #10
SXTH	R1, R1
SDIV	R2, R0, R1
SXTH	R2, R2
MOVW	R1, #lo_addr(_leftIDX+0)
MOVT	R1, #hi_addr(_leftIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,169 :: 		rightIDX = sec - (leftIDX*10);
MOVS	R1, #10
SXTH	R1, R1
MULS	R1, R2, R1
SXTH	R1, R1
SUB	R2, R0, R1
; sec end address is: 0 (R0)
MOVW	R1, #lo_addr(_rightIDX+0)
MOVT	R1, #hi_addr(_rightIDX+0)
STRH	R2, [R1, #0]
;Final_Pt3.c,170 :: 		}
L_end_find7segVal:
BX	LR
; end of _find7segVal
_sendChar:
;Final_Pt3.c,172 :: 		void sendChar(char message){ //sends one character over USART
; message start address is: 0 (R0)
; message end address is: 0 (R0)
; message start address is: 0 (R0)
;Final_Pt3.c,173 :: 		if(USART1_SR.B7 == 1){
MOVW	R1, #lo_addr(USART1_SR+0)
MOVT	R1, #hi_addr(USART1_SR+0)
_LX	[R1, ByteOffset(USART1_SR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_sendChar29
;Final_Pt3.c,174 :: 		USART1_DR = message;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; message end address is: 0 (R0)
;Final_Pt3.c,175 :: 		}
L_sendChar29:
;Final_Pt3.c,176 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_sendChar30:
SUBS	R7, R7, #1
BNE	L_sendChar30
NOP
NOP
NOP
;Final_Pt3.c,177 :: 		}
L_end_sendChar:
BX	LR
; end of _sendChar
_sendPressCount:
;Final_Pt3.c,179 :: 		void sendPressCount(int idx){    //sends the direction label and count through USART
; idx start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R4, R0
; idx end address is: 0 (R0)
; idx start address is: 16 (R4)
;Final_Pt3.c,180 :: 		sendChar(letter1[idx]);
MOVW	R1, #lo_addr(_letter1+0)
MOVT	R1, #hi_addr(_letter1+0)
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,181 :: 		sendChar(letter2[idx]);
MOVW	R1, #lo_addr(_letter2+0)
MOVT	R1, #hi_addr(_letter2+0)
ADDS	R1, R1, R4
LDRB	R1, [R1, #0]
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,182 :: 		sendChar(':');
MOVS	R0, #58
BL	_sendChar+0
;Final_Pt3.c,183 :: 		sendChar(' ');
MOVS	R0, #32
BL	_sendChar+0
;Final_Pt3.c,184 :: 		sendChar((pressCounts[idx]/100) + 48);
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
;Final_Pt3.c,185 :: 		temp = (pressCounts[idx]/100) * 100;
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
;Final_Pt3.c,186 :: 		sendChar((pressCounts[idx] - temp)/10 + 48);
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
;Final_Pt3.c,187 :: 		temp = (pressCounts[idx]/10) * 10;
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
;Final_Pt3.c,188 :: 		sendChar(pressCounts[idx] - temp + 48);
LDRSH	R1, [R3, #0]
SUB	R1, R1, R2
SXTH	R1, R1
ADDS	R1, #48
UXTB	R0, R1
BL	_sendChar+0
;Final_Pt3.c,189 :: 		sendChar(13);
MOVS	R0, #13
BL	_sendChar+0
;Final_Pt3.c,190 :: 		sendChar(10);
MOVS	R0, #10
BL	_sendChar+0
;Final_Pt3.c,191 :: 		sendChar(13);
MOVS	R0, #13
BL	_sendChar+0
;Final_Pt3.c,192 :: 		sendChar(10);
MOVS	R0, #10
BL	_sendChar+0
;Final_Pt3.c,193 :: 		}
L_end_sendPressCount:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendPressCount
_joyRead:
;Final_Pt3.c,195 :: 		int joyRead(){     //determines which direction joystick is being pressed and returns 0-5
;Final_Pt3.c,196 :: 		GPIOA_CRL.B26 = 1; //Sets PA6 as an input
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
_SX	[R0, ByteOffset(GPIOA_CRL+0)]
;Final_Pt3.c,197 :: 		GPIOB_CRL.B22 = 1; //sets PB5 as an input
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
_SX	[R0, ByteOffset(GPIOB_CRL+0)]
;Final_Pt3.c,198 :: 		GPIOC_CRH.B22 = 1; //sets PC13 as an input
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
_SX	[R0, ByteOffset(GPIOC_CRH+0)]
;Final_Pt3.c,199 :: 		GPIOE_CRH = 0x33333333; //Set PortE/H as an output for LEDS
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,200 :: 		GPIOD_CRL |= 0x40400; //Sets PD2 and PD4 as an input
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #1024
MOVT	R0, #4
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,203 :: 		if(GPIOD_IDR.B4 == 0){
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_joyRead32
;Final_Pt3.c,204 :: 		return 1; //joystick up return a 1
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_joyRead
;Final_Pt3.c,205 :: 		}else if(GPIOA_IDR.B6 == 0){
L_joyRead32:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_joyRead34
;Final_Pt3.c,206 :: 		return 2; //joystick right return 2
MOVS	R0, #2
SXTH	R0, R0
IT	AL
BAL	L_end_joyRead
;Final_Pt3.c,207 :: 		}else if(GPIOB_IDR.B5 == 0){
L_joyRead34:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_joyRead36
;Final_Pt3.c,208 :: 		return 3; //joystick down return 3
MOVS	R0, #3
SXTH	R0, R0
IT	AL
BAL	L_end_joyRead
;Final_Pt3.c,209 :: 		}else if(GPIOD_IDR.B2 == 0){
L_joyRead36:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_joyRead38
;Final_Pt3.c,210 :: 		return 4; //joystick left return 4
MOVS	R0, #4
SXTH	R0, R0
IT	AL
BAL	L_end_joyRead
;Final_Pt3.c,211 :: 		}else if(GPIOC_IDR.B13 == 0){
L_joyRead38:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_joyRead40
;Final_Pt3.c,212 :: 		return 5; //joystick clicked return 5
MOVS	R0, #5
SXTH	R0, R0
IT	AL
BAL	L_end_joyRead
;Final_Pt3.c,213 :: 		}else return 0; //nothing pressed return 0
L_joyRead40:
MOVS	R0, #0
SXTH	R0, R0
;Final_Pt3.c,214 :: 		}
L_end_joyRead:
BX	LR
; end of _joyRead
_sendPressed:
;Final_Pt3.c,216 :: 		void sendPressed(){  //sends the word 'Pressed' over USART
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Final_Pt3.c,217 :: 		sendChar(' ');
MOVS	R0, #32
BL	_sendChar+0
;Final_Pt3.c,218 :: 		sendChar('P');
MOVS	R0, #80
BL	_sendChar+0
;Final_Pt3.c,219 :: 		sendChar('r');
MOVS	R0, #114
BL	_sendChar+0
;Final_Pt3.c,220 :: 		sendChar('e');
MOVS	R0, #101
BL	_sendChar+0
;Final_Pt3.c,221 :: 		sendChar('s');
MOVS	R0, #115
BL	_sendChar+0
;Final_Pt3.c,222 :: 		sendChar('s');
MOVS	R0, #115
BL	_sendChar+0
;Final_Pt3.c,223 :: 		sendChar('e');
MOVS	R0, #101
BL	_sendChar+0
;Final_Pt3.c,224 :: 		sendChar('d');
MOVS	R0, #100
BL	_sendChar+0
;Final_Pt3.c,225 :: 		sendChar(13);
MOVS	R0, #13
BL	_sendChar+0
;Final_Pt3.c,226 :: 		sendChar(10);
MOVS	R0, #10
BL	_sendChar+0
;Final_Pt3.c,227 :: 		}
L_end_sendPressed:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendPressed
_initUSART:
;Final_Pt3.c,229 :: 		void initUSART(){ //starts USART1
;Final_Pt3.c,230 :: 		RCC_APB2ENR |= 1; //start clock to PA9 and PA10 can use alternate function
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,231 :: 		AFIO_MAPR = 0xF000000; //do no want to remap PA9 and PA10 in bit 2
MOV	R1, #251658240
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,232 :: 		RCC_APB2ENR |= 1 << 2; //enable clock for PA9 and PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,233 :: 		GPIOA_CRH = 0; //clear PA9 and PA10
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,234 :: 		GPIOA_CRH |= 0x4B << 4; //sets PA9 (Tx) as a push-pull output and PA10 (Rx) as an input
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1200
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,235 :: 		RCC_APB2ENR |= 1<<14; //enable clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,236 :: 		USART1_BRR=0X506; //set baud rate to 56000
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,237 :: 		USART1_CR1.B12 = 0; //forces M as 0 so 8 data bits
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,238 :: 		USART1_CR2.B12 = 0; //forces bits 13 and 12 to 00 so there is one stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
_SX	[R0, ByteOffset(USART1_CR2+0)]
;Final_Pt3.c,239 :: 		USART1_CR2.B13 = 0;
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
_SX	[R0, ByteOffset(USART1_CR2+0)]
;Final_Pt3.c,240 :: 		USART1_CR3.B8 = 0; //forces bit 8 to 0 so no RTS hardware flow
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
_SX	[R0, ByteOffset(USART1_CR3+0)]
;Final_Pt3.c,241 :: 		USART1_CR3.B9 = 0; //forces bit 9 to 0 so no CTS hardware flow
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
_SX	[R0, ByteOffset(USART1_CR3+0)]
;Final_Pt3.c,242 :: 		USART1_CR1.B9 = 0; //forces even parity but we will turn it off
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,243 :: 		USART1_CR1.B10 = 0;//forces no parity
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,244 :: 		USART1_CR1.B2 = 1; //Rx enabled
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,245 :: 		USART1_CR1.B3 = 1; //Tx enabled
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,246 :: 		USART1_CR1.B13 = 1; //Enables UART and needs to be enabled after all the configuration above
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
_SX	[R0, ByteOffset(USART1_CR1+0)]
;Final_Pt3.c,247 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_initUSART42:
SUBS	R7, R7, #1
BNE	L_initUSART42
NOP
NOP
NOP
;Final_Pt3.c,248 :: 		}
L_end_initUSART:
BX	LR
; end of _initUSART
_analogRead:
;Final_Pt3.c,250 :: 		int analogRead(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Final_Pt3.c,254 :: 		GPIOC_CRL = 0;         //Sets PC0 to be an analog input
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;Final_Pt3.c,255 :: 		RCC_APB2ENR |= 1 << 9 ; // Enable ADC1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;Final_Pt3.c,256 :: 		ADC1_SQR1 = 0; // sets ADC to do 1 conversion
MOVS	R1, #0
MOVW	R0, #lo_addr(ADC1_SQR1+0)
MOVT	R0, #hi_addr(ADC1_SQR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,257 :: 		ADC1_SQR3 = 10; // Select Channel 10 as only one in conversion sequence
MOVS	R1, #10
MOVW	R0, #lo_addr(ADC1_SQR3+0)
MOVT	R0, #hi_addr(ADC1_SQR3+0)
STR	R1, [R0, #0]
;Final_Pt3.c,258 :: 		ADC1_SMPR1 = 0b100; // Set sample time on channel 10
MOVS	R1, #4
MOVW	R0, #lo_addr(ADC1_SMPR1+0)
MOVT	R0, #hi_addr(ADC1_SMPR1+0)
STR	R1, [R0, #0]
;Final_Pt3.c,259 :: 		ADC1_CR2.B17 = 1; // Set software start as external event for regular group conversion
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,260 :: 		ADC1_CR2.B18 = 1;
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,261 :: 		ADC1_CR2.B19 = 1;
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,262 :: 		ADC1_CR2.ADON = 1; // Enable ADC1
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,265 :: 		ADC1_CR2.B20 = 1 ; //enables external trigger conversion mode
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,266 :: 		ADC1_CR2.B22 = 1; //starts the conversion
MOVW	R0, #lo_addr(ADC1_CR2+0)
MOVT	R0, #hi_addr(ADC1_CR2+0)
_SX	[R0, ByteOffset(ADC1_CR2+0)]
;Final_Pt3.c,267 :: 		while(ADC1_SR.B1 != 1){} //wait until conversion is done
L_analogRead44:
MOVW	R0, #lo_addr(ADC1_SR+0)
MOVT	R0, #hi_addr(ADC1_SR+0)
_LX	[R0, ByteOffset(ADC1_SR+0)]
CMP	R0, #0
IT	NE
BNE	L_analogRead45
IT	AL
BAL	L_analogRead44
L_analogRead45:
;Final_Pt3.c,268 :: 		ADCval = ADC1_DR;
MOVW	R0, #lo_addr(ADC1_DR+0)
MOVT	R0, #hi_addr(ADC1_DR+0)
; ADCval start address is: 0 (R0)
LDR	R0, [R0, #0]
;Final_Pt3.c,270 :: 		adjustedADC = (0.02584856397 * ADCval) + (0.974151436) + 0.5; //pot goes from 0-3831 we want to display 1-100 so this formula
BL	__SignedIntegralToFloat+0
; ADCval end address is: 0 (R0)
MOVW	R2, #49246
MOVT	R2, #15571
BL	__Mul_FP+0
MOVW	R2, #25085
MOVT	R2, #16249
BL	__Add_FP+0
MOV	R2, #1056964608
BL	__Add_FP+0
BL	__FloatToSignedIntegral+0
SXTH	R0, R0
;Final_Pt3.c,272 :: 		return adjustedADC;
;Final_Pt3.c,273 :: 		}
L_end_analogRead:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _analogRead

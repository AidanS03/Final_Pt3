_TIM1_ISR:
;Final_Pt3.c,20 :: 		void TIM1_ISR() iv IVT_INT_TIM1_UP {
;Final_Pt3.c,21 :: 		TIM1_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;Final_Pt3.c,22 :: 		TIM1count++;
MOVW	R1, #lo_addr(_TIM1count+0)
MOVT	R1, #hi_addr(_TIM1count+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,23 :: 		pressCounts[5]++;
MOVW	R1, #lo_addr(_pressCounts+10)
MOVT	R1, #hi_addr(_pressCounts+10)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,24 :: 		}
L_end_TIM1_ISR:
BX	LR
; end of _TIM1_ISR
_TIM3_ISR:
;Final_Pt3.c,26 :: 		void TIM3_ISR() iv IVT_INT_TIM3 ics ICS_OFF {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Final_Pt3.c,27 :: 		GPIOE_CRH = 0x33333333; // sets PE14 as an output for buzzer
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;Final_Pt3.c,28 :: 		TIM3_SR.UIF = 0; //clear the check bit
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
_SX	[R0, ByteOffset(TIM3_SR+0)]
;Final_Pt3.c,29 :: 		initTIM3(); //will read pot and update the ARR to change timer speed
BL	_initTIM3+0
;Final_Pt3.c,30 :: 		GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PA0
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_LX	[R0, ByteOffset(GPIOA_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;Final_Pt3.c,31 :: 		GPIOE_ODR.B14 = ~GPIOE_ODR.B14;  //flips PE14 to activate buzzer
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,32 :: 		}
L_end_TIM3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIM3_ISR
_PD2_Press_LEFT:
;Final_Pt3.c,34 :: 		void PD2_Press_LEFT() iv IVT_INT_EXTI2 ics ICS_AUTO {
;Final_Pt3.c,35 :: 		EXTI_PR.B2 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;Final_Pt3.c,36 :: 		GPIOE_ODR.B13 = ~GPIOE_ODR.B13;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,37 :: 		pressCounts[3]++;
MOVW	R1, #lo_addr(_pressCounts+6)
MOVT	R1, #hi_addr(_pressCounts+6)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,38 :: 		}
L_end_PD2_Press_LEFT:
BX	LR
; end of _PD2_Press_LEFT
_PD4_Press_UP:
;Final_Pt3.c,40 :: 		void PD4_Press_UP() iv IVT_INT_EXTI4 ics ICS_AUTO {
;Final_Pt3.c,41 :: 		EXTI_PR.B4 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;Final_Pt3.c,42 :: 		GPIOE_ODR.B11 = ~GPIOE_ODR.B11;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,43 :: 		GPIOE_ODR.B15 = ~GPIOE_ODR.B15;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,44 :: 		pressCounts[0]++;
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,45 :: 		}
L_end_PD4_Press_UP:
BX	LR
; end of _PD4_Press_UP
_PA6_PB5_Press:
;Final_Pt3.c,47 :: 		void PA6_PB5_Press() iv IVT_INT_EXTI9_5 ics ICS_OFF {
;Final_Pt3.c,48 :: 		if(GPIOA_IDR.B6 == 0){
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_PA6_PB5_Press0
;Final_Pt3.c,49 :: 		EXTI_PR.B6 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;Final_Pt3.c,50 :: 		GPIOE_ODR.B9 = ~GPIOE_ODR.B9;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,51 :: 		GPIOE_ODR.B10 = ~GPIOE_ODR.B10;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,52 :: 		pressCounts[1]++;
MOVW	R1, #lo_addr(_pressCounts+2)
MOVT	R1, #hi_addr(_pressCounts+2)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,53 :: 		}else if (GPIOB_IDR.B5 == 0){
IT	AL
BAL	L_PA6_PB5_Press1
L_PA6_PB5_Press0:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_PA6_PB5_Press2
;Final_Pt3.c,54 :: 		EXTI_PR.B5 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;Final_Pt3.c,55 :: 		GPIOE_ODR.B8 = ~GPIOE_ODR.B8;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,56 :: 		GPIOE_ODR.B12 = ~GPIOE_ODR.B12;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_LX	[R0, ByteOffset(GPIOE_ODR+0)]
EOR	R1, R0, #1
UXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;Final_Pt3.c,57 :: 		pressCounts[2]++;
MOVW	R1, #lo_addr(_pressCounts+4)
MOVT	R1, #hi_addr(_pressCounts+4)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,58 :: 		}
L_PA6_PB5_Press2:
L_PA6_PB5_Press1:
;Final_Pt3.c,59 :: 		}
L_end_PA6_PB5_Press:
BX	LR
; end of _PA6_PB5_Press
_main:
;Final_Pt3.c,62 :: 		void main() {
;Final_Pt3.c,63 :: 		initUSART(); //starts USART1
BL	_initUSART+0
;Final_Pt3.c,64 :: 		initGPIO(); //initializes GPIO
BL	_initGPIO+0
;Final_Pt3.c,65 :: 		initTIM1(); //Initializes TIM1
BL	_initTIM1+0
;Final_Pt3.c,66 :: 		initTIM3();
BL	_initTIM3+0
;Final_Pt3.c,67 :: 		initEXTI();
BL	_initEXTI+0
;Final_Pt3.c,68 :: 		TIM1count = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,69 :: 		buzzerOn = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_buzzerOn+0)
MOVT	R0, #hi_addr(_buzzerOn+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,70 :: 		for(;;){
L_main3:
;Final_Pt3.c,71 :: 		if(TIM1count >= 100){
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
CMP	R0, #100
IT	LT
BLT	L_main6
;Final_Pt3.c,72 :: 		TIM1count = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,73 :: 		}
L_main6:
;Final_Pt3.c,74 :: 		find7segVal(TIM1count);
MOVW	R0, #lo_addr(_TIM1count+0)
MOVT	R0, #hi_addr(_TIM1count+0)
LDRSH	R0, [R0, #0]
BL	_find7segVal+0
;Final_Pt3.c,75 :: 		GPIOD_ODR = leftNum[leftIDX];
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
;Final_Pt3.c,76 :: 		delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
NOP
;Final_Pt3.c,77 :: 		GPIOD_ODR = rightNum[rightIDX];
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
;Final_Pt3.c,78 :: 		delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main9:
SUBS	R7, R7, #1
BNE	L_main9
NOP
NOP
NOP
;Final_Pt3.c,79 :: 		if(USART1_SR.B5 == 1){
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
_LX	[R0, ByteOffset(USART1_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main11
;Final_Pt3.c,80 :: 		recieved = USART1_DR; //check if reciever data register is empty and update if it is
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,81 :: 		}
L_main11:
;Final_Pt3.c,82 :: 		if(recieved == 'Q'){
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
LDRSH	R0, [R0, #0]
CMP	R0, #81
IT	NE
BNE	L_main12
;Final_Pt3.c,84 :: 		for(i = 0; i < 38; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main13:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #38
IT	GE
BGE	L_main14
;Final_Pt3.c,85 :: 		sendChar(CountMessage[i]); //sends the data title
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_CountMessage+0)
MOVT	R0, #hi_addr(_CountMessage+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_sendChar+0
;Final_Pt3.c,84 :: 		for(i = 0; i < 38; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,86 :: 		}
IT	AL
BAL	L_main13
L_main14:
;Final_Pt3.c,87 :: 		for(i = 0; i < 6; i++){
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRH	R1, [R0, #0]
L_main16:
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
CMP	R0, #6
IT	GE
BGE	L_main17
;Final_Pt3.c,88 :: 		sendPressCount(i); //sends the label and data for each direction
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRSH	R0, [R0, #0]
BL	_sendPressCount+0
;Final_Pt3.c,87 :: 		for(i = 0; i < 6; i++){
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,89 :: 		}
IT	AL
BAL	L_main16
L_main17:
;Final_Pt3.c,90 :: 		}
L_main12:
;Final_Pt3.c,91 :: 		recieved = 0; //clears the pause/unpause variable, needed to prevent looping
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_recieved+0)
MOVT	R0, #hi_addr(_recieved+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,92 :: 		joy = joyRead(); //reads what direction the joystick is in and returns 0-5
BL	_joyRead+0
MOVW	R1, #lo_addr(_joy+0)
MOVT	R1, #hi_addr(_joy+0)
STRH	R0, [R1, #0]
;Final_Pt3.c,93 :: 		switch(joy){
IT	AL
BAL	L_main19
;Final_Pt3.c,94 :: 		case 0: //no press do nothing
L_main21:
;Final_Pt3.c,95 :: 		sent = 0; //sent variable is used to avoid the message from being sent multiple times for one press
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,96 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,97 :: 		case 1: //up press, send UP
L_main22:
;Final_Pt3.c,98 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main23
;Final_Pt3.c,99 :: 		sendChar('U');
MOVS	R0, #85
BL	_sendChar+0
;Final_Pt3.c,100 :: 		sendChar('P');  //sends the message, updates the sent variable and adds one to the count
MOVS	R0, #80
BL	_sendChar+0
;Final_Pt3.c,101 :: 		sendPressed();  //same process for each direction
BL	_sendPressed+0
;Final_Pt3.c,102 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,103 :: 		pressCounts[0] = pressCounts[0] + 1;
MOVW	R1, #lo_addr(_pressCounts+0)
MOVT	R1, #hi_addr(_pressCounts+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,104 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,105 :: 		}
L_main23:
;Final_Pt3.c,106 :: 		case 2: //right press, send RT
L_main24:
;Final_Pt3.c,107 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main25
;Final_Pt3.c,108 :: 		sendChar('R');
MOVS	R0, #82
BL	_sendChar+0
;Final_Pt3.c,109 :: 		sendChar('T');
MOVS	R0, #84
BL	_sendChar+0
;Final_Pt3.c,110 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,111 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,112 :: 		pressCounts[1] = pressCounts[1] + 1;
MOVW	R1, #lo_addr(_pressCounts+2)
MOVT	R1, #hi_addr(_pressCounts+2)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,113 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,114 :: 		}
L_main25:
;Final_Pt3.c,115 :: 		case 3: //down press, send DN
L_main26:
;Final_Pt3.c,116 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main27
;Final_Pt3.c,117 :: 		sendChar('D');
MOVS	R0, #68
BL	_sendChar+0
;Final_Pt3.c,118 :: 		sendChar('N');
MOVS	R0, #78
BL	_sendChar+0
;Final_Pt3.c,119 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,120 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,121 :: 		pressCounts[2] = pressCounts[2] + 1;
MOVW	R1, #lo_addr(_pressCounts+4)
MOVT	R1, #hi_addr(_pressCounts+4)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,122 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,123 :: 		}
L_main27:
;Final_Pt3.c,124 :: 		case 4: //left press, send LT
L_main28:
;Final_Pt3.c,125 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main29
;Final_Pt3.c,126 :: 		sendChar('L');
MOVS	R0, #76
BL	_sendChar+0
;Final_Pt3.c,127 :: 		sendChar('T');
MOVS	R0, #84
BL	_sendChar+0
;Final_Pt3.c,128 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,129 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,130 :: 		pressCounts[3] = pressCounts[3] + 1;
MOVW	R1, #lo_addr(_pressCounts+6)
MOVT	R1, #hi_addr(_pressCounts+6)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,131 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,132 :: 		}
L_main29:
;Final_Pt3.c,133 :: 		case 5: //click press, send CK
L_main30:
;Final_Pt3.c,134 :: 		if(sent == 0){
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main31
;Final_Pt3.c,135 :: 		sendChar('C');
MOVS	R0, #67
BL	_sendChar+0
;Final_Pt3.c,136 :: 		sendChar('K');
MOVS	R0, #75
BL	_sendChar+0
;Final_Pt3.c,137 :: 		sendPressed();
BL	_sendPressed+0
;Final_Pt3.c,138 :: 		sent = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_sent+0)
MOVT	R0, #hi_addr(_sent+0)
STRH	R1, [R0, #0]
;Final_Pt3.c,139 :: 		pressCounts[4] = pressCounts[4] + 1;
MOVW	R1, #lo_addr(_pressCounts+8)
MOVT	R1, #hi_addr(_pressCounts+8)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Final_Pt3.c,140 :: 		break;
IT	AL
BAL	L_main20
;Final_Pt3.c,141 :: 		}
L_main31:
;Final_Pt3.c,142 :: 		}
IT	AL
BAL	L_main20
L_main19:
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main21
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_main22
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_main24
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_main26
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_main28
MOVW	R0, #lo_addr(_joy+0)
MOVT	R0, #hi_addr(_joy+0)
LDRSH	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_main30
L_main20:
;Final_Pt3.c,143 :: 		}
IT	AL
BAL	L_main3
;Final_Pt3.c,144 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main

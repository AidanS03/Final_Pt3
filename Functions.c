#include "Functions.h"

int leftIDX, rightIDX, temp;
char letter1[6] = {'U', 'R', 'D', 'L', 'C', 'T'};
char letter2[6] = {'P', 'T', 'N', 'T', 'K', 'M'};
int pressCounts[6] = {0,0,0,0,0,0}; //from left to right UP, RT, DN, LT, CK

void initTIM1(){
     RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
     TIM1_CR1 = 0x0000; //clear control register for initialization
     TIM1_PSC = 7999; //1 second if counting to 9000
                       //9000 = 72,000,000/(7999 + 1)
     TIM1_ARR = 9000;  //target value for the counter
     NVIC_ISER0.B25 = 1; //Enable update interrupt for TIM1
     TIM1_DIER.UIE = 1; //enable update interrupts for our timer
     TIM1_CR1 = 0x0001;     //enable timer
}

void initTIM3(){
     RCC_APB1ENR |= 1 << 1; //enable clock for TIM3
     TIM3_CR1 = 0; //clear control register for configuration
     TIM3_PSC = 7199; // 1 second if ARR = 10,000
                      // 10,000 = 72,000,000/(7,199 + 1)
     TIM3_ARR = -90.90909090 * analogRead() + 10090.90909090; //timer 3 target value needs to be variable based on analog read
     NVIC_ISER0.B29 = 1; //Enable update interrupt for TIM3
     TIM3_DIER.UIE = 1; //enable update interrupts for our timer
     TIM3_CR1 = 1; //enable timer
}

void initGPIO(){  //starts the clocks for GPIO
     RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
     RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
     RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
     RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
     RCC_APB2ENR |= 1 << 6;  //enables clock for PortE

     GPIOA_CRL = 0x3; // sets PA0 as an output
     GPIOD_CRH = 0x33333333; //set PortD/H as an output
     GPIOE_CRH = 0x33333333; // set PortE/H as an output
     
     GPIOA_CRL.B26 = 1; //Sets PA6 as an input
     GPIOB_CRL.B22 = 1; //sets PB5 as an input
     GPIOC_CRH.B22 = 1; //sets PC13 as an input
     GPIOD_CRL |= 0x40400; //Sets PD2 and PD4 as an input
}

void initEXTI(){
     GPIOA_CRL = 0x4000000; //sets PA6 as a floating input
     GPIOB_CRL = 0x400000; //sets PB5 as a floating input
     GPIOD_CRL = 0x40400; //sets PD2 and PD4 as a floating input

     AFIO_EXTICR1 = 0x0300; //configure PD2 as an interrupt
     AFIO_EXTICR2 = 0x0013; //configure PD4, PB5, and PA6 as an external interrupt
     
     EXTI_FTSR = 0x0074;   //enable rising edge trigger
     
     EXTI_IMR = 0x0074; //sets our interrupts so they cannot be masked, activate immediatly
     NVIC_ISER0.B8 = 1;  //enables interrupts for line 2
     NVIC_ISER0.B10 = 1;  //enables interrupts for line 4
     NVIC_ISER0.B23 = 1;  //enables interrupts for lines 5-9
}

void initUSART(){ //starts USART1
     RCC_APB2ENR.AFIOEN= 1; //start clock to PA9 and PA10 can use alternate function
     AFIO_MAPR = 0xF000000; //do no want to remap PA9 and PA10 in bit 2
     RCC_APB2ENR |= 1 << 2; //enable clock for PA9 and PA10
     GPIOA_CRH = 0; //clear PA9 and PA10
     GPIOA_CRH |= 0x4B << 4; //sets PA9 (Tx) as a push-pull output and PA10 (Rx) as an input
     RCC_APB2ENR |= 1<<14; //enable clock for USART1
     USART1_BRR=0X506; //set baud rate to 56000
     USART1_CR1.B12 = 0; //forces M as 0 so 8 data bits
     USART1_CR2.B12 = 0; //forces bits 13 and 12 to 00 so there is one stop bit
     USART1_CR2.B13 = 0;
     USART1_CR3.B8 = 0; //forces bit 8 to 0 so no RTS hardware flow
     USART1_CR3.B9 = 0; //forces bit 9 to 0 so no CTS hardware flow
     USART1_CR1.B9 = 0; //forces even parity but we will turn it off
     USART1_CR1.B10 = 0;//forces no parity
     USART1_CR1.B2 = 1; //Rx enabled
     USART1_CR1.B3 = 1; //Tx enabled
     USART1_CR1.B13 = 1; //Enables UART and needs to be enabled after all the configuration above
     Delay_ms(100);
}

void find7segVal(int sec){
     leftIDX = (sec/10);
     rightIDX = sec - (leftIDX*10);
}

void sendChar(char message){ //sends one character over USART
     if(USART1_SR.B7 == 1){
          USART1_DR = message;
     }
     Delay_ms(1);
}

void sendPressCount(int idx){    //sends the direction label and count through USART
     sendChar(letter1[idx]);
     sendChar(letter2[idx]);
     sendChar(':');
     sendChar(' ');
     sendChar((pressCounts[idx]/100) + 48);
     temp = (pressCounts[idx]/100) * 100;
     sendChar((pressCounts[idx] - temp)/10 + 48);
     temp = (pressCounts[idx]/10) * 10;
     sendChar(pressCounts[idx] - temp + 48);
     sendChar(13);
     sendChar(10);
     sendChar(13);
     sendChar(10);
}

int joyRead(){     //determines which direction joystick is being pressed and returns 0-5

     if(GPIOD_IDR.B4 == 0){
          return 1; //joystick up return a 1
     }else if(GPIOA_IDR.B6 == 0){
          return 2; //joystick right return 2
     }else if(GPIOB_IDR.B5 == 0){
          return 3; //joystick down return 3
     }else if(GPIOD_IDR.B2 == 0){
          return 4; //joystick left return 4
     }else if(GPIOC_IDR.B13 == 0){
          return 5; //joystick clicked return 5
     }else return 0; //nothing pressed return 0
}

void sendPressed(){  //sends the word 'Pressed' over USART
     sendChar(' ');
     sendChar('P');
     sendChar('r');
     sendChar('e');
     sendChar('s');
     sendChar('s');
     sendChar('e');
     sendChar('d');
     sendChar(13);
     sendChar(10);
}

int analogRead(){
     int ADCval;
     int adjustedADC;
//Configure the ADC
     GPIOC_CRL = 0;         //Sets PC0 to be an analog input
     RCC_APB2ENR |= 1 << 9 ; // Enable ADC1 Clock
     ADC1_SQR1 = 0; // sets ADC to do 1 conversion
     ADC1_SQR3 = 10; // Select Channel 10 as only one in conversion sequence
     ADC1_SMPR1 = 0b100; // Set sample time on channel 10
     ADC1_CR2.B17 = 1; // Set software start as external event for regular group conversion
     ADC1_CR2.B18 = 1;
     ADC1_CR2.B19 = 1;
     ADC1_CR2.ADON = 1; // Enable ADC1

//read the value of the ADC
     ADC1_CR2.B20 = 1 ; //enables external trigger conversion mode
     ADC1_CR2.B22 = 1; //starts the conversion
     while(ADC1_SR.B1 != 1){} //wait until conversion is done
     ADCval = ADC1_DR;
//scale the ADC value
     adjustedADC = (0.02584856397 * ADCval) + (0.974151436) + 0.5; //pot goes from 0-3831 we want to display 1-100 so this formula
     //scales the ADC value to be between 1 and 100 the extra 0.5 is needed for rounding
     return adjustedADC;
}
//Name: Aidan Stoner, Shaunessy Reynolds, Erin Cardino, Marc Santacapita
//Date: 12/4/23
//Course: ELEC-3371
//Description: Use interupts to flash an LED when TIM1 reaches one second, update 
//             TIM3 when the analog potentiometer changes, rewrite the joystick fucntion
//             using interupts, and activate a buzzer using an interupt
//******************************************************************************
//Global Variables:
int TIM1count, i, recieved, temp, sent, joy;
int leftNum[10] = {0xA000, 0xA100, 0xA400, 0xA500, 0xB000, 0xB100, 0xB400, 0xB500, 0xE000, 0xE100};
int rightNum[10] = {0xA800, 0xA900, 0xAC00, 0xAD00, 0xB800, 0xB900, 0xBC00, 0xBD00, 0xE800, 0xE900}; //Variables for 7-seg display initially set to 0
int leftIDX, rightIDX;
char CountMessage[38] = {'J','o','y','s','t','i','c','k',' ','P','r','e','s','s','e','s',' ','S','i','n','c','e',' ','L','a','s','t',' ','R','e','s','e','t',':',13,10,13,10};
char letter1[6] = {'U', 'R', 'D', 'L', 'C', 'T'};
char letter2[6] = {'P', 'T', 'N', 'T', 'K', 'M'};
int pressCounts[6] = {0,0,0,0,0,0}; //from left to right UP, RT, DN, LT, CK
//******************************************************************************
//Functions:
void initTIM1();
void initGPIO();
void find7segVal(int sec);
void sendChar(char message);
void sendPressCount(int IDX);
int joyRead();
void sendPressed();
void initUSART();
//******************************************************************************
//Interrupt Routines:
void TIM1_ISR() iv IVT_INT_TIM1_UP {
     TIM1_SR.UIF = 0; //clear the check bit
     GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
     TIM1count++;
     pressCounts[5]++;
}

//******************************************************************************
//Main:
void main() {
     initUSART(); //starts USART1
     initGPIO(); //initializes GPIO
     initTIM1(); //Initializes TIM1
     TIM1count = -1;
     for(;;){
          if(TIM1count >= 100){
               TIM1count = 0;
          }
          find7segVal(TIM1count);
          GPIOD_ODR = leftNum[leftIDX];
          delay_ms(1);
          GPIOD_ODR = rightNum[rightIDX];
          delay_ms(1);
          if(USART1_SR.B5 == 1){
               recieved = USART1_DR; //check if reciever data register is empty and update if it is
          }
          if(recieved == 'Q'){
               //print press count for each button to UART1
               for(i = 0; i < 38; i++){
                    sendChar(CountMessage[i]); //sends the data title
               }
               for(i = 0; i < 6; i++){
                    sendPressCount(i); //sends the label and data for each direction
               }
          }
          recieved = 0; //clears the pause/unpause variable, needed to prevent looping
          joy = joyRead(); //reads what direction the joystick is in and returns 0-5
          switch(joy){
               case 0: //no press do nothing
                    sent = 0; //sent variable is used to avoid the message from being sent multiple times for one press
                    break;
               case 1: //up press, send UP
                    if(sent == 0){
                         sendChar('U');
                         sendChar('P');  //sends the message, updates the sent variable and adds one to the count
                         sendPressed();  //same process for each direction
                         sent = 1;
                         pressCounts[0] = pressCounts[0] + 1;
                         break;
                    }
               case 2: //right press, send RT
                    if(sent == 0){
                         sendChar('R');
                         sendChar('T');
                         sendPressed();
                         sent = 1;
                         pressCounts[1] = pressCounts[1] + 1;
                         break;
                    }
               case 3: //down press, send DN
                    if(sent == 0){
                         sendChar('D');
                         sendChar('N');
                         sendPressed();
                         sent = 1;
                         pressCounts[2] = pressCounts[2] + 1;
                         break;
                    }
               case 4: //left press, send LT
                    if(sent == 0){
                         sendChar('L');
                         sendChar('T');
                         sendPressed();
                         sent = 1;
                         pressCounts[3] = pressCounts[3] + 1;
                         break;
                    }
               case 5: //click press, send CK
                    if(sent == 0){
                         sendChar('C');
                         sendChar('K');
                         sendPressed();
                         sent = 1;
                         pressCounts[4] = pressCounts[4] + 1;
                         break;
                    }
          }
     }

}
//******************************************************************************
//Function Definitions
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

void initGPIO(){  //starts the clocks for GPIO
     RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
     RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
     RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
     RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
     RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
     
     GPIOA_CRL = 0x3; // sets PA0 as an output
     GPIOD_CRH = 0x33333333; //set PortE/H as an output
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
     GPIOA_CRL.B26 = 1; //Sets PA6 as an input
     GPIOB_CRL.B22 = 1; //sets PB5 as an input
     GPIOC_CRH.B22 = 1; //sets PC13 as an input
     GPIOE_CRH = 0x33333333; //Set PortE/H as an output for LEDS
     GPIOD_CRL |= 0x40400; //Sets PD2 and PD4 as an input


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

void initUSART(){ //starts USART1
     RCC_APB2ENR |= 1; //start clock to PA9 and PA10 can use alternate function
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
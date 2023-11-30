//Name: Aidan Stoner, Shaunessy Reynolds, Erin Cardino, Marc Santacapita
//Date: 12/4/23
//Course: ELEC-3371
//Description: Use interupts to flash an LED when TIM1 reaches one second, update 
//             TIM3 when the analog potentiometer changes, rewrite the joystick fucntion
//             using interupts, and activate a buzzer using an interupt
//******************************************************************************
//Global Variables:
int TIM1count, i, recieved, temp;
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
     initGPIO();
     initTIM1();
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
          if(recieved == 'Q'){
               //print press count for each button to UART1
               for(i = 0; i < 38; i++){
                    sendChar(CountMessage[i]); //sends the data title
               }
               for(i = 0; i < 5; i++){
                    sendPressCount(i); //sends the label and data for each direction
               }
          }
          recieved = 0; //clears the pause/unpause variable, needed to prevent looping
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
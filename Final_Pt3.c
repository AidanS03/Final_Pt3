//Name: Aidan Stoner, Shaunessy Reynolds, Erin Cardino, Marc Santacapita
//Date: 12/4/23
//Course: ELEC-3371
//Description: Use interupts to flash an LED when TIM1 reaches one second, update 
//             TIM3 when the analog potentiometer changes, rewrite the joystick fucntion
//             using interupts, and activate a buzzer using an interupt
//******************************************************************************
//Global Variables:
int TIM1count, i, recieved, sent, joy, buzzerOn;
int leftNum[10] = {0xA000, 0xA100, 0xA400, 0xA500, 0xB000, 0xB100, 0xB400, 0xB500, 0xE000, 0xE100};
int rightNum[10] = {0xA800, 0xA900, 0xAC00, 0xAD00, 0xB800, 0xB900, 0xBC00, 0xBD00, 0xE800, 0xE900}; //Variables for 7-seg display initially set to 0
char CountMessage[38] = {'J','o','y','s','t','i','c','k',' ','P','r','e','s','s','e','s',' ','S','i','n','c','e',' ','L','a','s','t',' ','R','e','s','e','t',':',13,10,13,10};
//******************************************************************************
//Inclusions
#include "Functions.h"

extern leftIDX, rightIDX, pressCounts[5];
//******************************************************************************
//Interrupt Routines:
void TIM1_ISR() iv IVT_INT_TIM1_UP {
     TIM1_SR.UIF = 0; //clear the check bit
     TIM1count++;
     pressCounts[5]++;
}

void TIM3_ISR() iv IVT_INT_TIM3 ics ICS_OFF {
     GPIOE_CRH = 0x33333333; // sets PE14 as an output for buzzer
     TIM3_SR.UIF = 0; //clear the check bit
     initTIM3(); //will read pot and update the ARR to change timer speed
     GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PA0
     GPIOE_ODR.B14 = ~GPIOE_ODR.B14;  //flips PE14 to activate buzzer
}

void PD2_Press_LEFT() iv IVT_INT_EXTI2 ics ICS_AUTO {
     EXTI_PR.B2 = 1;
     GPIOE_ODR.B13 = ~GPIOE_ODR.B13;
     pressCounts[3]++;
     joy = 4;
}

void PD4_Press_UP() iv IVT_INT_EXTI4 ics ICS_AUTO {
     EXTI_PR.B4 = 1;
     GPIOE_ODR.B11 = ~GPIOE_ODR.B11;
     GPIOE_ODR.B15 = ~GPIOE_ODR.B15;
     pressCounts[0]++;
     joy = 1;
}

void PA6_PB5_Press() iv IVT_INT_EXTI9_5 ics ICS_OFF {
     if(GPIOA_IDR.B6 == 0){
          EXTI_PR.B6 = 1;
          GPIOE_ODR.B9 = ~GPIOE_ODR.B9;
          GPIOE_ODR.B10 = ~GPIOE_ODR.B10;
          pressCounts[1]++;
          joy = 2;
     }else if (GPIOB_IDR.B5 == 0){
          EXTI_PR.B5 = 1;
          GPIOE_ODR.B8 = ~GPIOE_ODR.B8;
          GPIOE_ODR.B12 = ~GPIOE_ODR.B12;
          pressCounts[2]++;
          joy = 3;
     }
}
//******************************************************************************
//Main:
void main() {
     initUSART(); //starts USART1
     initGPIO(); //initializes GPIO
     initTIM1(); //Initializes TIM1
     initTIM3();
     initEXTI();
     TIM1count = -1;
     buzzerOn = 0;
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
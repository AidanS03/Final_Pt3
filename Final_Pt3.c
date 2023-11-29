//Name: Aidan Stoner, Shaunessy Reynolds, Erin Cardino, Marc Santacapita
//Date: 12/4/23
//Course: ELEC-3371
//Description: Use interupts to flash an LED when TIM1 reaches one second, update 
//             TIM3 when the analog potentiometer changes, rewrite the joystick fucntion
//             using interupts, and activate a buzzer using an interupt
//******************************************************************************
//Global Variables:
int TIM1count;
int leftNum[10] = {0xA000, 0xA100, 0xA400, 0xA500, 0xB000, 0xB100, 0xB400, 0xB500, 0xE000, 0xE100};
int rightNum[10] = {0xA800, 0xA900, 0xAC00, 0xAD00, 0xB800, 0xB900, 0xBC00, 0xBD00, 0xE800, 0xE900}; //Variables for 7-seg display initially set to 0
int leftIDX, rightIDX;
//******************************************************************************
//Functions:
void initTIM1();
void initGPIO();
void find7segVal(int sec);
//******************************************************************************
//Interrupt Routines:
void TIM1_ISR() iv IVT_INT_TIM1_UP {
     TIM1_SR.UIF = 0; //clear the check bit
     GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
     TIM1count++;
}



//******************************************************************************
//Main:
void main() {
     initGPIO();
     initTIM1();
     TIM1count = -1;
     for(;;){
          if(TIM1count >= 100){TIM1count = 0;}
          find7segVal(TIM1count);
          GPIOD_ODR = leftNum[leftIDX];
          delay_ms(1);
          GPIOD_ODR = rightNum[rightIDX];
          delay_ms(1);
     }
}

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
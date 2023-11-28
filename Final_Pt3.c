//Name: Aidan Stoner, Shaunessy Reynolds, Erin Cardino, Marc Santacapita
//Date: 12/4/23
//Course: ELEC-3371
//Description: Use interupts to flash an LED when TIM1 reaches one second, update 
//             TIM3 when the analog potentiometer changes, rewrite the joystick fucntion
//             using interupts, and activate a buzzer using an interupt
//******************************************************************************
//Global Variables:

//******************************************************************************
//Functions:
void initTIM1();
void initGPIO();

//******************************************************************************
//Interrupt Routines:
void TIM1_ISR() iv IVT_INT_TIM1_CC {
     TIM1_SR.UIF = 0; //clear the check bit
     GPIOA_ODR.B0 = ~GPIOA_ODR.B0; //flips PE8
}
//******************************************************************************
//Main:
void main() {
     initGPIO();
     initTIM1();
     for(;;){

     }
}

void initTIM1(){
     RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
     TIM1_CR1 = 0x0000; //clear control register for initialization
     TIM1_PSC = 14399; //1 second if counting to 5000
                       //5000 = 72,000,000/(14399 + 1)
     TIM1_ARR = 5000;  //target value for the counter
     NVIC_ISER0 |= 1 << 24; //Enable break interrupt for TIM1
     TIM1_DIER.UIE = 1; //enable update interrupts for our timer
     TIM1_CR1 = 0x0001;     //enable timer
}

void initGPIO(){  //starts the clocks for GPIO
     RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
     RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
     RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
     RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
     RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
     
     GPIOA_CRL = 0x3; // sets PortA/L as an output
}
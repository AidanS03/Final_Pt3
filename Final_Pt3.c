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
//Main:
void main() {
     initGPIO();
     initTIM1();
     for(;;){
          if(TIM1_SR.UIF == 1){ //check if counter reached target value
               TIM1_SR.UIF = 0; //clear the check bit
               GPIOE_ODR = ~ GPIOE_ODR; //flips PE8
          }
     }
}

void initTIM1(){
     RCC_APB2ENR |= 1 << 11; //enable clock for TIM1
     TIM1_CR1 = 0; //clear control register for initialization
     TIM1_PSC = 7999; //1 second if counting to 5000
                       //5000 = 72,000,000/(14399 + 1)
     TIM1_ARR = 9000;  //target value for the counter
     TIM1_CR1 = 1;     //enable timer
}

void initGPIO(){  //starts the clocks for GPIO
     RCC_APB2ENR |= 1 << 2;  //enables clock for PortA
     RCC_APB2ENR |= 1 << 3;  //enables clock for PortB
     RCC_APB2ENR |= 1 << 4;  //enables clock for PortC
     RCC_APB2ENR |= 1 << 5;  //enables clock for PortD
     RCC_APB2ENR |= 1 << 6;  //enables clock for PortE
     
     GPIOE_CRH = 0x33333333; // sets PE8 as an output
}
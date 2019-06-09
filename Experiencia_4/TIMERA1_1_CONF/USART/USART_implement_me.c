#include <msp430g2553.h>
#include <string.h>
#include "USART_implement_me.h"


void USART_Init(void)
{	

    UCA0CTL1 |= UCSWRST ;
    UCA0CTL1 |= UCSSEL_2;
    //9600 bauds
    UCA0BR0 = 109;
    UCA0BR1 = 109>>8;
    UCA0MCTL = 2<<1;
    UCA0CTL1 &= ~UCSWRST;
    UC0IE |= UCA0RXIE; //Interrupciones
    UC0IFG &= ~UCA0RXIFG; //Se baja la bandera
}



// Transmits a single character
void USART_Transmit_char(uint8_t data)
{
	UCA0TXBUF = data;
    while(UCA0STAT&UCBUSY);
}

char USART_Receive_char(void){
	while(!(IFG2&UCA0RXIFG));
	return UCA0RXBUF;
}


// Transmits a given string
void USART_Transmit_String(char* StringPtr)
{
	while(*StringPtr != 0x00){
		USART_Transmit_char(*StringPtr);
	StringPtr++;}
}



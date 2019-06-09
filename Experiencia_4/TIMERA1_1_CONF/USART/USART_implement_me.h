#ifndef _USART_IMPLEMENT_ME_H_
#define _USART_IMPLEMENT_ME_H_

#include <stdint.h>

// Call once to initialise USART communication
void USART_Init(void);

// Transmits a single character
void USART_Transmit_char(uint8_t data );

// Transmits a given string
void USART_Transmit_String(char* string);

char USART_Receive_char(void);


#endif // _USART_IMPLEMENT_ME_

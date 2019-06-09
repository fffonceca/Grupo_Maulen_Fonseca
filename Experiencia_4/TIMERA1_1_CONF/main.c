#include <msp430g2553.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include "USART/USART_implement_me.h"

#define BIENVENIDA "Bienvenido al control de Temperatura \r\nEn cualquier instante envie las siguientes cifras para cambiar: 1: Set Point, 2: Kp, 3: Ki \r\n"
#define RECORDAR    "1: Set Point, 2: Kp, 3: Ki \r\n"
/*********************************************/
/************VARIABLES GLOBALES***************/
int lista[10];
int l;
int j;
int k;
long double k_p = 0;
long double k_i = 0;
float integral = 0;
float duty = 0;
int pos = 0;
double set = 0;
float voltaje = 0;
uint8_t ESTADO_WHILE = 0;
char choice;

/*********************************************/

/**************************/
void IO_CONFIGURATION(void);
void TIMER_CONFIGURATION(void);
void PID_INSERT(void);
/*************************/

void main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

    IO_CONFIGURATION(); //CONFIGURANDO ENTRADAS Y SALIDAS

    TIMER_CONFIGURATION();

	USART_Init(); //CONFIGURANDO USART 9600BAUD 8DATOS 1STOP NOPAR

    USART_Transmit_String(BIENVENIDA);

    __enable_interrupt();
    int wea;
    while(1){
        if(ESTADO_WHILE){
            PID_INSERT();
            ESTADO_WHILE = 0;
            for(wea = 0; wea<5;wea++) USART_Transmit_String("\n");
            USART_Transmit_String(RECORDAR);
        }
    }
}

#pragma vector=USCIAB0RX_VECTOR
__interrupt void ISR_PARA_UART_RX(void)
{
    choice = UCA0RXBUF;
    ESTADO_WHILE = 1; //ACTIVAMOS INTERFAZ PARA ELEGIR KP O KI
    UC0IE  &= ~UCA0RXIE;    //DEHABILITAMOS LA INTERRUPCION DE NUEVO
    UC0IFG &= ~UCA0RXIFG;   //BAJAMOS EL FLAG
}

#pragma vector = TIMER1_A1_VECTOR
 __interrupt void TIMER1_A1_ISR(void){
    P1OUT  ^=   BIT0;
    TA1CCR1 = duty;  //duty cycle
    float error = 0;
    double value = 0;
    float orden = 0;
    float escalado = 0;
    int i;
    for (i = 0;i<10;i++){
        value = value+lista[i];
    }
    value = value/10.0;
    error = set-value;
    integral = 5*error/1000+integral;
    orden = k_p*error+k_i*integral;
    if (orden >= 1000){
        escalado = 655;
    }
    else if (orden <= 0){
        escalado = 0;
    }
    else{
        escalado = orden*655/1000;
    }
    // duty = (int) escalado;
    duty = escalado;
    TA1CTL &= ~TAIFG;

 }
/********************************************************************************************************/
/*************CONFIGURATION********************/
void IO_CONFIGURATION(void){
    //USART
    P1SEL |= BIT1 | BIT2;
    P1SEL2 |=  BIT1 | BIT2;
    //TIMER
    P2DIR  |= BIT0 | BIT1;
    P2SEL  |= BIT0 | BIT1;
    //LED 1.0
    P1DIR |= BIT0;
    P1OUT &=~ BIT0;
}

void TIMER_CONFIGURATION(void){

    TA1CCTL1 = OUTMOD_7;
    TA1CCR0 = 655;// Máximo del counter, 5ms de resolución (frecuencia PWM 200Hz)
    TA1CCR1 = 200;  //duty cycle
    TA1CTL |= TASSEL_2 | MC_1 | ID_3 | TAIE & ~TAIFG;
}
/********************************************************************************************************/


void PID_INSERT(void){
USART_Transmit_String("\r\n");
USART_Transmit_String("MENU DE CONSTANTES: \r\n");
long double valor   = 0;
switch(choice){
    case '1':
            USART_Transmit_String("Indique el valor que desea para el Set Point (00 a 99): ");
            for(j= 0;j<2;j++){
                char s = USART_Receive_char();
                USART_Transmit_char(s);
                valor = pow(10,1-j)*(s-48)+valor;
            }
            set = (valor)*3.3/100;
            USART_Transmit_String("\r\n");
            USART_Transmit_String("El valor ha sido cambiado\r\n");
            break;
    case '2':
            USART_Transmit_String("Indique el valor que desea para Kp formato XXX.XX (sin punto): ");
            for(k = 0; k<5;k++){
                if(k == 3) USART_Transmit_char('.');
                char p = USART_Receive_char();
                USART_Transmit_char(p);
                valor = pow(10,2-k)*(p-48)+valor;
            }
            k_p = valor;
            USART_Transmit_String("\r\n");
            USART_Transmit_String("El valor ha sido cambiado\r\n");
            break;
    case '3':
            USART_Transmit_String("Indique el valor que desea para Ki formato X.XXXX (sin punto): ");
            for(l = 0; l<5;l++){
                if(l == 1) USART_Transmit_char('.');
                char y = USART_Receive_char();
                USART_Transmit_char(y);
                valor = pow(10,0-l)*(y-48)+valor;
            }
            k_i = valor;
            USART_Transmit_String("\r\n");
            USART_Transmit_String("El valor ha sido cambiado\r\n");
            break;
    default: USART_Transmit_String("No se ha introducido caracter valido\r\n");
        }
USART_Transmit_String("\r\n");
UC0IE  |=  UCA0RXIE; //HABILITAMOS LA INTERRUPCION DE NUEVO
}


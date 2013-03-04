//
//  tpvDAO.h
//  GoChef
//
//  Created by iMario on 26/11/12.
//
//

#import <Foundation/Foundation.h>
#import "MRequest.h"
#import "CoreDataClass.h"


#define M_MAIN_TAG @"DATOSENTRADA"

#define M_AMOUNT @"DS_MERCHANT_AMOUNT" //Obligatorio. Las dos últimas posiciones se consideran decimales, salvo en el caso de los Yenes que no tienen.
#define M_ORDER @"DS_MERCHANT_ORDER" //Obligatorio. Número de pedido. Los 4 primeros dígitos deben ser numéricos. Cada pedido es único, no puede repetirse.
#define M_CODE @"DS_MERCHANT_MERCHANTCODE" //Obligatorio. Código FUC asignado al comercio.
#define M_TERMINAL @"DS_MERCHANT_TERMINAL" //Obligatorio. Número de Terminal que le asignará su banco. Por defecto valor “001”. 3 longitud máxima.
#define M_CURRENCY @"DS_MERCHANT_CURRENCY" //Obligatorio. Moneda del comercio. Tiene que ser la contratada para el Terminal. Valor 978 para Euros, 840 para Dólares, 826 para Libras esterlinas y 392 para Yenes.
#define M_PAN @"DS_MERCHANT_PAN" //Obligatorio. Tarjeta. Su longitud depende del tipo de tarjeta.
#define M_EXPIREDATE @"DS_MERCHANT_EXPIRYDATE" //Obligatorio. Caducidad de la tarjeta. Su formato es AAMM, siendo AA los dos últimos dígitos del año y MM los dos dígitos del mes.
#define M_CVV2 @"DS_MERCHANT_CVV2" //Obligatorio. Código CVV2 de la tarjeta.
#define M_TYPE @"DS_MERCHANT_TRANSACTIONTYPE" //Obligatorio. Campo para el comercio para indicar qué tipo de transacción es. Los posibles valores son: A – Pago tradicional 1 – Preautorización O – Autorización en diferido
#define M_SIGNATURE @"DS_MERCHANT_MERCHANTSIGNATURE" //Obligatorio. Firma del comercio.

#define notificationPaymentWithCardOK @"notificationPaymentWithCardOK"
#define notificationPaymentWithCardError @"notificationPaymentWithCardError"

// local configuration for this project
#define EURO_CODE 978
#define DEFAULT_TYPE @"A"
#define DEFAULT_TERMINAL @"1"
#define MERCHANT_CODE @"327096129"
#define MERCHANT_SECRET_KEY @"sdrjuser5use5useryus"
//#define MERCHANT_SECRET_KEY @"qwertyasdf0123456789"

//#define MAIN_TPV_URL @"https://sis-i.REDSYS.es:25443/sis/services/SerClsWSEntrada" //Integración
//#define MAIN_TPV_URL @"https://sis-t.sermepa.es:25443/sis/operaciones" //Pruebas
#define MAIN_TPV_URL   @"https://sis.sermepa.es/sis/operaciones" // Real XML

@interface tpvDAO : NSObject


@property (nonatomic,strong) MRequest *request;
@property (nonatomic, strong) CoreDataClass *coreData;
@property (nonatomic, strong) NSString *paymentId;
+ (tpvDAO *)sharedInstance;

/**
 Request the payment with the necesary params card cvv2 amount and unique order id
 */
-(void) requestPaymentWithCard:(NSString*)card expiration:(NSString*)expiration amount:(int)amount order:(NSString*)order andCVV2:(NSString*)cvv2;

/**
 Request de cancelation or confirmation
 
 operation values
 2 – Confirmación
 3 – Devolución Automática
 6 – Transacción Sucesiva
 9 – Anulación de Preautorización
 P - Confirmación de autorización en diferido Q - Anulación de autorización en diferido
 S – Autorización recurrente sucesiva diferido
 */
-(void) requestCancelOrConfirmWithPaymentId:(NSString*)paymentId amount:(int)amount andOperation:(NSString*)operation;

@end

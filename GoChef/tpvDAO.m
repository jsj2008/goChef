//
//  tpvDAO.m
//  GoChef
//
//  Created by iMario on 26/11/12.
//
//
#include <CommonCrypto/CommonDigest.h>
#import "tpvDAO.h"
#import "XMLReader.h"

#import "SingletonGlobal.h"

@interface tpvDAO (Private)

// payment flow
- (void) returnPaymentWithCardOK:(NSData *)data;
- (void) returnPaymentWithCardError:(NSError *)anError;

// confirmation / cancelation flow
- (void) returnCancelOrConfirmWithPaymentIdOK:(NSData *)data;
- (void) returnCancelOrConfirmWithPaymentIdError:(NSError *)anError;

// signature generator SHA-1
- (NSString*) generateSignatureForPaymentWithParams:(NSDictionary*)params;
- (NSString*) generateSignatureForConfirmationWithParams:(NSDictionary*)params;

// error control
-(NSString*) getErrorStringWithCode:(NSString*)code;

@end

@implementation tpvDAO

@synthesize request = _request;
@synthesize coreData = _coreData;
@synthesize paymentId = _paymentId;

static tpvDAO *_staticTpvDAO = nil;

+ (tpvDAO*) sharedInstance {
    if (_staticTpvDAO == nil){
        _staticTpvDAO = [[self alloc] init];
    }
    return _staticTpvDAO;
}

-(void) requestPaymentWithCard:(NSString*)card expiration:(NSString*)expiration amount:(int)amount order:(NSString*)order andCVV2:(NSString*)cvv2{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    self.paymentId = order;
    // signature params
    [params setValue:[NSNumber numberWithInt:amount] forKey:M_AMOUNT];
    [params setValue:order forKey:M_ORDER];
    [params setValue:MERCHANT_CODE forKey:M_CODE];
    [params setValue:[NSNumber numberWithInt:EURO_CODE] forKey:M_CURRENCY];
    [params setValue:card forKey:M_PAN];
    [params setValue:cvv2 forKey:M_CVV2];
    [params setValue:DEFAULT_TYPE forKey:M_TYPE];
    
    // unique signature
    NSDictionary *signatureParams = [NSDictionary dictionaryWithDictionary:params];
    [params setValue:[self generateSignatureForPaymentWithParams:signatureParams] forKey:M_SIGNATURE];
    
    // rest of the params
    [params setValue:DEFAULT_TERMINAL forKey:M_TERMINAL];
    [params setValue:expiration forKey:M_EXPIREDATE];
    
    //prepares the connection
    if (self.request == nil) {
        self.request = [[MRequest alloc] init];
        [self.request setDelegate:self];
    }
    
    NSString *url = MAIN_TPV_URL;

    //performs the request
    [self.request connect:url withParams:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:params, nil] forKeys:[NSArray arrayWithObjects:M_MAIN_TAG, nil]] withMethods:@"POST" withOkSelector:@selector(returnPaymentWithCardOK:) andKoSelector:@selector(returnPaymentWithCardError:)];
}

-(void) requestCancelOrConfirmWithPaymentId:(NSString*)paymentId amount:(int)amount andOperation:(NSString*)operation{
   
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    self.paymentId = paymentId;
    // signature params
    [params setValue:[NSNumber numberWithInt:amount] forKey:M_AMOUNT];
    [params setValue:paymentId forKey:M_ORDER];
    [params setValue:MERCHANT_CODE forKey:M_CODE];
    [params setValue:[NSNumber numberWithInt:EURO_CODE] forKey:M_CURRENCY];
    [params setValue:operation forKey:M_TYPE];
    
    // unique signature
    NSDictionary *signatureParams = [NSDictionary dictionaryWithDictionary:params];
    [params setValue:[self generateSignatureForConfirmationWithParams:signatureParams] forKey:M_SIGNATURE];
    
    // rest of the params
    [params setValue:DEFAULT_TERMINAL forKey:M_TERMINAL];
    
    //prepares the connection
    if (self.request == nil) {
        self.request = [[MRequest alloc] init];
        [self.request setDelegate:self];
    }
    
    NSString *url = MAIN_TPV_URL;
    
    //performs the request
    [self.request connect:url withParams:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:params, nil] forKeys:[NSArray arrayWithObjects:M_MAIN_TAG, nil]] withMethods:@"POST" withOkSelector:@selector(returnCancelOrConfirmWithPaymentIdOK:) andKoSelector:@selector(returnCancelOrConfirmWithPaymentIdError:)];
}

#pragma mark - Private methods

- (void)returnPaymentWithCardOK:(NSData *)data{
        
    // parse xml into nsdiccionary
    NSDictionary *dict = [XMLReader dictionaryForXMLData:data error:nil];
    NSString *responseCode = nil;
    
    // read response code
    if ([dict valueForKey:@"RETORNOXML"]) {
        if ([[dict valueForKey:@"RETORNOXML"] valueForKey:@"CODIGO"]) {
            responseCode = [[[dict valueForKey:@"RETORNOXML"] valueForKey:@"CODIGO"] valueForKey:@"text"];
            
            // store the payment id in coredata
            // [[[SingletonGlobal sharedGlobal] CDC_coreData] createTpvWithId:self.paymentId];
            
            if (responseCode && [responseCode isEqualToString:@"0"]) {
                
                // NOTIFICAR PENDIENTE DE CONFIRMACION
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOkNotification" object:nil];
                
            } else {
                
                //[[SingletonGlobal sharedGlobal] setNSS_msg_error:[self getErrorStringWithCode:responseCode]];
                
                [[SingletonGlobal sharedGlobal] setNSS_msg_error:@"Se ha producido un error al hacer el cargo en su tarjeta, inténtelo nuevamente o utilice una nueva tarjeta. Gracias."];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvFailNotification" object:nil];
            }
        } else {
            
            [[SingletonGlobal sharedGlobal] setNSS_msg_error:@"Error de conexión en el proceso de cobro."];            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvFailNotification" object:nil];
        }
    } else {
        [[SingletonGlobal sharedGlobal] setNSS_msg_error:@"Error de conexión en el proceso de cobro."];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvFailNotification" object:nil];
    }
}
- (void)returnPaymentWithCardError:(NSError *)anError{
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvFailNotification" object:self];
}

- (void) returnCancelOrConfirmWithPaymentIdOK:(NSData *)data{
    
    
    // parse xml into nsdiccionary
    NSDictionary *dict = [XMLReader dictionaryForXMLData:data error:nil];
    NSString *responseCode = nil;
    
    // read response code
    if ([dict valueForKey:@"RETORNOXML"]) {
        if ([[dict valueForKey:@"RETORNOXML"] valueForKey:@"CODIGO"]) {
            responseCode = [[[dict valueForKey:@"RETORNOXML"] valueForKey:@"CODIGO"] valueForKey:@"text"];
            
            if (responseCode && [responseCode isEqualToString:@"0"]) {
                
                // NOTIFICAR PENDIENTE DE CONFIRMACION
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOperationConfirmedCanceledOkNotification" object:nil];
            } else {
                
                [[SingletonGlobal sharedGlobal] setNSS_msg_error:[self getErrorStringWithCode:responseCode]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOperationConfirmedCanceledFailNotification" object:nil];
            }
        } else {
            [[SingletonGlobal sharedGlobal] setNSS_msg_error:@"Error de conexión en el proceso de cobro."];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOperationConfirmedCanceledFailNotification" object:nil];
        }
    } else {
        [[SingletonGlobal sharedGlobal] setNSS_msg_error:@"Error de conexión en el proceso de cobro."];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOperationConfirmedCanceledFailNotification" object:nil];
    }
}
- (void) returnCancelOrConfirmWithPaymentIdError:(NSError *)anError{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tpvOperationConfirmedCanceledFailNotification" object:nil];
}

# pragma mark - utils

- (NSString*) generateSignatureForPaymentWithParams:(NSDictionary *)params{
    
    /*DS_MERCHANT_AMOUNT + DS_MERCHANT_ORDER + DS_MERCHANT_MERCHANTCODE + DS_MERCHANT_CURRENCY + DS_MERCHANT_PAN + DS_MERCHANT_CVV2 + DS_MERCHANT_TRANSACTIONTYPE + CLAVE SECRETA*/
    
    NSString *initialString = [NSString stringWithFormat:@"%d%@%@%d%@%@%@%@",
                               [[params valueForKey:M_AMOUNT] intValue],
                               [params valueForKey:M_ORDER],
                               [params valueForKey:M_CODE],
                               [[params valueForKey:M_CURRENCY] intValue],
                               [params valueForKey:M_PAN],
                               [params valueForKey:M_CVV2],
                               [params valueForKey:M_TYPE],
                               MERCHANT_SECRET_KEY];
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [initialString dataUsingEncoding: NSUTF8StringEncoding]; 
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        NSMutableString* sha512 = [[NSMutableString alloc] init];
        for (int i = 0 ; i < CC_SHA1_DIGEST_LENGTH ; ++i){
            [sha512 appendFormat: @"%02x", digest[i]];
        }
        return (NSString*)sha512;
    } else {
        return nil;
    }
}

- (NSString*) generateSignatureForConfirmationWithParams:(NSDictionary*)params{
    
    /*DS_MERCHANT_AMOUNT + DS_MERCHANT_ORDER + DS_MERCHANT_MERCHANTCODE + DS_MERCHANT_CURRENCY + DS_MERCHANT_TRANSACTIONTYPE + CLAVE SECRETA*/
    
    NSString *initialString = [NSString stringWithFormat:@"%d%@%@%d%@%@",
                               [[params valueForKey:M_AMOUNT] intValue],
                               [params valueForKey:M_ORDER],
                               [params valueForKey:M_CODE],
                               [[params valueForKey:M_CURRENCY] intValue],
                               [params valueForKey:M_TYPE],
                               MERCHANT_SECRET_KEY];
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [initialString dataUsingEncoding: NSUTF8StringEncoding]; 
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        NSMutableString* sha512 = [[NSMutableString alloc] init];
        for (int i = 0 ; i < CC_SHA1_DIGEST_LENGTH ; ++i){
            [sha512 appendFormat: @"%02x", digest[i]];
        }
        return (NSString*)sha512;
    } else {
        return nil;
    }
}

-(NSString*) getErrorStringWithCode:(NSString*)code{
    
    NSString *parserCode = [[code uppercaseString] stringByReplacingOccurrencesOfString:@"SIS" withString:@""];
    parserCode = [NSString stringWithFormat:@"SIS%04d",[parserCode intValue]];
    
    // from TPV Virtual WebService_v1.0 RS.OP.PRO.MAN.0008.pdf document.
    NSMutableDictionary *errorCodes = [[NSMutableDictionary alloc] init];
    [errorCodes setValue:@"Error al desmontar el XML de entrada" forKey:@"SIS0007"];
    [errorCodes setValue:@"Error falta Ds_Merchant_MerchantCode" forKey:@"SIS0008"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_MerchantCode" forKey:@"SIS0009"];
    [errorCodes setValue:@"Error falta Ds_Merchant_Terminal" forKey:@"SIS0010"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_Terminal" forKey:@"SIS0011"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_Order" forKey:@"SIS0014"];
    [errorCodes setValue:@"Error falta Ds_Merchant_Currency" forKey:@"SIS0015"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_Currency" forKey:@"SIS0016"];
    [errorCodes setValue:@"Error falta Ds_Merchant_Amount" forKey:@"SIS0018"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_Amount" forKey:@"SIS0019"];
    [errorCodes setValue:@"Error falta Ds_Merchant_MerchantSignature" forKey:@"SIS0020"];
    [errorCodes setValue:@"Error la Ds_Merchant_MerchantSignature viene vacía" forKey:@"SIS0021"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_TransactionType" forKey:@"SIS0022"];
    [errorCodes setValue:@"Error Ds_Merchant_TransactionType desconocido" forKey:@"SIS0023"];
    [errorCodes setValue:@"Error No existe el comercio / terminal enviado" forKey:@"SIS0026"];
    [errorCodes setValue:@"Error Moneda enviada por el comercio es diferente a la que tiene asignada para ese terminal" forKey:@"SIS0027"];
    [errorCodes setValue:@"Error Comercio / terminal está dado de baja" forKey:@"SIS0028"];
    [errorCodes setValue:@"Error en un pago con tarjeta ha llegado un tipo de operación no valido" forKey:@"SIS0031"];
    [errorCodes setValue:@"Método de pago no definido" forKey:@"SIS0030"];
    [errorCodes setValue:@"Error de acceso a la Base de Datos" forKey:@"SIS0034"];
    [errorCodes setValue:@"Error en java" forKey:@"SIS0038"];
    [errorCodes setValue:@"Error el comercio / terminal no tiene ningún método de pago asignado" forKey:@"SIS0040"];
    [errorCodes setValue:@"Error en el cálculo de la firma de datos del comercio" forKey:@"SIS0041"];
    [errorCodes setValue:@"La firma enviada no es correcta" forKey:@"SIS0042"];
    [errorCodes setValue:@"El BIN de la tarjeta no está dado de alta" forKey:@"SIS0046"];
    [errorCodes setValue:@"Error número de pedido repetido" forKey:@"SIS0051"];
    [errorCodes setValue:@"Error no existe operación sobre la que realizar la devolución" forKey:@"SIS0054"];
    [errorCodes setValue:@"Error no existe más de un pago con el mismo número de pedido" forKey:@"SIS0055"];
    [errorCodes setValue:@"La operación sobre la que se desea devolver no está autorizada" forKey:@"SIS0056"];
    [errorCodes setValue:@"El importe a devolver supera el permitido" forKey:@"SIS0057"];
    [errorCodes setValue:@"Inconsistencia de datos, en la validación de una confirmación" forKey:@"SIS0058"];
    [errorCodes setValue:@"Error no existe operación sobre la que realizar la devolución" forKey:@"SIS0059"];
    [errorCodes setValue:@"Ya existe una confirmación asociada a la preautorización" forKey:@"SIS0060"];
    [errorCodes setValue:@"La preautorización sobre la que se desea confirmar no está autorizada" forKey:@"SIS0061"];
    [errorCodes setValue:@"El importe a confirmar supera el permitido" forKey:@"SIS0062"];
    [errorCodes setValue:@"Error. Número de tarjeta no disponible" forKey:@"SIS0063"];
    [errorCodes setValue:@"Error. El número de tarjeta no puede tener más de 19 posiciones" forKey:@"SIS0064"];
    [errorCodes setValue:@"Error. El número de tarjeta no es numérico" forKey:@"SIS0065"];
    [errorCodes setValue:@"Error. Mes de caducidad no disponible" forKey:@"SIS0066"];
    [errorCodes setValue:@"Error. El mes de la caducidad no es numérico" forKey:@"SIS0067"];
    [errorCodes setValue:@"Error. El mes de la caducidad no es válido" forKey:@"SIS0068"];
    [errorCodes setValue:@"Error. Año de caducidad no disponible" forKey:@"SIS0069"];
    [errorCodes setValue:@"Error. El Año de la caducidad no es numérico" forKey:@"SIS0070"];
    [errorCodes setValue:@"Tarjeta caducada" forKey:@"SIS0071"];
    [errorCodes setValue:@"Operación no anulable" forKey:@"SIS0072"];
    [errorCodes setValue:@"Error falta Ds_Merchant_Order" forKey:@"SIS0074"];
    [errorCodes setValue:@"Error el Ds_Merchant_Order tiene menos de 4 posiciones o más de 12" forKey:@"SIS0075"];
    [errorCodes setValue:@"Error el Ds_Merchant_Order no tiene las cuatro primeras posiciones numéricas" forKey:@"SIS0076"];
    [errorCodes setValue:@"Método de pago no disponible" forKey:@"SIS0078"];
    [errorCodes setValue:@"Error al realizar el pago con tarjeta" forKey:@"SIS0079"];
    [errorCodes setValue:@"La sesión es nueva, se han perdido los datos almacenados" forKey:@"SIS0081"];
    [errorCodes setValue:@"El valor de Ds_Merchant_ExpiryDate no ocupa 4 posiciones" forKey:@"SIS0089"];
    [errorCodes setValue:@"El valor de Ds_Merchant_ExpiryDate es nulo" forKey:@"SIS0092"];
    [errorCodes setValue:@"Tarjeta no encontrada en la tabla de rangos" forKey:@"SIS0093"];
    [errorCodes setValue:@"Error. El tipo de transacción especificado en Ds_Merchant_Transaction_Type no esta permitido" forKey:@"SIS0112"];
    [errorCodes setValue:@"Error no existe operación sobre la que realizar el pago de la cuota" forKey:@"SIS0115"];
    [errorCodes setValue:@"La operación sobre la que se desea pagar una cuota no es una operación válida" forKey:@"SIS0116"];
    [errorCodes setValue:@"La operación sobre la que se desea pagar una cuota no está autorizada" forKey:@"SIS0117"];
    [errorCodes setValue:@"Se ha excedido el importe total de las cuotas" forKey:@"SIS0118"];
    [errorCodes setValue:@"Valor del campo Ds_Merchant_DateFrecuency no válido" forKey:@"SIS0119"];
    [errorCodes setValue:@"Valor del campo Ds_Merchant_CargeExpiryDate no válido" forKey:@"SIS0120"];
    [errorCodes setValue:@"Valor del campo Ds_Merchant_SumTotal no válido" forKey:@"SIS0121"];
    [errorCodes setValue:@"Valor del campo Ds_merchant_DateFrecuency o Ds_Merchant_SumTotal tiene formato incorrecto" forKey:@"SIS0122"];
    [errorCodes setValue:@"Se ha excedido la fecha tope para realizar transacciones" forKey:@"SIS0123"];
    [errorCodes setValue:@"No ha transcurrido la frecuencia mínima en un pago recurrente sucesivo" forKey:@"SIS0124"];
    [errorCodes setValue:@"La fecha de Confirmación de Autorización no puede superar en más de 7 días a la de Preautorización" forKey:@"SIS0132"];
    [errorCodes setValue:@"Error el pago recurrente inicial está duplicado" forKey:@"SIS0139"];
    [errorCodes setValue:@"Tiempo excedido para el pago" forKey:@"SIS0142"];
    [errorCodes setValue:@"Error Ds_Merchant_CVV2 tiene mas de 3/4 posiciones" forKey:@"SIS0216"];
    [errorCodes setValue:@"Error de formato en Ds_Merchant_CVV2" forKey:@"SIS0217"];
    [errorCodes setValue:@"Error el CVV2 es obligatorio" forKey:@"SIS0221"];
    [errorCodes setValue:@"Ya existe una anulación asociada a la preautorización" forKey:@"SIS0222"];
    [errorCodes setValue:@"La preautorización que se desea anular no está autorizada" forKey:@"SIS0223"];
    [errorCodes setValue:@"Error no existe operación sobre la que realizar la anulación" forKey:@"SIS0225"];
    [errorCodes setValue:@"Inconsistencia de datos, en la validación de una anulación" forKey:@"SIS0226"];
    [errorCodes setValue:@"Valor del campo Ds_Merchan_TransactionDate no válido" forKey:@"SIS0227"];
    [errorCodes setValue:@"El comercio no permite el envío de tarjeta" forKey:@"SIS0252"];
    [errorCodes setValue:@"La tarjeta no cumple el check-digit" forKey:@"SIS0253"];
    [errorCodes setValue:@"Operación detenida por superar el control de restricciones en la entrada al SIS" forKey:@"SIS0261"];
    [errorCodes setValue:@"Tipo de operación desconocida o no permitida por esta entrada al SIS" forKey:@"SIS0274"];
    
    if ([errorCodes valueForKey:parserCode]) {
        return [errorCodes valueForKey:parserCode];
    } else {
        return [NSString stringWithFormat:@"Unknown code %@",code];
    }
}
@end

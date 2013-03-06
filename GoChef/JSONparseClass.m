//
//  JSONparseClass.m
//  EFEverde
//

#import <CommonCrypto/CommonDigest.h>
#import "JSONparseClass.h"
#import "JSONKit.h"

#import "DireccionClass.h"
#import "TipoCocinaClass.h"
#import "RestaurantClass.h"
#import "UserClass.h"
#import "MensajeClass.h"
#import "TarjetaClass.h"
#import "SearchRestaurantClass.h"
#import "SearchOfferClass.h"
#import "NSData+Base64.h"
#import "FoodClass.h"
#import "UserOfferClass.h"
#import "OrderClass.h"
#import "ImageClass.h"
#import "FacebookOfferClass.h"
#import "CoreLocationClass.h"
#import "CoreDataClass.h"

#import "tpvDAO.h"
#import "ImgCacheManager.h"

@interface JSONparseClass (Private)

- (NSString *)stringByRemovingControlCharacters: (NSString *)inputString;
- (NSString *)MD5String:(NSString*)original;


@end

@implementation JSONparseClass

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : parseGoogleMapAddressWith
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(DireccionClass *) parseGoogleMapAddressWith:(CLLocation *)CLL_location {

    DireccionClass *DC_Direccion = nil;
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Descargamos el Json de control de versión
    NSString *NSS_googleMapURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%.7f,%.7f&sensor=false", CLL_location.coordinate.latitude, CLL_location.coordinate.longitude];
    NSLog(@"%@", NSS_googleMapURL);
    
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSS_googleMapURL]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];

    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) NSLog(@"Error cargando URL %@", NSS_googleMapURL);
    else {
        
        // Creamos Direccion
        DC_Direccion = [[DireccionClass alloc] init];
        [DC_Direccion setNSI_id      :_ID_DIRECCION_NEW_LOCALIZACION_ACTUAL_];
        [DC_Direccion setNSS_etiqueta:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_address;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_address = [NSD_data objectFromJSONData];
        else NSD_address = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Recuperamos los datos de la Gallery
        NSArray *NSA_results = [NSD_address objectForKey:@"results"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            NSDictionary *NSD_geometry      = (NSDictionary *)[NSD_result objectForKey:@"geometry"];
            NSString *NSS_location_type     = (NSString *)[NSD_geometry objectForKey:@"location_type"];
            NSArray *NSA_address_components = [NSD_result objectForKey:@"address_components"];
            
            for (NSDictionary *NSD_component in NSA_address_components) {
                
                NSString *NSS_component_long_name = (NSString *)[NSD_component objectForKey:@"long_name"];
                NSArray *NSA_component_type  = (NSArray *)[NSD_component objectForKey:@"types"];
                NSString *NSS_component_type = (NSString *)[NSA_component_type objectAtIndex:0];
                
                if ([NSS_location_type isEqualToString:@"ROOFTOP"]) {
                    
                    if ([NSS_component_type isEqualToString:@"street_number"]) {
                        
                        [DC_Direccion setNSS_numero : NSS_component_long_name];
                    }
                    else if ([NSS_component_type isEqualToString:@"route"]) {
                        
                        [DC_Direccion setNSS_direccion : NSS_component_long_name];
                    }
                }
                
                if ([NSS_component_type isEqualToString:@"locality"]) {
                    
                    [DC_Direccion setNSS_ciudad : NSS_component_long_name];
                }
                else if ([NSS_component_type isEqualToString:@"postal_code"]) {
                    
                    [DC_Direccion setNSS_cp : NSS_component_long_name];
                }
            }
        }
    }
    
    return DC_Direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getOffers
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getOffers:(BOOL)B_download_images idrestaurant:(NSInteger)NSI_idrestaurant {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getoffers&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&position=%.7f,%.7f", globalVar.CLC_location.CLLM_manager.location.coordinate.latitude, globalVar.CLC_location.CLLM_manager.location.coordinate.longitude]];

    // Comprobamos si debemos cargar por bloques
    if (globalVar.B_UMNI_getOffers_active) {

        // Insertamos lo límites del bloque actual
        [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d", ((globalVar.NSI_numRecordBlock+1) * globalVar.NSI_blocksize_offers)]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d", globalVar.NSI_blocksize_offers]];
    }
    else {
        
        // Marcamos los límites generales
        [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d", _GET_START_VALUE_]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d", _GET_LIMIT_VALUE_]];
        
        // Iniciamos el array de tipos
        globalVar.UC_user.NSMA_offers = [[NSMutableArray alloc] init];
    }
    
    if (globalVar.OC_order.NSD_date_reservation) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd'%20'HH:mm:ss"];
        [NSMS_url appendString:[NSString stringWithFormat:@"&datetime=%@",[format stringFromDate:globalVar.OC_order.NSD_date_reservation]]];

    }
    
    // Comprobamos si debemos pasar el resturante
    if (!B_download_images) [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    
    // Comprobamos los filtros
    if (globalVar.SRC_search.B_filter) [NSMS_url appendString:[NSString stringWithFormat:@"&filter=%d", globalVar.SOC_search.TOF_filter]];
    if (globalVar.SRC_search.B_order)  [NSMS_url appendString:[NSString stringWithFormat:@"&order=%d", globalVar.SOC_search.TOO_order]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_OFFERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Iniciamos el array de tipos
        //globalVar.UC_user.NSMA_offers = [[NSMutableArray alloc] init];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_OFFERS_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getoffers"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            UserOfferClass *UOC_offer = [[UserOfferClass alloc] init];
            
            // Iniciamos propiedades
            [UOC_offer setNSI_idoffer           : [(NSString *)[NSD_result objectForKey:@"idoffer"]          integerValue]];
            [UOC_offer setNSI_idrestaurant      : [(NSString *)[NSD_result objectForKey:@"idrestaurant"]     integerValue]];
            [UOC_offer setNSI_discount          : [(NSString *)[NSD_result objectForKey:@"discount"]         integerValue]];
            [UOC_offer setNSI_idfood            : [(NSString *)[NSD_result objectForKey:@"idfood"]           integerValue]];
            [UOC_offer setNSI_idfoodCategories  : [(NSString *)[NSD_result objectForKey:@"idfoodCategories"] integerValue]];
            [UOC_offer setTOT_typediscount      : [(NSString *)[NSD_result objectForKey:@"typediscount"]     integerValue]];
            
            [UOC_offer setNSS_namerestaurant   : (NSString *)[NSD_result objectForKey:@"namerestaurant"]];
            [UOC_offer setNSS_nameoffer        : (NSString *)[NSD_result objectForKey:@"nameoffer"]];
            [UOC_offer setNSS_descriptionoffer : (NSString *)[NSD_result objectForKey:@"descriptionoffer"]];
            [UOC_offer setNSS_distance         : (NSString *)[NSD_result objectForKey:@"distance"]];
            
            NSString *NSS_position = (NSString *)[NSD_result objectForKey:@"position"];
            NSArray *NSA_position  = [NSS_position componentsSeparatedByString:@","];
            
            // Comprobamos si ha encontrado las coordenadas
            if ([NSA_position count] == 2) {
                
                [UOC_offer setCGF_latitude  : [(NSString *)[NSA_position objectAtIndex:0] floatValue]];
                [UOC_offer setCGF_longitude : [(NSString *)[NSA_position objectAtIndex:1] floatValue]];
            }
            
            [UOC_offer setB_favorite : [(NSString *)[NSD_result objectForKey:@"favorite"] boolValue]];

            [UOC_offer setNSD_date_start : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_start"]]];
            [UOC_offer setNSD_date_end   : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_end"]]];
            
            // Comprobamos si debemos descargar la imagen
            if (B_download_images) {
                
                // Cargamos la imagen
                UOC_offer.IC_imageoffer = [[ImageClass alloc] init];
                [UOC_offer.IC_imageoffer setTIT_type:TIT_offers];
                [UOC_offer.IC_imageoffer setCGF_width :100.0f];
                [UOC_offer.IC_imageoffer setCGF_height:100.0f];
                [self UMNI_getImage:UOC_offer.IC_imageoffer objectId:UOC_offer.NSI_idoffer];
            }
            
            // Insertamos RestaurantClass en el Array
            [globalVar.UC_user.NSMA_offers addObject:UOC_offer];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_OFFERS_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getOrders
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getOrders:(BOOL)B_download_images {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getorders&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  ((globalVar.NSI_numRecordBlock+1) * globalVar.NSI_blocksize_orders)]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  globalVar.NSI_blocksize_orders]];
    
    if (globalVar.B_FromHistory) {
        [NSMS_url appendString:@"&historial=1"];
        [globalVar setB_FromHistory:FALSE];
    }
    
    // Comprobamos si se esta realizando un pediddo
    if (globalVar.B_realizando_pedido) {
        
        // Comprobamos que sea un pedido a domicilio o a recoger (los únicos que tienes hitórico)
        if ( (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ){
            
            // Estamos recuperando el histórico -> añadimos filtro de type
            [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", globalVar.OC_order.TOT_type]];
        }
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Iniciamos el array de tipos
        //globalVar.NSMA_orders = [[NSMutableArray alloc] init];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getorders"];
        
        // Iniciamos variable contará New Order
        NSInteger NSI_new_order = 0;
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            OrderClass *OC_order = [[OrderClass alloc] init];
            
            // Iniciamos propiedades
            [OC_order setNSI_idorder          : [(NSString *)[NSD_result objectForKey:@"idorder"]          integerValue]];
            [OC_order setNSI_idorder_food     : [(NSString *)[NSD_result objectForKey:@"idorder_food"]     integerValue]];
            [OC_order setNSI_idrestaurant     : [(NSString *)[NSD_result objectForKey:@"idrestaurant"]     integerValue]];
            [OC_order setNSI_iduseraddress    : [(NSString *)[NSD_result objectForKey:@"iduseraddress"]    integerValue]];
            [OC_order setNSI_idoffer          : [(NSString *)[NSD_result objectForKey:@"idoffer"]          integerValue]];
            [OC_order setNSI_idoffer_facebook : [(NSString *)[NSD_result objectForKey:@"idoffer_facebook"] integerValue]];
            [OC_order setNSI_persons          : [(NSString *)[NSD_result objectForKey:@"persons"]          integerValue]];
            [OC_order setNSI_number_table     : [(NSString *)[NSD_result objectForKey:@"number_table"]     integerValue]];
            
            [OC_order setNSS_namerestaurant : (NSString *)[NSD_result objectForKey:@"namerestaurant"]];
            [OC_order setNSS_instructions   : (NSString *)[NSD_result objectForKey:@"instructions"]];
            [OC_order setNSS_payment_type   : (NSString *)[NSD_result objectForKey:@"payment_type"]];
            
            [OC_order setCGF_subtotal           : [(NSString *)[NSD_result objectForKey:@"subtotal"]            floatValue]];
            [OC_order setCGF_membership_discount: [(NSString *)[NSD_result objectForKey:@"membership_discount"] floatValue]];
            [OC_order setCGF_offer_discount     : [(NSString *)[NSD_result objectForKey:@"offer_discount"]      floatValue]];
            [OC_order setCGF_facebook_discount  : [(NSString *)[NSD_result objectForKey:@"facebook_discount"]   floatValue]];
            [OC_order setCGF_price_homedelivery : [(NSString *)[NSD_result objectForKey:@"price_homedelivery"]  floatValue]];
            [OC_order setCGF_total              : [(NSString *)[NSD_result objectForKey:@"total"]               floatValue]];
            
            [OC_order setNSD_date_start       : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_start"]]];
            [OC_order setNSD_date_end         : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_end"]]];
            [OC_order setNSD_date_reservation : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_reservation"]]];
            
            [OC_order setTOS_status : [(NSString *)[NSD_result objectForKey:@"status"]  integerValue]];
            [OC_order setTOT_type   : [(NSString *)[NSD_result objectForKey:@"type"]    integerValue]];
            [OC_order setTOA_active : [(NSString *)[NSD_result objectForKey:@"active"]  integerValue]];
            
            [OC_order setB_favorite : [(NSString *)[NSD_result objectForKey:@"favorite"] boolValue]];
            [OC_order setB_new      : [(NSString *)[NSD_result objectForKey:@"new"] boolValue]];
            
            // Recuperamos la tarjeta
            NSString *NSS_creditcard = (NSString *)[NSD_result objectForKey:@"creditcard"];
            TarjetaClass *TC_creditcard = [globalVar getCreditCardFor:NSS_creditcard];
            if (TC_creditcard != nil) [OC_order setTC_creditcard: TC_creditcard];
            
            // Recuperamos la orderfood
            //[self UMNI_getOrderfood:OC_order images:B_download_images];
            
            // Comprobamos si es una New Order
            if (OC_order.B_new) NSI_new_order += 1;
            
            // Insertamos RestaurantClass en el Array
            [globalVar.NSMA_orders addObject:OC_order];
        }
        
        // Actualizamos propiedad global New Order
        [globalVar setNSI_num_new_order:NSI_new_order];
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_PARSE_JSON_ 
                                                            object:self];
    }
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getOrders
//#	Fecha Creación	: 29/11/2012  (iMario)
//#	Fecha Ult. Mod.	: 29/11/2012  (iMario)
//# Descripción		:
//#
-(void) UMNI_getOrdersDevolution{
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getordersdevolution&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Iniciamos el array de tipos
        //globalVar.NSMA_orders = [[NSMutableArray alloc] init];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_ERROR_
                                                                object:self];
            
            return;
        }
    
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getordersdevolution"];
        NSMutableArray *devolutionsArray = [[NSMutableArray alloc] init];

        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            OrderClass *OC_order = [[OrderClass alloc] init];
            
            // Iniciamos propiedades
            [OC_order setNSI_idorder          : [(NSString *)[NSD_result objectForKey:@"idorder"]          integerValue]];
            [OC_order setNSI_idrestaurant     : [(NSString *)[NSD_result objectForKey:@"idrestaurant"]     integerValue]];
            
            [OC_order setNSS_namerestaurant : (NSString *)[NSD_result objectForKey:@"namerestaurant"]];
            [OC_order setNSS_payment_type   : (NSString *)[NSD_result objectForKey:@"payment_type"]];
            
            [OC_order setCGF_subtotal           : [(NSString *)[NSD_result objectForKey:@"subtotal"]            floatValue]];
            [OC_order setCGF_membership_discount: [(NSString *)[NSD_result objectForKey:@"membership_discount"] floatValue]];
            [OC_order setCGF_offer_discount     : [(NSString *)[NSD_result objectForKey:@"offer_discount"]      floatValue]];
            [OC_order setCGF_facebook_discount  : [(NSString *)[NSD_result objectForKey:@"facebook_discount"]   floatValue]];
            [OC_order setCGF_total              : [(NSString *)[NSD_result objectForKey:@"total"]               floatValue]];
            
            [OC_order setNSD_date_reservation : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_reservation"]]];
            
            [OC_order setTOT_type   : [(NSString *)[NSD_result objectForKey:@"type"]    integerValue]];
            [OC_order setTOA_active : [(NSString *)[NSD_result objectForKey:@"active"]  integerValue]];
            
            [OC_order setB_favorite : [(NSString *)[NSD_result objectForKey:@"favorite"] boolValue]];
            [OC_order setB_new      : [(NSString *)[NSD_result objectForKey:@"new"] boolValue]];
            
            // Recuperamos la tarjeta
            NSString *NSS_creditcard = (NSString *)[NSD_result objectForKey:@"creditcard"];
            NSString *NSS_type_creditcard = (NSString *)[NSD_result objectForKey:@"type_creditcard"];
            NSString *NSS_idorder_tpv = (NSString *)[NSD_result objectForKey:@"idorder_tpv"];
            
            NSMutableDictionary *devolutions = [[NSMutableDictionary alloc] initWithCapacity:2];
            [devolutions setObject:OC_order forKey:@"order"];
            [devolutions setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:NSS_creditcard,NSS_type_creditcard,NSS_idorder_tpv, nil] forKeys:[NSArray arrayWithObjects:@"creditcard",@"type",@"idorder_tpv", nil]] forKey:@"payment_info"];
            [devolutionsArray addObject:devolutions];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERSDEVOLUTIONS_PARSE_JSON_
                                                            object:devolutionsArray];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getOrderfood
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getOrderfood:(OrderClass *)OC_order images:(BOOL)B_download_images {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getorderfood&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d",  OC_order.NSI_idorder]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDER_FOOD_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDER_FOOD_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getorderfood"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            OrderFoodClass *OFC_food = [[OrderFoodClass alloc] init];
            
            // Iniciamos propiedades
            [OFC_food setNSI_idorder_food : [(NSString *)[NSD_result objectForKey:@"idorder_food"] integerValue]];
            
            NSString *NSS_idfood = (NSString *)[NSD_result objectForKey:@"idfood"];
            if ([NSS_idfood length] == 0) [OFC_food setNSI_idfoodgroup:_ID_FOOD_NO_SELECCIONADA_];
            else [OFC_food setNSI_idfood: [NSS_idfood integerValue]];
            
            NSString *NSS_iddailymenu_food = (NSString *)[NSD_result objectForKey:@"iddailymenu_food"];
            if ([NSS_iddailymenu_food length] == 0) [OFC_food setNSI_idfoodgroup:_ID_FOOD_NO_SELECCIONADA_];
            else [OFC_food setNSI_iddailymenu_food: [NSS_iddailymenu_food integerValue]];
            
            [OFC_food setNSI_idfoodcategories : [(NSString *)[NSD_result objectForKey:@"idfoodcategories"] integerValue]];
            [OFC_food setNSI_amount           : [(NSString *)[NSD_result objectForKey:@"amount"] integerValue]];
            
            NSString *NSS_idfoodgroup = (NSString *)[NSD_result objectForKey:@"idfoodgroup"];
            if (([NSS_idfoodgroup length] == 0) || ([NSS_idfoodgroup isEqualToString:@"0"])) [OFC_food setNSI_idfoodgroup:_ID_FOOD_NO_GROUP_];
            else [OFC_food setNSI_idfoodgroup: [NSS_idfoodgroup integerValue]];
            
            [OFC_food setNSS_namefood             : (NSString *)[NSD_result objectForKey:@"namefood"]];
            [OFC_food setNSS_descriptionfood      : (NSString *)[NSD_result objectForKey:@"descriptionfood"]];
            [OFC_food setNSS_namefoodcategories   : (NSString *)[NSD_result objectForKey:@"namefoodcategories"]];
            [OFC_food setNSS_namefoodgroup        : (NSString *)[NSD_result objectForKey:@"namefoodgroup"]];
            [OFC_food setNSS_descriptionfoodgroup : (NSString *)[NSD_result objectForKey:@"descriptionfoodgroup"]];
            [OFC_food setNSS_instructions         : (NSString *)[NSD_result objectForKey:@"instructions"]];
            
            [OFC_food setCGF_price              : [(NSString *)[NSD_result objectForKey:@"price"] floatValue]];
            [OFC_food setCGF_priceplusfoodgroup : [(NSString *)[NSD_result objectForKey:@"priceplusfoodgroup"] floatValue]];
            
            // Comprobamos si debemos descargar la imagen
            if (B_download_images) {

                // Cargamos la imagen
                OFC_food.IC_imagefood = [[ImageClass alloc] init];
                [OFC_food.IC_imagefood setTIT_type:TIT_foods];
                [OFC_food.IC_imagefood setCGF_width :220.0f];
                [OFC_food.IC_imagefood setCGF_height:110.0f];
                [self UMNI_getImage:OFC_food.IC_imagefood objectId:OFC_food.NSI_idfood];
            }
            
            // Recuperamos las options
            NSArray *NSA_options = [NSD_result objectForKey:@"foodoptions"]; 
            
            // Recorremos el Array de Options
            for (NSDictionary *NSD_option in NSA_options) {
                
                // Creamos ObjectClass
                FoodOptionClass *FOC_option = [[FoodOptionClass alloc] init];
                
                // Iniciamos propiedades
                [FOC_option setNSI_idfoodoption        : [(NSString *)[NSD_option objectForKey:@"idfoodoption"] integerValue]];
                [FOC_option setNSS_namefoodoption      : (NSString *)[NSD_option objectForKey:@"namefoodoption"]];
                [FOC_option setCGF_priceplusfoodoption : [(NSString *)[NSD_option objectForKey:@"priceplusfoodoption"] floatValue]];
                 
                 // Insertamos RestaurantClass en el Array
                [OFC_food.NSMA_options addObject:FOC_option];
            }

            // Insertamos RestaurantClass en el Array
            [OC_order.NSMA_orderfoods addObject:OFC_food];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDER_FOOD_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getFoods
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getFoods {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getfoods&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", globalVar.OC_order.RC_restaurant.NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&menu=0"]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d", _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d", _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSString *tmp = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
            tmp = [self stringByRemovingControlCharacters:tmp];
            NSD_data = [tmp dataUsingEncoding:NSUTF8StringEncoding];
            
            if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
            else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];

            if (!NSD_parse) {
                 
                NSLog(@"Error parsing JSON: %@", NSE_error);
                
                // Guardamos mensaje de error
                [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
                
                // Lazamos la notificación de error
                [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_ERROR_ object:self];
            
                return;
            }
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getfoods"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            FoodClass *FC_food = [[FoodClass alloc] init];
            
            // Iniciamos propiedades
            [FC_food setNSI_idfood           : [(NSString *)[NSD_result objectForKey:@"idfood"] integerValue]];
            [FC_food setNSI_idfoodcategories : [(NSString *)[NSD_result objectForKey:@"idfoodcategories"] integerValue]];
            
            // Comprobamos si la Food ya se ha insertado en el Array
            if ([globalVar exitsFood:FC_food.NSI_idfood category:FC_food.NSI_idfoodcategories]) continue;
            
            NSString *NSS_idfoodgroup = (NSString *)[NSD_result objectForKey:@"idfoodgroup"];
            if ([NSS_idfoodgroup length] == 0) [FC_food setNSI_idfoodgroup:_ID_FOOD_NO_GROUP_];
            else [FC_food setNSI_idfoodgroup: [NSS_idfoodgroup integerValue]];
            
            [FC_food setNSS_namefood             : (NSString *)[NSD_result objectForKey:@"namefood"]];
            [FC_food setNSS_descriptionfood      : (NSString *)[NSD_result objectForKey:@"descriptionfood"]];
            [FC_food setNSS_namefoodcategories   : (NSString *)[NSD_result objectForKey:@"namefoodcategories"]];
            [FC_food setNSS_namefoodgroup        : (NSString *)[NSD_result objectForKey:@"namefoodgroup"]];
            [FC_food setNSS_descriptionfoodgroup : (NSString *)[NSD_result objectForKey:@"descriptionfoodgroup"]];
            
            [FC_food setCGF_price              : [(NSString *)[NSD_result objectForKey:@"price"] floatValue]];
            [FC_food setCGF_priceplusfoodgroup : [(NSString *)[NSD_result objectForKey:@"priceplusfoodgroup"] floatValue]];
            
            [FC_food setB_options : [(NSString *)[NSD_result objectForKey:@"options"] boolValue]];
            
            // Cargamos la imagen
            FC_food.IC_imagefood = [[ImageClass alloc] init];
            [FC_food.IC_imagefood setTIT_type:TIT_foods];
            [FC_food.IC_imagefood setCGF_width :220.0f];
            [FC_food.IC_imagefood setCGF_height:110.0f];
            //[self UMNI_getImage:FC_food.IC_imagefood objectId:FC_food.NSI_idfood];

            // Hacemo delay de carga de imagen
            //if (FC_food.IC_imagefood != nil) [NSThread sleepForTimeInterval:0.8];
            
            /*
            // Cargamos las options de la food
            if (FC_food.B_options) {

                [self UMNI_getFoodOptions:FC_food obligatory:FALSE];
                [self UMNI_getFoodOptions:FC_food obligatory:TRUE];
            }
             */
            
            // Insertamos RestaurantClass en el Array
            [globalVar.OC_order.RC_restaurant.NSMA_foods addObject:FC_food];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getFoodOptions:obligatory:
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getFoodOptions:(FoodClass *)FC_food obligatory:(BOOL)B_obligatory images:(BOOL)B_download_images {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getfoodoptions&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d",  globalVar.OC_order.RC_restaurant.NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idfood=%d", FC_food.NSI_idfood]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&obligatory=%d", B_obligatory?1:0]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        if (B_obligatory) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_ object:self];
        else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_ object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            if (B_obligatory) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_ object:self];
            else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_ object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getfoodoptions"];
        
        // Iniciamos Arrays
        if (B_obligatory) [FC_food.NSMA_options_obligatories removeAllObjects];
        else [FC_food.NSMA_options removeAllObjects];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            FoodOptionClass *FOC_option = [[FoodOptionClass alloc] init];
            
            // Iniciamos propiedades
            [FOC_option setNSI_idfoodoption          : [(NSString *)[NSD_result objectForKey:@"idfoodoption"] integerValue]];
            [FOC_option setNSS_namefoodoption        :  (NSString *)[NSD_result objectForKey:@"namefoodoption"]];
            [FOC_option setNSS_descriptionfoodoption :  (NSString *)[NSD_result objectForKey:@"descriptionfoodoption"]];
            [FOC_option setCGF_priceplusfoodoption   : [(NSString *)[NSD_result objectForKey:@"priceplusfoodoption"] floatValue]];
            
            // Insertamos RestaurantClass en el Array
            if (B_obligatory) [FC_food.NSMA_options_obligatories addObject:FOC_option];
            else [FC_food.NSMA_options addObject:FOC_option];
        }
        
        // Comprobamos si la imagen se ha cargado ya
        if ( (B_download_images) && (FC_food.IC_imagefood.NSS_imageUrl == nil)) [self UMNI_getImage:FC_food.IC_imagefood objectId:FC_food.NSI_idfood];
        
        // Lazamos la notificación de operación terminada correctamente
        if (B_obligatory) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_ object:self];
        else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_ object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getFoodCategories
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getFoodCategories:(BOOL)B_menu {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getfoodcategories&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", globalVar.OC_order.RC_restaurant.NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&menu=%d", B_menu?1:0]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d", _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d", _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        if (B_menu) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_ object:self];
        else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_CATEGORIES_ERROR_ object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        
        if (!jsonSerializationClass)
            NSD_parse = [NSD_data objectFromJSONData];
        else
            NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            if (B_menu) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_ object:self];
            else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_CATEGORIES_ERROR_ object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getfoodcategories"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            FoodCategoryClass *FCC_foodcategories = [[FoodCategoryClass alloc] init];
            
            // Iniciamos propiedades
            [FCC_foodcategories setNSI_idfoodcategories   : [(NSString *)[NSD_result objectForKey:@"idfoodcategories"] integerValue]];
            [FCC_foodcategories setNSS_namefoodcategories : (NSString *)[NSD_result objectForKey:@"namefoodcategories"]];
            
            // Insertamos RestaurantClass en el Array
            if (B_menu) [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories addObject:FCC_foodcategories];
            else [globalVar.OC_order.RC_restaurant.NSMA_foodcategories addObject:FCC_foodcategories];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        if (B_menu) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_CATEGORIES_PARSE_JSON_ object:self];
        else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_CATEGORIES_PARSE_JSON_ object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getDailymenu
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getDailymenu {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getdailymenu&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d",  globalVar.OC_order.RC_restaurant.NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getdailymenu"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            DailymenuClass *DC_dailymenu = [[DailymenuClass alloc] init];
            
            // Iniciamos propiedades
            [DC_dailymenu setNSI_iddailymenu : [(NSString *)[NSD_result objectForKey:@"iddailymenu"] integerValue]];
            [DC_dailymenu setNSS_name        : [NSD_result objectForKey:@"name"]];
            [DC_dailymenu setNSD_date_start  : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_start"]]];
            [DC_dailymenu setNSD_date_end    : [globalVar getNSDateFromDateString:(NSString *)[NSD_result objectForKey:@"date_end"]]];
            [DC_dailymenu setCGF_price       : [(NSString *)[NSD_result objectForKey:@"price"] floatValue]];
            
            // Cargamos la food del dailymenu
            [self UMNI_getDailymenufood:DC_dailymenu];
            
            // Insertamos RestaurantClass en el Array
            [globalVar.OC_order.RC_restaurant.NSMA_dailymenus addObject:DC_dailymenu];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getDailymenufood
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getDailymenufood:(DailymenuClass *)DMC_dailymenu {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getdailymenufood&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&iddailymenu=%d",  DMC_dailymenu.NSI_iddailymenu]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_FOOD_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_FOOD_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getdailymenufood"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            DailymenufoodClass *DFC_dailymenufood = [[DailymenufoodClass alloc] init];
            
            // Iniciamos propiedades
            [DFC_dailymenufood setNSI_iddailymenufood    : [(NSString *)[NSD_result objectForKey:@"iddailymenufood"] integerValue]];
            [DFC_dailymenufood setNSI_idfood             : [(NSString *)[NSD_result objectForKey:@"idfood"] integerValue]];
            [DFC_dailymenufood setNSI_idfoodcategories   : [(NSString *)[NSD_result objectForKey:@"idfoodcategories"] integerValue]];
            [DFC_dailymenufood setNSS_namefoodcategories : (NSString *)[NSD_result objectForKey:@"namefoodcategories"]];
            [DFC_dailymenufood setNSS_namefood           : (NSString *)[NSD_result objectForKey:@"namefood"]];
            
            // Insertamos RestaurantClass en el Array
            [DMC_dailymenu.NSMA_dailymenufoods addObject:DFC_dailymenufood];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_FOOD_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getRestaurants
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getRestaurants:(BOOL)B_download_images {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getrestaurants&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
        
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",  globalVar.OC_order.TOT_type]];
    
    if (!globalVar.SRC_search) {
        
        [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",0]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",globalVar.NSI_blocksize_restaurants]];
        
    } else {
    
        [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d", globalVar.SRC_search.NSI_start]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d", globalVar.SRC_search.NSI_limit]];
    }
    [NSMS_url appendString:[NSString stringWithFormat:@"&position=%.7f,%.7f", globalVar.CLC_location.CLLM_manager.location.coordinate.latitude, globalVar.CLC_location.CLLM_manager.location.coordinate.longitude]];
    
    // Comprobamos los filtros
    if (globalVar.SRC_search.B_filter)         [NSMS_url appendString:[NSString stringWithFormat:@"&filter=%d", globalVar.SRC_search.TFR_filter]];
    if (globalVar.SRC_search.B_restaurant)     [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", globalVar.SRC_search.NSI_idrestaurant]];
    if (globalVar.SRC_search.B_restauranttype) [NSMS_url appendString:[NSString stringWithFormat:@"&idrestauranttype=%@", globalVar.SRC_search.NSS_idrestauranttype]];
    if (globalVar.SRC_search.B_order)          [NSMS_url appendString:[NSString stringWithFormat:@"&order=%d", globalVar.SRC_search.TRO_order]];
    
    // Comprobamos si es un pedido a domicilio
    if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
        
        // Comprobamos si la direccion aun no se ha enviado al servidor
        if (globalVar.OC_order.NSI_iduseraddress != _ID_NEW_ADDRESS_) [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d", globalVar.OC_order.NSI_iduseraddress]];
        else [NSMS_url appendString:[NSString stringWithFormat:@"&cp=%@", globalVar.OC_order.DC_useraddress.NSS_cp]];
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTES_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Iniciamos el array de tipos
        //globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTES_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getrestaurants"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            RestaurantClass *RC_restaurant = [[RestaurantClass alloc] init];
            
            // Iniciamos propiedades
            [RC_restaurant setNSI_idrestaurant     : [(NSString *)[NSD_result objectForKey:@"idrestaurant"] integerValue]];
            [RC_restaurant setNSI_idrestauranttype : (NSString *)[NSD_result objectForKey:@"idrestauranttype"]];
            [RC_restaurant setNSI_idoffer          : [(NSString *)[NSD_result objectForKey:@"idoffer"] integerValue]];
            
            [RC_restaurant setNSS_name          : (NSString *)[NSD_result objectForKey:@"name"]];
            [RC_restaurant setNSS_description   : (NSString *)[NSD_result objectForKey:@"description"]];
            [RC_restaurant setNSS_address1      : (NSString *)[NSD_result objectForKey:@"address1"]];
            [RC_restaurant setNSS_address2      : (NSString *)[NSD_result objectForKey:@"address2"]];
            [RC_restaurant setNSS_address3      : (NSString *)[NSD_result objectForKey:@"address3"]];
            [RC_restaurant setNSS_distance      : (NSString *)[NSD_result objectForKey:@"distance"]];
            [RC_restaurant setNSS_discount      : (NSString *)[NSD_result objectForKey:@"discount"]];
            [RC_restaurant setNSS_namemembership: (NSString *)[NSD_result objectForKey:@"namemembership"]];
            
            NSString *NSS_position = (NSString *)[NSD_result objectForKey:@"position"];
            NSArray *NSA_position  = [NSS_position componentsSeparatedByString:@","];
            
            // Comprobamos si ha encontrado las coordenadas
            if ([NSA_position count] == 2) {

                [RC_restaurant setCGF_latitude  : [(NSString *)[NSA_position objectAtIndex:0] floatValue]];
                [RC_restaurant setCGF_longitude : [(NSString *)[NSA_position objectAtIndex:1] floatValue]];
            }
            
            [RC_restaurant setCGF_stars                     : [(NSString *)[NSD_result objectForKey:@"stars"]                  floatValue]];
            [RC_restaurant setCGF_price_average             : [(NSString *)[NSD_result objectForKey:@"price_average"]          floatValue]];
            [RC_restaurant setCGF_min_price_homedelivery    : [(NSString *)[NSD_result objectForKey:@"min_price_homedelivery"] floatValue]];
            [RC_restaurant setCGF_price_homedelivery        : [(NSString *)[NSD_result objectForKey:@"price_homedelivery"]     floatValue]];
            [RC_restaurant setCGF_price_accumulated         : [(NSString *)[NSD_result objectForKey:@"price_accumulated"]      floatValue]];
            
            [RC_restaurant setTRS_service_adomicilio        : [(NSString *)[NSD_result objectForKey:@"service_adomicilio"]       integerValue]];
            [RC_restaurant setTRS_service_arecoger          : [(NSString *)[NSD_result objectForKey:@"service_arecoger"]         integerValue]];
            [RC_restaurant setTRS_service_antesrestaurante  : [(NSString *)[NSD_result objectForKey:@"service_antesrestaurante"] integerValue]];
            [RC_restaurant setTRS_service_enrestaurante     : [(NSString *)[NSD_result objectForKey:@"service_enrestaurante"]    integerValue]];
            [RC_restaurant setTRS_service_reserva           : [(NSString *)[NSD_result objectForKey:@"service_reserva"]          integerValue]];
            
            [RC_restaurant setB_visa        : [(NSString *)[NSD_result objectForKey:@"visa"]        boolValue]];
            [RC_restaurant setB_mastercard  : [(NSString *)[NSD_result objectForKey:@"mastercard"]  boolValue]];
            [RC_restaurant setB_favorite    : [(NSString *)[NSD_result objectForKey:@"favorite"]    boolValue]];
            
            for (int i = 1; i <=9; i++) {
                [RC_restaurant setNSI_imagesCount:i];
                if ([(NSString*)[NSD_result valueForKey:[NSString stringWithFormat:@"image%d_content",i]] isEqualToString:@"0"]) {
                    break;
                }
            }
            
            NSArray *weekDays = (NSArray*)_WEEK_DAYS_;
            
            RC_restaurant.NSMD_openHoursAntesRestaurante = [[NSMutableDictionary alloc] init];
            
            for (NSString *wDay in weekDays) {
                
                NSMutableArray *hours = [[NSMutableArray alloc] init];

                if ([NSD_result objectForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_1_start_%@",wDay]]) {
                    [hours addObject:[NSD_result valueForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_1_start_%@",wDay]]];
                }
                if ([NSD_result objectForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_1_end_%@",wDay]]) {
                    [hours addObject:[NSD_result valueForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_1_end_%@",wDay]]];
                }
                if ([NSD_result objectForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_2_start_%@",wDay]]) {
                    [hours addObject:[NSD_result valueForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_2_start_%@",wDay]]];
                }
                if ([NSD_result objectForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_2_end_%@",wDay]]) {
                    [hours addObject:[NSD_result valueForKey:[NSString stringWithFormat:@"service_antesrestaurante_hours_2_end_%@",wDay]]];
                }
            
                [RC_restaurant.NSMD_openHoursAntesRestaurante  setObject:hours forKey:wDay];
            }
        
            // Comprobamos si debemos cargar las imágenes
            if (B_download_images) {
                
                // Cargamos la imagenes
                RC_restaurant.IC_image_mini = [[ImageClass alloc] init];
                [RC_restaurant.IC_image_mini setTIT_type:TIT_restaurants];
                [RC_restaurant.IC_image_mini setCGF_width :100.0f];
                [RC_restaurant.IC_image_mini setCGF_height:100.0f];
                [RC_restaurant.IC_image_mini setNSI_number:1];
                [self UMNI_getImage:RC_restaurant.IC_image_mini objectId:RC_restaurant.NSI_idrestaurant];
                
                // Cargamos imagen de la oferta
                if (RC_restaurant.NSI_idoffer > 0) {
                    
                    RC_restaurant.IC_image_offer = [[ImageClass alloc] init];
                    [RC_restaurant.IC_image_offer setTIT_type:TIT_offers];
                    [RC_restaurant.IC_image_offer setCGF_width :100.0f];
                    [RC_restaurant.IC_image_offer setCGF_height:140.0f];
                    [self UMNI_getImage:RC_restaurant.IC_image_offer objectId:RC_restaurant.NSI_idoffer];
                }
            }
            
            // Insertamos RestaurantClass en el Array
            [globalVar.NSMA_restaurants addObject:RC_restaurant];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTES_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {

        }
    }
}

-(NSArray*) UMNI_getDatesOffers:(NSInteger)idRestaurant inMonth:(NSString*)month{
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getdatesoffers&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];

    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", idRestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&month=%@", month]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UMNI_getDatesOffersError" object:nil];
    }
    else {
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UMNI_getDatesOffersError" object:self];
            
            return nil;
        }
        
        NSArray *NSA_results = [NSD_parse objectForKey:@"getdatesoffers"];
        
        return NSA_results;
    }
    
    return nil;


}
-(NSArray*) UMNI_getHoursOffers:(NSInteger)idRestaurant service:(NSString*)service inDate:(NSString*)date{

    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=gethoursoffers&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", idRestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&date=%@", date]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&service=%@", service]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UMNI_getHoursOffersError" object:nil];
    }
    else {
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UMNI_getHoursOffersError" object:nil];
            
            return nil;
        }
        
        NSArray *NSA_results = [NSD_parse objectForKey:@"gethoursoffers"];
        
        return NSA_results;
    }
    
    return nil;

}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getRestaurant
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getRestaurant:(NSInteger)NSI_idrestaurant images:(BOOL)B_download_images {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getrestaurants&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&position=%.7f,%.7f", globalVar.CLC_location.CLLM_manager.location.coordinate.latitude, globalVar.CLC_location.CLLM_manager.location.coordinate.longitude]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTE_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTE_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getrestaurants"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Iniciamos el array de tipos
            globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
            
            // Iniciamos propiedades
            [globalVar.OC_order.RC_restaurant setNSI_idrestaurant     : [(NSString *)[NSD_result objectForKey:@"idrestaurant"] integerValue]];
            [globalVar.OC_order.RC_restaurant setNSI_idrestauranttype : (NSString *)[NSD_result objectForKey:@"idrestauranttype"]];
            [globalVar.OC_order.RC_restaurant setNSI_idoffer          : [(NSString *)[NSD_result objectForKey:@"idoffer"] integerValue]];
            
            [globalVar.OC_order.RC_restaurant setNSS_name          : (NSString *)[NSD_result objectForKey:@"name"]];
            [globalVar.OC_order.RC_restaurant setNSS_description   : (NSString *)[NSD_result objectForKey:@"description"]];
            [globalVar.OC_order.RC_restaurant setNSS_address1      : (NSString *)[NSD_result objectForKey:@"address1"]];
            [globalVar.OC_order.RC_restaurant setNSS_address2      : (NSString *)[NSD_result objectForKey:@"address2"]];
            [globalVar.OC_order.RC_restaurant setNSS_address3      : (NSString *)[NSD_result objectForKey:@"address3"]];
            [globalVar.OC_order.RC_restaurant setNSS_distance      : (NSString *)[NSD_result objectForKey:@"distance"]];
            [globalVar.OC_order.RC_restaurant setNSS_discount      : (NSString *)[NSD_result objectForKey:@"discount"]];
            [globalVar.OC_order.RC_restaurant setNSS_namemembership: (NSString *)[NSD_result objectForKey:@"namemembership"]];
            
            NSString *NSS_position = (NSString *)[NSD_result objectForKey:@"position"];
            NSArray *NSA_position  = [NSS_position componentsSeparatedByString:@","];
            
            // Comprobamos si ha encontrado las coordenadas
            if ([NSA_position count] == 2) {
                
                [globalVar.OC_order.RC_restaurant setCGF_latitude  : [(NSString *)[NSA_position objectAtIndex:0] floatValue]];
                [globalVar.OC_order.RC_restaurant setCGF_longitude : [(NSString *)[NSA_position objectAtIndex:1] floatValue]];
            }
            
            [globalVar.OC_order.RC_restaurant setCGF_stars                     : [(NSString *)[NSD_result objectForKey:@"stars"]                  floatValue]];
            [globalVar.OC_order.RC_restaurant setCGF_price_average             : [(NSString *)[NSD_result objectForKey:@"price_average"]          floatValue]];
            [globalVar.OC_order.RC_restaurant setCGF_min_price_homedelivery    : [(NSString *)[NSD_result objectForKey:@"min_price_homedelivery"] floatValue]];
            [globalVar.OC_order.RC_restaurant setCGF_price_homedelivery        : [(NSString *)[NSD_result objectForKey:@"price_homedelivery"]     floatValue]];
            [globalVar.OC_order.RC_restaurant setCGF_price_accumulated         : [(NSString *)[NSD_result objectForKey:@"price_accumulated"]      floatValue]];
            
            [globalVar.OC_order.RC_restaurant setTRS_service_adomicilio        : [(NSString *)[NSD_result objectForKey:@"service_adomicilio"]       integerValue]];
            [globalVar.OC_order.RC_restaurant setTRS_service_arecoger          : [(NSString *)[NSD_result objectForKey:@"service_arecoger"]         integerValue]];
            [globalVar.OC_order.RC_restaurant setTRS_service_antesrestaurante  : [(NSString *)[NSD_result objectForKey:@"service_antesrestaurante"] integerValue]];
            [globalVar.OC_order.RC_restaurant setTRS_service_enrestaurante     : [(NSString *)[NSD_result objectForKey:@"service_enrestaurante"]    integerValue]];
            [globalVar.OC_order.RC_restaurant setTRS_service_reserva           : [(NSString *)[NSD_result objectForKey:@"service_reserva"]          integerValue]];
            
            [globalVar.OC_order.RC_restaurant setB_visa        : [(NSString *)[NSD_result objectForKey:@"visa"]       boolValue]];
            [globalVar.OC_order.RC_restaurant setB_mastercard  : [(NSString *)[NSD_result objectForKey:@"mastercard"] boolValue]];
            [globalVar.OC_order.RC_restaurant setB_favorite    : [(NSString *)[NSD_result objectForKey:@"favorite"]   boolValue]];
            
            // Comprobamos si debemos cargar ls imágenes
            if (B_download_images) {
                
                // Cargamos la imagenes
                globalVar.OC_order.RC_restaurant.IC_image_mini = [[ImageClass alloc] init];
                [globalVar.OC_order.RC_restaurant.IC_image_mini setTIT_type:TIT_restaurants];
                [globalVar.OC_order.RC_restaurant.IC_image_mini setCGF_width :100.0f];
                [globalVar.OC_order.RC_restaurant.IC_image_mini setCGF_height:100.0f];
                [globalVar.OC_order.RC_restaurant.IC_image_mini setNSI_number:1];
                [self UMNI_getImage:globalVar.OC_order.RC_restaurant.IC_image_mini objectId:globalVar.OC_order.RC_restaurant.NSI_idrestaurant];
                
                // Cargamos las 9 posible imágenes
                for (int iCount = 1; iCount < 10; iCount++) {
                    
                    ImageClass *IC_image = [[ImageClass alloc] init];
                    [IC_image setTIT_type:TIT_restaurants];
                    [IC_image setCGF_width :640.0f];
                    [IC_image setCGF_height:400.0f];
                    [IC_image setNSI_number:iCount];
                    [globalVar.OC_order.RC_restaurant.NSMA_images addObject:IC_image];
                    [self UMNI_getImage:IC_image objectId:globalVar.OC_order.RC_restaurant.NSI_idrestaurant];
                    
                    // Comprobamos si la imagen se encontro
                    if (IC_image.NSS_imageUrl == nil) [globalVar.OC_order.RC_restaurant.NSMA_images removeObject:IC_image];
                    //else [NSThread sleepForTimeInterval:0.8];
                }
                
                // Cargamos imagen de la oferta
                if (globalVar.OC_order.RC_restaurant.NSI_idoffer > 0) {
                    
                    globalVar.OC_order.RC_restaurant.IC_image_offer = [[ImageClass alloc] init];
                    [globalVar.OC_order.RC_restaurant.IC_image_offer setTIT_type:TIT_offers];
                    [globalVar.OC_order.RC_restaurant.IC_image_offer setCGF_width :100.0f];
                    [globalVar.OC_order.RC_restaurant.IC_image_offer setCGF_height:140.0f];
                    [self UMNI_getImage:globalVar.OC_order.RC_restaurant.IC_image_offer objectId:globalVar.OC_order.RC_restaurant.NSI_idoffer];
                }
            }
            
            // Insertamos RestaurantClass en el Array
            [globalVar.NSMA_restaurants addObject:globalVar.OC_order.RC_restaurant];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTE_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getRestauranttype
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getRestauranttype {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getrestauranttype&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
     
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_TIPOS_COCINA_ERROR_
                                                            object:self];
    }
    else {

        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSASCIIStringEncoding]);
        
        // Iniciamos el array de tipos
        globalVar.NSMA_tipos_cocina = [[NSMutableArray alloc] init];
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_TIPOS_COCINA_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getrestauranttype"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos TipoCocinaClass
            TipoCocinaClass *TCC_tipo_cocina = [[TipoCocinaClass alloc] init];
            
            // Iniciamos propiedades
            [TCC_tipo_cocina setNSI_id          : [(NSString *)[NSD_result objectForKey:@"idrestauranttype"] integerValue]];
            [TCC_tipo_cocina setNSS_name        : (NSString *)[NSD_result objectForKey:@"name"]];
            [TCC_tipo_cocina setNSS_description : (NSString *)[NSD_result objectForKey:@"description"]];
            
            // Insertamos TipoCocinaclass en el Array
            [globalVar.NSMA_tipos_cocina addObject:TCC_tipo_cocina];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_TIPOS_COCINA_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
            // Recorremos el NSMautableArray de Campos activo
            for (TipoCocinaClass *TCC_tipo_cocina in globalVar.NSMA_tipos_cocina) {
                
                NSLog(@"-------------- TIPOS COCINA --------------");
                NSLog(@"             NSS_id : %d", TCC_tipo_cocina.NSI_id);
                NSLog(@"           NSS_name : %@", TCC_tipo_cocina.NSS_name);
                NSLog(@"    NSS_description : %@", TCC_tipo_cocina.NSS_description);
            }
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getUsermembership
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getUsermembership:(NSInteger)NSI_idrestaurant {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getusermembership&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_MEMBERSHIP_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_MEMBERSHIP_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"getusermembership"];
        
        // Recuperamos el id
        NSString *NSS_idmembership = (NSString *)[NSD_result objectForKey:@"idmembership"];
        
        // Comprobamos si se ha devuelto resultados
        if ([NSS_idmembership length] != 0)  {
            
            // Iniciamos propiedades
            [globalVar.UC_user.UMC_membership setNSI_idmembership           : [(NSString *)[NSD_result objectForKey:@"idmembership"] integerValue]];
            [globalVar.UC_user.UMC_membership setCGF_priceaccumulated       : [(NSString *)[NSD_result objectForKey:@"priceaccumulated"] floatValue]];
            [globalVar.UC_user.UMC_membership setNSS_membershipname         :  (NSString *)[NSD_result objectForKey:@"membershipname"]];
            [globalVar.UC_user.UMC_membership setNSS_membershippricemax     :  (NSString *)[NSD_result objectForKey:@"membershippricemax"]];
            [globalVar.UC_user.UMC_membership setNSS_membershippricemin     :  (NSString *)[NSD_result objectForKey:@"membershippricemin"]];
            [globalVar.UC_user.UMC_membership setNSS_membershippricemaxname :  (NSString *)[NSD_result objectForKey:@"membershippricemaxname"]];
            [globalVar.UC_user.UMC_membership setNSS_membershippriceminname :  (NSString *)[NSD_result objectForKey:@"membershippriceminname"]];
            [globalVar.UC_user.UMC_membership setNSS_membershipdescription  :  (NSString *)[NSD_result objectForKey:@"membershipdescription"]];
            [globalVar.UC_user.UMC_membership setNSS_discount               :  (NSString *)[NSD_result objectForKey:@"discount"]];
        }
        else {
            
            // Indicamos que no se tiene datos
            [globalVar.UC_user.UMC_membership setNSI_idmembership:_ID_USER_MEMBERSHIP_NO_VALUE_];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_MEMBERSHIP_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
         
            NSLog(@"-------------------- USUARIO MEMBERSHIP --------------------");
            NSLog(@"           NSI_idmembership : %d",   globalVar.UC_user.UMC_membership.NSI_idmembership);
            NSLog(@"       CGF_priceaccumulated : %.2f", globalVar.UC_user.UMC_membership.CGF_priceaccumulated);
            NSLog(@"         NSS_membershipname : %@",   globalVar.UC_user.UMC_membership.NSS_membershipname);
            NSLog(@"     NSS_membershippricemax : %@",   globalVar.UC_user.UMC_membership.NSS_membershippricemax);
            NSLog(@"     NSS_membershippricemin : %@",   globalVar.UC_user.UMC_membership.NSS_membershippricemin);
            NSLog(@" NSS_membershippricemaxname : %@",   globalVar.UC_user.UMC_membership.NSS_membershippricemaxname);
            NSLog(@" NSS_membershippriceminname : %@",   globalVar.UC_user.UMC_membership.NSS_membershippriceminname);
            NSLog(@"  NSS_membershipdescription : %@",   globalVar.UC_user.UMC_membership.NSS_membershipdescription);
            NSLog(@"               NSS_discount : %@",   globalVar.UC_user.UMC_membership.NSS_discount);
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getUser
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getUser {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getuser&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_user = [NSD_parse objectForKey:@"getuser"];
        
        // Iniciamos propiedades
        [globalVar.UC_user setNSI_phone : [(NSString *)[NSD_user objectForKey:@"phone"] integerValue]];
        [globalVar.UC_user setTST_genre : [(NSString *)[NSD_user objectForKey:@"genre"] integerValue]];
        [globalVar.UC_user setTRT_type  : [(NSString *)[NSD_user objectForKey:@"type"] integerValue]];
        
        [globalVar.UC_user setNSS_name      : (NSString *)[NSD_user objectForKey:@"name"]];
        [globalVar.UC_user setNSS_lastname  : (NSString *)[NSD_user objectForKey:@"lastname"]];
        [globalVar.UC_user setNSS_email     : (NSString *)[NSD_user objectForKey:@"email"]];
        [globalVar.UC_user setNSS_location  : (NSString *)[NSD_user objectForKey:@"location"]];
        
        [globalVar.UC_user setNSD_birthday : [globalVar getNSDateFromDateString:(NSString *)[NSD_user objectForKey:@"birthday"]]];
        
        [globalVar.UC_user setNSN_spending          : (NSNumber *)[NSNumber numberWithFloat:[(NSString *)[NSD_user objectForKey:@"total_spending"] floatValue]]];
        [globalVar.UC_user setNSN_saving            : (NSNumber *)[NSNumber numberWithFloat:[(NSString *)[NSD_user objectForKey:@"total_saving"] floatValue]]];
        [globalVar.UC_user setNSN_restaurants_visits: (NSNumber *)[NSNumber numberWithFloat:[(NSString *)[NSD_user objectForKey:@"restaurants_visits"] integerValue]]];

        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
            // Actualizamos UILT fecha caducidad
            NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
            [NSDF_date setDateFormat:@"dd ' de ' MMMM ' de ' yyyy"];
            NSString *NSS_date = [NSDF_date stringFromDate:globalVar.UC_user.NSD_birthday];
            
            NSLog(@"-------------------- USUARIO --------------------");
            NSLog(@"                 NSS_id : %d", globalVar.UC_user.NSI_id);
            NSLog(@"              NSI_phone : %d", globalVar.UC_user.NSI_phone);
            NSLog(@"              TST_genre : %d", globalVar.UC_user.TST_genre);
            NSLog(@"               NSS_name : %@", globalVar.UC_user.NSS_name);
            NSLog(@"           NSS_lastname : %@", globalVar.UC_user.NSS_lastname);
            NSLog(@"              NSS_email : %@", globalVar.UC_user.NSS_email);
            NSLog(@"               TRT_type : %d", globalVar.UC_user.TRT_type);
            NSLog(@"           NSS_location : %@", globalVar.UC_user.NSS_location);
            NSLog(@"           NSD_birthday : %@", NSS_date);
            NSLog(@"           NSN_spending : %.2f", [globalVar.UC_user.NSN_spending floatValue]);
            NSLog(@"             NSN_saving : %.2f", [globalVar.UC_user.NSN_saving floatValue]);
            NSLog(@" NSN_restaurants_visits : %d", [globalVar.UC_user.NSN_restaurants_visits integerValue]);
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getUseraddress
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getUseraddress {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getuseraddress&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&start=%d",  _GET_START_VALUE_]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&limit=%d",  _GET_LIMIT_VALUE_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DIRECCIONES_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DIRECCIONES_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_results = [NSD_parse objectForKey:@"getuseraddress"];
        
        // Recorremos el Array de Editios
        for (NSDictionary *NSD_result in NSA_results) {
            
            // Creamos ObjectClass
            DireccionClass *DC_direccion = [[DireccionClass alloc] init];
            
            // Iniciamos propiedades
            [DC_direccion setNSI_id         : [(NSString *)[NSD_result objectForKey:@"iduseraddress"] integerValue]];
            [DC_direccion setNSS_etiqueta   : (NSString *)[NSD_result objectForKey:@"name"]];
            [DC_direccion setNSS_direccion  : (NSString *)[NSD_result objectForKey:@"address1"]];
            [DC_direccion setNSS_numero     : (NSString *)[NSD_result objectForKey:@"address2"]];
            [DC_direccion setNSS_piso       : (NSString *)[NSD_result objectForKey:@"address3"]];
            [DC_direccion setNSS_letra      : (NSString *)[NSD_result objectForKey:@"address4"]];
            [DC_direccion setNSS_portal     : (NSString *)[NSD_result objectForKey:@"address5"]];
            [DC_direccion setNSS_escalera   : (NSString *)[NSD_result objectForKey:@"address6"]];
            [DC_direccion setNSS_cp         : (NSString *)[NSD_result objectForKey:@"cp"]];
            [DC_direccion setNSS_ciudad     : (NSString *)[NSD_result objectForKey:@"location"]];
            [DC_direccion setNSS_telefono   : (NSString *)[NSD_result objectForKey:@"phone"]];
            [DC_direccion setNSS_movil      : (NSString *)[NSD_result objectForKey:@"mobile"]];
            
            // Insertamos ObjectClass en el Array
            [globalVar.NSMA_direcciones addObject:DC_direccion];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DIRECCIONES_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
            // Recorremos el NSMautableArray de Campos activo
            for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones) {
                
                NSLog(@"-------------- DIRECCIONES --------------");
                NSLog(@"             NSS_id : %d", DC_direccion.NSI_id);
                NSLog(@"       NSS_etiqueta : %@", DC_direccion.NSS_etiqueta);
                NSLog(@"      NSS_direccion : %@", DC_direccion.NSS_direccion);
                NSLog(@"         NSS_numero : %@", DC_direccion.NSS_numero);
                NSLog(@"           NSS_piso : %@", DC_direccion.NSS_piso);
                NSLog(@"          NSS_letra : %@", DC_direccion.NSS_letra);
                NSLog(@"         NSS_portal : %@", DC_direccion.NSS_portal);
                NSLog(@"       NSS_escalera : %@", DC_direccion.NSS_escalera);
                NSLog(@"             NSS_cp : %@", DC_direccion.NSS_cp);
                NSLog(@"         NSS_ciudad : %@", DC_direccion.NSS_ciudad);
                NSLog(@"       NSS_telefono : %@", DC_direccion.NSS_telefono);
                NSLog(@"          NSS_movil : %@", DC_direccion.NSS_movil);
            }
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_rememberPassword
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_rememberPassword:(NSString *)NSS_email {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=rememberpassword&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&email=%@", NSS_email]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"rememberpassword"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_rememberPassword_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_rememberPassword_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_ERROR_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_JSON_ 
                                                                object:self];
        }
    }
} 

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_sendOrderticket
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_sendOrderticket {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=sendorderticket&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d", globalVar.OC_order.NSI_idorder]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"sendorderticket"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"1"]) {
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_PARSE_JSON_
                                                                object:self];
        }
        else {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_sendOrderticket_];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_ERROR_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setSuggestionsproblems
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setSuggestionsproblems:(MensajeClass *)MC_mensaje {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setsuggestionsproblems&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    if (globalVar.B_usuario_registrado) [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&description=%@", [globalVar urlEncodeValue:MC_mensaje.NSS_description]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",  MC_mensaje.TMT_type]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];

        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);

        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setSuggestionsproblems_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setSuggestionsproblems_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_ERROR_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_PARSE_JSON_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setUser:(UserClass *)UC_user update:(BOOL)B_update changePassword:(BOOL)B_password {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Actualizamos la BB.DD
    [globalVar.CDC_coreData updateUser:UC_user];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setuser&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&name=%@",     [globalVar urlEncodeValue:UC_user.NSS_name]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&lastname=%@", [globalVar urlEncodeValue:UC_user.NSS_lastname]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&email=%@",    [globalVar urlEncodeValue:UC_user.NSS_email]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&phone=%d",    UC_user.NSI_phone]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&token=%@",    UC_user.NSS_token]];

    // Comprobamos si hemos recuperado el numero de amigos de facebook
    if (UC_user.NSI_num_facebook_friends > 0) [NSMS_url appendString:[NSString stringWithFormat:@"&friends=%d", UC_user.NSI_num_facebook_friends]];
    
    // Comprobamos si es una actualización
    if (B_update) {

        // Actualizamos UILabel Fecha
        NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
        [NSDF_date setDateFormat:@"yyyy-MM-dd"];
        NSString *NSS_date = [NSDF_date stringFromDate:UC_user.NSD_birthday];
        
        // Insertamos el resto de parámetros
        [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d",    UC_user.NSI_id]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&location=%@",  [globalVar urlEncodeValue:UC_user.NSS_location]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&genre=%d",     UC_user.TST_genre]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&birthday=%@",  NSS_date]];
        
        // Comprobamos si el password se ha introducido
        if (B_password) {
         
            // Insertamos el Password
            [NSMS_url appendString:[NSString stringWithFormat:@"&password=%@", [globalVar urlEncodeValue:UC_user.NSS_password]]];
            
            // Comprobamos el tipo
            if (UC_user.TRT_type == TRT_facebook) {
                
                // Cambiamos el tipo
                [UC_user setTRT_type:TRT_normal];
                
                // Actualizamos la BB.DD
                [globalVar.CDC_coreData updateUser:UC_user];
            }
        }
        
        // Añadimos el tipo
        [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", UC_user.TRT_type]];
    }
    else {
        
        // Añadimos el password y el tipo
        [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",     UC_user.TRT_type]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&password=%@", [globalVar urlEncodeValue:UC_user.NSS_password]]];
        
        // Comprobamos si es de Facebook
        if (UC_user.TRT_type == TRT_facebook) {

            // Insertamos location y sexo
            [NSMS_url appendString:[NSString stringWithFormat:@"&location=%@",  [globalVar urlEncodeValue:UC_user.NSS_location]]];
            [NSMS_url appendString:[NSString stringWithFormat:@"&genre=%d",     UC_user.TST_genre]];
        }
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos el id del Usuario
            [globalVar.UC_user setNSI_id:[NSS_result integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_PARSE_JSON_ 
                                                                object:self];
        }
    }
}    

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_deleteUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_deleteUser:(NSInteger)NSI_id {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=deleteuser&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", NSI_id]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_deleteUser_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_deleteUser_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_ERROR_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_JSON_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setUseraddress
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setUseraddress:(DireccionClass *)DC_direccion update:(BOOL)B_update {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setuseraddress&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d",    globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&name=%@",      [globalVar urlEncodeValue:DC_direccion.NSS_etiqueta]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address1=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_direccion]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address2=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_numero]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address3=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_piso]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address4=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_letra]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address5=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_portal]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&address6=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_escalera]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&cp=%@",        [globalVar urlEncodeValue:DC_direccion.NSS_cp]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&location=%@",  [globalVar urlEncodeValue:DC_direccion.NSS_ciudad]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&phone=%@",     [globalVar urlEncodeValue:DC_direccion.NSS_telefono]]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&mobile=%@",    [globalVar urlEncodeValue:DC_direccion.NSS_movil]]];
    
    // Comprobamos si es una actualización
    if (DC_direccion.NSI_id > 0) {
        
        // Insertamos el resto de parámetros
        [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d", DC_direccion.NSI_id]];
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        if (!B_update) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_ERROR_ object:self];
        else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_ERROR_ object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setUseraddress_];
            
            // Lazamos la notificación de error
            if (!B_update) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_ERROR_ object:self];
            else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_ERROR_ object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setUseraddress_];
            
            // Lazamos la notificación de error
            if (!B_update) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_ERROR_ object:self];
            else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_ERROR_ object:self];
        }
        else {
            
            // Actualizamos el id del Usuario
            [globalVar.OC_order.DC_useraddress setNSI_id:[NSS_result integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            if (!B_update) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_PARSE_JSON_ object:self];
            else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_PARSE_JSON_ object:self];
        }
    }
} 

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_deleteUseraddress
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_deleteUseraddress:(NSInteger)NSI_id {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=deleteuseraddress&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d", NSI_id]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_deleteUserAddress_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_deleteUserAddress_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_ERROR_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_PARSE_JSON_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_validateLogin:password:
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_validateLogin:(UserClass *)UC_user {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=validatelogin&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&email=%@",    UC_user.NSS_email]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&password=%@", UC_user.NSS_password]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&token=%@",    globalVar.NSS_deviceToken]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"validatelogin"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_validateLogin_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_NO_VALID_
                                                                object:self];
        }
        else if ([NSS_result isEqualToString:@"-1"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:(NSString *)[NSD_result objectForKey:@"msg"]];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_BANEADO_
                                                                object:self];
        }
        else {
            
            // Actualizamos el id del Usuario
            [globalVar.UC_user setNSI_id:[(NSString *)[NSD_result objectForKey:@"iduser"] integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_PARSE_JSON_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_validateEmail
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_validateEmail:(NSString *)NSS_email type:(typeRegisterType)TRT_type {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=validateemail&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&email=%@", NSS_email]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",  TRT_type]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&token=%@", globalVar.NSS_deviceToken]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"validateemail"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"-1"]) {
            
            // Recuperamos el mensaje
            [globalVar setNSS_msg_error:(NSString *)[NSD_result objectForKey:@"msg"]];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_BANEADO_
                                                                object:self];
        }
        else if ([NSS_result isEqualToString:@"1"]) {
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_EXISTE_KO_
                                                                object:self];
        }
        else if ([NSS_result isEqualToString:@"0"]) {
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_PARSE_JSON_
                                                                object:self];
        }
        else {
            
            // Guardamos el idUser
            [globalVar.UC_user setNSI_id:[NSS_result integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_EXISTE_OK_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setOrder
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setOrder:(OrderClass *)OC_order {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setorder&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d",        globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d",  OC_order.RC_restaurant.NSI_idrestaurant]];
    
    [NSMS_url appendString:[NSString stringWithFormat:@"&status=%d",        OC_order.TOS_status]];
    
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",          OC_order.TOT_type]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&active=%d",        OC_order.TOA_active]];

    // Comprobamos si tiene una Offer
    if (OC_order.NSI_idorder != _ID_ORDER_NO_VALUE_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d",  OC_order.NSI_idorder]];
    }
    
    // Comprobamos si tiene una Facebook Offer
    if (OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer_facebook=%d",  OC_order.NSI_idoffer_facebook]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&facebook_discount=%.2f", OC_order.CGF_facebook_discount]];
    }
    
    // Comprobamos si tiene una Offer
    if (OC_order.OC_offer.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer=%d",          OC_order.OC_offer.NSI_idoffer]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&offer_discount=%.2f", OC_order.CGF_offer_discount]];
    }
    
    // Comprobamos si tiene una Tarjeta
    if (OC_order.TC_creditcard.NSI_id != _ID_CREDITCARD_NO_SELECTED_) {
        
        NSString *lastNums = [OC_order.TC_creditcard.NSS_number substringFromIndex:(OC_order.TC_creditcard.NSS_number.length-4)];
        [NSMS_url appendString:[NSString stringWithFormat:@"&number_creditcard=%@", lastNums]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&type_creditcard=%@", OC_order.TC_creditcard.NSS_type]];
        
        if ([[tpvDAO sharedInstance] paymentId]) {
            [NSMS_url appendString:[NSString stringWithFormat:@"&idorder_tpv=%@", [[tpvDAO sharedInstance] paymentId]]];
        }
    }
    
    // Comprobamos que no sea una reserva
    if (OC_order.TOT_type != TOT_reserva) {
        
        // Insertamos valores monetarios
        [NSMS_url appendString:[NSString stringWithFormat:@"&subtotal=%.2f",            OC_order.CGF_subtotal]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&membership_discount=%.2f", OC_order.CGF_membership_discount]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&total=%.2f",               OC_order.CGF_total]];
        
        // Insertamos los parametros variables
        if (OC_order.TOT_type == TOT_pedido_a_domicilio) {
         
            [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d",        OC_order.DC_useraddress.NSI_id]];
            [NSMS_url appendString:[NSString stringWithFormat:@"&price_homedelivery=%.2f", OC_order.CGF_price_homedelivery]];
        }
        else if (OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            [NSMS_url appendString:[NSString stringWithFormat:@"&number_table=%d", OC_order.NSI_number_table]];
        }
        else if (OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos UILabel Fecha
            NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
            [NSDF_date setDateFormat:@"HH:mm"];
            NSString *NSS_date = [NSDF_date stringFromDate:OC_order.NSD_date_reservation];
            
            // Insertamos los parametros variables
            [NSMS_url appendString:[NSString stringWithFormat:@"&date_reservation=%@", NSS_date]];
            [NSMS_url appendString:[NSString stringWithFormat:@"&persons=%d",          OC_order.NSI_persons]];
        }   
        
        // comprobamos si hay instrucciones
        if ([OC_order.NSS_instructions length] != 0) {
         
            [NSMS_url appendString:[NSString stringWithFormat:@"&instructions=%@", [globalVar urlEncodeValue:OC_order.NSS_instructions]]];
        }
    }
    else {
        
        // Actualizamos UILabel Fecha
        NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
        [NSDF_date setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *NSS_date = [NSDF_date stringFromDate:OC_order.NSD_date_reservation];
        
        // Insertamos los parametros variables
        [NSMS_url appendString:[NSString stringWithFormat:@"&date_reservation=%@", [globalVar urlEncodeValue:NSS_date]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&persons=%d",          OC_order.NSI_persons]];
        [NSMS_url appendString:@"&total=0"];
    } 
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"setorder"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setOrder_];
            
            // Lanzamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setOrder_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos el id la orden
            [OC_order setNSI_idorder:[NSS_result integerValue]];
            
          //  [globalVar.CDC_coreData updateTpvWithId:[[tpvDAO sharedInstance] paymentId] setOrderId:[NSString stringWithFormat:@"%d",OC_order.NSI_idorder]];

            // Comprobamos que no sea una reserva
            if (OC_order.TOT_type != TOT_reserva) {

            //if (OC_order.TOT_type != TOT_reserva) {

                // Insertamos OrderFood
                for (OrderFoodClass *OFC_orderfood in OC_order.NSMA_orderfoods) {
                    
                    // Comprobamos que no sea una offer -> no hay que enviarla
                    if ((!OFC_orderfood.B_is_offer) && (!OFC_orderfood.B_is_offer_facebook)) [self UMNI_setOrderfood:OFC_orderfood idorder:OC_order.NSI_idorder];
                }
            }
            
            // Lanzamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_PARSE_JSON_
             object:self];
        }
    }
}

-(void) UMNI_setOrderCupon:(OrderClass *)OC_order{

    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setordercupon&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d",        globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d",  OC_order.RC_restaurant.NSI_idrestaurant]];
    
    [NSMS_url appendString:[NSString stringWithFormat:@"&status=%d",        OC_order.TOS_status]];
    
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d",          OC_order.TOT_type]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&active=%d",        OC_order.TOA_active]];
    
    // Comprobamos si tiene una Offer
    if (OC_order.NSI_idorder != _ID_ORDER_NO_VALUE_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d",  OC_order.NSI_idorder]];
    }
    
    // Comprobamos si tiene una Facebook Offer
    if (OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer_facebook=%d",  OC_order.NSI_idoffer_facebook]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&facebook_discount=%.2f", OC_order.CGF_facebook_discount]];
    }
    
    // Comprobamos si tiene una Offer
    if (OC_order.OC_offer.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Insertamos parametros relacionados
        [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer=%d",          OC_order.OC_offer.NSI_idoffer]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&offer_discount=%.2f", OC_order.CGF_offer_discount]];
    }
    
    // Comprobamos si tiene una Tarjeta
    if (OC_order.TC_creditcard.NSI_id != _ID_CREDITCARD_NO_SELECTED_) {
        
        NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
        [NSDF_date setDateFormat:@"yyyy-MM"];
        NSString *NSS_date = [NSDF_date stringFromDate:OC_order.TC_creditcard.NSD_date_expiration];
                
        [NSMS_url appendString:[NSString stringWithFormat:@"&owner_creditcard=%@",  [globalVar urlEncodeValue:OC_order.TC_creditcard.NSS_name]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&number_creditcard=%@", [self MD5String:OC_order.TC_creditcard.NSS_number]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&type_creditcard=%@",   OC_order.TC_creditcard.NSS_type]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&cvv=%@",               OC_order.TC_creditcard.NSS_cvv]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&date_expiration=%@",   NSS_date]];
        
        if ([[tpvDAO sharedInstance] paymentId]) {
            [NSMS_url appendString:[NSString stringWithFormat:@"&idorder_tpv=%@", [[tpvDAO sharedInstance] paymentId]]];
        }
    }
    
    // Comprobamos que no sea una reserva
    if (OC_order.TOT_type != TOT_reserva) {
        
        // Insertamos valores monetarios
        [NSMS_url appendString:[NSString stringWithFormat:@"&subtotal=%.2f",            OC_order.CGF_subtotal]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&membership_discount=%.2f", OC_order.CGF_membership_discount]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&total=%.2f",               OC_order.CGF_total]];
        
        // Insertamos los parametros variables
        if (OC_order.TOT_type == TOT_pedido_a_domicilio) {
            
            [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d",        OC_order.DC_useraddress.NSI_id]];
            [NSMS_url appendString:[NSString stringWithFormat:@"&price_homedelivery=%.2f", OC_order.CGF_price_homedelivery]];
        }
        else if (OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            [NSMS_url appendString:[NSString stringWithFormat:@"&number_table=%d", OC_order.NSI_number_table]];
        }
        else if (OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos UILabel Fecha
            NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
            [NSDF_date setDateFormat:@"HH:mm"];
            NSString *NSS_date = [NSDF_date stringFromDate:OC_order.NSD_date_reservation];
            
            // Insertamos los parametros variables
            [NSMS_url appendString:[NSString stringWithFormat:@"&date_reservation=%@", NSS_date]];
            [NSMS_url appendString:[NSString stringWithFormat:@"&persons=%d",          OC_order.NSI_persons]];
        }
        
        // comprobamos si hay instrucciones
        if ([OC_order.NSS_instructions length] != 0) {
            
            [NSMS_url appendString:[NSString stringWithFormat:@"&instructions=%@", [globalVar urlEncodeValue:OC_order.NSS_instructions]]];
        }
    }
    else {
        
        // Actualizamos UILabel Fecha
        NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
        [NSDF_date setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *NSS_date = [NSDF_date stringFromDate:OC_order.NSD_date_reservation];
        
        // Insertamos los parametros variables
        [NSMS_url appendString:[NSString stringWithFormat:@"&date_reservation=%@", [globalVar urlEncodeValue:NSS_date]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&persons=%d",          OC_order.NSI_persons]];
        [NSMS_url appendString:@"&total=0"];
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        NSLog(@"Error cargando URL %@", NSMS_url);
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        // Lazamos la notificación de error
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cuponValidationResultKo" object:self];
    }
    else {
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cuponValidationResultOk" object:NSD_parse];
    }
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_updateOrderStatus
//#	Fecha Creación	: 01/12/2012  (iMario)
//#	Fecha Ult. Mod.	: 01/12/2012  (iMario)
//# Descripción		:
//#
-(void) UMNI_updateOrderStatus:(OrderClass *)OC_order {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setorder&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&status=%d",OC_order.TOS_status]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d",OC_order.NSI_idorder]];

    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"setorder"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        NSString *msg = nil;
        
        if (OC_order.TOS_status == TOS_devolucion_fallida) {
            msg = [NSString stringWithFormat:_ALERT_MSG_UMIN_CANCELATION_ERROR_,[NSString stringWithFormat:@"%@. Se ha producido un error en la devolución del importe. Por favor, póngase en contacto con Atención al Cliente: usuarios@gochef.com, 911828723. Gracias.",OC_order.NSS_namerestaurant]];

        } else if (OC_order.TOS_status == TOS_devolucion_efectuada){
           msg = [NSString stringWithFormat:_ALERT_MSG_UMIN_CANCELATION_OK_,[NSString stringWithFormat:@"%@ .Se ha efectuado la devolución del importe a la tarjeta de forma correcta.", OC_order.NSS_namerestaurant]];

        }
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:msg];
            // Lanzamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ORDER_STATUS_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:msg];
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ORDER_STATUS_ERROR_
                                                                object:self];
        }
        else {
            
            [globalVar setNSS_msg_error:msg];
            // Lazamos la notificación de exito
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ORDER_STATUS_SUCCESSFUL_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setOrderfood
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_setOrderfood:(OrderFoodClass *)OFC_food idorder:(NSInteger)NSI_idorder {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setorderfood&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d", NSI_idorder]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idfoodcategories=%d", OFC_food.NSI_idfoodcategories]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&amount=%d", OFC_food.NSI_amount]];
    
    // Insertamos los parametros variables
    if (OFC_food.NSI_idfood           != _ID_FOOD_NO_SELECCIONADA_) [NSMS_url appendString:[NSString stringWithFormat:@"&idfood=%d", OFC_food.NSI_idfood]];
    if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) [NSMS_url appendString:[NSString stringWithFormat:@"&iddailymenu_food=%d", OFC_food.NSI_iddailymenu_food]];
    if (OFC_food.NSI_idfoodgroup      != _ID_FOOD_NO_GROUP_)        [NSMS_url appendString:[NSString stringWithFormat:@"&idfoodgroup=%d", OFC_food.NSI_idfoodgroup]];
    if ([OFC_food.NSS_instructions length] != 0) [NSMS_url appendString:[NSString stringWithFormat:@"&instructions=%@", [globalVar urlEncodeValue:OFC_food.NSS_instructions]]];
    
    // Construimos los ids de las options
    NSMutableString *NSS_options = [[NSMutableString alloc] init];
    int iPos = 0;
    for (FoodOptionClass *FOC_option in OFC_food.NSMA_options) {
        
        // Recuperamos el FoodOptionClass
        FoodOptionClass *FOC_option = [OFC_food.NSMA_options objectAtIndex:iPos];
        
        // Insertamos idOptions en el NSString
        if (iPos == 0) [NSS_options appendString:[NSString stringWithFormat:@"%d", FOC_option.NSI_idfoodoption]];
        else [NSS_options appendString:[NSString stringWithFormat:@",%d", FOC_option.NSI_idfoodoption]];
        
        // Incrementamos contadod e posisicón
        iPos += 1;
    }
    
    // Insertamos options
    if (iPos > 0) [NSMS_url appendString:[NSString stringWithFormat:@"&idfoodoptions=%@", NSS_options]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATIONSET__ORDER_FOOD_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setOrderfood_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATIONSET__ORDER_FOOD_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setOrderfood_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATIONSET__ORDER_FOOD_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos el id del Usuario
            [OFC_food setNSI_idorder_food:[NSS_result integerValue]];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setRestaurantStarsfavorites
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setRestaurantStarsfavorites:(NSInteger)NSI_idrestaurant type:(BOOL)B_typeFavorito value:(NSInteger)NSI_value {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setrestaurantstarsfavorites&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    
    // Comprobamos el type
    if (B_typeFavorito) {

        [NSMS_url appendString:[NSString stringWithFormat:@"&favorite=%d", NSI_value]];
        [NSMS_url appendString:@"&type=0"];
    }
    else {
        
        [NSMS_url appendString:[NSString stringWithFormat:@"&stars=%d", NSI_value]];
        [NSMS_url appendString:@"&type=1"];
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setRestaurantStarsfavorites_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_ERROR_
                                                                object:self];
        }
        else if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_setRestaurantStarsfavorites_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_ERROR_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_PARSE_JSON_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_validateTablenumber:code:
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_validateTablenumber:(NSInteger)NSI_idrestaurant code:(NSInteger)NSI_code {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=validatetablenumber&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&code=%d",         NSI_code]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"validatetablenumber"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"1"]) {
            
            // Lanzamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_PARSE_JSON_
                                                                object:self];
        }
        else if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_validateTablenumber_];
            
            // Lanzamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_
                                                                object:self];
        }
        else {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_
                                                                object:self];
        }
    }
} 

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setCheckout:type:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_setCheckout:(OrderClass *)OC_order type:(typeCheckOutType)TCO_type {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setcheckout&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d", OC_order.NSI_idorder]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", TCO_type]];
    
    // Comprobamos si tiene una Tarjeta
    if (TCO_type == TCO_pago_con_tarjeta) {
        
        // Actualizamos UILabel Fecha
        NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
        [NSDF_date setDateFormat:@"yyyy-MM"];
        NSString *NSS_date = [NSDF_date stringFromDate:OC_order.TC_creditcard.NSD_date_expiration];
        
        // Insertamos los parametros variables
        [NSMS_url appendString:[NSString stringWithFormat:@"&owner_creditcard=%@",  [globalVar urlEncodeValue:OC_order.TC_creditcard.NSS_name]]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&number_creditcard=%@", OC_order.TC_creditcard.NSS_number]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&type_creditcard=%@",   OC_order.TC_creditcard.NSS_type]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&cvv=%@",               OC_order.TC_creditcard.NSS_cvv]];
        [NSMS_url appendString:[NSString stringWithFormat:@"&date_expiration=%@",   [globalVar urlEncodeValue:NSS_date]]];
    }
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"1"]) {
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_PARSE_JSON_
                                                                object:self];
        }
        else {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_ERROR_
                                                                object:self];
        }
    }
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getURLforImage
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) UMNI_getURLforImage:(ImageClass *)IC_image objectId:(NSInteger)NSI_id {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getimage&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros no fijos
    if (globalVar.B_usuario_registrado)       [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    if (IC_image.TIT_type == TIT_restaurants) [NSMS_url appendString:[NSString stringWithFormat:@"&img_number=%d", IC_image.NSI_number]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&id=%d",   NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", IC_image.TIT_type]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&w=%.2f",  IC_image.CGF_width]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&h=%.2f",  IC_image.CGF_height]];
    
    return NSMS_url;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getImage
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getImage:(ImageClass *)IC_image objectId:(NSInteger)NSI_id {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getimage&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros no fijos
    if (globalVar.B_usuario_registrado)       [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    if (IC_image.TIT_type == TIT_restaurants) [NSMS_url appendString:[NSString stringWithFormat:@"&img_number=%d", IC_image.NSI_number]];
    
    // Insertamos los parametros fijos
    [NSMS_url appendString:[NSString stringWithFormat:@"&id=%d",   NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", IC_image.TIT_type]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&w=%.2f",  IC_image.CGF_width]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&h=%.2f",  IC_image.CGF_height]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    [IC_image setNSS_imageUrl:NSMS_url];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_PARSE_JSON_
                                                        object:self];
    
    /*
    
    NSString *fileName = [NSString stringWithFormat:@"%d%d%d%d%.0f%.0f",globalVar.UC_user.NSI_id,IC_image.NSI_number,NSI_id,IC_image.TIT_type,IC_image.CGF_width,IC_image.CGF_height];
    
    if ([[ImgCacheManager sharedInstance] fileCached:fileName] ) {
        // Cramos NSData asosciado
        NSData *NSD_image = [NSData dataWithData:UIImagePNGRepresentation([[ImgCacheManager sharedInstance] getFile:fileName])];
        
        // Actualizamos la propiedad
        [IC_image setNSD_image:NSD_image];
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_PARSE_JSON_
                                                            object:self];
    } else {
    
        // Realizamos la consulta
        NSData *NSD_data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:NSMS_url]];
        
        // Verificamos que el fichero se ha podido cargar correctamente
        if (NSD_data == nil) {
            
            NSLog(@"Error cargando URL %@", NSMS_url);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_ERROR_
                                                                object:self];
        }
        else {
            
            // Comprobamos si a devuelto una foto
            if ([NSD_data length] > 0.0f) {
                
                [[ImgCacheManager sharedInstance] storeFile:fileName withData:NSD_data];
                
                // Descargamos el logo Imagen
                UIImage *UII_image = [[UIImage alloc] initWithData:NSD_data];
                
                // Cramos NSData asosciado
                NSData *NSD_image = [NSData dataWithData:UIImagePNGRepresentation(UII_image)];
                
                // Actualizamos la propiedad
                [IC_image setNSD_image:NSD_image];
                
                // Lazamos la notificación de operación terminada correctamente
                [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_PARSE_JSON_
                                                                    object:self];
            }
            else {
                
                NSLog(@"ERROR Size: %.2u", [NSD_data length]);
                
                // Lazamos la notificación de error
                [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_PARSE_JSON_
                                                                    object:self];
            }
        }
    }
    
    */
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getFacebookOffer:(FacebookOfferClass *)FC_facebook_offer restaurant:(NSInteger)NSI_idrestaurant {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getfacebookoffers&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&type=%d", globalVar.OC_order.TOT_type]];
    
    // Insertamos parametro opcionales
    if (FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) 
        [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer_facebook=%d", FC_facebook_offer.NSI_idoffer_facebook]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSArray *NSA_result = [NSD_parse objectForKey:@"getfacebookoffers"];
        
        // Comprobamos si ha devuelto alguna oferta
        if ([NSA_result count] > 0) {

            NSDictionary *NSD_result = [NSA_result objectAtIndex:0];
            
            // Recuperamos el id
            NSString *NSS_idoffer_facebook = (NSString *)[NSD_result objectForKey:@"idoffer_facebook"];
            
            // Comprobamos si se ha devuelto resultados
            if ([NSS_idoffer_facebook length] != 0)  {
                
                // Iniciamos propiedades
                [FC_facebook_offer setNSI_idoffer_facebook       : [(NSString *)[NSD_result objectForKey:@"idoffer_facebook"] integerValue]];
                [FC_facebook_offer setNSI_idfood                 : [(NSString *)[NSD_result objectForKey:@"idfood"] integerValue]];
                [FC_facebook_offer setNSS_offer_description      :  (NSString *)[NSD_result objectForKey:@"offer_description"]];
                [FC_facebook_offer setNSS_facebook_description   :  (NSString *)[NSD_result objectForKey:@"facebook_description"]];
            }
            else {
                
                // Indicamos que no se tiene datos
                [FC_facebook_offer setNSI_idoffer_facebook:_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
                [FC_facebook_offer setNSS_facebook_description: (NSString *)[NSD_result objectForKey:@"facebook_description"]];
            }
        }
        else {
            
            // Indicamos que no se tiene datos
            [FC_facebook_offer setNSI_idoffer_facebook:_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
        }
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GET_FACEBOOK_OFFERS_PARSE_JSON_ 
                                                            object:self];
        
        // Mostramos los datos cargados
        if ((BOOL)_SHOW_LOG_) {
            
            NSLog(@"-------------------- FACEBOOK OFFER --------------------");
            NSLog(@"     NSI_idoffer_facebook : %d", FC_facebook_offer.NSI_idoffer_facebook);
            NSLog(@"               NSI_idfood : %d", FC_facebook_offer.NSI_idfood);
            NSLog(@"    NSS_offer_description : %@", FC_facebook_offer.NSS_offer_description);
            NSLog(@" NSS_facebook_description : %@", FC_facebook_offer.NSS_facebook_description);
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_setFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_setFacebookOffer:(FacebookOfferClass *)FC_facebook_offer {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=setfacebookoffer&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idoffer_facebook=%d", FC_facebook_offer.NSI_idoffer_facebook]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&future=%d", FC_facebook_offer.B_future?1:0]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result isEqualToString:@"1"]) {
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_FACEBOOK_OFFERS_PARSE_JSON_
                                                                object:self];
        }
        else {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_ 
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getRestaurantpostalcode
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UMNI_getRestaurantpostalcode:(NSInteger)NSI_idrestaurant address:(NSInteger)NSI_idaddress {
    
    // Referenciamos Singleton Object
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getRestaurantpostalcode&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idrestaurant]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduseraddress=%d", NSI_idaddress]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_ERROR_
                                                            object:self];
    }
    else {
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding]);
        
        // Parseamos el Json data
        NSError* NSE_error;
        NSDictionary* NSD_parse;
        Class jsonSerializationClass = NSClassFromString(@"NSJSONSerialization");
        if (!jsonSerializationClass) NSD_parse = [NSD_data objectFromJSONData];
        else NSD_parse = [NSJSONSerialization JSONObjectWithData:NSD_data options:kNilOptions error:&NSE_error];
        
        // Comprobamos si ha dado algún error
        if (!NSD_parse) {
            
            NSLog(@"Error parsing JSON: %@", NSE_error);
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_ERROR_
                                                                object:self];
            
            return;
        }
        
        // Recuperamos los datos
        NSDictionary *NSD_result = [NSD_parse objectForKey:@"getrestaurantpostalcode"];
        
        // Iniciamos propiedades
        NSString *NSS_result = (NSString *)[NSD_result objectForKey:@"result"];
        
        // Comprobamos si ha dado error
        if ([NSS_result isEqualToString:@"0"]) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_getRestaurantpostalcode_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_NO_VALID_
                                                                object:self];
        }
        else {
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_PARSE_JSON_ 
                                                                object:self];
        }
    }
} 

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getmembershipvalidate
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_getmembershipvalidate:(NSInteger)NSI_idRestaurante {
    
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getmembershipvalidate&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&idrestaurant=%d", NSI_idRestaurante]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos propiedad 
            [globalVar setB_restaurante_con_fidelizacion:[NSS_result boolValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_JSON_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_activeenrestaurant
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_activeenrestaurant {
    
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=activeenrestaurant&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_EN_MESA_ACTIVE_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_EN_MESA_ACTIVE_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos propiedad
            [globalVar setB_active_en_mesa:[NSS_result boolValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_EN_MESA_ACTIVE_JSON_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getordersnew
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_getordersnew {
    
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getordersnew&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_NEW_ORDERS_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result length] > 5) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_NEW_ORDERS_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos propiedad
            [globalVar setNSI_num_new_order:[NSS_result integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_NEW_ORDERS_JSON_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_activeenrestaurant
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_numberofregisters {
    
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=numberofregisters&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_REGRISTROS_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Comprobamos resultado
        if ([NSS_result length] > 20) {
            
            // Guardamos mensaje de error
            [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
            
            // Lazamos la notificación de error
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_REGRISTROS_ERROR_
                                                                object:self];
        }
        else {
            
            // Actualizamos propiedad
            NSArray *NSA_numregistros = [NSS_result componentsSeparatedByString:@","];
            
            // Iniciamos el numero de resgitros por bloque
            [globalVar setNSI_blocksize_restaurants: [[NSA_numregistros objectAtIndex:0] integerValue]];
            [globalVar setNSI_blocksize_offers     : [[NSA_numregistros objectAtIndex:1] integerValue]];
            [globalVar setNSI_blocksize_orders     : [[NSA_numregistros objectAtIndex:2] integerValue]];
            
            // Lazamos la notificación de operación terminada correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_REGRISTROS_JSON_
                                                                object:self];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UMNI_getreportepedidos
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) UMNI_getreportepedidos:(NSInteger)NSI_idOrder {
    
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Construimos el URLString
    NSMutableString *NSMS_url = [[NSMutableString alloc] init];
    
    // Insertamos la base de la consulta
    [NSMS_url appendString:[NSString stringWithFormat:@"%@a=getreportepedidos&idprovider=%@", _HTTP_DOMINIO_SERVICIOS_, _UMNI_ID_PROVIDER_]];
    
    // Insertamos los parametros
    [NSMS_url appendString:[NSString stringWithFormat:@"&iduser=%d", globalVar.UC_user.NSI_id]];
    [NSMS_url appendString:[NSString stringWithFormat:@"&idorder=%d", NSI_idOrder]];
    //[NSMS_url appendString:@"&ishtml=1"];
    
    // Mostramos log
    if ((BOOL)_SHOW_LOG_) NSLog(@"%@", NSMS_url);
    
    // Realizamos la consulta
    NSURLRequest *NSURLR_request = [NSURLRequest requestWithURL:[NSURL URLWithString:NSMS_url]];
    NSData *NSD_data = [NSURLConnection sendSynchronousRequest:NSURLR_request returningResponse:nil error:nil];
    
    // Verificamos que el fichero se ha podido cargar correctamente
    if (NSD_data == nil) {
        
        NSLog(@"Error cargando URL %@", NSMS_url);
        
        // Guardamos mensaje de error
        [globalVar setNSS_msg_error:_ALERT_MSG_UMNI_ERROR_default_];
        
        // Lazamos la notificación de error
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_REPORT_ERROR_
                                                            object:self];
    }
    else {
        
        // Recuperamos respuesta servidor
        NSString *NSS_result = [[NSString alloc] initWithData:NSD_data encoding:NSUTF8StringEncoding];
        
        // Mostramos JSON
        if ((BOOL)_SHOW_INFO_LOG_) NSLog(@"%@", NSS_result);
        
        // Lazamos la notificación de operación terminada correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_REPORT_JSON_
                                                            object:self];
    }
}

#pragma mark - private

- (NSString *)stringByRemovingControlCharacters: (NSString *)inputString
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputString rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputString];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputString;
}

- (NSString *)MD5String:(NSString*)original {
    
    const char *cstr = [original UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}


@end
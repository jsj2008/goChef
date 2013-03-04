//
//  SingletonGlobal.m
//  QPoints
//
//  Created by Pablo Javier Hernandez Oramas on 16/01/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SingletonGlobal.h"
#import "Reachability.h"

#import "CoreLocationClass.h"
#import "MiSacoClass.h"
#import "TipoCocinaClass.h"
#import "TarjetaClass.h"
#import "FoodClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"
#import "JSONparseClass.h"
#import "FacebookOfferClass.h"
#import "FacebookClass.h"

#import "AESCryptClass.h"
#import "NSData+Base64.h"
#import "NSString+hex.h"


static SingletonGlobal *sharedGlobal = nil;

@implementation SingletonGlobal

@synthesize NSI_NavController_index = _NSI_NavController_index;
@synthesize NSI_last_Id_DDBB   = _NSI_last_Id_DDBB;
@synthesize NSI_num_new_order  = _NSI_num_new_order;
@synthesize NSI_numRecordBlock = _NSI_numRecordBlock;

@synthesize NSI_blocksize_restaurants = _NSI_blocksize_restaurants;
@synthesize NSI_blocksize_offers = _NSI_blocksize_offers;
@synthesize NSI_blocksize_orders = _NSI_blocksize_orders;

@synthesize NSS_deviceToken = _NSS_deviceToken;
@synthesize NSS_msg_error   = _NSS_msg_error;

@synthesize B_valueFavoritos = _B_valueFavoritos;
@synthesize NSI_value = _NSI_value;

@synthesize FC_facebook   = _FC_facebook;
@synthesize MC_mensaje    = _MC_mensaje;
@synthesize TC_creditcard = _TC_creditcard;
@synthesize IC_image      = _IC_image;
@synthesize DC_direccion  = _DC_direccion;

@synthesize AES_crypt = _AES_crypt;

@synthesize B_usuario_registrado  = _B_usuario_registrado;
@synthesize B_realizando_pedido   = _B_realizando_pedido;
@synthesize B_pedido_confirmado   = _B_pedido_confirmado;
@synthesize B_come_from_historial = _B_come_from_historial;
@synthesize B_come_from_mi_saco   = _B_come_from_mi_saco;
@synthesize B_origen_mi_saco      = _B_origen_mi_saco;
@synthesize B_guardar_usuario     = _B_guardar_usuario;
@synthesize B_pedido_en_cocina    = _B_pedido_en_cocina;
@synthesize B_options             = _B_options;
@synthesize B_datos_introducidos  = _B_datos_introducidos;
@synthesize B_cargar_imagenes     = _B_cargar_imagenes;
@synthesize B_registro_facebook   = _B_registro_facebook;
@synthesize B_login_from_reserva  = _B_login_from_reserva;
@synthesize B_active_en_mesa      = _B_active_en_mesa;
@synthesize B_change_password     = _B_change_password;

@synthesize B_come_from_instrucciones = _B_come_from_instrucciones;

@synthesize B_UMNI_getRestaurants_active = _B_UMNI_getRestaurants_active;
@synthesize B_UMNI_getOrders_active      = _B_UMNI_getOrders_active;
@synthesize B_UMNI_getOffers_active      = _B_UMNI_getOffers_active;

@synthesize B_restaurante_con_fidelizacion = _B_restaurante_con_fidelizacion;

@synthesize B_data_historico_updated = _B_data_historico_updated;
@synthesize B_come_from_condiciones_legales = _B_come_from_condiciones_legales;

@synthesize SRC_search = _SRC_search;
@synthesize SOC_search = _SOC_search;

@synthesize UC_user = _UC_user;
@synthesize FC_food = _FC_food;

@synthesize OC_order = _OC_order;
@synthesize OC_order_en_cocina = _OC_order_en_cocina;
@synthesize OFC_order_food = _OFC_order_food;

@synthesize NSMA_tabbar_viewcontroller = _NSMA_tabbar_viewcontroller;
@synthesize NSI_tabbar_index = _NSI_tabbar_index;

@synthesize LVC_loading = _LVC_loading;

@synthesize TPVC_principal   = _TPVC_principal;
@synthesize TPVC_domicilio   = _TPVC_domicilio;
@synthesize TPVC_restaurante = _TPVC_restaurante;
@synthesize TPVC_antesllegar = _TPVC_antesllegar;
@synthesize TPVC_recoger     = _TPVC_recoger;

@synthesize CLC_location = _CLC_location;
@synthesize CDC_coreData = _CDC_coreData;
@synthesize JPC_json = _JPC_json;

@synthesize NSMA_restaurants  = _NSMA_restaurants;
@synthesize NSMA_direcciones  = _NSMA_direcciones;
@synthesize NSMA_tarjetas     = _NSMA_tarjetas;
@synthesize NSMA_orders       = _NSMA_orders;
@synthesize NSMA_mi_saco      = _NSMA_mi_saco;
@synthesize NSMA_tipos_cocina = _NSMA_tipos_cocina;

@synthesize B_FromHistory = B_FromHistory;


#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDC_direccion
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) setDC_direccion:(DireccionClass *)DC_direccion {
 
    _DC_direccion = DC_direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_change_password
//#	Fecha Creación	: 20/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_change_password:(BOOL)B_change_password {
    
    _B_change_password = B_change_password;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_come_from_instrucciones
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_come_from_instrucciones:(BOOL)B_come_from_instrucciones {
    
    _B_come_from_instrucciones = B_come_from_instrucciones;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_blocksize_restaurants
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_blocksize_restaurants:(NSInteger)NSI_blocksize_restaurants {
    
    _NSI_blocksize_restaurants = NSI_blocksize_restaurants;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_blocksize_offers
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_blocksize_offers:(NSInteger)NSI_blocksize_offers {
    
    _NSI_blocksize_offers = NSI_blocksize_offers;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_blocksize_orders
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_blocksize_orders:(NSInteger)NSI_blocksize_orders {
    
    _NSI_blocksize_orders = NSI_blocksize_orders;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setFC_food
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setFC_food:(FoodClass *)FC_food {
    
    _FC_food = FC_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_UMNI_getOrders_active
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_UMNI_getOrders_active:(BOOL)B_UMNI_getOrders_active {
    
    _B_UMNI_getOrders_active = B_UMNI_getOrders_active;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_UMNI_getOffers_active
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_UMNI_getOffers_active:(BOOL)B_UMNI_getOffers_active {
    
    _B_UMNI_getOffers_active = B_UMNI_getOffers_active;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_UMNI_getRestaurants_active
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_UMNI_getRestaurants_active:(BOOL)B_UMNI_getRestaurants_active {
    
    _B_UMNI_getRestaurants_active = B_UMNI_getRestaurants_active;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_numRecordBlock
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_numRecordBlock:(NSInteger)NSI_numRecordBlock {
    
    _NSI_numRecordBlock = NSI_numRecordBlock;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setAES_crypt
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setAES_crypt:(AESCryptClass *)AES_crypt {
    
    _AES_crypt = AES_crypt;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_num_new_order
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_num_new_order:(NSInteger)NSI_num_new_order {
    
    _NSI_num_new_order = NSI_num_new_order;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_active_en_mesa
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_active_en_mesa:(BOOL)B_active_en_mesa {
    
    _B_active_en_mesa = B_active_en_mesa;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_login_from_reserva
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_login_from_reserva:(BOOL)B_login_from_reserva {
    
    _B_login_from_reserva = B_login_from_reserva;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_restaurante_con_fidelizacion
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_restaurante_con_fidelizacion:(BOOL)B_restaurante_con_fidelizacion {
    
    _B_restaurante_con_fidelizacion = B_restaurante_con_fidelizacion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_registro_facebook
//#	Fecha Creación	: 10/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_registro_facebook:(BOOL)B_registro_facebook {
    
    _B_registro_facebook = B_registro_facebook;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_data_historico_updated
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_data_historico_updated:(BOOL)B_data_historico_updated {
    
    _B_data_historico_updated = B_data_historico_updated;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_come_from_historial
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_come_from_historial:(BOOL)B_come_from_historial {
    
    _B_come_from_historial = B_come_from_historial;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_origen_mi_saco
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_origen_mi_saco:(BOOL)B_origen_mi_saco {
    
    _B_origen_mi_saco = B_origen_mi_saco;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setOC_order_en_cocina
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order_en_cocina:(OrderClass *)OC_order_en_cocina {
    
    _OC_order_en_cocina = OC_order_en_cocina;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_come_from_condiciones_legales
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_come_from_condiciones_legales:(BOOL)B_come_from_condiciones_legales {
    
    _B_come_from_condiciones_legales = B_come_from_condiciones_legales;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_cargar_imagenes
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_cargar_imagenes:(BOOL)B_cargar_imagenes {
    
    _B_cargar_imagenes = B_cargar_imagenes;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_msg_error
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_msg_error:(NSString *)NSS_msg_error {
    
    _NSS_msg_error = NSS_msg_error;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_deviceToken
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_deviceToken:(NSString *)NSS_deviceToken {
    
    _NSS_deviceToken = [NSS_deviceToken copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setIC_image
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_image:(ImageClass *)IC_image {
   
    _IC_image = IC_image;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_datos_introducidos
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_datos_introducidos:(BOOL)B_datos_introducidos {
    
    _B_datos_introducidos = B_datos_introducidos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_options
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_options:(BOOL)B_options {
    
    _B_options = B_options;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_pedido_en_cocina
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_pedido_en_cocina:(BOOL)B_pedido_en_cocina {
    
    _B_pedido_en_cocina = B_pedido_en_cocina;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_value
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_value:(NSInteger)NSI_value {
    
    _NSI_value = NSI_value;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_value
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_valueFavoritos:(BOOL)B_valueFavoritos {
    
    _B_valueFavoritos = B_valueFavoritos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_pedido_confirmado
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_pedido_confirmado:(BOOL)B_pedido_confirmado {
    
    _B_pedido_confirmado = B_pedido_confirmado;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setTC_creditcard
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTC_creditcard:(TarjetaClass *)TC_creditcard {
    
    _TC_creditcard = TC_creditcard;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_guardar_usuario
//#	Fecha Creación	: 28/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 28/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_guardar_usuario:(BOOL)B_guardar_usuario {
    
    _B_guardar_usuario = B_guardar_usuario;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setOFC_order_food
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOFC_order_food:(OrderFoodClass *)OFC_order_food {
    
    _OFC_order_food = OFC_order_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_orders
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_orders:(NSMutableArray *)NSMA_orders {
   
    _NSMA_orders = NSMA_orders;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setOC_order
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSOC_search
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSOC_search:(SearchOfferClass *)SOC_search {
    
    _SOC_search = SOC_search;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_restaurants
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_restaurants:(NSMutableArray *)NSMA_restaurants {
    
    _NSMA_restaurants = NSMA_restaurants;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSRC_search
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSRC_search:(SearchRestaurantClass *)SRC_search {
    
    _SRC_search = SRC_search;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setFC_facebook
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFC_facebook:(FacebookClass *)FC_facebook {
    
    _FC_facebook = FC_facebook;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCDC_coreData
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCDC_coreData:(CoreDataClass *)CDC_coreData {
    
    _CDC_coreData = CDC_coreData;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setMC_mensaje
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_usuario_registrado:(BOOL)B_usuario_registrado {
    
    _B_usuario_registrado = B_usuario_registrado;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setMC_mensaje
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMC_mensaje:(MensajeClass *)MC_mensaje {
    
    _MC_mensaje = MC_mensaje;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setUC_user
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUC_user:(UserClass *)UC_user {
    
    _UC_user = UC_user;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_last_Id_DDBB
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_last_Id_DDBB:(NSInteger)NSI_last_Id_DDBB {
    
    _NSI_last_Id_DDBB = NSI_last_Id_DDBB;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCLC_location
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCLC_location:(CoreLocationClass *)CLC_location {
    
    _CLC_location = CLC_location;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setJPC_json
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setJPC_json:(JSONparseClass *)JPC_json {
    
    _JPC_json = JPC_json;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_come_from_mi_saco
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_come_from_mi_saco:(BOOL)B_come_from_mi_saco {
    
    _B_come_from_mi_saco = B_come_from_mi_saco;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_realizando_pedido
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_realizando_pedido:(BOOL)B_realizando_pedido {
    
    _B_realizando_pedido = B_realizando_pedido;
    
    NSLog(@"B_realizando_pedido: %@", _B_realizando_pedido?@"SI":@"NO");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_NavController_index
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_NavController_index:(NSInteger)NSI_NavController_index {
    
    _NSI_NavController_index = NSI_NavController_index;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_tabbar_viewcontroller
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_tabbar_viewcontroller:(NSMutableArray *)NSMA_tabbar_viewcontroller {
    
    _NSMA_tabbar_viewcontroller = NSMA_tabbar_viewcontroller;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_tabbar_index
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_tabbar_index:(NSInteger)NSI_tabbar_index {
    
    _NSI_tabbar_index = NSI_tabbar_index;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setLVC_loading
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setLVC_loading:(LoadingViewController *)LVC_loading {
    
    _LVC_loading = LVC_loading;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_principal
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_principal:(TabbarPrincipalViewController *)TPVC_principal {
    
    _TPVC_principal = TPVC_principal;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_domicilio
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_domicilio:(TabbarDomicilioViewController *)TPVC_domicilio {
    
    _TPVC_domicilio = TPVC_domicilio;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_restaurante
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_restaurante:(TabbarRestauranteViewController *)TPVC_restaurante {
    
    _TPVC_restaurante = TPVC_restaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_antesllegar
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_antesllegar:(TabbarAntesLlegarViewController *)TPVC_antesllegar {
    
    _TPVC_antesllegar = TPVC_antesllegar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_recoger
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_recoger:(TabbarRecogerViewController *)TPVC_recoger {
    
    _TPVC_recoger = TPVC_recoger;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_mi_saco
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_mi_saco:(NSMutableArray *)NSMA_mi_saco {
    
    _NSMA_mi_saco = NSMA_mi_saco;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_tipos_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_tipos_cocina:(NSMutableArray *)NSMA_tipos_cocina {
    
    _NSMA_tipos_cocina = NSMA_tipos_cocina;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_direcciones
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_direcciones:(NSMutableArray *)NSMA_direcciones {
    
    _NSMA_direcciones = NSMA_direcciones;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_tarjetas
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_tarjetas:(NSMutableArray *)NSMA_tarjetas {
    
    _NSMA_tarjetas = NSMA_tarjetas;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : chekInternetConnection
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) chekInternetConnection {
    
    // Comprobamos si hay conexión a Internet
    Reachability *reach = [Reachability reachabilityForInternetConnection];	
    NetworkStatus netStatus = [reach currentReachabilityStatus];    
    if (netStatus == NotReachable)return FALSE;
    return TRUE;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : showAlerMsgWith:message:
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showAlerMsgWith:(NSString *)NSS_title message:(NSString *)NSS_message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSS_title 
                                                    message:NSS_message 
                                                   delegate:nil 
                                          cancelButtonTitle:nil 
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: formatTarjetaNumber
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) formatTarjetaNumber:(TarjetaClass *)TC_tarjeta {
    
    NSString *NSS_result;
    
    // Comprobamos si es una tarjeta válida
    if ([TC_tarjeta.NSS_number length] > 10) NSS_result = [NSString stringWithFormat:@"%@ XXXXXXXXXXX%@", TC_tarjeta.NSS_type, [TC_tarjeta.NSS_number substringFromIndex:12]];
    else NSS_result = [NSString stringWithFormat:@"%@", TC_tarjeta.NSS_type];
    
    return NSS_result;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: MetrosToKilometros, MetrosToMillas, MetrosToYardas, MetrosToPulgadas
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
double MetrosToKilometros (double metros) {return metros * 0.001;};
double MetrosToMillas     (double metros) {return metros * 0.00062;};
double MetrosToYardas     (double metros) {return metros * 1.094;};
double MetrosToPulgadas   (double metros) {return metros * 39;};

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: formatDistanceWithMeters
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) formatDistanceWithMeters:(CGFloat)CGF_distanceInMeters {
    
    CGFloat CGF_distance;
    NSString *NSS_result;
    
    // Combertimos unidade si es necesario
    if ((double)CGF_distanceInMeters > _LIMIT_TO_CHANGE_KM_) CGF_distance = MetrosToKilometros(CGF_distanceInMeters);
    else CGF_distance = CGF_distanceInMeters;
    
    // Formateamos el número
    NSNumberFormatter *NSNF_formatter = [[NSNumberFormatter alloc] init];
    [NSNF_formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    // Configuramos numero decimales dependiendo unidad
    if ((double)CGF_distanceInMeters > _LIMIT_TO_CHANGE_KM_) [NSNF_formatter setMaximumFractionDigits:0];
    else [NSNF_formatter setMaximumFractionDigits:2];
    
    // Construimos NSString de salida
    if ((double)CGF_distanceInMeters > _LIMIT_TO_CHANGE_KM_) NSS_result = [NSString stringWithFormat:@"%@ kilometers", [NSNF_formatter stringFromNumber:[NSNumber numberWithFloat:CGF_distance]]];
    else NSS_result = [NSString stringWithFormat:@"%@ meters", [NSNF_formatter stringFromNumber:[NSNumber numberWithFloat:CGF_distance]]];
    
    return NSS_result;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getNSDateFromTimeString
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
- (NSString *)urlEncodeValue:(NSString *)str {
    
    // Comprobamos si la cadena es vacía
    NSString *result = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
    return result;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getNSDateFromTimeString
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(NSDate *) getNSDateFromDateString:(NSString *)NSS_date {

    // Comprobamos si se ha enviado una fecha
    if (([NSS_date length] == 0) || ([NSS_date isEqualToString:@"0000-00-00 00:00:00"])) return nil;
    
    // Formateamos el resultado
    NSDateFormatter *NSDF_formatter=[[NSDateFormatter alloc]init];
    
    if ([NSS_date length] == 10) [NSDF_formatter setDateFormat:@"yyyy-MM-dd"];
    else [NSDF_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *NSD_result = [NSDF_formatter dateFromString:NSS_date];
    
    if (!NSD_result) {
        return nil;
    }
    
    // Calculamos la fecha referencia
    NSCalendar *NSC_gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *NSDC_offset = [[NSDateComponents alloc] init];
    [NSDC_offset setYear:-100];
    NSDate *NSD_referencia = [NSC_gregorian dateByAddingComponents:NSDC_offset toDate:NSD_result options:0];
    
    // Comprobamos si la fecha es menor de la referencia
    switch ([NSD_referencia compare:NSD_result])
    {
        case NSOrderedAscending:
            return NSD_result;
            break;
        
        case NSOrderedSame:
            return NSD_result;
            break;

        case NSOrderedDescending:
            return nil;
            break;
    }
    
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getRestautanttypeWith
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(TipoCocinaClass *)getRestautanttypeWithId:(NSString*)NSI_id {
    
    for (TipoCocinaClass *TCC_restauranttype in _NSMA_tipos_cocina)
        if (TCC_restauranttype.NSI_id == [NSI_id intValue])
            return TCC_restauranttype;
    
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getRestautanttypeWith
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(TipoCocinaClass *)getRestautanttypeWithName:(NSString *)NSS_name {
    
    for (TipoCocinaClass *TCC_restauranttype in _NSMA_tipos_cocina)
        if ([TCC_restauranttype.NSS_name isEqualToString:NSS_name])
            return TCC_restauranttype;
    
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: stringWithHexBytes
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString*) stringWithHexBytes:(NSData *)NSD_in {
    
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([NSD_in length] * 2)];
    
    const unsigned char *dataBuffer = [NSD_in bytes];
    int i;
    
    for (i = 0; i < [NSD_in length]; ++i)
        [stringBuffer appendFormat:@"%02lX", (unsigned long)dataBuffer[ i ]];
    
    return [stringBuffer copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getFoodWithId
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(FoodClass *)getFoodWithId:(NSInteger)NSI_id {
    
    for (FoodClass *FC_food in _OC_order.RC_restaurant.NSMA_foods)
        if (FC_food.NSI_idfood == NSI_id)
            return FC_food;
    
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : recomiendo_en_facebook
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recomiendo_en_facebook {
    
    // Recuperamos la imagen
    NSString *NSS_image = [_JPC_json UMNI_getURLforImage:_OC_order.RC_restaurant.IC_image_mini objectId:_OC_order.RC_restaurant.NSI_idrestaurant];
    
    // Post in Facebook Wall
    [_FC_facebook postInUserWallMessage:_OC_order.FC_facebook_offer.NSS_facebook_description 
                                   name:_FACEBOOK_NAME_POST_
                                caption:_OC_order.RC_restaurant.NSS_name
                            description:_OC_order.RC_restaurant.NSS_description
                                   link:_FACEBOOK_LINK_POST_ 
                                picture:NSS_image];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : exitsFood
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) exitsFood:(NSInteger)NSI_idfood category:(NSInteger)NSI_idfoodcategories {
    
    // Recorremos Array comida
    for (FoodClass *FC_food in _OC_order.RC_restaurant.NSMA_foods)
        if ((FC_food.NSI_idfood == NSI_idfood) && (FC_food.NSI_idfoodcategories == NSI_idfoodcategories)) 
            return TRUE;
    
    return FALSE;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : iPosMenuOfFood
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(int) iPosMenuOfFood:(OrderFoodClass *)OFC_food {
    
    int iPos = -1;
    for (DailymenuClass *DC_menu in _OC_order.RC_restaurant.NSMA_dailymenus) {

        iPos += 1;
        for (DailymenufoodClass *DFC_food in DC_menu.NSMA_dailymenufoods)                   
            if (DFC_food.NSI_idfood == OFC_food.NSI_iddailymenu_food) {
                
                return iPos;
            }
    }
    
    return -1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : priceOfMenuOfFood
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) priceOfMenuOfFood:(OrderFoodClass *)OFC_food {
    
    for (DailymenuClass *DC_menu in _OC_order.RC_restaurant.NSMA_dailymenus)
        for (DailymenufoodClass *DFC_food in DC_menu.NSMA_dailymenufoods)                   
            if (DFC_food.NSI_idfood == OFC_food.NSI_iddailymenu_food) {
                
                return DC_menu.CGF_price;
            }
    
    return 0.0f;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : priceOfMenuOfFood
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		:
//#
-(NSString *) nameOfMenuOfFood:(OrderFoodClass *)OFC_food {
    
    for (DailymenuClass *DC_menu in _OC_order.RC_restaurant.NSMA_dailymenus)
        for (DailymenufoodClass *DFC_food in DC_menu.NSMA_dailymenufoods)
            if (DFC_food.NSI_idfood == OFC_food.NSI_iddailymenu_food) {
                
                return DC_menu.NSS_name;
            }
    
    return @"";
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : showNoOfferAllowedMessage
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) showNoOfferAllowedMessage {
    
    [self showAlerMsgWith:@"Información"
                  message:@"La oferta seleccionada no puede aplicarse si no selecciona platos de carta."];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : showNoOfferCategoryMessage
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) showNoOfferCategoryMessage {
    
    [self showAlerMsgWith:@"Información"
                  message:@"La oferta seleccionada no puede aplicarse si no selecciona platos de carta de la categoría referenciada en la oferta."];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getCreditCardFor
//#	Fecha Creación	: 20/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(TarjetaClass *) getCreditCardFor:(NSString *)NSS_number {
    
    // Comprobamos si es vacio
    if ([NSS_number length] == 0) return nil;
    
    // Recorremos el array de tarjetas
    for (TarjetaClass *TC_creditcard in _NSMA_tarjetas) {
        
        // Recuperamos los 4 últimos dígitos de la tarjeta
        NSString *NSS_4_last_number = [TC_creditcard.NSS_number substringWithRange:NSMakeRange(([TC_creditcard.NSS_number length]-4), 4)];
        
        // Comprobamos si es la que buscamos
        if ([NSS_4_last_number isEqualToString:NSS_number]) return TC_creditcard;
    }
    
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : newCreditCardId
//#	Fecha Creación	: 20/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(NSInteger) newCreditCardId {
    
    NSInteger NSI_max_id = 0;
    
    // Recorremos el array de tarjetas
    for (TarjetaClass *TC_creditcard in _NSMA_tarjetas)
        if (NSI_max_id < TC_creditcard.NSI_id)
            NSI_max_id = TC_creditcard.NSI_id;
    
    return (NSI_max_id+1);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkEmailFormat
//#	Fecha Creación	: 18/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/10/2012  (pjoramas)
//# Descripción		:
//#
-(BOOL) checkEmailFormat:(NSString *)NSS_email {
    
    // Comprobamos si el tamaño es mayor de 8
    if ([NSS_email length] < 8) return FALSE;
    
    // Comprobamos si el correo tiene una @
    NSArray *NSA_split1 = [NSS_email componentsSeparatedByString:@"@"];
    if ([NSA_split1 count] != 2) return FALSE;
    
    // Comprobamos si la primera parte del email tiene tamaño correcto
    NSString *NSS_part1 = [NSA_split1 objectAtIndex:0];
    if ([NSS_part1 length] < 2) return FALSE;
    
    // Comprobamos si el correo tiene un .
    NSString *NSS_part2 = [NSA_split1 objectAtIndex:1];
    NSArray *NSA_split2 = [NSS_part2 componentsSeparatedByString:@"."];
    if ([NSA_split1 count] != 2) return FALSE;
    
    // Comprobamos si la segunda parte del email tiene tamaño correcto
    NSString *NSS_part3 = [NSA_split2 objectAtIndex:0];
    NSString *NSS_part4 = [NSA_split2 objectAtIndex:1];
    if (([NSS_part3 length] < 2) || ([NSS_part4 length] < 2)) return FALSE;
    
    return TRUE;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: decrypEAS128
//#	Fecha Creación	: 21/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(NSString *) decrypEAS128:(NSString *)NSS_crypt {
    
    // Desencriptamos la cadena
    NSData *cryptData = [[NSData alloc] initWithData:[_AES_crypt decodeFromHexidecimal:NSS_crypt]];
    NSData *plainData = [_AES_crypt AES128DecryptWithKey:_UMNI_KEY_CRYPT_ data:cryptData];
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    return plainString;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: encrypEAS128
//#	Fecha Creación	: 21/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(NSString *) encrypEAS128:(NSString *)NSS_text {
    
    // Desencriptamos la cadena
    NSData *plainData = [NSS_text dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cryptData = [_AES_crypt AES128EncryptWithKey:_UMNI_KEY_CRYPT_ data:plainData];
    NSString *cryptString = [_AES_crypt hexadecimalString:cryptData];
    
    return cryptString;
}

#pragma mark -
#pragma mark Singleton Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: init
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: sharedGlobal
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
+ (SingletonGlobal *)sharedGlobal {
    
    if(sharedGlobal == nil){
        sharedGlobal = [[super allocWithZone:NULL] init];
    }
    return sharedGlobal;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: copyWithZone
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}


@end
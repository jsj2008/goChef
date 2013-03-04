//
//  OrderClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "DireccionClass.h"
#import "TarjetaClass.h"
#import "UserOfferClass.h"
#import "FacebookOfferClass.h"


@implementation OrderClass

@synthesize NSI_idorder          = _NSI_idorder;
@synthesize NSI_idorder_food     = _NSI_idorder_food;
@synthesize NSI_idrestaurant     = _NSI_idrestaurant;
@synthesize NSI_iduseraddress    = _NSI_iduseraddress;
@synthesize NSI_idcreditcard     = _NSI_idcreditcard;
@synthesize NSI_idoffer          = _NSI_idoffer;
@synthesize NSI_idoffer_facebook = _NSI_idoffer_facebook;
@synthesize NSI_persons          = _NSI_persons;
@synthesize NSI_number_table     = _NSI_number_table;

@synthesize NSS_namerestaurant = _NSS_namerestaurant;
@synthesize NSS_instructions   = _NSS_instructions;
@synthesize NSS_payment_type   = _NSS_payment_type;

@synthesize CGF_subtotal            = _CGF_subtotal;
@synthesize CGF_membership_discount = _CGF_membership_discount;
@synthesize CGF_offer_discount      = _CGF_offer_discount;
@synthesize CGF_facebook_discount   = _CGF_facebook_discount;
@synthesize CGF_price_homedelivery  = _CGF_price_homedelivery;
@synthesize CGF_total               = _CGF_total;

@synthesize NSD_date_start       = _NSD_date_start;
@synthesize NSD_date_end         = _NSD_date_end;
@synthesize NSD_date_reservation = _NSD_date_reservation;

@synthesize TOS_status = _TOS_status;
@synthesize TOT_type   = _TOT_type;
@synthesize TOA_active = _TOA_active;

@synthesize RC_restaurant  = _RC_restaurant;    
@synthesize DC_useraddress = _DC_useraddress;
@synthesize TC_creditcard  = _TC_creditcard;
@synthesize OC_offer       = _OC_offer;

@synthesize FC_facebook_offer = _FC_facebook_offer;

@synthesize B_favorite = _B_favorite;
@synthesize B_new = _B_new;

@synthesize NSMA_orderfoods = _NSMA_orderfoods;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idoffer_facebook
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idoffer_facebook:(NSInteger)NSI_idoffer_facebook {
    
    _NSI_idoffer_facebook = NSI_idoffer_facebook;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestaurant
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFC_facebook_offer:(FacebookOfferClass *)FC_facebook_offer {
    
    _FC_facebook_offer = FC_facebook_offer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestaurant
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idrestaurant:(NSInteger)NSI_idrestaurant {
    
    _NSI_idrestaurant = NSI_idrestaurant;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_iduseraddress
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_iduseraddress:(NSInteger)NSI_iduseraddress {
    
    _NSI_iduseraddress = NSI_iduseraddress;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idcreditcard
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idcreditcard:(NSInteger)NSI_idcreditcard {
    
    _NSI_idcreditcard = NSI_idcreditcard;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idoffer
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idoffer:(NSInteger)NSI_idoffer {
    
    _NSI_idoffer = NSI_idoffer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_payment_type
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_payment_type:(NSString *)NSS_payment_type {
    
    _NSS_payment_type = [NSS_payment_type copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idorder
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idorder:(NSInteger)NSI_idorder {
    
    _NSI_idorder = NSI_idorder;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idorder_food
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idorder_food:(NSInteger)NSI_idorder_food {
    
    _NSI_idorder_food = NSI_idorder_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_persons
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_persons:(NSInteger)NSI_persons {
    
    _NSI_persons = NSI_persons;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_number_table
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_number_table:(NSInteger)NSI_number_table {
    
    _NSI_number_table = NSI_number_table;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namerestaurant
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namerestaurant:(NSString *)NSS_namerestaurant {
    
    _NSS_namerestaurant = [NSS_namerestaurant copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_instructions
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_instructions:(NSString *)NSS_instructions {
    
    _NSS_instructions = [NSS_instructions copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_subtotal
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_subtotal:(CGFloat)CGF_subtotal {
    
    _CGF_subtotal = CGF_subtotal;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_membership_discount
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_membership_discount:(CGFloat)CGF_membership_discount {
    
    _CGF_membership_discount = CGF_membership_discount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_offer_discount
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_offer_discount:(CGFloat)CGF_offer_discount {
    
    _CGF_offer_discount = CGF_offer_discount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_facebook_discount
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_facebook_discount:(CGFloat)CGF_facebook_discount {
    
    _CGF_facebook_discount = CGF_facebook_discount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price_homedelivery
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price_homedelivery:(CGFloat)CGF_price_homedelivery {
    
    _CGF_price_homedelivery = CGF_price_homedelivery;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_total
//#	Fecha Creación	: 01/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_total:(CGFloat)CGF_total {
    
    _CGF_total = CGF_total;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_start
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_start:(NSDate *)NSD_date_start {
    
    _NSD_date_start = NSD_date_start;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_end
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_end:(NSDate *)NSD_date_end {
    
    _NSD_date_end = NSD_date_end;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_reservation
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_reservation:(NSDate *)NSD_date_reservation {
    
    _NSD_date_reservation = NSD_date_reservation;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOS_status
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOS_status:(typeOrderStatus)TOS_status {
    
    _TOS_status = TOS_status;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOT_type
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOT_type:(typeOrderType)TOT_type {
    
    _TOT_type = TOT_type;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOA_active
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOA_active:(typeOrderActive)TOA_active {
    
    _TOA_active = TOA_active;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setRC_restaurant
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRC_restaurant:(RestaurantClass *)RC_restaurant {
    
    _RC_restaurant = RC_restaurant;
    
    // Actualizamos propiedades relacionadas
    [self setNSI_idrestaurant  :_RC_restaurant.NSI_idrestaurant];
    [self setNSS_namerestaurant:_RC_restaurant.NSS_name];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_favorite
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_favorite:(BOOL)B_favorite {
    
    _B_favorite = B_favorite;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setDC_useraddress
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDC_useraddress:(DireccionClass *)DC_useraddress {
    
    _DC_useraddress = DC_useraddress;
    
    // Actualizamos id
    [self setNSI_iduseraddress:_DC_useraddress.NSI_id];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTC_creditcard
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTC_creditcard:(TarjetaClass *)TC_creditcard {
    
    _TC_creditcard = TC_creditcard;
    
    // Actualizamos propiedades relacionadas
    [self setNSI_idcreditcard:_TC_creditcard.NSI_id];
    [self setNSS_payment_type:_TC_creditcard.NSS_type];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_offer
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_offer:(UserOfferClass *)OC_offer {
    
    _OC_offer = OC_offer;
    
    // Actualizamos id
    [self setNSI_idoffer:_OC_offer.NSI_idoffer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_orderfoods
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_orderfoods:(NSMutableArray *)NSMA_orderfoods {
    
    _NSMA_orderfoods = NSMA_orderfoods;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_new
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_new:(BOOL)B_new {
    
    _B_new = B_new;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos Array
    _NSMA_orderfoods = [[NSMutableArray alloc] init];
    
    // Iniciamos las classes
    _RC_restaurant  = [[RestaurantClass alloc] init];
    _DC_useraddress = [[DireccionClass  alloc] init];
    _TC_creditcard  = [[TarjetaClass    alloc] init];
    _OC_offer       = [[UserOfferClass  alloc] init];
    
    // Iniciamos las Offers class
    _FC_facebook_offer = [[FacebookOfferClass  alloc] init];

    // Iniciamos los ID
    [self setNSI_idorder            :_ID_ORDER_NO_VALUE_];
    [self setNSI_idcreditcard       :_ID_CREDITCARD_NO_SELECTED_];
    [self setNSI_idoffer            :_ID_OFFER_NO_SELECTED_];
    [self setNSI_idoffer_facebook   :_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
    [self setNSI_idrestaurant       :_ID_RESTAURANT_NO_SELECTED_];
    
    // Iniciamos datos de reserva
    [self setNSD_date_reservation:[NSDate date]];
    [self setNSI_persons:0];
    
    // Iniciamos BOOL
    [self setB_new:FALSE];
    
    // Iniciamos propiedad global
    //[globalVar setB_realizando_pedido:FALSE];
    
    // Inicimos el Status de la Order
    [self setTOS_status:TOS_pendiente_de_confirmar_y_pago];
    
    // Iniciamos el Active de la Order
    [self setTOA_active:TOA_abierto];

    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : copy
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) copy:(OrderClass *)OC_order {
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Copiamos las propiedades
    [self setNSI_idorder                : OC_order.NSI_idorder];
    [self setNSI_idorder_food           : OC_order.NSI_idorder_food];
    [self setNSI_idrestaurant           : OC_order.NSI_idrestaurant];
    [self setNSI_iduseraddress          : OC_order.NSI_iduseraddress];
    [self setNSI_idcreditcard           : OC_order.NSI_idcreditcard];
    [self setNSI_idoffer                : OC_order.NSI_idoffer];
    [self setNSI_idoffer_facebook       : OC_order.NSI_idoffer_facebook];
    [self setNSI_persons                : OC_order.NSI_persons];
    [self setNSI_number_table           : OC_order.NSI_number_table];
    [self setNSS_namerestaurant         : OC_order.NSS_namerestaurant];
    [self setNSS_instructions           : OC_order.NSS_instructions];
    [self setNSS_payment_type           : OC_order.NSS_payment_type];
    [self setCGF_subtotal               : OC_order.CGF_subtotal];
    [self setCGF_membership_discount    : OC_order.CGF_membership_discount];
    [self setCGF_offer_discount         : OC_order.CGF_offer_discount];
    [self setCGF_facebook_discount      : OC_order.CGF_facebook_discount];
    [self setCGF_price_homedelivery     : OC_order.CGF_price_homedelivery];
    [self setCGF_total                  : OC_order.CGF_total];
    [self setNSD_date_start             : OC_order.NSD_date_start];
    [self setNSD_date_end               : OC_order.NSD_date_end];
    [self setNSD_date_reservation       : OC_order.NSD_date_reservation];
    [self setTOS_status                 : OC_order.TOS_status];
    [self setTOT_type                   : OC_order.TOT_type];
    [self setTOA_active                 : OC_order.TOA_active];
    [self setB_favorite                 : OC_order.B_favorite];
    [self setB_new                      : OC_order.B_new];
         
    // Apntamos las clases
    [self setRC_restaurant      : OC_order.RC_restaurant];    
    [self setDC_useraddress     : OC_order.DC_useraddress];
    [self setTC_creditcard      : OC_order.TC_creditcard];
    [self setOC_offer           : OC_order.OC_offer];
    [self setFC_facebook_offer  : OC_order.FC_facebook_offer];
    
    // Copiamos el Array
    for (OrderFoodClass *OFC_food in OC_order.NSMA_orderfoods) [_NSMA_orderfoods addObject:OFC_food];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : update
//#	Fecha Creación	: 11/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) update:(OrderClass *)OC_order {
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Comprobamos si aun NO se tiene offer
    if (_NSI_idoffer == _ID_OFFER_NO_SELECTED_) {

        // Copiamos las propiedades
        [self setNSI_idoffer        : OC_order.NSI_idoffer];
        [self setOC_offer           : OC_order.OC_offer];
        [self setCGF_offer_discount : OC_order.CGF_offer_discount];
    }
    
    // Comprobamos si aun NO se tiene Facebook Offer
    if (_NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Copiamos las propiedades
        [self setNSI_idoffer_facebook  : OC_order.NSI_idoffer_facebook];
        [self setFC_facebook_offer     : OC_order.FC_facebook_offer];
        [self setCGF_facebook_discount : OC_order.CGF_facebook_discount];
    }
    
    // Copiamos las propiedades
    [self setNSS_instructions : OC_order.NSS_instructions];

    // Copiamos el Array
    for (OrderFoodClass *OFC_food in OC_order.NSMA_orderfoods) [_NSMA_orderfoods addObject:OFC_food];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : reset
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) reset {
    
    // Iniciamos Array
    _NSMA_orderfoods = [[NSMutableArray alloc] init];
    
    // Iniciamos las classes
    _OC_offer          = [[UserOfferClass     alloc] init];
    _FC_facebook_offer = [[FacebookOfferClass alloc] init];
    _TC_creditcard     = [[TarjetaClass       alloc] init];
    
    // Iniciamos Food and DaialyMenuFood
    [_RC_restaurant.NSMA_foodcategories       removeAllObjects];
    [_RC_restaurant.NSMA_foods                removeAllObjects];
    [_RC_restaurant.NSMA_dailymenus           removeAllObjects];
    [_RC_restaurant.NSMA_dailymenuscategories removeAllObjects];

    // Iniciamos propiedades
    [self setNSS_instructions         : @""];
    [self setNSS_payment_type         : @""];
    [self setCGF_subtotal             : 0.0f];
    [self setCGF_membership_discount  : 0.0f];
    [self setCGF_offer_discount       : 0.0f];
    [self setCGF_facebook_discount    : 0.0f];
    [self setCGF_price_homedelivery   : 0.0f];
    [self setCGF_total                : 0.0f];
    [self setNSI_persons              : 0];
    
    // Iniciamos Fechas
    [self setNSD_date_reservation:[NSDate date]]; 
    
    // Iniciamos datos de reserva
    [self setNSI_idorder            :_ID_ORDER_NO_VALUE_];
    [self setNSI_idcreditcard       :_ID_CREDITCARD_NO_SELECTED_];
    [self setNSI_idoffer            :_ID_OFFER_NO_SELECTED_];   
    [self setNSI_idoffer_facebook   :_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
    
    // Inicimos el Status de la Order
    [self setTOS_status:TOS_pendiente_de_confirmar_y_pago];
    
    // Iniciamos el Active de la Order
    [self setTOA_active:TOA_abierto];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : resetFood
//#	Fecha Creación	: 11/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) resetFood {
    
    // Iniciamos Array
    _NSMA_orderfoods = [[NSMutableArray alloc] init];
    
    // Iniciamos las classes
    _OC_offer          = [[UserOfferClass     alloc] init];
    _FC_facebook_offer = [[FacebookOfferClass alloc] init];
    
    // Iniciamos propiedades
    [self setCGF_subtotal             : 0.0f];
    [self setCGF_membership_discount  : 0.0f];
    [self setCGF_offer_discount       : 0.0f];
    [self setCGF_facebook_discount    : 0.0f];
    [self setCGF_price_homedelivery   : 0.0f];
    [self setCGF_total                : 0.0f];
    
    // Iniciamos datos de reserva
    [self setNSI_idoffer            :_ID_OFFER_NO_SELECTED_];   
    [self setNSI_idoffer_facebook   :_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : resetOffers
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) resetOffers {
    
    // Iniciamos las classes
    _OC_offer          = [[UserOfferClass     alloc] init];
    _FC_facebook_offer = [[FacebookOfferClass alloc] init];
    
    // Iniciamos propiedades
    [self setCGF_subtotal            : 0.0f];
    [self setCGF_membership_discount : 0.0f];
    [self setCGF_offer_discount      : 0.0f];
    [self setCGF_facebook_discount   : 0.0f];
    [self setCGF_price_homedelivery  : 0.0f];
    [self setCGF_total               : 0.0f];
    
    // Iniciamos datos de reserva
    [self setNSI_idoffer          :_ID_OFFER_NO_SELECTED_];   
    [self setNSI_idoffer_facebook :_ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
    
    // Inicimos el Status de la Order
    [self setTOS_status:TOS_pendiente_de_confirmar_y_pago];
}


@end
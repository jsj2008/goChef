//
//  RestaurantClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestaurantClass.h"


@implementation RestaurantClass

@synthesize NSI_idrestaurant     = _NSI_idrestaurant;
@synthesize NSI_idrestauranttype = _NSI_idrestauranttype;
@synthesize NSI_idoffer          = _NSI_idoffer;
@synthesize NSI_imagesCount      = _NSI_imagesCount;

@synthesize NSS_name            = _NSS_name;
@synthesize NSS_description     = _NSS_description;
@synthesize NSS_address1        = _NSS_address1;
@synthesize NSS_address2        = _NSS_address2;
@synthesize NSS_address3        = _NSS_address3;
@synthesize NSS_distance        = _NSS_distance;
@synthesize NSS_discount        = _NSS_discount;
@synthesize NSS_namemembership  = _NSS_namemembership;

@synthesize CGF_latitude                = _CGF_latitude;
@synthesize CGF_longitude               = _CGF_longitude;
@synthesize CGF_stars                   = _CGF_stars;
@synthesize CGF_price_average           = _CGF_price_average;
@synthesize CGF_min_price_homedelivery  = _CGF_min_price_homedelivery;
@synthesize CGF_price_homedelivery      = _CGF_price_homedelivery;
@synthesize CGF_price_accumulated       = _CGF_price_accumulated;

@synthesize TRS_service_adomicilio       = _TRS_service_adomicilio;
@synthesize TRS_service_arecoger         = _TRS_service_arecoger;
@synthesize TRS_service_antesrestaurante = _TRS_service_antesrestaurante;
@synthesize TRS_service_enrestaurante    = _TRS_service_enrestaurante;
@synthesize TRS_service_reserva          = _TRS_service_reserva;

@synthesize B_visa       = _B_visa;
@synthesize B_mastercard = _B_mastercard;
@synthesize B_favorite   = _B_favorite;

@synthesize IC_image_mini  = _IC_image_mini;
@synthesize IC_image_offer = _IC_image_offer;
@synthesize IC_image_ficha = _IC_image_ficha;

@synthesize NSMA_images               = _NSMA_images;
@synthesize NSMA_foods                = _NSMA_foods;
@synthesize NSMA_foodcategories       = _NSMA_foodcategories;
@synthesize NSMA_dailymenus           = _NSMA_dailymenus;
@synthesize NSMA_dailymenuscategories = _NSMA_dailymenuscategories;
@synthesize NSMD_openHoursAntesRestaurante = _NSMD_openHoursAntesRestaurante;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setIC_image_ficha
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setIC_image_ficha:(ImageClass *)IC_image_ficha {
    
    _IC_image_ficha = IC_image_ficha;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setIC_image_offer
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_image_offer:(ImageClass *)IC_image_offer {
    
    _IC_image_offer = IC_image_offer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setIC_imageOffer
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_image_mini:(ImageClass *)IC_image_mini {
    
    _IC_image_mini = IC_image_mini;
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
//#	Propiedad       : setNSMA_foodcategories
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_foodcategories:(NSMutableArray *)NSMA_foodcategories {
    
    _NSMA_foodcategories = NSMA_foodcategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_foods
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_foods:(NSMutableArray *)NSMA_foods {
    
    _NSMA_foods = NSMA_foods;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_dailymenus
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_dailymenus:(NSMutableArray *)NSMA_dailymenus {
    
    _NSMA_dailymenus = NSMA_dailymenus;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_discount
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_discount:(NSString *)NSS_discount {
    
    _NSS_discount = [NSS_discount copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namemembership
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namemembership:(NSString *)NSS_namemembership {
    
    _NSS_namemembership = [NSS_namemembership copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_favorite
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_favorite:(BOOL)B_favorite {
    
    _B_favorite = B_favorite;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestauranttype
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idrestauranttype:(NSString*)NSI_idrestauranttype {
    
    _NSI_idrestauranttype = NSI_idrestauranttype;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestaurant
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idrestaurant:(NSInteger)NSI_idrestaurant {
    
    _NSI_idrestaurant = NSI_idrestaurant;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_name
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_name:(NSString *)NSS_name {
    
    _NSS_name = [NSS_name copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_description
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_description:(NSString *)NSS_description {
    
    _NSS_description = [NSS_description copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_address1
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_address1:(NSString *)NSS_address1 {
    
    _NSS_address1 = [NSS_address1 copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_address2
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_address2:(NSString *)NSS_address2 {
    
    _NSS_address2 = [NSS_address2 copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_address3
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_address3:(NSString *)NSS_address3 {
    
    _NSS_address3 = [NSS_address3 copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_distance
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_distance:(NSString *)NSS_distance {
    
    _NSS_distance = [NSS_distance copy];
    
    // Comprobamos si es un porcentaje
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_latitude
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_latitude:(CGFloat)CGF_latitude {
    
    _CGF_latitude = CGF_latitude;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_longitude
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_longitude:(CGFloat)CGF_longitude {
    
    _CGF_longitude = CGF_longitude;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_stars
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_stars:(CGFloat)CGF_stars {
    
    _CGF_stars = CGF_stars;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price_average
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price_average:(CGFloat)CGF_price_average {
    
    _CGF_price_average = CGF_price_average;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_min_price_homedelivery
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_min_price_homedelivery:(CGFloat)CGF_min_price_homedelivery {
    
    _CGF_min_price_homedelivery = CGF_min_price_homedelivery;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price_homedelivery
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price_homedelivery:(CGFloat)CGF_price_homedelivery {
    
    _CGF_price_homedelivery = CGF_price_homedelivery;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price_accumulated
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price_accumulated:(CGFloat)CGF_price_accumulated {
    
    _CGF_price_accumulated = CGF_price_accumulated;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRS_service_adomicilio
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRS_service_adomicilio:(typeRestaurantService)TRS_service_adomicilio {
    
    _TRS_service_adomicilio = TRS_service_adomicilio;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRS_service_arecoger
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRS_service_arecoger:(typeRestaurantService)TRS_service_arecoger {
    
    _TRS_service_arecoger = TRS_service_arecoger;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRS_service_antesrestaurante
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRS_service_antesrestaurante:(typeRestaurantService)TRS_service_antesrestaurante {
    
    _TRS_service_antesrestaurante = TRS_service_antesrestaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRS_service_enrestaurante
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRS_service_enrestaurante:(typeRestaurantService)TRS_service_enrestaurante {
    
    _TRS_service_enrestaurante = TRS_service_enrestaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRS_service_reserva
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRS_service_reserva:(typeRestaurantService)TRS_service_reserva {
    
    _TRS_service_reserva = TRS_service_reserva;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_visa
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_visa:(BOOL)B_visa {
    
    _B_visa = B_visa;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_mastercard
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_mastercard:(BOOL)B_mastercard {
    
    _B_mastercard = B_mastercard;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_images
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_images:(NSMutableArray *)NSMA_images {
    
    _NSMA_images = NSMA_images;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_dailymenuscategories
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSMA_dailymenuscategories:(NSMutableArray *)NSMA_dailymenuscategories {
    
    _NSMA_dailymenuscategories = NSMA_dailymenuscategories;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos los Arrays
    _NSMA_images               = [[NSMutableArray alloc] init];
    _NSMA_foods                = [[NSMutableArray alloc] init];
    _NSMA_foodcategories       = [[NSMutableArray alloc] init];
    _NSMA_dailymenus           = [[NSMutableArray alloc] init];
    _NSMA_dailymenuscategories = [[NSMutableArray alloc] init];
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : CGF_discount
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) CGF_discount {
    
    // Comprobamos que caracter debemos buscar
    if ([self B_discount_efectivo]) {

        // Buscamos el símbolo del €
        NSArray *NSA_discount = [_NSS_discount componentsSeparatedByString:@"€"];
        NSString *NSS_discount = [NSA_discount objectAtIndex:0];
        
        return [NSS_discount floatValue];
    }
    else {
        
        // Buscamos el símbolo del %
        NSArray *NSA_discount = [_NSS_discount componentsSeparatedByString:@"%"];
        NSString *NSS_discount = [NSA_discount objectAtIndex:0];
        
        return [NSS_discount floatValue];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : CGF_discount
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) B_discount_efectivo {
    
    // Buscamos el símbolo del %
    NSArray *NSA_discount = [_NSS_discount componentsSeparatedByString:@"%"];
    NSString *NSS_discount = [NSA_discount objectAtIndex:0];
    
    // comprobamos si no lo ha encontrado
    if ([NSS_discount length] == [_NSS_discount length]) return TRUE;
    else return FALSE;
}


@end
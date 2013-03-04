//
//  UserOfferClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "UserOfferClass.h"


@implementation UserOfferClass

@synthesize NSI_idoffer          = _NSI_idoffer;
@synthesize NSI_idrestaurant     = _NSI_idrestaurant;
@synthesize NSI_discount         = _NSI_discount;
@synthesize NSI_idfood           = _NSI_idfood;
@synthesize NSI_idfoodCategories = _NSI_idfoodCategories;

@synthesize NSS_namerestaurant   = _NSS_namerestaurant;
@synthesize NSS_nameoffer        = _NSS_nameoffer;
@synthesize NSS_descriptionoffer = _NSS_descriptionoffer;
@synthesize NSS_distance         = _NSS_distance;

@synthesize CGF_latitude  = _CGF_latitude;
@synthesize CGF_longitude = _CGF_longitude;

@synthesize TOT_typediscount = _TOT_typediscount;

@synthesize NSD_date_start = _NSD_date_start;
@synthesize NSD_date_end   = _NSD_date_end;

@synthesize IC_imageoffer = _IC_imageoffer;

@synthesize B_favorite = _B_favorite;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_discount
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_discount:(NSInteger)NSI_discount {
    
    _NSI_discount = NSI_discount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfood
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfood:(NSInteger)NSI_idfood {
    
    _NSI_idfood = NSI_idfood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodCategories
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodCategories:(NSInteger)NSI_idfoodCategories {
    
    _NSI_idfoodCategories = NSI_idfoodCategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOT_typediscount
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOT_typediscount:(typeOfferType)TOT_typediscount {
    
    _TOT_typediscount = TOT_typediscount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_distance
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_distance:(NSString *)NSS_distance {
    
    _NSS_distance = [NSS_distance copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idoffer
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idoffer:(NSInteger)NSI_idoffer {
    
    _NSI_idoffer = NSI_idoffer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestaurant
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idrestaurant:(NSInteger)NSI_idrestaurant {
    
    _NSI_idrestaurant = NSI_idrestaurant;
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
//#	Propiedad       : setNSS_nameoffer
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_nameoffer:(NSString *)NSS_nameoffer {
    
    _NSS_nameoffer = [NSS_nameoffer copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionoffer
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionoffer:(NSString *)NSS_descriptionoffer {
    
    _NSS_descriptionoffer = [NSS_descriptionoffer copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_latitude
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_latitude:(CGFloat)CGF_latitude {
    
    _CGF_latitude = CGF_latitude;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_longitude
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_longitude:(CGFloat)CGF_longitude {
    
    _CGF_longitude = CGF_longitude;
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
//#	Propiedad       : setIC_imageoffer
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_imageoffer:(ImageClass *)IC_imageoffer {
    
    _IC_imageoffer = IC_imageoffer;
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

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_idoffer:_ID_OFFER_NO_SELECTED_];
    
    return self;
}


@end
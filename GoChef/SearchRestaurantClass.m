//
//  SearchRestaurantClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SearchRestaurantClass.h"
#import "UserClass.h"
#import "CoreLocationClass.h"


@implementation SearchRestaurantClass

@synthesize B_order          = _B_order;
@synthesize B_filter         = _B_filter;
@synthesize B_restaurant     = _B_restaurant;
@synthesize B_restauranttype = _B_restauranttype;

@synthesize TRO_order  = _TRO_order;
@synthesize TFR_filter = _TFR_filter;

@synthesize NSI_idrestaurant     = _NSI_idrestaurant;
@synthesize NSS_idrestauranttype = _NSS_idrestauranttype;

@synthesize NSI_start = _NSI_start;
@synthesize NSI_limit = _NSI_limit;

@synthesize CGF_latitude  = _CGF_latitude;
@synthesize CGF_longitude = _CGF_longitude;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_order
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_start:(NSInteger)NSI_start {
    
    _NSI_start = NSI_start;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_order
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_limit:(NSInteger)NSI_limit {
    
    _NSI_limit = NSI_limit;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_order
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_order:(BOOL)B_order {
    
    _B_order = B_order;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_filter
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_filter:(BOOL)B_filter {
    
    _B_filter = B_filter;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_restaurant
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_restaurant:(BOOL)B_restaurant {
    
    _B_restaurant = B_restaurant;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_restauranttype
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_restauranttype:(BOOL)B_restauranttype {
    
    _B_restauranttype = B_restauranttype;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRO_order
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRO_order:(typeResultOrder)TRO_order {
    
    _TRO_order = TRO_order;
    
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
    [self setB_order:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTFR_filter
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTFR_filter:(typeFilterRestaurant)TFR_filter {
    
    _TFR_filter = TFR_filter;
    
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
    [self setB_filter:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestaurant
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idrestaurant:(NSInteger)NSI_idrestaurant {
    
    _NSI_idrestaurant = NSI_idrestaurant;
    
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
    [self setB_restaurant:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idrestauranttype
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_idrestauranttype:(NSString*)NSS_idrestauranttype {
    
    _NSS_idrestauranttype = NSS_idrestauranttype;
    
    if (NSS_idrestauranttype != nil) {
        [self setB_restauranttype:TRUE];
    } else {
        [self setB_restauranttype:FALSE];
    }
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
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

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : init
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setB_order          : FALSE];
    [self setB_filter         : FALSE];
    [self setB_restaurant     : FALSE];
    [self setB_restauranttype : FALSE];
    
    // Iniciamos rango registro
    [self setNSI_start:_GET_START_VALUE_];
    [self setNSI_limit:globalVar.NSI_blocksize_restaurants];
    
    // Iniciamos método de ordenación
    [self setTRO_order:TRO_distancia];
    
    // Iniciamos restaurantes a mostrar
    [self setTFR_filter:TFR_todos];
    
    // Iniciamos coordenadas
    [self setCGF_latitude :globalVar.CLC_location.CLLM_manager.location.coordinate.latitude];
    [self setCGF_longitude:globalVar.CLC_location.CLLM_manager.location.coordinate.longitude];
    
    return self;
}


@end
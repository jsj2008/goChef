//
//  FacebookOfferClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "FacebookOfferClass.h"


@implementation FacebookOfferClass

@synthesize NSI_idoffer_facebook = _NSI_idoffer_facebook;
@synthesize NSI_idfood = _NSI_idfood;

@synthesize NSS_offer_description = _NSS_offer_description;
@synthesize NSS_facebook_description = _NSS_facebook_description;

@synthesize B_future = _B_future;
@synthesize B_utilizada = _B_utilizada;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_utilizada
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_utilizada:(BOOL)B_utilizada {
    
    _B_utilizada = B_utilizada;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_future
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_future:(BOOL)B_future {
    
    _B_future = B_future;
}

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
//#	Propiedad       : setNSI_idfood
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfood:(NSInteger)NSI_idfood {
    
    _NSI_idfood = NSI_idfood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_offer_description
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_offer_description:(NSString *)NSS_offer_description {
    
    _NSS_offer_description = [NSS_offer_description copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_facebook_description
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_facebook_description:(NSString *)NSS_facebook_description {
    
    _NSS_facebook_description = [NSS_facebook_description copy];
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_idoffer_facebook     : _ID_FACEBOOK_OFFER_NO_SELECCIONADA_];
    [self setNSI_idfood               : _ID_FOOD_NO_SELECCIONADA_];
    [self setNSS_offer_description    : @""];
    [self setNSS_facebook_description : @""];
    [self setB_future                 : FALSE];
    [self setB_utilizada              : FALSE];
    
    return self;
}


@end
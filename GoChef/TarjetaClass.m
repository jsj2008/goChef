//
//  TarjetaClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TarjetaClass.h"


@implementation TarjetaClass

@synthesize NSI_id     = _NSI_id;
@synthesize NSS_type   = _NSS_type;
@synthesize NSS_name   = _NSS_name;
@synthesize NSS_number = _NSS_number;
@synthesize NSS_cvv    = _NSS_cvv;
@synthesize B_default  = _B_default;

@synthesize NSD_date_expiration = _NSD_date_expiration;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_id
//#	Fecha Creación	: 20/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_id:(NSInteger)NSI_id {
    
    _NSI_id = NSI_id;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_default
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_default:(BOOL)B_default {
    
    _B_default = B_default;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_type
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_type:(NSString *)NSS_type {
    
    _NSS_type = [NSS_type copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_name
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_name:(NSString *)NSS_name {
    
    _NSS_name = [NSS_name copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_number
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_number:(NSString *)NSS_number {
    
    _NSS_number = [NSS_number copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_expiration
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_expiration:(NSDate *)NSD_date_expiration {
    
    _NSD_date_expiration = NSD_date_expiration;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_verification_code
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_cvv:(NSString *)NSS_cvv {
    
    _NSS_cvv = [NSS_cvv copy];
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_id     : _ID_CREDITCARD_NO_SELECTED_];
    [self setNSS_type   : @""];
    [self setB_default  : FALSE];
    [self setNSS_name   : @""];
    [self setNSS_number : @""];
    [self setNSS_cvv    : _CVV_CREDIT_CARD_NULL];

    [self setNSD_date_expiration : nil];

    return self;
}


@end
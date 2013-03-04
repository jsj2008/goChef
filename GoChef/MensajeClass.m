//
//  MensajeClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MensajeClass.h"


@implementation MensajeClass

@synthesize NSS_description = _NSS_description;
@synthesize TMT_type = _TMT_type;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_id
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_description:(NSString *)NSS_description {
    
    _NSS_description = [NSS_description copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSN_restaurants_visits
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTMT_type:(typeMensajeType)TMT_type {
    
    _TMT_type = TMT_type;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    return self;
}


@end
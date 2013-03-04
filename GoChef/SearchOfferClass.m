//
//  SearchOfferClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SearchOfferClass.h"
#import "CoreLocationClass.h"


@implementation SearchOfferClass

@synthesize B_order  = _B_order;
@synthesize B_filter = _B_filter;

@synthesize TOO_order  = _TOO_order;
@synthesize TOF_filter = _TOF_filter;

@synthesize CGF_latitude  = _CGF_latitude;
@synthesize CGF_longitude = _CGF_longitude;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_order
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_order:(BOOL)B_order {
    
    _B_order = B_order;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_filter
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_filter:(BOOL)B_filter {
    
    _B_filter = B_filter;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOO_order
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOO_order:(typeOfferOrder)TOO_order {
    
    _TOO_order = TOO_order;
    
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
    [self setB_order:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTOF_filter
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTOF_filter:(typeOfferFilter)TOF_filter {
    
    _TOF_filter = TOF_filter;
    
    // Inidicamos que se ha introducido un filtro por Tipo de cocina
    [self setB_filter:TRUE];
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

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : init
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setB_order  : FALSE];
    [self setB_filter : FALSE];
    
    // Iniciamos método de ordenación
    [self setTOO_order:TOO_fecha];
    
    // Iniciamos restaurantes a mostrar
    [self setTOF_filter:TOF_todos];
    
    // Iniciamos coordenadas
    [self setCGF_latitude :globalVar.CLC_location.CLLM_manager.location.coordinate.latitude];
    [self setCGF_longitude:globalVar.CLC_location.CLLM_manager.location.coordinate.longitude];
    
    return self;
}


@end
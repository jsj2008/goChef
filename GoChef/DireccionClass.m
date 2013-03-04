//
//  DireccionClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DireccionClass.h"


@implementation DireccionClass

@synthesize NSI_id          = _NSI_id;
@synthesize NSS_telefono    = _NSS_telefono;
@synthesize NSS_movil       = _NSS_movil;
@synthesize NSS_direccion   = _NSS_direccion;
@synthesize NSS_numero      = _NSS_numero;
@synthesize NSS_piso        = _NSS_piso;
@synthesize NSS_letra       = _NSS_letra;
@synthesize NSS_portal      = _NSS_portal;
@synthesize NSS_escalera    = _NSS_escalera;
@synthesize NSS_cp          = _NSS_cp;
@synthesize NSS_ciudad      = _NSS_ciudad;
@synthesize NSS_etiqueta    = _NSS_etiqueta;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_id
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_id:(NSInteger)NSI_id {
    
    _NSI_id = NSI_id;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_telefono
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_movil:(NSString *)NSS_movil {
    
    _NSS_movil = [NSS_movil copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_telefono
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_telefono:(NSString *)NSS_telefono {
    
    _NSS_telefono = [NSS_telefono copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_direccion
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_direccion:(NSString *)NSS_direccion {
    
    _NSS_direccion = [NSS_direccion copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_numero
//#	Fecha Creación	: 16/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_numero:(NSString *)NSS_numero {
    
    _NSS_numero = [NSS_numero copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_piso
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_piso:(NSString *)NSS_piso {
    
    _NSS_piso = [NSS_piso copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_letra
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_letra:(NSString *)NSS_letra {
    
    _NSS_letra = [NSS_letra copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_portal
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_portal:(NSString *)NSS_portal {
    
    _NSS_portal = [NSS_portal copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_escalera
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_escalera:(NSString *)NSS_escalera {
    
    _NSS_escalera = [NSS_escalera copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_cp
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_cp:(NSString *)NSS_cp {
    
    _NSS_cp = [NSS_cp copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_ciudad
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_ciudad:(NSString *)NSS_ciudad {
    
    _NSS_ciudad = [NSS_ciudad copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_etiqueta
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_etiqueta:(NSString *)NSS_etiqueta {
    
    _NSS_etiqueta = [NSS_etiqueta copy];
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos Propiedades
    [self setNSI_id         :_ID_ADDRESS_NO_SELECTED_];
    [self setNSS_telefono   : @""];
    [self setNSS_movil      : @""];
    [self setNSS_direccion  : @""];
    [self setNSS_numero     : @""];
    [self setNSS_piso       : @""];
    [self setNSS_letra      : @""];
    [self setNSS_portal     : @""];
    [self setNSS_escalera   : @""];
    [self setNSS_cp         : @""];
    [self setNSS_ciudad     : @""];
    [self setNSS_etiqueta   : @""];
    
    return self;
}


@end
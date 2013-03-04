//
//  MiSacoClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiSacoClass.h"


@implementation MiSacoClass

@synthesize NSI_id                      = _NSI_id;
@synthesize NSS_titulo                  = _NSS_titulo;
@synthesize NSS_nombre_restaurante      = _NSS_nombre_restaurante;
@synthesize NSS_direccion_restaurante   = _NSS_direccion_restaurante;
@synthesize NSS_cp_provincia            = _NSS_cp_provincia;
@synthesize NSS_imagen                  = _NSS_imagen;
@synthesize NSD_fecha_final             = _NSD_fecha_final;
@synthesize CGF_distancia               = _CGF_distancia;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_id
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_id:(NSInteger)NSI_id {
    
    _NSI_id = NSI_id;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_titulo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_titulo:(NSString *)NSS_titulo {
    
    _NSS_titulo = [NSS_titulo copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_nombre_restaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_nombre_restaurante:(NSString *)NSS_nombre_restaurante {
    
    _NSS_nombre_restaurante = [NSS_nombre_restaurante copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_direccion_restaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_direccion_restaurante:(NSString *)NSS_direccion_restaurante {
    
    _NSS_direccion_restaurante = [NSS_direccion_restaurante copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_cp_provincia
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_cp_provincia:(NSString *)NSS_cp_provincia {
    
    _NSS_cp_provincia = [NSS_cp_provincia copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_imagen
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_imagen:(NSString *)NSS_imagen {
    
    _NSS_imagen = [NSS_imagen copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_fecha_final
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_fecha_final:(NSDate *)NSD_fecha_final {
    
    _NSD_fecha_final = NSD_fecha_final;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_distancia
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_distancia:(CGFloat)CGF_distancia {
    
    _CGF_distancia = CGF_distancia;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    return self;
}


@end
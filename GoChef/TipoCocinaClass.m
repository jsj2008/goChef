//
//  TipoCocinaClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TipoCocinaClass.h"


@implementation TipoCocinaClass

@synthesize NSI_id = _NSI_id;
@synthesize NSS_name = _NSS_name;
@synthesize NSS_description = _NSS_description;

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
//#	Propiedad       : setNSS_descripcion
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_description:(NSString *)NSS_description {
    
    _NSS_description = [NSS_description copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descripcion
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_name:(NSString *)NSS_name {
    
    _NSS_name = [NSS_name copy];
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
    
    return self;
}


@end
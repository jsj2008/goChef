//
//  FoodOptionClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "FoodOptionClass.h"


@implementation FoodOptionClass

@synthesize NSI_idfoodoption          = _NSI_idfoodoption;
@synthesize NSS_namefoodoption        = _NSS_namefoodoption;
@synthesize NSS_descriptionfoodoption = _NSS_descriptionfoodoption;
@synthesize CGF_priceplusfoodoption   = _CGF_priceplusfoodoption;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodcategories
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodoption:(NSInteger)NSI_idfoodoption {
    
    _NSI_idfoodoption = NSI_idfoodoption;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodoption
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodoption:(NSString *)NSS_namefoodoption {
    
    _NSS_namefoodoption = [NSS_namefoodoption copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionfoodoption
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionfoodoption:(NSString *)NSS_descriptionfoodoption {
    
    _NSS_descriptionfoodoption = [NSS_descriptionfoodoption copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_priceplusfoodoption
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_priceplusfoodoption:(CGFloat)CGF_priceplusfoodoption {
    
    _CGF_priceplusfoodoption = CGF_priceplusfoodoption;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    return self;
}


@end
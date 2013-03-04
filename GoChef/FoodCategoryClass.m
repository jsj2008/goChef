//
//  FoodCategoryClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "FoodCategoryClass.h"


@implementation FoodCategoryClass

@synthesize NSI_idfoodcategories   = _NSI_idfoodcategories;
@synthesize NSS_namefoodcategories = _NSS_namefoodcategories;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodcategories
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodcategories:(NSInteger)NSI_idfoodcategories {
    
    _NSI_idfoodcategories = NSI_idfoodcategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodcategories
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodcategories:(NSString *)NSS_namefoodcategories {
    
    _NSS_namefoodcategories = [NSS_namefoodcategories copy];
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
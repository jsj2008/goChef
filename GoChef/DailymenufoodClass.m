//
//  DailymenufoodClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DailymenufoodClass.h"


@implementation DailymenufoodClass

@synthesize NSI_iddailymenufood     = _NSI_iddailymenufood;
@synthesize NSI_idfood              = _NSI_idfood;
@synthesize NSI_idfoodcategories    = _NSI_idfoodcategories;
@synthesize NSS_namefood            = _NSS_namefood;
@synthesize NSS_namefoodcategories  = _NSS_namefoodcategories;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_iddailymenufood
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_iddailymenufood:(NSInteger)NSI_iddailymenufood {
    
    _NSI_iddailymenufood = NSI_iddailymenufood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfood
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfood:(NSInteger)NSI_idfood {
    
    _NSI_idfood = NSI_idfood;
}

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
//#	Propiedad       : setNSS_namefood
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefood:(NSString *)NSS_namefood {
    
    _NSS_namefood = [NSS_namefood copy];
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
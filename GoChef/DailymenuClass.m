//
//  DailymenuClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DailymenuClass.h"


@implementation DailymenuClass

@synthesize NSI_iddailymenu = _NSI_iddailymenu;

@synthesize NSS_name = _NSS_name;

@synthesize NSD_date_start = _NSD_date_start;
@synthesize NSD_date_end   = _NSD_date_end;

@synthesize CGF_price = _CGF_price;

@synthesize NSMA_dailymenufoods = _NSMA_dailymenufoods;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_name
//#	Fecha Creación	: 18/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSS_name:(NSString *)NSS_name {
    
    _NSS_name = [NSS_name copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_iddailymenu
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_dailymenufoods:(NSMutableArray *)NSMA_dailymenufoods {
    
    _NSMA_dailymenufoods = NSMA_dailymenufoods;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_iddailymenu
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_iddailymenu:(NSInteger)NSI_iddailymenu {
    
    _NSI_iddailymenu = NSI_iddailymenu;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_start
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_start:(NSDate *)NSD_date_start {
    
    _NSD_date_start = NSD_date_start;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_date_end
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_date_end:(NSDate *)NSD_date_end {
    
    _NSD_date_end = NSD_date_end;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price:(CGFloat)CGF_price {
    
    _CGF_price = CGF_price;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos los Arrays
    _NSMA_dailymenufoods = [[NSMutableArray alloc] init];
    
    // Iniciamos propiedades
    [self setNSS_name:@""];
    
    return self;
}


@end
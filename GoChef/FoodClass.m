//
//  FoodClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "FoodClass.h"


@implementation FoodClass

@synthesize NSI_idfood           = _NSI_idfood;
@synthesize NSI_idfoodcategories = _NSI_idfoodcategories;
@synthesize NSI_idfoodgroup      = _NSI_idfoodgroup;

@synthesize NSS_namefood             = _NSS_namefood;
@synthesize NSS_descriptionfood      = _NSS_descriptionfood;
@synthesize NSS_namefoodcategories   = _NSS_namefoodcategories;
@synthesize NSS_namefoodgroup        = _NSS_namefoodgroup;
@synthesize NSS_descriptionfoodgroup = _NSS_descriptionfoodgroup;

@synthesize CGF_price              = _CGF_price;
@synthesize CGF_priceplusfoodgroup = _CGF_priceplusfoodgroup;

@synthesize B_options = _B_options;

@synthesize IC_imagefood = _IC_imagefood;

@synthesize NSMA_options              = _NSMA_options;
@synthesize NSMA_options_obligatories = _NSMA_options_obligatories;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfood
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfood:(NSInteger)NSI_idfood {
    
    _NSI_idfood = NSI_idfood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodcategories
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodcategories:(NSInteger)NSI_idfoodcategories {
    
    _NSI_idfoodcategories = NSI_idfoodcategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodgroup
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodgroup:(NSInteger)NSI_idfoodgroup {
    
    _NSI_idfoodgroup = NSI_idfoodgroup;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefood
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefood:(NSString *)NSS_namefood {
    
    _NSS_namefood = [NSS_namefood copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionfood
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionfood:(NSString *)NSS_descriptionfood {
    
    _NSS_descriptionfood = [NSS_descriptionfood copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodcategories
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodcategories:(NSString *)NSS_namefoodcategories {
    
    _NSS_namefoodcategories = [NSS_namefoodcategories copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodgroup
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodgroup:(NSString *)NSS_namefoodgroup {
    
    _NSS_namefoodgroup = [NSS_namefoodgroup copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionfoodgroup
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionfoodgroup:(NSString *)NSS_descriptionfoodgroup {
    
    _NSS_descriptionfoodgroup = [NSS_descriptionfoodgroup copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price:(CGFloat)CGF_price {
    
    _CGF_price = CGF_price;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_priceplusfoodgroup
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_priceplusfoodgroup:(CGFloat)CGF_priceplusfoodgroup {
    
    _CGF_priceplusfoodgroup = CGF_priceplusfoodgroup;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_options
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_options:(BOOL)B_options {
    
    _B_options = B_options;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setIC_imagefood
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_imagefood:(ImageClass *)IC_imagefood {
    
    _IC_imagefood = IC_imagefood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_options
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_options:(NSMutableArray *)NSMA_options {
    
    _NSMA_options = NSMA_options;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_options_obligatories
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_options_obligatories:(NSMutableArray *)NSMA_options_obligatories {
    
    _NSMA_options_obligatories = NSMA_options_obligatories;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos los Arrays
    _NSMA_options              = [[NSMutableArray alloc] init];
    _NSMA_options_obligatories = [[NSMutableArray alloc] init];

    return self;
}


@end
//
//  ImageClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "ImageClass.h"


@implementation ImageClass

@synthesize NSI_number = _NSI_number;

@synthesize TIT_type = _TIT_type;

@synthesize CGF_width  = _CGF_width;
@synthesize CGF_height = _CGF_height;

@synthesize NSD_image = _NSD_image;
@synthesize NSS_imageUrl = _NSS_imageUrl;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_number
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_number:(NSInteger)NSI_number {
    
    _NSI_number = NSI_number;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTIT_type
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTIT_type:(typeImageType)TIT_type {
    
    _TIT_type = TIT_type;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_width
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_width:(CGFloat)CGF_width {
    
    _CGF_width = CGF_width;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_height
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_height:(CGFloat)CGF_height {
    
    _CGF_height = CGF_height;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_image
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_image:(NSData *)NSD_image {
    
    _NSD_image = NSD_image;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 15/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos porpiedades
    [self setNSD_image:nil];
    
    return self;
}


@end
//
//  AnnotationClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "AnnotationClass.h"

@implementation AnnotationClass

@synthesize coordinate;

@synthesize NSS_title;
@synthesize NSS_subtitle;
@synthesize dLatitud;
@synthesize dLongitud;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: subtitle
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *)subtitle {
	return NSS_subtitle;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: title
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) title {
	return NSS_title;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSubtitle
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSubtitle: (NSString *)st {
	self.NSS_subtitle = st;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setTitle
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTitle: (NSString *)t {
	self.NSS_title = t;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initWithCoordinate:title:subtitle:rId:rVer:wId:
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id)initWithCoordinate:(CLLocationCoordinate2D) c
				  title:(NSString *) t
			   subtitle:(NSString *) st
{
	coordinate            = c;
	self.NSS_title        = t;
	self.NSS_subtitle     = st;
    self.dLatitud         = c.latitude;
    self.dLongitud        = c.longitude;
    
	return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: moveAnnotation
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) moveAnnotation: (CLLocationCoordinate2D) newCoordinate {
	
	coordinate = newCoordinate;
}


@end
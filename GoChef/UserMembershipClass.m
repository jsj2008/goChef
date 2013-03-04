//
//  UserMembershipClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "UserMembershipClass.h"


@implementation UserMembershipClass

@synthesize NSI_idmembership = _NSI_idmembership;

@synthesize NSS_membershipname         = _NSS_membershipname;
@synthesize NSS_membershippricemax     = _NSS_membershippricemax;
@synthesize NSS_membershippricemin     = _NSS_membershippricemin;
@synthesize NSS_membershippricemaxname = _NSS_membershippricemaxname;
@synthesize NSS_membershippriceminname = _NSS_membershippriceminname;
@synthesize NSS_membershipdescription  = _NSS_membershipdescription;
@synthesize NSS_discount               = _NSS_discount;

@synthesize CGF_priceaccumulated = _CGF_priceaccumulated;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idmembership
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idmembership:(NSInteger)NSI_idmembership {
    
    _NSI_idmembership = NSI_idmembership;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershipname
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershipname:(NSString *)NSS_membershipname {
    
    _NSS_membershipname = [NSS_membershipname copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershippricemax
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershippricemax:(NSString *)NSS_membershippricemax {
    
    _NSS_membershippricemax = [NSS_membershippricemax copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershippricemin
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershippricemin:(NSString *)NSS_membershippricemin {
    
    _NSS_membershippricemin = [NSS_membershippricemin copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershipdescription
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershipdescription:(NSString *)NSS_membershipdescription {
    
    _NSS_membershipdescription = [NSS_membershipdescription copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershippricemaxname
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershippricemaxname:(NSString *)NSS_membershippricemaxname {
    
    _NSS_membershippricemaxname = [NSS_membershippricemaxname copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_membershippriceminname
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_membershippriceminname:(NSString *)NSS_membershippriceminname {
    
    _NSS_membershippriceminname = [NSS_membershippriceminname copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_discount
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_discount:(NSString *)NSS_discount {
    
    _NSS_discount = [NSS_discount copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_priceaccumulated
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_priceaccumulated:(CGFloat)CGF_priceaccumulated {
    
    _CGF_priceaccumulated = CGF_priceaccumulated;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_idmembership           : _ID_USER_MEMBERSHIP_NO_VALUE_];
    [self setNSS_membershipname         : @""];
    [self setNSS_membershippricemax     : @""];
    [self setNSS_membershippricemin     : @""];
    [self setNSS_membershippricemaxname : @""];
    [self setNSS_membershippriceminname : @""];
    [self setNSS_membershipdescription  : @""];
    [self setNSS_discount               : @""];
    [self setCGF_priceaccumulated       : 0.0f];
    
    return self;
}


@end
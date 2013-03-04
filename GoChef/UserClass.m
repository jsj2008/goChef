//
//  UserClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "UserClass.h"


@implementation UserClass

@synthesize NSI_id    = _NSI_id;
@synthesize NSI_phone = _NSI_phone;

@synthesize NSI_num_facebook_friends = _NSI_num_facebook_friends;

@synthesize TST_genre = _TST_genre;
@synthesize TRT_type  = _TRT_type;

@synthesize NSS_name     = _NSS_name;
@synthesize NSS_lastname = _NSS_lastname;
@synthesize NSS_email    = _NSS_email;
@synthesize NSS_password = _NSS_password;
@synthesize NSS_location = _NSS_location;
@synthesize NSS_token    = _NSS_token;

@synthesize NSD_birthday = _NSD_birthday;

@synthesize NSN_spending           = _NSN_spending;
@synthesize NSN_saving             = _NSN_saving;
@synthesize NSN_restaurants_visits = _NSN_restaurants_visits;

@synthesize UMC_membership = _UMC_membership;

@synthesize NSMA_offers = _NSMA_offers;

#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_num_facebook_friends
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_num_facebook_friends:(NSInteger)NSI_num_facebook_friends {
    
    _NSI_num_facebook_friends = NSI_num_facebook_friends;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setUMC_membership
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUMC_membership:(UserMembershipClass *)UMC_membership {
    
    _UMC_membership = UMC_membership;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_token
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_token:(NSString *)NSS_token {
    
    _NSS_token = [NSS_token copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_offers
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_offers:(NSMutableArray *)NSMA_offers {
    
    _NSMA_offers = NSMA_offers;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_id
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_id:(NSInteger)NSI_id {
    
    _NSI_id = NSI_id;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_phone
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_phone:(NSInteger)NSI_phone {
    
    _NSI_phone = NSI_phone;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTST_genre
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTST_genre:(typeSexoType)TST_genre {
    
    _TST_genre = TST_genre;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTRT_type
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTRT_type:(typeRegisterType)TRT_type {
    
    _TRT_type = TRT_type;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_name
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_name:(NSString *)NSS_name {
    
    _NSS_name = [NSS_name copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_lastname
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_lastname:(NSString *)NSS_lastname {
    
    _NSS_lastname = [NSS_lastname copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_email
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_email:(NSString *)NSS_email {
    
    _NSS_email = [NSS_email copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_password
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_password:(NSString *)NSS_password {
    
    _NSS_password = [NSS_password copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_location
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_location:(NSString *)NSS_location {
    
    _NSS_location = [NSS_location copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSD_birthday
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_birthday:(NSDate *)NSD_birthday {
    
    _NSD_birthday = NSD_birthday;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSN_spending
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSN_spending:(NSNumber *)NSN_spending {
    
    _NSN_spending = NSN_spending;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSN_saving
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSN_saving:(NSNumber *)NSN_saving {
    
    _NSN_saving = NSN_saving;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSN_restaurants_visits
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSN_restaurants_visits:(NSNumber *)NSN_restaurants_visits {
    
    _NSN_restaurants_visits = NSN_restaurants_visits;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_id    :_ID_USER_NO_REGISTRADO_];
    [self setNSS_token :globalVar.NSS_deviceToken];
    
    // Iniciamos numero de amigos de Facebook
    [self setNSI_num_facebook_friends:0];
    
    // Iniciamos Class
    _UMC_membership = [[UserMembershipClass alloc] init];
    
    // Iniciamos los Arrays
    _NSMA_offers = [[NSMutableArray alloc] init];
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : haveOffersForRestaurant
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) haveOffersForRestaurant:(NSInteger)NSI_idrestaurant {
    
    BOOL B_result = FALSE;
    
    // Buscamos el idRestuarnt en el Array de Offers
    for (UserOfferClass *UOC_offer in _NSMA_offers)
        if (UOC_offer.NSI_idrestaurant == NSI_idrestaurant) {
            B_result = TRUE;
            break;
        }
    
    return B_result;
}


@end
//
//  UserClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "UserOfferClass.h"
#import "UserMembershipClass.h"


@interface UserClass : NSObject {
    
    NSInteger _NSI_id;
    NSInteger _NSI_phone;
    NSInteger _NSI_num_facebook_friends;
    
    typeSexoType _TST_genre;
    typeRegisterType _TRT_type;
    
    NSString *_NSS_name;
    NSString *_NSS_lastname;
    NSString *_NSS_email;
    NSString *_NSS_password;
    NSString *_NSS_location;
    NSString *_NSS_token;
    
    NSDate *_NSD_birthday;
    
    NSNumber *_NSN_spending;
    NSNumber *_NSN_saving;
    NSNumber *_NSN_restaurants_visits;
    
    UserMembershipClass *_UMC_membership;
    
    NSMutableArray *_NSMA_offers;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_id;
@property (nonatomic, readwrite) NSInteger NSI_phone;
@property (nonatomic, readwrite) NSInteger NSI_num_facebook_friends;

@property (nonatomic, readwrite) typeSexoType TST_genre;
@property (nonatomic, readwrite) typeRegisterType TRT_type;

@property (nonatomic, retain) NSString *NSS_name;
@property (nonatomic, retain) NSString *NSS_lastname;
@property (nonatomic, retain) NSString *NSS_email;
@property (nonatomic, retain) NSString *NSS_password;
@property (nonatomic, retain) NSString *NSS_location;
@property (nonatomic, retain) NSString *NSS_token;

@property (nonatomic, retain) NSDate *NSD_birthday;

@property (nonatomic, retain) NSNumber *NSN_spending;
@property (nonatomic, retain) NSNumber *NSN_saving;
@property (nonatomic, retain) NSNumber *NSN_restaurants_visits;

@property (nonatomic, retain) UserMembershipClass *UMC_membership;

@property (nonatomic, retain) NSMutableArray *NSMA_offers;


-(BOOL) haveOffersForRestaurant:(NSInteger)NSI_idrestaurant;


@end
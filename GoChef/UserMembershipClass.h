//
//  UserMembershipClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface UserMembershipClass : NSObject {
    
    NSInteger _NSI_idmembership;
    
    NSString *_NSS_membershipname;
    NSString *_NSS_membershippricemax;
    NSString *_NSS_membershippricemin;
    NSString *_NSS_membershippricemaxname;
    NSString *_NSS_membershippriceminname;
    NSString *_NSS_membershipdescription;
    NSString *_NSS_discount;
    
    CGFloat _CGF_priceaccumulated;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idmembership;

@property (nonatomic, retain) NSString *NSS_membershipname;
@property (nonatomic, retain) NSString *NSS_membershippricemax;
@property (nonatomic, retain) NSString *NSS_membershippricemin;
@property (nonatomic, retain) NSString *NSS_membershippricemaxname;
@property (nonatomic, retain) NSString *NSS_membershippriceminname;
@property (nonatomic, retain) NSString *NSS_membershipdescription;
@property (nonatomic, retain) NSString *NSS_discount;

@property (nonatomic, readwrite) CGFloat CGF_priceaccumulated;


@end
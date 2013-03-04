//
//  UserOfferClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "ImageClass.h"


@interface UserOfferClass : NSObject {
    
    NSInteger _NSI_idoffer;
    NSInteger _NSI_idrestaurant;
    NSInteger _NSI_discount;
    NSInteger _NSI_idfood;
    NSInteger _NSI_idfoodCategories;
    
    NSString *_NSS_namerestaurant;
    NSString *_NSS_nameoffer;
    NSString *_NSS_descriptionoffer;
    NSString *_NSS_distance;
    
    CGFloat _CGF_latitude;
    CGFloat _CGF_longitude;
    
    typeOfferType _TOT_typediscount;
    
    NSDate *_NSD_date_start;
    NSDate *_NSD_date_end;
    
    ImageClass *_IC_imageoffer;
    
    BOOL _B_favorite;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idoffer;
@property (nonatomic, readwrite) NSInteger NSI_idrestaurant;
@property (nonatomic, readwrite) NSInteger NSI_discount;
@property (nonatomic, readwrite) NSInteger NSI_idfood;
@property (nonatomic, readwrite) NSInteger NSI_idfoodCategories;

@property (nonatomic, retain) NSString *NSS_namerestaurant;
@property (nonatomic, retain) NSString *NSS_nameoffer;
@property (nonatomic, retain) NSString *NSS_descriptionoffer;
@property (nonatomic, retain) NSString *NSS_distance;

@property (nonatomic, readwrite) CGFloat CGF_latitude;
@property (nonatomic, readwrite) CGFloat CGF_longitude;

@property (nonatomic, readwrite) typeOfferType TOT_typediscount;

@property (nonatomic, retain) NSDate *NSD_date_start;
@property (nonatomic, retain) NSDate *NSD_date_end;

@property (nonatomic, retain) ImageClass *IC_imageoffer;

@property (nonatomic, readwrite) BOOL B_favorite;


@end
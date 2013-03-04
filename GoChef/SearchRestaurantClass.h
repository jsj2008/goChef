//
//  SearchRestaurantClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface SearchRestaurantClass : NSObject {
    
    BOOL _B_order;
    BOOL _B_filter;
    BOOL _B_restaurant;
    BOOL _B_restauranttype;
    
    typeResultOrder _TRO_order;
    typeFilterRestaurant _TFR_filter;
    
    NSInteger _NSI_idrestaurant;
    
    NSInteger _NSI_start;
    NSInteger _NSI_limit;
    
    CGFloat _CGF_latitude;
    CGFloat _CGF_longitude;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_order;
@property (nonatomic, readwrite) BOOL B_filter;
@property (nonatomic, readwrite) BOOL B_restaurant;
@property (nonatomic, readwrite) BOOL B_restauranttype;

@property (nonatomic, readwrite) typeResultOrder TRO_order;
@property (nonatomic, readwrite) typeFilterRestaurant TFR_filter;

@property (nonatomic, readwrite) NSInteger NSI_idrestaurant;
@property (nonatomic, readwrite) NSString *NSS_idrestauranttype;

@property (nonatomic, readwrite) NSInteger NSI_start;
@property (nonatomic, readwrite) NSInteger NSI_limit;

@property (nonatomic, readwrite) CGFloat CGF_latitude;
@property (nonatomic, readwrite) CGFloat CGF_longitude;


@end
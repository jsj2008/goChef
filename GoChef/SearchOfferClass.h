//
//  SearchOfferClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface SearchOfferClass : NSObject {
    
    BOOL _B_order;
    BOOL _B_filter;
    
    typeOfferOrder _TOO_order;
    typeOfferFilter _TOF_filter;
    
    CGFloat _CGF_latitude;
    CGFloat _CGF_longitude;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_order;
@property (nonatomic, readwrite) BOOL B_filter;

@property (nonatomic, readwrite) typeOfferOrder TOO_order;
@property (nonatomic, readwrite) typeOfferFilter TOF_filter;

@property (nonatomic, readwrite) CGFloat CGF_latitude;
@property (nonatomic, readwrite) CGFloat CGF_longitude;


@end
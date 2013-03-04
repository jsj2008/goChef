//
//  FacebookOfferClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface FacebookOfferClass : NSObject {
    
    NSInteger _NSI_idoffer_facebook;
    NSInteger _NSI_idfood;
    
    NSString *_NSS_offer_description;
    NSString *_NSS_facebook_description;
    
    BOOL _B_future;
    BOOL _B_utilizada;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idoffer_facebook;
@property (nonatomic, readwrite) NSInteger NSI_idfood;

@property (nonatomic, retain) NSString *NSS_offer_description;
@property (nonatomic, retain) NSString *NSS_facebook_description;

@property (nonatomic, readwrite) BOOL B_future;
@property (nonatomic, readwrite) BOOL B_utilizada;


@end
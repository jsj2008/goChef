//
//  FoodOptionClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface FoodOptionClass : NSObject {
    
    NSInteger _NSI_idfoodoption;
    
    NSString *_NSS_namefoodoption;
    NSString *_NSS_descriptionfoodoption;
    
    CGFloat _CGF_priceplusfoodoption;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idfoodoption;

@property (nonatomic, retain) NSString *NSS_namefoodoption;
@property (nonatomic, retain) NSString *NSS_descriptionfoodoption;

@property (nonatomic, readwrite) CGFloat CGF_priceplusfoodoption;


@end
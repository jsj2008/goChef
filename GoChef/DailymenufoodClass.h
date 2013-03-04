//
//  DailymenufoodClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface DailymenufoodClass : NSObject {
    
    NSInteger _NSI_iddailymenufood;
    NSInteger _NSI_idfood;
    NSInteger _NSI_idfoodcategories;
    
    NSString *_NSS_namefood;
    NSString *_NSS_namefoodcategories;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_iddailymenufood;
@property (nonatomic, readwrite) NSInteger NSI_idfood;
@property (nonatomic, readwrite) NSInteger NSI_idfoodcategories;

@property (nonatomic, retain) NSString *NSS_namefood;
@property (nonatomic, retain) NSString *NSS_namefoodcategories;


@end
//
//  TarjetaClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface TarjetaClass : NSObject {
    
    NSInteger _NSI_id;
    
    NSString *_NSS_type;
    NSString *_NSS_name;
    NSString *_NSS_number;
    NSString *_NSS_cvv;
    
    NSDate *_NSD_date_expiration;

    BOOL _B_default;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_id;

@property (nonatomic, retain) NSString *NSS_type;
@property (nonatomic, retain) NSString *NSS_name;
@property (nonatomic, retain) NSString *NSS_number;
@property (nonatomic, retain) NSString *NSS_cvv;

@property (nonatomic, retain) NSDate *NSD_date_expiration;

@property (nonatomic, readwrite) BOOL B_default;



@end
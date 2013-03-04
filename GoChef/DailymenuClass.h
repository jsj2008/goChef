//
//  DailymenuClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "DailymenufoodClass.h"

@interface DailymenuClass : NSObject {
    
    NSInteger _NSI_iddailymenu;
    
    NSString *_NSS_name;
    
    NSDate *_NSD_date_start;
    NSDate *_NSD_date_end;
    
    CGFloat _CGF_price;
    
    NSMutableArray *_NSMA_dailymenufoods;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_iddailymenu;

@property (nonatomic, retain) NSString *NSS_name;

@property (nonatomic, retain) NSDate *NSD_date_start;
@property (nonatomic, retain) NSDate *NSD_date_end;

@property (nonatomic, readwrite) CGFloat CGF_price;

@property (nonatomic, retain) NSMutableArray *NSMA_dailymenufoods;


@end
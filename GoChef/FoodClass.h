//
//  FoodClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "FoodCategoryClass.h"
#import "FoodOptionClass.h"
#import "ImageClass.h"


@interface FoodClass : NSObject {
    
    NSInteger _NSI_idfood;
    NSInteger _NSI_idfoodcategories;
    NSInteger _NSI_idfoodgroup;
    
    NSString *_NSS_namefood;
    NSString *_NSS_descriptionfood;
    NSString *_NSS_namefoodcategories;
    NSString *_NSS_namefoodgroup;
    NSString *_NSS_descriptionfoodgroup;
    
    CGFloat _CGF_price;
    CGFloat _CGF_priceplusfoodgroup;
    
    BOOL _B_options;
    
    ImageClass *_IC_imagefood;
    
    NSMutableArray *_NSMA_options;
    NSMutableArray *_NSMA_options_obligatories;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idfood;
@property (nonatomic, readwrite) NSInteger NSI_idfoodcategories;
@property (nonatomic, readwrite) NSInteger NSI_idfoodgroup;

@property (nonatomic, retain) NSString *NSS_namefood;
@property (nonatomic, retain) NSString *NSS_descriptionfood;
@property (nonatomic, retain) NSString *NSS_namefoodcategories;
@property (nonatomic, retain) NSString *NSS_namefoodgroup;
@property (nonatomic, retain) NSString *NSS_descriptionfoodgroup;

@property (nonatomic, readwrite) CGFloat CGF_price;
@property (nonatomic, readwrite) CGFloat CGF_priceplusfoodgroup;

@property (nonatomic, readwrite) BOOL B_options;

@property (nonatomic, retain) ImageClass *IC_imagefood;

@property (nonatomic, retain) NSMutableArray *NSMA_options;
@property (nonatomic, retain) NSMutableArray *NSMA_options_obligatories;


@end
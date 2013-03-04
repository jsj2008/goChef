//
//  OrderFoodClass.h
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


@interface OrderFoodClass : NSObject {
    
    NSInteger _NSI_idorder_food;
    NSInteger _NSI_idfood;
    NSInteger _NSI_iddailymenu_food;
    NSInteger _NSI_idfoodcategories;
    NSInteger _NSI_idfoodgroup;
    NSInteger _NSI_amount;
    NSInteger _NSI_menus;
    
    NSString *_NSS_namefood;
    NSString *_NSS_descriptionfood;
    NSString *_NSS_namefoodcategories;
    NSString *_NSS_namefoodgroup;
    NSString *_NSS_descriptionfoodgroup;
    NSString *_NSS_instructions;
    
    CGFloat _CGF_price;
    CGFloat _CGF_priceplusfoodgroup;
    
    BOOL _B_is_offer;
    BOOL _B_is_offer_facebook;
    BOOL _B_is_price_offer;
    
    ImageClass *_IC_imagefood;
    
    NSMutableArray *_NSMA_options;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idorder_food;
@property (nonatomic, readwrite) NSInteger NSI_idfood;
@property (nonatomic, readwrite) NSInteger NSI_iddailymenu_food;
@property (nonatomic, readwrite) NSInteger NSI_idfoodcategories;
@property (nonatomic, readwrite) NSInteger NSI_idfoodgroup;
@property (nonatomic, readwrite) NSInteger NSI_amount;
@property (nonatomic, readwrite) NSInteger NSI_menus;

@property (nonatomic, retain) NSString *NSS_namefood;
@property (nonatomic, retain) NSString *NSS_descriptionfood;
@property (nonatomic, retain) NSString *NSS_namefoodcategories;
@property (nonatomic, retain) NSString *NSS_namefoodgroup;
@property (nonatomic, retain) NSString *NSS_descriptionfoodgroup;
@property (nonatomic, retain) NSString *NSS_instructions;

@property (nonatomic, readwrite) CGFloat CGF_price;
@property (nonatomic, readwrite) CGFloat CGF_priceplusfoodgroup;

@property (nonatomic, readwrite) BOOL B_is_offer;
@property (nonatomic, readwrite) BOOL B_is_offer_facebook;
@property (nonatomic, readwrite) BOOL B_is_price_offer;

@property (nonatomic, retain) ImageClass *IC_imagefood;

@property (nonatomic, retain) NSMutableArray *NSMA_options;


-(CGFloat) CGF_total_price;
-(CGFloat) CGF_options_price;


@end
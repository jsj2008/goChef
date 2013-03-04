//
//  RestaurantClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "DailymenuClass.h"
#import "FoodClass.h"
#import "ImageClass.h"


@interface RestaurantClass : NSObject {
    
    NSInteger _NSI_idrestaurant;
    NSString *_NSI_idrestauranttype;
    NSInteger _NSI_idoffer;
    
    NSString *_NSS_name;
    NSString *_NSS_description;
    NSString *_NSS_address1;
    NSString *_NSS_address2;
    NSString *_NSS_address3;
    NSString *_NSS_distance;
    NSString *_NSS_discount;
    NSString *_NSS_namemembership;
    
    CGFloat _CGF_latitude;
    CGFloat _CGF_longitude;
    CGFloat _CGF_stars;
    CGFloat _CGF_price_average;
    CGFloat _CGF_min_price_homedelivery;
    CGFloat _CGF_price_homedelivery;
    CGFloat _CGF_price_accumulated;
    
    typeRestaurantService _TRS_service_adomicilio;
    typeRestaurantService _TRS_service_arecoger;
    typeRestaurantService _TRS_service_antesrestaurante;
    typeRestaurantService _TRS_service_enrestaurante;
    typeRestaurantService _TRS_service_reserva;
    
    BOOL _B_visa;
    BOOL _B_mastercard;
    BOOL _B_favorite;

    ImageClass *_IC_image_mini;
    ImageClass *_IC_image_offer;
    ImageClass *_IC_image_ficha;
    
    NSMutableArray *_NSMA_images;
    NSMutableArray *_NSMA_foods;
    NSMutableArray *_NSMA_foodcategories;
    NSMutableArray *_NSMA_dailymenus;
    NSMutableArray *_NSMA_dailymenuscategories;
            
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idrestaurant;
@property (nonatomic, readwrite) NSString *NSI_idrestauranttype;
@property (nonatomic, readwrite) NSInteger NSI_idoffer;
@property (nonatomic, assign)    NSInteger NSI_imagesCount;

@property (nonatomic, retain) NSString *NSS_name;
@property (nonatomic, retain) NSString *NSS_description;
@property (nonatomic, retain) NSString *NSS_address1;
@property (nonatomic, retain) NSString *NSS_address2;
@property (nonatomic, retain) NSString *NSS_address3;
@property (nonatomic, retain) NSString *NSS_distance;
@property (nonatomic, retain) NSString *NSS_discount;
@property (nonatomic, retain) NSString *NSS_namemembership;

@property (nonatomic, readwrite) CGFloat CGF_latitude;
@property (nonatomic, readwrite) CGFloat CGF_longitude;
@property (nonatomic, readwrite) CGFloat CGF_stars;
@property (nonatomic, readwrite) CGFloat CGF_price_average;
@property (nonatomic, readwrite) CGFloat CGF_min_price_homedelivery;
@property (nonatomic, readwrite) CGFloat CGF_price_homedelivery;
@property (nonatomic, readwrite) CGFloat CGF_price_accumulated;

@property (nonatomic, readwrite) typeRestaurantService TRS_service_adomicilio;
@property (nonatomic, readwrite) typeRestaurantService TRS_service_arecoger;
@property (nonatomic, readwrite) typeRestaurantService TRS_service_antesrestaurante;
@property (nonatomic, readwrite) typeRestaurantService TRS_service_enrestaurante;
@property (nonatomic, readwrite) typeRestaurantService TRS_service_reserva;

@property (nonatomic, readwrite) BOOL B_visa;
@property (nonatomic, readwrite) BOOL B_mastercard;
@property (nonatomic, readwrite) BOOL B_favorite;

@property (nonatomic, retain) ImageClass *IC_image_mini;
@property (nonatomic, retain) ImageClass *IC_image_offer;
@property (nonatomic, retain) ImageClass *IC_image_ficha;

@property (nonatomic, retain) NSMutableArray *NSMA_images;
@property (nonatomic, retain) NSMutableArray *NSMA_foods;
@property (nonatomic, retain) NSMutableArray *NSMA_foodcategories;
@property (nonatomic, retain) NSMutableArray *NSMA_dailymenus;
@property (nonatomic, retain) NSMutableArray *NSMA_dailymenuscategories;
@property (nonatomic, retain) NSMutableDictionary *NSMD_openHoursAntesRestaurante;


-(CGFloat) CGF_discount;
-(BOOL) B_discount_efectivo;
  
  
@end
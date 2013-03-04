//
//  OrderClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "OrderFoodClass.h"

@class RestaurantClass, DireccionClass, TarjetaClass, UserOfferClass, FacebookOfferClass;

@interface OrderClass : NSObject {
    
    NSInteger _NSI_idorder;
    NSInteger _NSI_idorder_food;
    NSInteger _NSI_idrestaurant;
    NSInteger _NSI_iduseraddress;
    NSInteger _NSI_idcreditcard;
    NSInteger _NSI_idoffer;
    NSInteger _NSI_idoffer_facebook;
    NSInteger _NSI_persons;
    NSInteger _NSI_number_table;
    
    NSString *_NSS_namerestaurant;
    NSString *_NSS_instructions;
    NSString *_NSS_payment_type;
    
    CGFloat _CGF_subtotal;
    CGFloat _CGF_membership_discount;
    CGFloat _CGF_offer_discount;
    CGFloat _CGF_facebook_discount;
    CGFloat _CGF_price_homedelivery;
    CGFloat _CGF_total;
    
    NSDate *_NSD_date_start;
    NSDate *_NSD_date_end;
    NSDate *_NSD_date_reservation;
    
    typeOrderStatus _TOS_status;
    typeOrderType   _TOT_type;
    typeOrderActive _TOA_active;
    
    RestaurantClass *_RC_restaurant;    
    DireccionClass  *_DC_useraddress;
    TarjetaClass    *_TC_creditcard;
    UserOfferClass  *_OC_offer;
    
    FacebookOfferClass *_FC_facebook_offer;
    
    BOOL _B_favorite;
    BOOL _B_new;
    
    NSMutableArray *_NSMA_orderfoods;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_idorder;
@property (nonatomic, readwrite) NSInteger NSI_idorder_food;
@property (nonatomic, readwrite) NSInteger NSI_idrestaurant;
@property (nonatomic, readwrite) NSInteger NSI_iduseraddress;
@property (nonatomic, readwrite) NSInteger NSI_idcreditcard;
@property (nonatomic, readwrite) NSInteger NSI_idoffer;
@property (nonatomic, readwrite) NSInteger NSI_idoffer_facebook;
@property (nonatomic, readwrite) NSInteger NSI_persons;
@property (nonatomic, readwrite) NSInteger NSI_number_table;

@property (nonatomic, retain) NSString *NSS_namerestaurant;
@property (nonatomic, retain) NSString *NSS_instructions;
@property (nonatomic, retain) NSString *NSS_payment_type;

@property (nonatomic, readwrite) CGFloat CGF_subtotal;
@property (nonatomic, readwrite) CGFloat CGF_membership_discount;
@property (nonatomic, readwrite) CGFloat CGF_offer_discount;
@property (nonatomic, readwrite) CGFloat CGF_facebook_discount;
@property (nonatomic, readwrite) CGFloat CGF_price_homedelivery;
@property (nonatomic, readwrite) CGFloat CGF_total;

@property (nonatomic, retain) NSDate *NSD_date_start;
@property (nonatomic, retain) NSDate *NSD_date_end;
@property (nonatomic, retain) NSDate *NSD_date_reservation;

@property (nonatomic, readwrite) typeOrderStatus TOS_status;
@property (nonatomic, readwrite) typeOrderType   TOT_type;
@property (nonatomic, readwrite) typeOrderActive TOA_active;

@property (nonatomic, retain) RestaurantClass *RC_restaurant;    
@property (nonatomic, retain) DireccionClass  *DC_useraddress;
@property (nonatomic, retain) TarjetaClass    *TC_creditcard;
@property (nonatomic, retain) UserOfferClass  *OC_offer;

@property (nonatomic, retain) FacebookOfferClass *FC_facebook_offer;

@property (nonatomic, readwrite) BOOL B_favorite;
@property (nonatomic, readwrite) BOOL B_new;

@property (nonatomic, retain) NSMutableArray *NSMA_orderfoods;


-(void) copy:(OrderClass *)OC_order;
-(void) update:(OrderClass *)OC_order;

-(void) reset;
-(void) resetFood;
-(void) resetOffers;


@end
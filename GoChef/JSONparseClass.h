//
//  JSONparseClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SingletonGlobal.h"

@class DireccionClass, MensajeClass, UserClass, FoodClass, DailymenuClass, TarjetaClass, OrderClass, OrderFoodClass, ImageClass, FacebookOfferClass;


@interface JSONparseClass : NSObject {
    
    SingletonGlobal *globalVar;
}

-(DireccionClass *) parseGoogleMapAddressWith:(CLLocation *)CLL_location;


-(void) UMNI_setSuggestionsproblems:(MensajeClass *)MC_mensaje;
-(void) UMNI_setUser:(UserClass *)UC_user update:(BOOL)B_update changePassword:(BOOL)B_password;
-(void) UMNI_validateLogin:(UserClass *)UC_user ;
-(void) UMNI_rememberPassword:(NSString *)NSS_password;
-(void) UMNI_deleteUser:(NSInteger)NSI_id;
-(void) UMNI_setUseraddress:(DireccionClass *)DC_direccion update:(BOOL)B_update;
-(void) UMNI_deleteUseraddress:(NSInteger)NSI_id;
-(void) UMNI_validateLogin:(UserClass *)UC_user;
-(void) UMNI_validateEmail:(NSString *)NSS_email type:(typeRegisterType)TRT_type;
-(void) UMNI_getRestaurants:(BOOL)B_download_images;
-(void) UMNI_getRestaurant:(NSInteger)NSI_idrestaurant images:(BOOL)B_download_images;
-(void) UMNI_getUseraddress;
-(void) UMNI_getUser;
-(void) UMNI_getRestauranttype;
-(NSArray*) UMNI_getDatesOffers:(NSInteger)idRestaurant inMonth:(NSString*)month;
-(NSArray*) UMNI_getHoursOffers:(NSInteger)idRestaurant service:(NSString*)service inDate:(NSString*)date;
-(void) UMNI_getFoods;
-(void) UMNI_getFoodOptions:(FoodClass *)FC_food obligatory:(BOOL)B_obligatory images:(BOOL)B_download_images;
-(void) UMNI_getFoodCategories:(BOOL)B_menu;
-(void) UMNI_getDailymenu;
-(void) UMNI_getDailymenufood:(DailymenuClass *)DMC_dailymenu;
-(void) UMNI_getOffers:(BOOL)B_download_images idrestaurant:(NSInteger)NSI_idrestaurant;
-(void) UMNI_getOrders:(BOOL)B_download_images;
-(void) UMNI_getOrdersDevolution;
-(void) UMNI_getOrderfood:(OrderClass *)OC_order images:(BOOL)B_download_images;
-(void) UMNI_setOrder:(OrderClass *)OC_order;
-(void) UMNI_updateOrderStatus:(OrderClass *)OC_order;
-(void) UMNI_setOrderfood:(OrderFoodClass *)OFC_food idorder:(NSInteger)NSI_idorder;
-(void) UMNI_sendOrderticket;
-(void) UMNI_setRestaurantStarsfavorites:(NSInteger)NSI_idrestaurant type:(BOOL)B_typeFavorito value:(NSInteger)NSI_value;
-(void) UMNI_validateTablenumber:(NSInteger)NSI_idrestaurant code:(NSInteger)NSI_code;
-(void) UMNI_setCheckout:(OrderClass *)OC_order type:(typeCheckOutType)TCO_type;
-(void) UMNI_getImage:(ImageClass *)IC_image objectId:(NSInteger)NSI_id;
-(void) UMNI_getUsermembership:(NSInteger)NSI_idrestaurant;
-(void) UMNI_getFacebookOffer:(FacebookOfferClass *)FC_facebook_offer restaurant:(NSInteger)NSI_idrestaurant;
-(void) UMNI_setFacebookOffer:(FacebookOfferClass *)FC_facebook_offer;
-(void) UMNI_getRestaurantpostalcode:(NSInteger)NSI_idrestaurant address:(NSInteger)NSI_idaddress;
-(void) UMNI_getmembershipvalidate:(NSInteger)NSI_idRestaurante;
-(void) UMNI_activeenrestaurant;
-(void) UMNI_getordersnew;
-(void) UMNI_numberofregisters;
-(void) UMNI_getreportepedidos:(NSInteger)NSI_idOrder;


-(NSString *) UMNI_getURLforImage:(ImageClass *)IC_image objectId:(NSInteger)NSI_id;


@end
//
//  LoadingViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class RestaurantAllInfoClass;

@interface LoadingViewController : UIViewController {
    
    NSString *_NSS_text;
    
    IBOutlet UILabel *UIL_text;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) NSString *NSS_text;
@property (nonatomic, retain) UILabel *UIL_text;


-(void) getGoogleMapAddress;
-(void) loadTiposCocina;
-(void) loadDirecciones;

-(void) loadRestaurantes;
-(void) loadRestaurante;

-(void) setsuggestionsproblems;

-(void) loadUsuario;
-(void) setUser;
-(void) updateUser;
-(void) loginUser;
-(void) recordarPassword;
-(void) removeUser;
-(void) loadUsuarioMembership;

-(void) comprobarCorreo;

-(void) loadFoods;
-(void) loadFoodCategories;
-(void) loadDailymenus;
-(void) loadDailymenusCategories;
-(void) loadFoodsOptionsObligatory;
-(void) loadFoodsOptionsNoObligatory;

-(void) loadOffers;

-(void) loadOrders;
-(void) loadOrderFood;
-(void) setOrder;
-(void) sendReporte;

-(void) setDireccion;
-(void) updateDireccion;
-(void) removeDireccion;

-(void) mailOrderticket;
-(void) valueRestaurant;
-(void) changeFavorite;

-(void) checkTableNumber;

-(void) pedirCuenta;
-(void) pagarConTarjeta;

-(void) getImage;

-(void) getFacebookOffer;
-(void) setFacebookOffer;

-(void) checkAddress;

-(void) checkFidelizacion;
-(void) checkActiveEnMesa;
-(void) checkNewOrders;
-(void) checkNumberofregisters;


@end
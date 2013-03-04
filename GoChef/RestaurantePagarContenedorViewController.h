//
//  RestaurantePagarContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectTarjetaViewController.h"

@class RestauranteConfirmacionViewController, TarjetasAltaViewController;

@interface RestaurantePagarContenedorViewController : UIViewController <SelectTarjetaViewControllerDelegate> {
    
    BOOL _B_favorite;
    BOOL _B_con_tarjeta;
    BOOL _B_come_from_tarjeta;
    
    IBOutlet UILabel *UIL_restaurantename;
    IBOutlet UILabel *UIL_total;
    IBOutlet UILabel *UIL_tarjeta;
    IBOutlet UILabel *UIL_facebook_text;
    
    IBOutlet UIImageView *UIIV_facebook;
    
    IBOutlet UIButton *UIB_favorites;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIView *UIV_general;
    IBOutlet UIView *UIV_tarjeta;
    
    RestauranteConfirmacionViewController *_RCVC_confirm;
    
    TarjetasAltaViewController  *_TAVC_alta_tarjeta;
    SelectTarjetaViewController *_STVC_tarjeta;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_favorite;
@property (nonatomic, readwrite) BOOL B_con_tarjeta;
@property (nonatomic, readwrite) BOOL B_come_from_tarjeta;

@property (nonatomic, retain) UILabel *UIL_restaurantename;
@property (nonatomic, retain) UILabel *UIL_total;
@property (nonatomic, retain) UILabel *UIL_tarjeta;
@property (nonatomic, retain) UILabel *UIL_facebook_text;

@property (nonatomic, retain) UIImageView *UIIV_facebook;

@property (nonatomic, retain) UIButton *UIB_favorites;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIView *UIV_general;
@property (nonatomic, retain) UIView *UIV_tarjeta;

@property (nonatomic, retain) RestauranteConfirmacionViewController *RCVC_confirm;

@property (nonatomic, retain) TarjetasAltaViewController  *TAVC_alta_tarjeta;
@property (nonatomic, retain) SelectTarjetaViewController *STVC_tarjeta;


-(IBAction) UIB_favorites_TouchUpInside         :(id)sender;
-(IBAction) UIB_faceboock_TouchUpInside         :(id)sender;
-(IBAction) UIB_pedir_cuenta_TouchUpInside      :(id)sender;
-(IBAction) UIB_pagar_con_tarjeta_TouchUpInside :(id)sender;
-(IBAction) UIB_next_view_tarjeta_TouchUpInside :(id)sender;
-(IBAction) UIB_prev_view_tarjeta_TouchUpInside :(id)sender;
-(IBAction) UIB_select_tarjeta_TouchUpInside    :(id)sender;
-(IBAction) UIB_alta_tarjeta_TouchUpInside      :(id)sender;

-(void) initNavigationBar;


@end
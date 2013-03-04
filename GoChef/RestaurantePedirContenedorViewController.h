//
//  RestaurantePedirContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectRestaurantesViewController.h"

@class PedidoViewController, RestaurantePedirConfirmacionViewController;

@protocol RestaurantePedirContenedorViewControllerDelegate

-(void) Tabbar_rst_en_cocina_Touched;
-(void) Tabbar_rst_pagar_Touched;
-(void) Tabbar_mi_cuenta_Touched;

@end

@interface RestaurantePedirContenedorViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, SelectRestaurantesViewControllerDelegate> {
    
    BOOL _B_confirmado;
    
    IBOutlet UITextField *UITF_mesa_01;
    IBOutlet UITextField *UITF_mesa_02;
    IBOutlet UITextField *UITF_mesa_03;
    IBOutlet UITextField *UITF_mesa_04;
    
    IBOutlet UILabel *UIL_restaurante;
    
    SelectRestaurantesViewController *_SRVC_resturantes;
    
    PedidoViewController *_PVC_pedir;
    RestaurantePedirConfirmacionViewController *_RPCVS_confirmar;
    
    __unsafe_unretained id<RestaurantePedirContenedorViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<RestaurantePedirContenedorViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_confirmado;

@property (nonatomic, retain) UITextField *UITF_mesa_01;
@property (nonatomic, retain) UITextField *UITF_mesa_02;
@property (nonatomic, retain) UITextField *UITF_mesa_03;
@property (nonatomic, retain) UITextField *UITF_mesa_04;

@property (nonatomic, retain) UILabel *UIL_restaurante;

@property (nonatomic, retain) SelectRestaurantesViewController *SRVC_resturantes;

@property (nonatomic, retain) PedidoViewController *PVC_pedir;
@property (nonatomic, retain) RestaurantePedirConfirmacionViewController *RPCVS_confirmar;


-(void) initNavigationBar;

-(IBAction) UIB_select_restaurante_TouchUpInside:(id)sender;
-(IBAction) UIB_confirmar_restaurante_mesa_TouchUpInside:(id)sender;


@end
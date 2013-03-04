//
//  MiCuentaRegistroLoginViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "MiCuentaLoginViewController.h"
#import "MiCuentaCondicionesLegalesViewController.h"


@protocol MiCuentaRegistroLoginViewControllerDelegate

-(void) Tabbar_dom_mi_pedido_Touched;
-(void) Tabbar_rst_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;
-(void) UIB_settings_Touched;
-(void) Tabbar_reserva_Touched;

@end

@class UIScrollViewWithTouchEvent;

@interface MiCuentaRegistroLoginViewController : UIViewController <UITextFieldDelegate, MiCuentaLoginViewControllerDelegate, MiCuentaCondicionesLegalesViewControllerDelegate> {
    
    BOOL _B_teclado_visible;
    BOOL _B_registro_facebook;
    
    IBOutlet UITextField *UITF_nombre;
    IBOutlet UITextField *UITF_apellidos;
    IBOutlet UITextField *UITF_correo;
    IBOutlet UITextField *UITF_telefono;
    IBOutlet UITextField *UITF_password;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIScrollViewWithTouchEvent *UISV_scroll;
    
    MiCuentaLoginViewController *_MCLVC_login;
    MiCuentaCondicionesLegalesViewController *_MCCLVC_condiciones_legales;
    
    __unsafe_unretained id<MiCuentaRegistroLoginViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<MiCuentaRegistroLoginViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_teclado_visible;
@property (nonatomic, readwrite) BOOL B_registro_facebook;

@property (nonatomic, retain) UITextField *UITF_nombre;
@property (nonatomic, retain) UITextField *UITF_apellidos;
@property (nonatomic, retain) UITextField *UITF_correo;
@property (nonatomic, retain) UITextField *UITF_telefono;
@property (nonatomic, retain) UITextField *UITF_password;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIScrollViewWithTouchEvent *UISV_scroll;

@property (nonatomic, retain) MiCuentaLoginViewController *MCLVC_login;
@property (nonatomic, retain) MiCuentaCondicionesLegalesViewController *MCCLVC_condiciones_legales;


-(IBAction) UIB_continuar_TouchUpInside               :(id)sender;
-(IBAction) UIB_iniciar_sesion_facebook_TouchUpInside :(id)sender;
-(IBAction) UIB_iniciar_sesion_GoChef_TouchUpInside   :(id)sender;


-(void) initNavigationBar;


@end
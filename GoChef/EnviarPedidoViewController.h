//
//  EnviarPedidoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectTarjetaViewController.h"
#import "UIScrollViewWithTouchEvent.h"

@class ConfirmacionViewController, TarjetasAltaViewController;

@interface EnviarPedidoViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, SelectTarjetaViewControllerDelegate> {
    
    BOOL _B_keyboardIsShow;
    
    UITextField *UITF_actual;
    
    IBOutlet UILabel *UIL_direccion_00;
    IBOutlet UILabel *UIL_direccion_01;
    IBOutlet UILabel *UIL_direccion_02;
    IBOutlet UILabel *UIL_tarjeta;
    
    IBOutlet UIButton *UIB_en_efectivo;
    IBOutlet UIButton *UIB_tarjeta;
    
    IBOutlet UITextField *UITF_telefono;
    IBOutlet UITextField *UITF_direccion_info;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIButton *UIIV_tarjeta;
    
    IBOutlet UILabel *UIL_domicilio_subtotal;
    IBOutlet UILabel *UIL_domicilio_descuento;
    IBOutlet UILabel *UIL_domicilio_gastos_envio;
    IBOutlet UILabel *UIL_domicilio_descuento_ofertas;
    IBOutlet UILabel *UIL_domicilio_total;
    
    IBOutlet UILabel *UIL_recoger_subtotal;
    IBOutlet UILabel *UIL_recoger_descuento;
    IBOutlet UILabel *UIL_recoger_descuento_ofertas;
    IBOutlet UILabel *UIL_recoger_total;
    
    IBOutlet UIView *UIV_recoger;
    IBOutlet UIView *UIV_domicilio;
    
    IBOutlet UIImageView *UIIV_domicilio_background;
    IBOutlet UIImageView *UIIV_recoger_background;
     
    IBOutlet UIScrollViewWithTouchEvent *UISV_scroll;
    
    TarjetasAltaViewController *_TAVC_alta_tarjeta;
    ConfirmacionViewController *_CVC_confirmar;
    
    SelectTarjetaViewController *_STVC_tarjeta;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_keyboardIsShow;

@property (nonatomic, retain) UITextField *UITF_actual;

@property (nonatomic, retain) UILabel *UIL_direccion_00;
@property (nonatomic, retain) UILabel *UIL_direccion_01;
@property (nonatomic, retain) UILabel *UIL_direccion_02;
@property (nonatomic, retain) UILabel *UIL_tarjeta;

@property (nonatomic, retain) UIButton *UIB_en_efectivo;
@property (nonatomic, retain) UIButton *UIB_tarjeta;

@property (nonatomic, retain) UITextField *UITF_telefono;
@property (nonatomic, retain) UITextField *UITF_direccion_info;
@property (nonatomic, retain) IBOutlet UITextField *cupponTextField;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIButton *UIIV_tarjeta;

@property (nonatomic, retain) UILabel *UIL_domicilio_subtotal;
@property (nonatomic, retain) UILabel *UIL_domicilio_descuento;
@property (nonatomic, retain) UILabel *UIL_domicilio_gastos_envio;
@property (nonatomic, retain) UILabel *UIL_domicilio_descuento_ofertas;
@property (nonatomic, retain) UILabel *UIL_domicilio_total;

@property (nonatomic, retain) UILabel *UIL_recoger_subtotal;
@property (nonatomic, retain) UILabel *UIL_recoger_descuento;
@property (nonatomic, retain) UILabel *UIL_recoger_descuento_ofertas;
@property (nonatomic, retain) UILabel *UIL_recoger_total;

@property (nonatomic, retain) UIView *UIV_recoger;
@property (nonatomic, retain) UIView *UIV_domicilio;

@property (nonatomic, retain) UIImageView *UIIV_domicilio_background;
@property (nonatomic, retain) UIImageView *UIIV_recoger_background;

@property (nonatomic, retain) UIScrollViewWithTouchEvent *UISV_scroll;

@property (nonatomic, retain) TarjetasAltaViewController *TAVC_alta_tarjeta;
@property (nonatomic, retain) ConfirmacionViewController *CVC_confirmar;

@property (nonatomic, retain) SelectTarjetaViewController *STVC_tarjeta;


-(void) initNavigationBar;


-(IBAction) UIB_alta_tarjeta_TouchUpInside    :(id)sender;
-(IBAction) UIB_enviar_pedido_TouchUpInside   :(id)sender;
-(IBAction) UIB_select_tarjeta_TouchUpInside  :(id)sender;
-(IBAction) UIB_filtro_efectivo_TouchUpInside :(id)sender;
-(IBAction) UIB_filtro_tarjeta_TouchUpInside  :(id)sender;
-(IBAction) UIB_hide_keyboard                 :(id)sender;

-(IBAction) validateDiscountCuppon:(id)sender;

@end
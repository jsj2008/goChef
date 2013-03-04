//
//  CustomUITableViewCellPedidoPieViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellPedidoPieViewControllerDelegate

-(void) pedir_mas_comida_Touched;
-(void) select_oferta_Touched;
-(void) enviar_pedido_Touched;
-(void) cancelar_pedido_Touched;

@end


@interface CustomUITableViewCellPedidoPieViewController : UIViewController {
    
    IBOutlet UILabel *UIL_domicilio_oferta;
    IBOutlet UILabel *UIL_recoger_oferta;
    
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
    
    IBOutlet UIImageView *UIIV_recoger_background;
    IBOutlet UIImageView *UIIV_domicilio_background;
    
    IBOutlet UIButton *UIB_domicilio_cancelar;
    IBOutlet UIButton *UIB_domicilio_enviar_pedido;
    
    IBOutlet UIButton *UIB_recoger_cancelar;
    IBOutlet UIButton *UIB_recoger_enviar_pedido;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoPieViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoPieViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_domicilio_oferta;
@property (nonatomic, retain) UILabel *UIL_recoger_oferta;

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

@property (nonatomic, retain) UIImageView *UIIV_recoger_background;
@property (nonatomic, retain) UIImageView *UIIV_domicilio_background;

@property (nonatomic, retain) UIButton *UIB_domicilio_cancelar;
@property (nonatomic, retain) UIButton *UIB_domicilio_enviar_pedido;

@property (nonatomic, retain) UIButton *UIB_recoger_cancelar;
@property (nonatomic, retain) UIButton *UIB_recoger_enviar_pedido;

@property (nonatomic, retain) OrderClass *OC_order;


-(void) setContentWith:(OrderClass *)newOC_order;


-(IBAction) UIB_pedir_mas_comida_TouchUpInside  :(id)sender;
-(IBAction) UIB_select_oferta_TouchUpInside     :(id)sender;
-(IBAction) UIB_enviar_pedido_TouchUpInside     :(id)sender;
-(IBAction) UIB_cancelar_pedido_TouchUpInside   :(id)sender;


@end
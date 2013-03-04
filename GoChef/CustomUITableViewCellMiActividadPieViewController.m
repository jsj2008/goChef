//
//  CustomUITableViewCellMiActividadPieViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiActividadPieViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "UserOfferClass.h"
#import "UserClass.h"


@implementation CustomUITableViewCellMiActividadPieViewController

@synthesize UIL_subtotal;
@synthesize UIL_descuento;
@synthesize UIL_gastos_envio;
@synthesize UIL_descuento_ofertas;
@synthesize UIL_descuento_facebook;   
@synthesize UIL_total;
@synthesize UIB_status;

@synthesize OC_order = _OC_order;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/090/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Calculamos los costes de envío
    CGFloat CGF_gastos_envio = _OC_order.RC_restaurant.CGF_price_homedelivery;
    if (_OC_order.TOT_type != TOT_pedido_a_domicilio) CGF_gastos_envio = 0.0f;
    
    // Actualizamos los UILabel
    [UIL_subtotal           setText:[NSString stringWithFormat:@"%.2f €", _OC_order.CGF_subtotal]];
    [UIL_descuento          setText:[NSString stringWithFormat:@"%@%.2f €", (_OC_order.CGF_membership_discount == 0)?@"":@"-", _OC_order.CGF_membership_discount]];
    [UIL_gastos_envio       setText:[NSString stringWithFormat:@"%.2f €", CGF_gastos_envio]];
    [UIL_descuento_ofertas  setText:[NSString stringWithFormat:@"%@%.2f €", (_OC_order.CGF_offer_discount == 0)?@"":@"-", _OC_order.CGF_offer_discount]];
    [UIL_descuento_facebook setText:[NSString stringWithFormat:@"%@%.2f €", (_OC_order.CGF_facebook_discount == 0)?@"":@"-", _OC_order.CGF_facebook_discount]];
    [UIL_total              setText:[NSString stringWithFormat:@"%.2f €", _OC_order.CGF_total]];
    
    
    // Actualizamos UIButton
    UIImage *UII_status = [UIImage imageNamed:[NSString stringWithFormat:@"Status_%d.png",_OC_order.TOS_status]];
    [UIB_status setImage:UII_status forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_show_instructions_TouchUpInside
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_show_instructions_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate show_instructions_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_status_TouchUpInside
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_status_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate status_Touched];
}


@end
//
//  CustomUITableViewCellPedidoCabeceraViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPedidoCabeceraViewController.h"
#import "LoadingViewController.h"

#import "OrderClass.h"
#import "FacebookOfferClass.h"


@implementation CustomUITableViewCellPedidoCabeceraViewController

@synthesize UIL_nombre_restaurantes;
@synthesize UIL_facebook_text;
@synthesize UIB_recomendar;
@synthesize UIIV_facebook;

@synthesize NSS_nombre_restaurante = _NSS_nombre_restaurante;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_nombre_restaurante
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_nombre_restaurante:(NSString *)NSS_nombre_restaurante {
    
    _NSS_nombre_restaurante = NSS_nombre_restaurante;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos componentes
    [UIL_nombre_restaurantes setText:@""];
    [UIL_facebook_text setText:@""];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSString *)newNSS_nombre_restaurante {
    
    // Actualizamos propiedad
    [self setNSS_nombre_restaurante:newNSS_nombre_restaurante];
    
    // Actualizamos el UILabel
    [UIL_nombre_restaurantes setText:_NSS_nombre_restaurante];
    
    // Creamos UIImage
    UIImage *UII_facebook;
    
    // Comprobamos si tiene Facebook Offer
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {

        // Comprobamos si ya ha sido utilizada
        if (globalVar.OC_order.FC_facebook_offer.B_utilizada) {
         
            // Ocultamos texto
            [UIL_facebook_text setAlpha:0.0f];
            
            // Seleccionamo imagen correspondiente
            UII_facebook = [UIImage imageNamed:@"mi_pedido_cabecera_disable.png"];
        }
        else {
            
            // Actualizamos componentes
            [UIL_facebook_text setText:globalVar.OC_order.FC_facebook_offer.NSS_offer_description];
            
            // Seleccionamo imagen correspondiente
            UII_facebook = [UIImage imageNamed:@"mi_pedido_cabecera.png"];
        }
    }
    else {
        
        // Ocultamos texto
        [UIL_facebook_text setAlpha:0.0f];
        
        // Seleccionamo imagen correspondiente
        UII_facebook = [UIImage imageNamed:@"mi_pedido_cabecera_normal.png"];
    }
    
    // Acualizamos UIImageView Facebook
    [UIIV_facebook setImage:UII_facebook];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_recomiendo_en_facebook_TouchUpInside:(id)sender {
    
    // Comprobamos si tiene Facebook Offer y ha sido utilizada
    if ((globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && (globalVar.OC_order.FC_facebook_offer.B_utilizada)) return;
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate recomiendo_en_facebook];
}


@end
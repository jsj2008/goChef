//
//  CustomUITableViewCellPedidoConfirmacionCabeceraViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPedidoConfirmacionCabeceraViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"


@implementation CustomUITableViewCellPedidoConfirmacionCabeceraViewController

@synthesize UIL_nombre_restaurantes;
@synthesize UIL_detalle_pedido;

@synthesize OC_order = _OC_order;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_nombre_restaurante
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
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
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Actualizamos el UILabel
    [UIL_nombre_restaurantes setText:_OC_order.RC_restaurant.NSS_name];
    
    // Formateamos la fecha
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    if      (_OC_order.TOT_type == TOT_pedido_en_el_restaurante)            [NSDF_date setDateFormat:@"'Pedido Desde la Mesa ' EEEE d 'de' MMMM 'a las' HH:mm"];
    else if (_OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante)   [NSDF_date setDateFormat:@"'Pedido Llegar y Comer ' EEEE d 'de' MMMM 'a las' HH:mm"];
    else if (_OC_order.TOT_type == TOT_pedido_a_domicilio)                  [NSDF_date setDateFormat:@"'Pedido A Domicilio ' EEEE d 'de' MMMM 'a las' HH:mm"];
    else if (_OC_order.TOT_type == TOT_pedido_para_recoger)                 [NSDF_date setDateFormat:@"'Pedido A Recoger ' EEEE d 'de' MMMM 'a las' HH:mm"];
    else if (_OC_order.TOT_type == TOT_reserva)                             [NSDF_date setDateFormat:@"'Reserva para el ' EEEE d 'de' MMMM 'a las' HH:mm"];
    
    // Comprobamos si se está en la pantalla de confirmación
    if (globalVar.B_pedido_confirmado) {

        // Actualizamos el UILabel fecha la la fecha actual
        NSString *NSS_date = [NSDF_date stringFromDate:[NSDate date]];
        [UIL_detalle_pedido setText:NSS_date];
    }
    else {

        // Actualizamos el UILabel fecha la la fecha del pedido
        NSString *NSS_date = [NSDF_date stringFromDate:_OC_order.NSD_date_start];
        [UIL_detalle_pedido setText:NSS_date];
    }
}


@end
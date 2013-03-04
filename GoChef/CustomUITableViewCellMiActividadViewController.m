//
//  CustomUITableViewCellMiActividadViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiActividadViewController.h"
#import "OrderClass.h"


@implementation CustomUITableViewCellMiActividadViewController

@synthesize UIL_nombre_restaurante;
@synthesize UIL_tipo_pedido;
@synthesize UIL_fecha;
@synthesize UIL_estado;
@synthesize UIL_precio;
@synthesize UIIV_confirmado;
@synthesize UIIV_pagado;
@synthesize UIIV_background;
@synthesize UIIV_new;
@synthesize UIB_cell;

@synthesize OC_order = _OC_order;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Iniciamos UILabel
    [UIL_nombre_restaurante setText:@""];
    [UIL_tipo_pedido        setText:@""];
    [UIL_fecha              setText:@""];
    [UIL_estado             setText:@""];
    [UIL_precio             setText:@""];

    // Actualizamos el UIImageview background
    UIImage *UII_backgrpund;
    if (_OC_order.TOT_type == TOT_reserva) UII_backgrpund = [UIImage imageNamed:@"cell_mi_actividad_short_info_reserva_background.png"];
    else UII_backgrpund = [UIImage imageNamed:@"cell_mi_actividad_short_info_background.png"];
    [UIIV_background setImage:UII_backgrpund];
    
    // comprobamos si es una New Order
    if (_OC_order.B_new) [UIIV_new setAlpha:1.0f];
    else [UIIV_new setAlpha:0.0f];
        
    // Actualizamos el UILabel Nombre Restaurante
    [UIL_nombre_restaurante setText:_OC_order.NSS_namerestaurant];

    // Actualizamos UILabel Tipo Pedido
    switch (_OC_order.TOT_type)
    {
        case TOT_pedido_a_domicilio: 
            [UIL_tipo_pedido setText:@"A Domicilio"]; 
            break;
            
        case TOT_pedido_en_el_restaurante: 
            [UIL_tipo_pedido setText:@"Desde la Mesa"]; 
            break;
            
        case TOT_pedido_antes_de_ir_al_restaurante: 
            [UIL_tipo_pedido setText:@"Llegar y Comer"]; 
            break;
            
        case TOT_pedido_para_recoger: 
            [UIL_tipo_pedido setText:@"A Recoger"]; 
            break;
            
        case TOT_reserva: 
            [UIL_tipo_pedido setText:[NSString stringWithFormat:@"Reserva en el restaurante, %d personas", _OC_order.NSI_persons]]; 
            break;
    }
    
    // Iniciamos UIView Confirmado y Pagado
    [UIIV_confirmado setAlpha:0.0f];
    [UIIV_pagado     setAlpha:0.0f];
    
    // Actualizamos UILabel Tipo Pedido
    switch (_OC_order.TOS_status)
    {
        case TOS_pagado_con_tarjeta: 
            [UIL_estado  setText:@"Pendiente de confirmación"];
            [UIIV_pagado setAlpha:1.0f];
            break;
            
        case TOS_confirmado_y_pagado_con_tarjeta: 
            [UIL_estado      setText:@"Confirmado y Pagado con tarjeta"];
            [UIIV_pagado     setAlpha:1.0f];
            [UIIV_confirmado setAlpha:1.0f];
            break;
            
        case TOS_confirmado_y_pagado_con_efectivo: 
            [UIL_estado      setText:@"Confirmado y a pagar con efectivo"];
            [UIIV_confirmado setAlpha:1.0f];
            break;
            
        case TOS_confirmado: 
            [UIL_estado      setText:@"Confirmado"];
            [UIIV_confirmado setAlpha:1.0f];
            break;
            
        case TOS_pagado_con_efectivo: 
            [UIL_estado setText:@"Pagado con efectivo"];
            break;
            
        case TOS_pendiente_de_confirmar_y_pago: 
            [UIL_estado setText:@"Pendiente de confirmación"]; 
            break;
            
        case TOS_confirmado_y_pendiente_de_pago:
            [UIL_estado setText:@"Confirmado y Pendiente de pago"]; 
            break;
            
        case TOS_cobro_fallido:
            [UIL_estado setText:@"Cobro fallido"];
            break;
            
        case TOS_devolucion_efectuada:
            [UIL_estado setText:@"Cancelado y Devolución efectuada"];
            break;
            
        case TOS_devolucion_fallida:
            [UIL_estado setText:@"Cancelado y Devolución fallida"];
            break;
            
        case TOS_devolucion_pendiente:
            [UIL_estado setText:@"Cancelado y Devolución pendiente"];
            break;
        case TOS_cancelado:
            [UIL_estado setText:@"Cancelado"];
            break;
    }
    
    // Actualizamos UILabel Fecha
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    [NSDF_date setDateFormat:@"EEEE d 'de' MMMM 'de' yyyy ', a las' HH:mm"];
    NSString *NSS_date = [NSDF_date stringFromDate:_OC_order.NSD_date_start];
    [UIL_fecha setText:NSS_date];

    // Comprobamos que no sea una reserva
    if (_OC_order.TOT_type == TOT_reserva) {
        
        // Quitamos el precio
        [UIL_precio setText:@""];
        
        // Aumentamos el tamaño de los UILabel
        [UIL_nombre_restaurante setFrame:CGRectMake(UIL_nombre_restaurante.frame.origin.x, UIL_nombre_restaurante.frame.origin.y, 270.0f, UIL_nombre_restaurante.frame.size.height)];
        [UIL_tipo_pedido        setFrame:CGRectMake(UIL_tipo_pedido.frame.origin.x, UIL_tipo_pedido.frame.origin.y, 270.0f, UIL_tipo_pedido.frame.size.height)];
        [UIL_fecha              setFrame:CGRectMake(UIL_fecha.frame.origin.x, UIL_fecha.frame.origin.y, 270.0f, UIL_fecha.frame.size.height)];
        [UIL_estado             setFrame:CGRectMake(UIL_estado.frame.origin.x, UIL_estado.frame.origin.y, 270.0f, UIL_estado.frame.size.height)];
    }
    else {

        // Actualizamos UILabel del Precio
        NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
        [UIL_precio setText:[NSString stringWithFormat:@"%.2f%@", _OC_order.CGF_total, NSS_symbol]];
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Comprobamos que no sea una reserva
    if (_OC_order.TOT_type == TOT_reserva) return;
        
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_OC_order];
}


@end
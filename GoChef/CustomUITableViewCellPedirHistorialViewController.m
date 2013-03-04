//
//  CustomUITableViewCellPedirHistorialViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPedirHistorialViewController.h"
#import "OrderClass.h"


@implementation CustomUITableViewCellPedirHistorialViewController

@synthesize UIL_nombre_restaurante;
@synthesize UIL_type;
@synthesize UIL_fecha;
@synthesize UIB_cell;

@synthesize OC_order = _OC_order;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Iniciamos UILabel
    [UIL_nombre_restaurante setText:@""];
    [UIL_type  setText:@""];
    [UIL_fecha setText:@""];
    
    // Actualizamos el UILabel Nombre Restaurante
    [UIL_nombre_restaurante setText:_OC_order.NSS_namerestaurant];
    
    // Actualizamos UILabel Fecha
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    [NSDF_date setDateFormat:@"EEEE d 'de' MMMM 'de' yyyy"];
    NSString *NSS_date = [NSDF_date stringFromDate:_OC_order.NSD_date_start];
    [UIL_fecha setText:NSS_date];
    
    // Actualizamos UILabel del Precio
    switch (_OC_order.TOA_active)
    {
        case TOA_abierto:
        {
            [UIL_type setText:@"Abierto"];
            break;
        }
        case TOA_cerrado:
        {
            [UIL_type setText:@"Cerrado"];
            break;            
        }
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_OC_order];
}


@end
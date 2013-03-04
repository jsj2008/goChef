//
//  CustomUITableViewCellCartaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellCartaViewController.h"

#import "FoodClass.h"


@implementation CustomUITableViewCellCartaViewController

@synthesize UIL_precio;
@synthesize UIL_plato;
@synthesize UIIV_precio_background;
@synthesize UIIV_flecha;

@synthesize FC_food = _FC_food;
@synthesize B_readonly = _B_readonly;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setPC_plato
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFC_food:(FoodClass *)FC_food {
    
    _FC_food = FC_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_readonly
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_readonly:(BOOL)B_readonly {
    
    _B_readonly = B_readonly;
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
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(FoodClass *)newFC_food readOnlyMode:(BOOL)newB_readonly {
    
    // Actualizamos propiedad
    [self setFC_food:newFC_food];
    [self setB_readonly:newB_readonly];
    
    // Actualizamos el UILabel
    [UIL_plato setText:_FC_food.NSS_namefood];
    
    // Actualizamos UILabel del Precio
    NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
    [UIL_precio setText:[NSString stringWithFormat:@"%.2f%@", _FC_food.CGF_price, NSS_symbol]];
    
    // Comprobamos si es solo de consulta
    if (_B_readonly) [UIIV_flecha setAlpha:0.0f];
    else [UIIV_flecha setAlpha:1.0f];
    
    if (_FC_food.NSS_namefood.length > 25) {
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, 53.0f)];
        [UIL_plato setNumberOfLines:2];
    }

}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Comprobamos si es solo de consulta
    //if (!_B_readonly) {

        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate cellTouched:_FC_food];
    //}
}


@end
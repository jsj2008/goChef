//
//  CustomUITableViewCellPlatosViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPlatosViewController.h"

#import "DailymenufoodClass.h"


@implementation CustomUITableViewCellPlatosViewController

@synthesize UIL_number;
@synthesize UIL_plato;
@synthesize UIB_add_number;
@synthesize UIB_redo_number;
@synthesize UIIV_number_background;

@synthesize MFC_food = _MFC_food;
@synthesize B_readonly = _B_readonly;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMFC_food
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMFC_food:(DailymenufoodClass *)MFC_food {
    
    _MFC_food = MFC_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_readonly
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
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
-(void) setContentWith:(DailymenufoodClass *)newMFC_food readOnlyMode:(BOOL)newB_readonly cantidad:(NSInteger)NSI_cantidad {
    
    // Actualizamos propiedad
    [self setMFC_food:newMFC_food];
    [self setB_readonly:newB_readonly];

    // Actualizamos el UILabel
    [UIL_number setText:[NSString stringWithFormat:@"%d", NSI_cantidad]];
    [UIL_plato  setText:_MFC_food.NSS_namefood];
    
    // Comprobamos si es solo de consulta
    if (_B_readonly) {
        
        [UIIV_number_background setAlpha:0.0f];
        [UIL_number      setAlpha:0.0f];
        [UIB_add_number  setAlpha:0.0f];
        [UIB_redo_number setAlpha:0.0f];
    }
    else {
        
        [UIIV_number_background setAlpha:1.0f];
        [UIL_number      setAlpha:1.0f];
        [UIB_add_number  setAlpha:1.0f];
        [UIB_redo_number setAlpha:1.0f];
    }
    
    if (_MFC_food.NSS_namefood.length > 25) {
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, 53.0f)];
        [UIL_plato setNumberOfLines:2];
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_add_number_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_number_TouchUpInside:(id)sender {
    
    // Comprobamos si es solo de consulta
    if (!_B_readonly) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate add_numberTouched:self idCategoria:_MFC_food.NSI_idfoodcategories];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_redo_number_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_redo_number_TouchUpInside:(id)sender {
    
    // Comprobamos si es solo de consulta
    if (!_B_readonly) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate redo_numberTouched:self idCategoria:_MFC_food.NSI_idfoodcategories];
    }
}


@end
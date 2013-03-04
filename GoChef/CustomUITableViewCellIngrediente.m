//
//  CustomUITableViewCellIngrediente.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellIngrediente.h"

#import "FoodOptionClass.h"


@implementation CustomUITableViewCellIngrediente

@synthesize CUITVCPVC_cell = _CUITVCPVC_cell;

@synthesize FOC_food_option = _FOC_food_option;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCPVC_cell
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCPVC_cell:(CustomUITableViewCellIngredienteViewController *)CUITVCPVC_cell {
    
    _CUITVCPVC_cell = CUITVCPVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setPIC_ingrediente
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFOC_food_option:(FoodOptionClass *)FOC_food_option {
    
    _FOC_food_option = FOC_food_option;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithFrame
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    // Cells are transparent
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(FoodOptionClass *)newFOC_food_option active:(BOOL)B_active onlyCheck:(BOOL)B_onlyCheck {
    
    // Actualizamos propiedad
    [self setFOC_food_option:newFOC_food_option];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controler
    _CUITVCPVC_cell = [[CustomUITableViewCellIngredienteViewController alloc] initWithNibName:@"CustomUITableViewCellIngredienteView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCPVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCPVC_cell.view]; 
    
    // Iniciamos el Cell View Controler
    [_CUITVCPVC_cell setContentWith:_FOC_food_option active:B_active onlyCheck:B_onlyCheck];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWithText:price:active:
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWithText:(NSString *)NSS_text price:(CGFloat)CGF_price active:(BOOL)B_active {
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controler
    _CUITVCPVC_cell = [[CustomUITableViewCellIngredienteViewController alloc] initWithNibName:@"CustomUITableViewCellIngredienteView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCPVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCPVC_cell.view]; 
    
    // Iniciamos el Cell View Controler
    [_CUITVCPVC_cell setContentWithText:NSS_text price:CGF_price active:B_active];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(FoodOptionClass *)FOC_food_option options:(BOOL)B_options {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:FOC_food_option options:B_options];
}


@end
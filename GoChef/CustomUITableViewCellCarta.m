//
//  CustomUITableViewCellCarta.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellCarta.h"

#import "FoodClass.h"


@implementation CustomUITableViewCellCarta

@synthesize CUITVCPVC_cell = _CUITVCPVC_cell;

@synthesize FC_food = _FC_food;
@synthesize B_readonly = _B_readonly;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCPVC_cell
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCPVC_cell:(CustomUITableViewCellCartaViewController *)CUITVCPVC_cell {
 
    _CUITVCPVC_cell = CUITVCPVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setFC_food
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
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_readonly:(BOOL)B_readonly {
 
    _B_readonly = B_readonly;
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
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(FoodClass *)newFC_food readOnlyMode:(BOOL)newB_readonly {
    
    // Actualizamos propiedad
    [self setFC_food:newFC_food];
    [self setB_readonly:newB_readonly];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controler
    _CUITVCPVC_cell = [[CustomUITableViewCellCartaViewController alloc] initWithNibName:@"CustomUITableViewCellCartaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCPVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCPVC_cell.view]; 
    
    // Iniciamos el Cell View Controler
    [_CUITVCPVC_cell setContentWith:_FC_food readOnlyMode:newB_readonly];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(FoodClass *)FC_food {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:FC_food];
}

@end
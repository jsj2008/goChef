//
//  CustomUITableViewCellPlatos.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPlatos.h"

#import "DailymenufoodClass.h"


@implementation CustomUITableViewCellPlatos

@synthesize CUITVCPVC_cell = _CUITVCPVC_cell;

@synthesize MFC_food = _MFC_food;
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
-(void) setCUITVCPVC_cell:(CustomUITableViewCellPlatosViewController *)CUITVCPVC_cell {
 
    _CUITVCPVC_cell = CUITVCPVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMFC_food
//#	Fecha Creación	: 03/04/2012  (pjoramas)
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
-(void) setContentWith:(DailymenufoodClass *)newMFC_food readOnlyMode:(BOOL)newB_readonly cantidad:(NSInteger)NSI_cantidad {
    
    // Actualizamos propiedad
    [self setMFC_food:newMFC_food];
    [self setB_readonly:newB_readonly];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controler
    _CUITVCPVC_cell = [[CustomUITableViewCellPlatosViewController alloc] initWithNibName:@"CustomUITableViewCellPlatosView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCPVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCPVC_cell.view]; 
    
    // Iniciamos el Cell View Controler
    [_CUITVCPVC_cell setContentWith:_MFC_food readOnlyMode:_B_readonly cantidad:NSI_cantidad];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : add_numberTouched
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) add_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate add_numberTouched:sender idCategoria:NSI_id_categoria];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : redo_numberTouched
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) redo_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate redo_numberTouched:sender idCategoria:NSI_id_categoria];
}


@end
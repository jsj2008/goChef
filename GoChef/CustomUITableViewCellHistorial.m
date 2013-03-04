//
//  CustomUITableViewCellHistorial.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellHistorial.h"
#import "OrderClass.h"


@implementation CustomUITableViewCellHistorial

@synthesize CUITVCMAVC_cell = _CUITVCMAVC_cell;
@synthesize OC_order = _OC_order;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMAVC_cell
//#	Fecha Creación	: 08/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMAVC_cell:(CustomUITableViewCellHistorialViewController *)CUITVCMAVC_cell {
    
    _CUITVCMAVC_cell = CUITVCMAVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 08/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithFrame
//#	Fecha Creación	: 08/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/06/2012  (pjoramas)
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
//#	Fecha Creación	: 08/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controller
    _CUITVCMAVC_cell = [[CustomUITableViewCellHistorialViewController alloc] initWithNibName:@"CustomUITableViewCellHistorialView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCMAVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCMAVC_cell.view]; 
    
    // Iniciamos el Cell View Controller
    [_CUITVCMAVC_cell setContentWith:_OC_order];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 08/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(OrderClass *)OC_order {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:OC_order];
}

@end
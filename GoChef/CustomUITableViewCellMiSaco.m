//
//  CustomUITableViewCellMiSaco.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiSaco.h"
#import "UserOfferClass.h"


@implementation CustomUITableViewCellMiSaco

@synthesize CUITVCMSVC_cell = _CUITVCMSVC_cell;
@synthesize UOC_offer = _UOC_offer;
@synthesize delegate  = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMAVC_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMSVC_cell:(CustomUITableViewCellMiSacoViewController *)CUITVCMSVC_cell {
    
    _CUITVCMSVC_cell = CUITVCMSVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setUOC_offer
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUOC_offer:(UserOfferClass *)UOC_offer {
    
    _UOC_offer = UOC_offer;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithFrame
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(UserOfferClass *)newUOC_offer {
    
    // Actualizamos propiedad
    [self setUOC_offer:newUOC_offer];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controller
    _CUITVCMSVC_cell = [[CustomUITableViewCellMiSacoViewController alloc] initWithNibName:@"CustomUITableViewCellMiSacoView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCMSVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCMSVC_cell.view]; 
    
    // Iniciamos el Cell View Controller
    [_CUITVCMSVC_cell setContentWith:_UOC_offer];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(UserOfferClass *)UOC_offer {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:UOC_offer];
}

@end
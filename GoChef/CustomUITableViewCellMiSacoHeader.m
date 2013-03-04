//
//  CustomUITableViewCellMiSacoHeader.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiSacoHeader.h"


@implementation CustomUITableViewCellMiSacoHeader

@synthesize CUITVCMSH_cell = _CUITVCMSH_cell;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMAVC_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMSH_cell:(CustomUITableViewCellMiSacoHeaderViewController *)CUITVCMSH_cell {
    
    _CUITVCMSH_cell = CUITVCMSH_cell;
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
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controller
    _CUITVCMSH_cell = [[CustomUITableViewCellMiSacoHeaderViewController alloc] initWithNibName:@"CustomUITableViewCellMiSacoHeaderView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCMSH_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCMSH_cell.view]; 
    
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_ultimos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_ultimos_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_ultimos_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_cercania_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_cercania_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_cercania_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_favoritos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_favoritos_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_favoritos_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_hoy_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_hoy_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_hoy_Touched];
}

@end
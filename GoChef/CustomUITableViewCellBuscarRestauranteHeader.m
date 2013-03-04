//
//  CustomUITableViewCellBuscarRestauranteHeader.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellBuscarRestauranteHeader.h"


@implementation CustomUITableViewCellBuscarRestauranteHeader

@synthesize CUITVCMSH_cell = _CUITVCMSH_cell;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMSH_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMSH_cell:(CustomUITableViewCellBuscarRestauranteHeaderViewController *)CUITVCMSH_cell {
    
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
    _CUITVCMSH_cell = [[CustomUITableViewCellBuscarRestauranteHeaderViewController alloc] initWithNibName:@"CustomUITableViewCellBuscarRestauranteHeaderView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCMSH_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCMSH_cell.view]; 
    
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_cercania_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_cercania_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_cercania_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_ofertas_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_ofertas_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_ofertas_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_descuentos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_descuentos_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_descuentos_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_cocina_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_tipo_cocina_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_restaurantes_Touched
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_restaurantes_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_restaurantes_Touched];
}


@end
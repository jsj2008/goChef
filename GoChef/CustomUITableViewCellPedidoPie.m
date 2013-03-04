//
//  CustomUITableViewCellPedidoPie.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellPedidoPie.h"

#import "OrderClass.h"


@implementation CustomUITableViewCellPedidoPie

@synthesize CUITVCPVC_cell = _CUITVCPVC_cell;

@synthesize OC_order = _OC_order;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCPVC_cell
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCPVC_cell:(CustomUITableViewCellPedidoPieViewController *)CUITVCPVC_cell {
    
    _CUITVCPVC_cell = CUITVCPVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
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
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controler
    _CUITVCPVC_cell = [[CustomUITableViewCellPedidoPieViewController alloc] initWithNibName:@"CustomUITableViewCellPedidoPieView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCPVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCPVC_cell.view]; 
    
    // Iniciamos el Cell View Controler
    [_CUITVCPVC_cell setContentWith:_OC_order];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_mas_comida_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate pedir_mas_comida_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_oferta_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_oferta_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) enviar_pedido_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate enviar_pedido_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cancelar_pedido_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cancelar_pedido_Touched];
}


@end
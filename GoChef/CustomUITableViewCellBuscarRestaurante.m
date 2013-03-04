//
//  CustomUITableViewCellBuscarRestaurante.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellBuscarRestaurante.h"


@implementation CustomUITableViewCellBuscarRestaurante

@synthesize CUITVCBRVC_cell = _CUITVCBRVC_cell;
@synthesize RC_restaurant = _RC_restaurant;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMAVC_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCBRVC_cell:(CustomUITableViewCellBuscarRestauranteViewController *)CUITVCBRVC_cell {
    
    _CUITVCBRVC_cell = CUITVCBRVC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setRC_restaurant
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRC_restaurant:(RestaurantClass *)RC_restaurant {
    
    _RC_restaurant = RC_restaurant;
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
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(RestaurantClass *)newRC_restaurant {
    
    // Actualizamos propiedad
    [self setRC_restaurant:newRC_restaurant];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controller
    _CUITVCBRVC_cell = [[CustomUITableViewCellBuscarRestauranteViewController alloc] initWithNibName:@"CustomUITableViewCellBuscarRestauranteView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_CUITVCBRVC_cell setDelegate:self];
    
    // Add subview
    [self.contentView addSubview:_CUITVCBRVC_cell.view]; 
    
    // Iniciamos el Cell View Controller
    [_CUITVCBRVC_cell setContentWith:_RC_restaurant];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(RestaurantClass *)RC_restaurant {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:RC_restaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_mi_saco_Touched
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_saco_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    //if (_delegate != nil) [_delegate Tabbar_mi_saco_Touched];
}

@end
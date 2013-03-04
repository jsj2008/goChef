//
//  CustomUITableViewCellMore.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMore.h"
#import "CustomUITableViewCellMoreViewController.h"


@implementation CustomUITableViewCellMore

@synthesize CUITVCMAVC_cell = _CUITVCMAVC_cell;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCUITVCMAVC_cell
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setCUITVCMAVC_cell:(CustomUITableViewCellMoreViewController *)CUITVCMAVC_cell {
    
    _CUITVCMAVC_cell = CUITVCMAVC_cell;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithFrame
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    // Cells are transparent
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    // Cells are transparent
    [self setBackgroundColor:[UIColor clearColor]];
    
    // Default to no selected style and not selected
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Construimos el Cell View Controller
    _CUITVCMAVC_cell = [[CustomUITableViewCellMoreViewController alloc] initWithNibName:@"CustomUITableViewCellMoreViewController" bundle:[NSBundle mainBundle]];
    
    // Add subview
    [self.contentView addSubview:_CUITVCMAVC_cell.view];
    
    return self;
}


@end
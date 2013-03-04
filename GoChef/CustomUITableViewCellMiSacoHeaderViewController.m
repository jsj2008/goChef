//
//  CustomUITableViewCellMiSacoHeaderViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiSacoHeaderViewController.h"


@implementation CustomUITableViewCellMiSacoHeaderViewController

@synthesize UIB_ultimos;
@synthesize UIB_cercania;
@synthesize UIB_favoritos;
@synthesize UIB_hoy;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos Barra
    [UIB_ultimos   setSelected:TRUE];
    [UIB_cercania  setSelected:FALSE];
    [UIB_favoritos setSelected:FALSE];
    [UIB_hoy       setSelected:FALSE];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_ultimos_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    /*[UIB_ultimos   setSelected:TRUE];
    [UIB_cercania  setSelected:FALSE];
    [UIB_favoritos setSelected:FALSE];
    [UIB_hoy       setSelected:FALSE];*/
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_ultimos_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cercania_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    /*[UIB_ultimos   setSelected:FALSE];
    [UIB_cercania  setSelected:TRUE];
    [UIB_favoritos setSelected:FALSE];
    [UIB_hoy       setSelected:FALSE];*/
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_cercania_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_favoritos_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
   /* [UIB_ultimos   setSelected:FALSE];
    [UIB_cercania  setSelected:FALSE];
    [UIB_favoritos setSelected:TRUE];
    [UIB_hoy       setSelected:FALSE];*/
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_favoritos_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_hoy_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
   /* [UIB_ultimos   setSelected:FALSE];
    [UIB_cercania  setSelected:FALSE];
    [UIB_favoritos setSelected:FALSE];
    [UIB_hoy       setSelected:TRUE];*/
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate ordenar_hoy_Touched];
}


@end
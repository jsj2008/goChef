//
//  CustomUITableViewCellMoreViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMoreViewController.h"


@implementation CustomUITableViewCellMoreViewController

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}


@end
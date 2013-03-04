//
//  SelectMonthYearViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectMonthYearViewController.h"

#import "TarjetaClass.h"


@implementation SelectMonthYearViewController

@synthesize UIDPV_date;

@synthesize NSD_fecha = _NSD_fecha;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSD_fecha
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_fecha:(NSDate *)NSD_fecha {
    
    _NSD_fecha = NSD_fecha;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración UIDatePickerView
    [UIDPV_date setDatePickerMode:UIDatePickerModeDate];
    
    // Actualizamos fecha
    [UIDPV_date setDate:[NSDate date]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSDate *)newNSD_fecha {
    
    [self setNSD_fecha:newNSD_fecha];
    
    // Actualizamos fecha
    if (_NSD_fecha != nil) [UIDPV_date setDate:_NSD_fecha];
    else [UIDPV_date setDate:[NSDate date]];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_fecha_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_fecha:UIDPV_date.date];
}


@end
//
//  SelectFechaHoraViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectFechaHoraViewController.h"

#import "TarjetaClass.h"


@implementation SelectFechaHoraViewController

@synthesize UIDPV_date;

@synthesize NSD_fecha = _NSD_fecha;
@synthesize NSS_maxHour = _NSS_maxHour;
@synthesize NSS_minHour = _NSS_minHour;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSD_fecha
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_fecha:(NSDate *)NSD_fecha {
    
    _NSD_fecha = NSD_fecha;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* compoNents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHH:mm"];
    
    // Configuración UIDatePickerView
    [UIDPV_date setDatePickerMode:UIDatePickerModeDateAndTime];

    [UIDPV_date setMinimumDate:[format dateFromString:[NSString stringWithFormat:@"%d%02d%02d%@",[compoNents year],[compoNents month],[compoNents day],self.NSS_minHour]]];
    
    [UIDPV_date setMinuteInterval:15];
    
    // Actualizamos fecha
    [UIDPV_date setDate:[NSDate date]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSDate *)newNSD_fecha {
    
    [self setNSD_fecha:newNSD_fecha];
    
    // Actualizamos fecha
    [UIDPV_date setDate:_NSD_fecha];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_fecha_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_fecha:UIDPV_date.date];
}


@end
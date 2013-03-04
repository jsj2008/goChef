//
//  SelectTarjetaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectTarjetaViewController.h"
#import "LoadingViewController.h"

#import "TarjetaClass.h"
#import "UserClass.h"


@implementation SelectTarjetaViewController

@synthesize UIPV_listado;

@synthesize NSS_tarjeta = _NSS_tarjeta;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_tarjeta
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_tarjeta:(NSString *)NSS_tarjeta {
    
    _NSS_tarjeta = NSS_tarjeta;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración de delegados
	UIPV_listado.delegate   = self;
	UIPV_listado.dataSource = self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    int iPos = 0;
    
    // Buscamos Tarjeta seleccionada
    for (TarjetaClass *TC_tarjeta in globalVar.NSMA_tarjetas) {
        
        NSString *NSS_texto = [globalVar formatTarjetaNumber:TC_tarjeta];
        
        if ([NSS_texto isEqualToString:_NSS_tarjeta]) {
            
            [UIPV_listado selectRow:iPos inComponent:0 animated:YES];
            break;
        }
        
        iPos += 1;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSString *)newNSS_tarjeta {
    
    [self setNSS_tarjeta:newNSS_tarjeta];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_tarjeta_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_tarjeta];
}

#pragma mark -
#pragma mark UIPickerView Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfComponentsInPickerView
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:didSelectRow:inComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    TarjetaClass *TC_tarjeta = [globalVar.NSMA_tarjetas objectAtIndex:row];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_tarjeta:TC_tarjeta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [globalVar.NSMA_tarjetas count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    TarjetaClass *TC_tarjeta = [globalVar.NSMA_tarjetas objectAtIndex:row];
    
    return [globalVar formatTarjetaNumber:TC_tarjeta];
}

@end
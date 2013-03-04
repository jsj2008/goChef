//
//  SelectDireccionViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectDireccionViewController.h"
#import "LoadingViewController.h"

#import "DireccionClass.h"
#import "JSONparseClass.h"


@implementation SelectDireccionViewController

@synthesize UIPV_listado;

@synthesize NSS_direccion = _NSS_direccion;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_direccion
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_direccion:(NSString *)NSS_direccion {
    
    _NSS_direccion = NSS_direccion;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración de delegados
	UIPV_listado.delegate   = self;
	UIPV_listado.dataSource = self;
    
    // Comprobamos si debemos cargar las Direcciones
    if ([globalVar.NSMA_direcciones count] == 1) [self loadDirecciones];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    int iPos = 0;
    BOOL B_encontrado = FALSE;
    
    // Buscamos dirección seleccionada
    for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones) {
        
        if ([DC_direccion.NSS_etiqueta isEqualToString:_NSS_direccion]) {
            
            [UIPV_listado selectRow:iPos inComponent:0 animated:YES];
            B_encontrado = TRUE;
        }
        
        iPos += 1;
    }
    
    // Comprobamo si se encontró
    if (!B_encontrado) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate select_direccion:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSString *)newNSS_direccion {
    
    [self setNSS_direccion:newNSS_direccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDirecciones {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DIRECCIONES_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DIRECCIONES_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DIRECCIONES_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadDireccionesSuccessful:) 
                                                 name: _NOTIFICATION_DIRECCIONES_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_DIRECCIONES_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_DIRECCIONES_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadDirecciones];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDireccionesSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDireccionesSuccessful:(NSNotification *)notification {
    
    // Actualizsmos el listado de Tipos de cocina
    [UIPV_listado reloadAllComponents];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tipo_cocina_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_direccion_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_direccion];
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
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    DireccionClass *DC_direccion = [globalVar.NSMA_direcciones objectAtIndex:row];
    
    [self setNSS_direccion:DC_direccion.NSS_etiqueta];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_direccion:_NSS_direccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [globalVar.NSMA_direcciones count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    DireccionClass *DC_direccion = [globalVar.NSMA_direcciones objectAtIndex:row];
    
    return DC_direccion.NSS_etiqueta;
}

@end
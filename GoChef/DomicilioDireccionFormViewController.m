//
//  DomicilioDireccionFormViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DomicilioDireccionFormViewController.h"
#import "LoadingViewController.h"

#import "DireccionClass.h"
#import "CoreLocationClass.h"
#import "JSONparseClass.h"
#import "OrderClass.h"
#import "UserClass.h"


@implementation DomicilioDireccionFormViewController

@synthesize UITF_telefono;
@synthesize UITF_direccion;
@synthesize UITF_numero;
@synthesize UITF_piso;
@synthesize UITF_letra;
@synthesize UITF_portal;
@synthesize UITF_escalera;
@synthesize UITF_cp;
@synthesize UITF_ciudad;
@synthesize UITF_etiqueta;
@synthesize UIV_formulairo;

@synthesize B_new_address = _B_new_address;
@synthesize DC_direccion  = _DC_direccion;


#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_new_address
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_new_address:(BOOL)B_new_address {
    
    _B_new_address = B_new_address;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setDC_direccion
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDC_direccion:(DireccionClass *)DC_direccion {
    
    _DC_direccion = DC_direccion;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos propiedades
    [self setDC_direccion:globalVar.OC_order.DC_useraddress];
    
    // Insertamos UIView formulario en la View general
    [self.view addSubview:UIV_formulairo];
    
    // Posisiocnamos loa UIView Formulario
    [UIV_formulairo setFrame:CGRectMake(0.0f, 0.0f, UIV_formulairo.frame.size.width, UIV_formulairo.frame.size.height)];
    
    // Iniciamos el formulario
    [self initFormulario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Alta Dirección";
    
    // Mostramos el teclado
    [UITF_telefono becomeFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
    [UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_leftContainer addSubview:UIB_back];
    
    // Adaptamos tamaño de la UIView
    [UIV_leftContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 32.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_leftItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_leftContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.leftBarButtonItem = UIBBI_leftItems;
    [self.navigationItem hidesBackButton];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initFormulario
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initFormulario {
    
    // Comprobamos si es un nuevo registro
    if (_B_new_address) {
        
        // Actualizamos todos los campos del formulario
        [UITF_telefono  setText: @""];
        [UITF_direccion setText: @""];
        [UITF_numero    setText: @""];
        [UITF_piso      setText: @""];
        [UITF_letra     setText: @""];
        [UITF_portal    setText: @""];
        [UITF_escalera  setText: @""];
        [UITF_cp        setText: @""];
        [UITF_ciudad    setText: @""];
        [UITF_etiqueta  setText: @""];
        
        // Indicamos que es una modificación
        [self setDC_direccion:nil];
        
        // Comprobamos si el usuario está registrado
        if (globalVar.B_usuario_registrado) {
            
            // Comprobamos si tiene un teléfono asociado
            if (globalVar.UC_user.NSI_phone > 1000) {
                
                // Actualizamos propiedad que indica que el usuario no necesita actualizarse
                [globalVar setB_guardar_usuario:FALSE];
                
                // Insertamos el teléofno aosiciado a la cuenta 
                [UITF_telefono setText:[NSString stringWithFormat:@"%d", globalVar.UC_user.NSI_phone]];
            }
            else {
                
                // Actualizamos propiedad que indica que el usuario debe actualizarse
                [globalVar setB_guardar_usuario:TRUE];
                
                // Buscamos en todas las direcciones del usuario si existen algún teléfono
                for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones)
                    if ([DC_direccion.NSS_telefono length] > 5)
                        [UITF_telefono setText:DC_direccion.NSS_telefono];
            }
        }
    }
    else {
        
        // Comprobamos si se ha seleccionado la localización actual
        if (globalVar.OC_order.DC_useraddress.NSI_id == _ID_DIRECCION_LOCALIZACION_ACTUAL_) {
            
            // Esperamos antes de ir al menú de la aplicación
            NSTimer *NST_timer;
            NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                         target:self
                                                       selector:@selector(delayGetGoogleMapAddress)
                                                       userInfo:nil
                                                        repeats:NO];
        }
        else if (globalVar.OC_order.DC_useraddress.NSI_id != _ID_ADDRESS_NO_SELECTED_) { 
            
            // Indicamos que es una modificación
            [self setDC_direccion:globalVar.OC_order.DC_useraddress];
            
            // Actualizamos formulario
            [self updateFormularioWith:_DC_direccion google:FALSE];
        }
        else {
            
            // Indicamos que es una modificación
            [self setDC_direccion:nil];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayGetGoogleMapAddress
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayGetGoogleMapAddress {
    
    // Realizamos llamada ael Google Map
    [self getGoogleMapAddress];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateFormularioWith
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateFormularioWith:(DireccionClass *)DC_direccion google:(BOOL)B_google {
    
    // Actualizamos todos los campos del formulario
    [UITF_telefono  setText: _DC_direccion.NSS_telefono];
    [UITF_direccion setText: _DC_direccion.NSS_direccion];
    [UITF_numero    setText: _DC_direccion.NSS_numero];
    [UITF_piso      setText: _DC_direccion.NSS_piso];
    [UITF_letra     setText: _DC_direccion.NSS_letra];
    [UITF_portal    setText: _DC_direccion.NSS_portal];
    [UITF_escalera  setText: _DC_direccion.NSS_escalera];
    [UITF_cp        setText: _DC_direccion.NSS_cp];
    [UITF_ciudad    setText: _DC_direccion.NSS_ciudad];
    [UITF_etiqueta  setText: _DC_direccion.NSS_etiqueta];
    
    // Comprobamos si la direccion se ha sacado del GoogleMap
    if (B_google) {
        
        // Comprobamos si el usuario está registrado
        if (globalVar.B_usuario_registrado) {
            
            // Comprobamos si tiene un teléfono asociado
            if (globalVar.UC_user.NSI_phone > 1000) {
                
                // Actualizamos propiedad que indica que el usuario no necesita actualizarse
                [globalVar setB_guardar_usuario:FALSE];
                
                // Insertamos el teléofno aosiciado a la cuenta
                [UITF_telefono setText:[NSString stringWithFormat:@"%d", globalVar.UC_user.NSI_phone]];
            }
            else {
                
                // Actualizamos propiedad que indica que el usuario debe actualizarse
                [globalVar setB_guardar_usuario:TRUE];
                
                // Buscamos en todas las direcciones del usuario si existen algún teléfono
                for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones)
                    if ([DC_direccion.NSS_telefono length] > 5)
                        [UITF_telefono setText:DC_direccion.NSS_telefono];
            }
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getGoogleMapAddress
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getGoogleMapAddress {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GOOGLE_ADDRESS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GOOGLE_ADDRESS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GOOGLE_ADDRESS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(getGoogleMapAddressSuccessful:) 
                                                 name: _NOTIFICATION_GOOGLE_ADDRESS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_GOOGLE_ADDRESS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_GOOGLE_ADDRESS_ERROR_
                                               object: nil];
    
    // Desplazamos LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, globalVar.LVC_loading.view.frame.origin.y-80.0f, globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading getGoogleMapAddress];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getGoogleMapAddressSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getGoogleMapAddressSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setDC_direccion:globalVar.OC_order.DC_useraddress];
    
    // Actualizamos formulario
    [self updateFormularioWith:_DC_direccion google:TRUE];
    
    // Desplazamos LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, globalVar.LVC_loading.view.frame.origin.y+80.0f, globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
    
    // Desplazamos LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, globalVar.LVC_loading.view.frame.origin.y+80.0f, globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
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
    
    // Desplazamos LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, globalVar.LVC_loading.view.frame.origin.y+80.0f, globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_guardar_direccion_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_guardar_direccion_TouchUpInside:(id)sender {
    
    // Comprbamos si se ha introducido un teléfono
    if ([UITF_telefono.text length] < 9) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un número de teléfono válido."];
        return;
    }
    
    // Comprbamos si se ha introducido un teléfono
    if ([UITF_direccion.text length] < 4) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir la calle."];
        return;
    }
    
    // Comprbamos si se ha introducido un teléfono
    if ([UITF_numero.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir el número."];
        return;
    }
    
    // Comprbamos si se ha introducido un teléfono
    if ([UITF_cp.text length] < 4) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir el código postal."];
        return;
    }
    
    // Comprbamos si se ha introducido un teléfono
    if ([UITF_ciudad.text length] < 4) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir la ciudad."];
        return;
    }
    
    // Comprbamos si se ha introducido la etiqueta
    if ([UITF_etiqueta.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir una etiqueta."];
        return;
    }
    
    // Comprobamos que la etiqueta no sea una de las predefinidas
    if ([UITF_etiqueta.text isEqualToString:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_]) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"La etiqueta debe ser diferente de '%@'", _COMBO_DIRECCION_LOCALIZACION_ACTUAL_]];
        return;
    }
    
    // Creamos la DirecionClass
    if (_DC_direccion == nil) {
        
        // Inicimos el DireccionClass
        _DC_direccion = [[DireccionClass alloc] init];
        
    } /*else {
        

        
        // Comprobamos si es la localización actual
        if (_DC_direccion.NSI_id == _ID_DIRECCION_NEW_LOCALIZACION_ACTUAL_)
            [globalVar.NSMA_direcciones addObject:_DC_direccion];
        
        // Actualizamos la BB.DD del servidor
        [globalVar setNSI_last_Id_DDBB:_DC_direccion.NSI_id];
    }*/
    
    // Actualizamos propiedades
    [_DC_direccion setNSS_telefono   : UITF_telefono.text];
    [_DC_direccion setNSS_direccion  : UITF_direccion.text];
    [_DC_direccion setNSS_numero     : UITF_numero.text];
    [_DC_direccion setNSS_piso       : UITF_piso.text];
    [_DC_direccion setNSS_letra      : UITF_letra.text];
    [_DC_direccion setNSS_portal     : UITF_portal.text];
    [_DC_direccion setNSS_escalera   : UITF_escalera.text];
    [_DC_direccion setNSS_cp         : UITF_cp.text];
    [_DC_direccion setNSS_ciudad     : UITF_ciudad.text];
    [_DC_direccion setNSS_etiqueta   : UITF_etiqueta.text];
    
    NSLog(@"_DC_direccion.NSI_id %d ",_DC_direccion.NSI_id);
    // Insertamos Dirección en el Array
    BOOL inArray = false;
    
    for (DireccionClass *dClass in globalVar.NSMA_direcciones) {
        if (dClass == _DC_direccion) {
            inArray = TRUE;
            break;
        }
    }
    if (!inArray) {
        [globalVar.NSMA_direcciones addObject:_DC_direccion];
    }
    
    if (_DC_direccion.NSI_id == -1) {
        [globalVar setNSI_last_Id_DDBB:_ID_NEW_ADDRESS_];
    } else {
        [globalVar setNSI_last_Id_DDBB:_DC_direccion.NSI_id];
    }

    // Actualizamos el id de la dirección
    [_DC_direccion setNSI_id:globalVar.NSI_last_Id_DDBB];
    
    // Inidicamos que es la dirección activa
    [globalVar.OC_order setDC_useraddress:_DC_direccion];
    
    [globalVar.LVC_loading setDireccion];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

@end
//
//  MiCuentaCondicionesLegalesViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiCuentaCondicionesLegalesViewController.h"
#import "LoadingViewController.h"

#import "MensajeClass.h"
#import "CoreDataClass.h"


@implementation MiCuentaCondicionesLegalesViewController

@synthesize B_checked = _B_checked;

@synthesize UIB_check_condiciones_legales;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_checked
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_checked:(BOOL)B_checked {
    
    _B_checked = B_checked;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Crear Cuenta";
    
    // Iniciamos propiedades
    [self setB_checked:FALSE];
    
    // Iniciamos UIIButton
    UIImage *UII_check = [UIImage imageNamed:@"mi_cuenta_checkbox_off.png"];
    [UIB_check_condiciones_legales setImage:UII_check forState:UIControlStateNormal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
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
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Actualizamos propiedad
    [globalVar setB_come_from_condiciones_legales:TRUE];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : registrarUsuario
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) registrarUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_SUCCESSFUL_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_NO_INTERNET_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_ERROR_         object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(registrarUsuarioSuccessful:) 
                                                 name: _NOTIFICATION_SET_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_USER_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading setUser];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : registrarUsuarioSuccessful
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) registrarUsuarioSuccessful:(NSNotification *)notification {
    
    // Insertamos User Id en la BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
        
    // Mostramos mensaje de operación exitosa
    [globalVar showAlerMsgWith:_ALERT_TITLE_REGISTRO_USER_ message:_ALERT_MSG_REGISTRO_USER_];
    
    // Comprobamos si estamos en options
    if (globalVar.B_options) {
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
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
//#	Procedimiento   : UIB_check_condiciones_legales_TouchUpInside
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_check_TouchUpInside:(id)sender {
 
    // Comprobamos el estado actual
    if (_B_checked) {
        
        // Iniciamos propiedades
        [self setB_checked:FALSE];
        
        // Iniciamos UIIButton
        UIImage *UII_check = [UIImage imageNamed:@"mi_cuenta_checkbox_off.png"];
        [UIB_check_condiciones_legales setImage:UII_check forState:UIControlStateNormal];
    }
    else {
        
        // Iniciamos propiedades
        [self setB_checked:TRUE];
        
        // Iniciamos UIIButton
        UIImage *UII_check = [UIImage imageNamed:@"mi_cuenta_checkbox_on.png"];
        [UIB_check_condiciones_legales setImage:UII_check forState:UIControlStateNormal];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_read_condiciones_legales_TouchUpInside
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_registrar_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha checked las condiciones legales
    if (!_B_checked) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe leer y aceptar las Condiciones Legales."];
        return;
    }
    
    // Registramos al usuario
    [self registrarUsuario];
}


@end
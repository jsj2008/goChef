//
//  MiCuentaLoginViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiCuentaLoginViewController.h"
#import "LoadingViewController.h"

#import "UserClass.h"
#import "CoreDataClass.h"
#import "OrderClass.h"


@implementation MiCuentaLoginViewController

@synthesize UITF_correo_login;
@synthesize UITF_correo_recordar;
@synthesize UITF_password;
@synthesize UIV_login;
@synthesize UIV_recordar;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Insertamos las UIView
    [self.view addSubview:UIV_login];
    [self.view addSubview:UIV_recordar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Login";
    
    // Posicionamos las UIView
    [UIV_login    setFrame:CGRectMake(0.0f, 20.0f, UIV_login.frame.size.width, UIV_login.frame.size.height)];
    [UIV_recordar setFrame:CGRectMake(320.0f, 40.0f, UIV_recordar.frame.size.width, UIV_recordar.frame.size.height)];
     
    // Mostramos el teclado
    [UITF_correo_login becomeFirstResponder];
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
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
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
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showRecordar
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showRecordar {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_UIVIEW_DIRECCION_DURATION_];
    
    // Reposicionamos los View
    [UIV_login    setFrame:CGRectMake(-320.0f, 20.0f, UIV_login.frame.size.width, UIV_login.frame.size.height)];
    [UIV_recordar setFrame:CGRectMake(0.0f, 40.0f, UIV_recordar.frame.size.width, UIV_recordar.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideRecordar
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideRecordar {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_UIVIEW_DIRECCION_DURATION_];
    
    // Reposicionamos los View
    [UIV_login    setFrame:CGRectMake(0.0f, 20.0f, UIV_login.frame.size.width, UIV_login.frame.size.height)];
    [UIV_recordar setFrame:CGRectMake(320.0f, 40.0f, UIV_recordar.frame.size.width, UIV_recordar.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuario
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_ERROR_       object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_NO_VALID_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_BANEADO_     object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loginUsuarioSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loginUsuarioError:) 
                                                 name: _NOTIFICATION_VALIDATE_USER_NO_VALID_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loginUsuarioBaneado:)
                                                 name: _NOTIFICATION_VALIDATE_USER_BANEADO_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_VALIDATE_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_USER_ERROR_
                                               object: nil];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading loginUser];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : recordarPassword
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recordarPassword {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMEMBER_PASSWORD_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMEMBER_PASSWORD_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMEMBER_PASSWORD_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(recordarPasswordSuccessful:) 
                                                 name: _NOTIFICATION_REMEMBER_PASSWORD_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_REMEMBER_PASSWORD_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_REMEMBER_PASSWORD_ERROR_
                                               object: nil];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading recordarPassword];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuario
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadUserSuccessful:) 
                                                 name: _NOTIFICATION_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_USER_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadUsuario];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUserSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUserSuccessful:(NSNotification *)notification {
    
    // Iniciamos que se ha cargado un usuario
    [globalVar setB_usuario_registrado:TRUE];
    
    // Insertamos User Id en la BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Comprobamos si estamos realizando un pedido
    if (globalVar.B_realizando_pedido) {
        
        // Comprobamos el tipo de pedido
        if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Indicamos al delegado que se ha pulsado sobre la celda
            if (_delegate != nil) [_delegate Tabbar_rst_pedir_Touched];
        }
        else if (globalVar.B_login_from_reserva) {
            
            // Indicamos al delegado que se ha pulsado sobre la celda
            if (_delegate != nil) [_delegate Tabbar_reserva_Touched];
        }
        else {
            
            // Indicamos al delegado que se ha pulsado sobre la celda
            if (_delegate != nil) [_delegate Tabbar_dom_mi_pedido_Touched];
        }
    }
    else {
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUsuarioSuccessful:(NSNotification *)notification {
    
    // Cargamos los datos del usuario
    [self loadUsuario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recordarPasswordSuccessful:(NSNotification *)notification {

    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:@"Información" 
                       message:@"Le enviaremos la nueva clave a su dirección de correo."];
    
    // Actualizamos UITextFields
    [UITF_correo_login setText:UITF_correo_recordar.text];
    [UITF_password setText:@""];
    [UITF_password becomeFirstResponder];
    
    // Volvemos ventana login
    [self hideRecordar];
     
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioError
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUsuarioError:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioBaneado
//#	Fecha Creación	: 19/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioBaneado:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_login_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_login_TouchUpInside:(id)sender{
    
    // Comprobamos si se ha introducido el correo
    if ([UITF_correo_login.text length] < 5) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un correo válido"];
        return;
    }
    
    // Comprobamos si se ha introducido el password
    if ([UITF_password.text length] < 3) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un password válido"];
        return;
    }
    
    // Creamos el UserClass
    globalVar.UC_user = [[UserClass alloc] init];
    
    // Actualizasmos propiedades
    [globalVar.UC_user setNSS_email   :UITF_correo_login.text];
    [globalVar.UC_user setNSS_password:UITF_password.text];
    
    // Registramos el usuario en el servidor
    [self loginUsuario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_show_recordar_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_show_recordar_TouchUpInside:(id)sender {
    
    // Mostramos el formualrio de recordar contraseña
    [self showRecordar];
    
    // Posicionamos cursosr sobre UITextField
    [UITF_correo_recordar becomeFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_recordar_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_recordar_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha introducido el correo
    if ([UITF_correo_recordar.text length] < 5) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un correo válido"];
        return;
    }
    
    // Creamos el UserClass
    globalVar.UC_user = [[UserClass alloc] init];
    
    // Actualizasmos propiedades
    [globalVar.UC_user setNSS_email:UITF_correo_recordar.text];
    
    // Registramos el usuario en el servidor
    [self recordarPassword];
}

#pragma mark -
#pragma mark UITextField Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : textFieldShouldReturn
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    // Ocultamos Keyboard
    [textField resignFirstResponder];
    return NO;
}


@end
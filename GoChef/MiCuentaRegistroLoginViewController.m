//
//  MiCuentaRegistroLoginViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiCuentaRegistroLoginViewController.h"
#import "LoadingViewController.h"

#import "UIScrollViewWithTouchEvent.h"
#import "UserClass.h"
#import "CoreDataClass.h"
#import "FacebookClass.h"


@implementation MiCuentaRegistroLoginViewController

@synthesize UITF_nombre;
@synthesize UITF_apellidos;
@synthesize UITF_correo;
@synthesize UITF_telefono;
@synthesize UITF_password;
@synthesize UIV_contenido;
@synthesize UISV_scroll;

@synthesize B_teclado_visible = _B_teclado_visible;
@synthesize B_registro_facebook = _B_registro_facebook;

@synthesize MCLVC_login = _MCLVC_login;
@synthesize MCCLVC_condiciones_legales = _MCCLVC_condiciones_legales;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setMCCLVC_condiciones_legales
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCCLVC_condiciones_legales:(MiCuentaCondicionesLegalesViewController *)MCCLVC_condiciones_legales {
   
    _MCCLVC_condiciones_legales = MCCLVC_condiciones_legales; 
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_registro_facebook
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_registro_facebook:(BOOL)B_registro_facebook {
    
    _B_registro_facebook = B_registro_facebook;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_teclado_visible
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_teclado_visible:(BOOL)B_teclado_visible {
    
    _B_teclado_visible = B_teclado_visible;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setMCLVC_login
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCLVC_login:(MiCuentaLoginViewController *)MCLVC_login {
    
    _MCLVC_login = MCLVC_login;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos propiedad
    [self setB_teclado_visible:FALSE];
    
    // Actualizamos propiedad
    [globalVar setB_come_from_condiciones_legales:FALSE];
    
    // Insertamos UIView en el UISCrollView
    [UISV_scroll addSubview:UIV_contenido];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Actualizamoz propiedad
    [globalVar setB_registro_facebook:FALSE];
    
    // Comprobamos si se viene de la ventana de Condicionles Legales
    if (globalVar.B_come_from_condiciones_legales) {
    
        // Actualizamos propiedad
        [globalVar setB_come_from_condiciones_legales:FALSE];
        return;
    }
    

    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Login / Registro";
    
    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    // Inicimos componente formulario
    [UITF_nombre    setText:@""];
    [UITF_apellidos setText:@""];
    [UITF_correo    setText:@""];
    [UITF_telefono  setText:@""];
    [UITF_password  setText:@""];
    
    // Ocultamos teclado
    [UITF_nombre    resignFirstResponder];
    [UITF_apellidos resignFirstResponder];
    [UITF_correo    resignFirstResponder];
    [UITF_telefono  resignFirstResponder];
    [UITF_password  resignFirstResponder];
    
    // Posicionamos UIScollView
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, self.view.frame.size.height)];
    [UISV_scroll setContentSize:CGSizeMake(UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Comprobamo si debemos retroceder hasta el padre
    if (globalVar.B_usuario_registrado) {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_BACK_NAVBAR_
                                                     target:self
                                                   selector:@selector(backPrevieViewController)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Actualizamoz propiedad
    [globalVar setB_registro_facebook:FALSE];
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    
    // Comprobamos si se está relizando un pedido
    if (!globalVar.B_realizando_pedido) {

        [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
        [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
        [UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
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
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Actualizamoz propiedad
    [globalVar setB_registro_facebook:FALSE];
    
    // Comprobamos si se está relizando un pedido
    if (globalVar.B_realizando_pedido) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_dom_mi_pedido_Touched];
    }
    else {
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                            object:self];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: backPrevieViewController
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) backPrevieViewController {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkFormulario
//#	Fecha Creación	: 22/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		:
//#
-(BOOL) checkFormulario {
    
    // Comprobamos si se ha introducido el nombre
    if ([UITF_nombre.text length] < 3) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un nombre válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido el nombre
    if ([UITF_nombre.text length] > _MAX_FORM_SIZE_NOMBRE_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo del nombre (%d caracteres).", _MAX_FORM_SIZE_NOMBRE_]];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_apellidos.text length] < 3) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir unos apellidos válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_apellidos.text length] > _MAX_FORM_SIZE_APELLIDOS_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo de los apellidos (%d caracteres).", _MAX_FORM_SIZE_APELLIDOS_]];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido el correo
    if ([UITF_correo.text length] < 5) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un correo válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_correo.text length] > _MAX_FORM_SIZE_CORREO_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo del correo (%d caracteres).", _MAX_FORM_SIZE_CORREO_]];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido un correo válido
    if (![globalVar checkEmailFormat:UITF_correo.text]) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un correo válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido el telefono
    if ([UITF_telefono.text length] < 9) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un teléfono válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_telefono.text length] > _MAX_FORM_SIZE_TELEFONO_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo del teléfono (%d caracteres).", _MAX_FORM_SIZE_TELEFONO_]];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido el password
    if ([UITF_password.text length] < 3) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un password válido"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_password.text length] > _MAX_FORM_SIZE_CLAVE_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo del password (%d caracteres).", _MAX_FORM_SIZE_CLAVE_]];
        return FALSE;
    }
    
    return TRUE;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : validarEmail
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) validarEmail {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_SUCCESSFUL_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_NO_INTERNET_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_ERROR_         object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_EXISTE_KO_     object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_EXISTE_OK_     object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_BANEADO_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(validarEmailSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_EMAIL_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(validarEmailExiste:) 
                                                 name: _NOTIFICATION_VALIDATE_EMAIL_EXISTE_KO_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(validarEmailExisteLogin:) 
                                                 name: _NOTIFICATION_VALIDATE_EMAIL_EXISTE_OK_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(validarEmailBaneado:)
                                                 name: _NOTIFICATION_VALIDATE_EMAIL_BANEADO_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_VALIDATE_EMAIL_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_USER_ERROR_
                                               object: nil];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading comprobarCorreo];
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
    
    // Cargamos los datos
    [globalVar.LVC_loading loginUser];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeUserToFacebook
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeUserToFacebook:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setB_registro_facebook:TRUE];
    
    // Actualizamos propiedades
    [globalVar.UC_user setNSI_phone     :000000000];
    [globalVar.UC_user setNSS_password  :_USER_FACEBOOK_PASSWORD_];
    [globalVar.UC_user setTRT_type      :TRT_facebook];
    
    // Comprobamos si el email existe
    [self validarEmail];
    
    // Actualizamoz propiedad
    [globalVar setB_registro_facebook:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeUserToFacebook
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUsuarioSuccessful:(NSNotification *)notification {
    
    // Insertamos User Id en la BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    [globalVar.CDC_coreData getCreaditCardsWithUserId:globalVar.UC_user.NSI_id];

    // Comprobamos si estamos en options
    if (globalVar.B_options) {
        
        // Volvemos Viewcontroller padre
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    }
    else {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
    }
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
//#	Procedimiento   : validarEmailSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) validarEmailSuccessful:(NSNotification *)notification {
    
    // Comprobamos de donde viene
    if (_B_registro_facebook) {

        // Actualizamos propiedades
        [globalVar.UC_user setNSI_phone    :000000000];
        [globalVar.UC_user setNSS_password :_USER_FACEBOOK_PASSWORD_];
        [globalVar.UC_user setTRT_type     :TRT_facebook];
    }
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Creamos View Controller
    _MCCLVC_condiciones_legales = [[MiCuentaCondicionesLegalesViewController alloc] initWithNibName:@"MiCuentaCondicionesLegalesView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_MCCLVC_condiciones_legales setDelegate:self];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCCLVC_condiciones_legales animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : validarEmailExiste
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) validarEmailExiste:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:@"Error" 
                       message:[NSString stringWithFormat:@"Ya existe un usuario registrado con el email %@", globalVar.UC_user.NSS_email]];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : validarEmailExisteLogin
//#	Fecha Creación	: 14/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) validarEmailExisteLogin:(NSNotification *)notification {
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Insertamos User Id en la BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    [globalVar.CDC_coreData getCreaditCardsWithUserId:globalVar.UC_user.NSI_id];
    
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
//#	Procedimiento   : validarEmailBaneado
//#	Fecha Creación	: 19/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) validarEmailBaneado {
    
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
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

#pragma mark -
#pragma mark Keyboard Notifications Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidShow
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    // Comprobamos si el teclado esta ya visible
    if (_B_teclado_visible) return;
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    
    // Posicionamos UIVew
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, (UISV_scroll.frame.size.height-210.0f))];
    
    // Ajecutamos animación
    [UIView commitAnimations];
    
    // Actualizamos propiedad
    [self setB_teclado_visible:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidHide:(NSNotification *) notification {
    
    // Comprobamos si el teclado esta ya oculto
    if (!_B_teclado_visible) return;
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    
    // Posicionamos UIVew
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, (UISV_scroll.frame.size.height+210.0f))];
    
    // Ajecutamos animación
    [UIView commitAnimations];
    
    // Actualizamos propiedad
    [self setB_teclado_visible:FALSE];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_continuar_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(IBAction) UIB_continuar_TouchUpInside:(id)sender {

    // Comprobamos si los datos del formulario son correctos
    if (![self checkFormulario]) return;

    // Borramos todas las tarjetas
    //[globalVar.CDC_coreData removeAllCreaditCard];

    
    // Creamos el UserClass
    globalVar.UC_user = [[UserClass alloc] init];
    
    // Actualizasmos propiedades
    [globalVar.UC_user setNSS_name      :UITF_nombre.text];
    [globalVar.UC_user setNSS_lastname  :UITF_apellidos.text];
    [globalVar.UC_user setNSS_email     :UITF_correo.text];
    [globalVar.UC_user setNSI_phone     :[UITF_telefono.text integerValue]];
    [globalVar.UC_user setNSS_password  :UITF_password.text];
    [globalVar.UC_user setTRT_type      :TRT_normal];
    
    // Actulizamos propiedad
    [self setB_registro_facebook:FALSE];
    
    // Registramos el usuario en el servidor
    [self validarEmail];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_iniciar_sesion_facebook_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(IBAction) UIB_iniciar_sesion_facebook_TouchUpInside:(id)sender {
    
    // Borramos todas las tarjetas
    //[globalVar.CDC_coreData removeAllCreaditCard];
    
    
    // Actualizamoz propiedad
    [globalVar setB_registro_facebook:TRUE];
    
    // Realizamos el login en Facebook si corresponde
    [globalVar.FC_facebook loginFacebook];
    
    // Creamos NSNotificationCenter que indica que se ha recuperado el email del usuario
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(changeUserToFacebook:) 
                                                 name: _NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_
                                               object: nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_iniciar_sesion_GoChef_TouchUpInside
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_iniciar_sesion_GoChef_TouchUpInside:(id)sender {
    
    // Borramos todas las tarjetas
    //[globalVar.CDC_coreData removeAllCreaditCard];
    
    // Creamos View Controller
    _MCLVC_login = [[MiCuentaLoginViewController alloc] initWithNibName:@"MiCuentaLoginView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_MCLVC_login setDelegate:self];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCLVC_login animated:YES];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_registro_TouchUpInside
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_dom_mi_pedido_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_dom_mi_pedido_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_cuenta_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_rst_pedir_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_rst_pedir_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_rst_pedir_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_reserva_Touched
//#	Fecha Creación	: 26/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_reserva_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_reserva_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_settings_Touched
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_settings_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_settings_Touched];
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
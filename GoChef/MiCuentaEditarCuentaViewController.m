//
//  MiCuentaEditarCuentaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiCuentaEditarCuentaViewController.h"
#import "LoadingViewController.h"

#import "UserClass.h"
#import "CoreDataClass.h"
#import "OrderClass.h"


@implementation MiCuentaEditarCuentaViewController

@synthesize UITF_nombre;
@synthesize UITF_apellidos;
@synthesize UITF_correo;
@synthesize UITF_ciudad;
@synthesize UITF_telefono;
@synthesize UITF_password01;
@synthesize UITF_password02;
@synthesize UIL_sexo;
@synthesize UIL_fecha_nacimiento;
@synthesize UIV_contenido;
@synthesize UISV_scroll;

@synthesize NSD_fecha_nacimiento = _NSD_fecha_nacimiento;
@synthesize TST_sexo = _TST_sexo;
@synthesize B_teclado_visible = _B_teclado_visible;

@synthesize SSVC_sexo = _SSVC_sexo;
@synthesize SFVC_fecha_nacimiento = _SFVC_fecha_nacimiento;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setTST_sexo
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTST_sexo:(typeSexoType)TST_sexo {
    
    _TST_sexo = TST_sexo;
    
    // Actualizamos UILabel
    if      (_TST_sexo == TST_hombre) [UIL_sexo setText:_COMBO_SEXO_HOMBRE_];
    else if (_TST_sexo == TST_mujer)  [UIL_sexo setText:_COMBO_SEXO_MUJER_];
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
//#	Propiedad   	: setNSD_fecha_nacimiento
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_fecha_nacimiento:(NSDate *)NSD_fecha_nacimiento {
    
    _NSD_fecha_nacimiento = NSD_fecha_nacimiento;
    
    // Actualizamos UILT fecha caducidad
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    [NSDF_date setDateFormat:@"dd ' de ' MMMM ' de ' yyyy"];
    NSString *NSS_date = [NSDF_date stringFromDate:_NSD_fecha_nacimiento];
    [UIL_fecha_nacimiento setText:NSS_date];
    
    // Comprobamos si es una fecha válida
    if ([UIL_fecha_nacimiento.text length] == 0) _NSD_fecha_nacimiento = nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSSVC_sexo
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSSVC_sexo:(SelectSexoViewController *)SSVC_sexo {
    
    _SSVC_sexo = SSVC_sexo;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSFVC_fecha_nacimiento
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSFVC_fecha_nacimiento:(SelectFechaViewController *)SFVC_fecha_nacimiento {
    
    _SFVC_fecha_nacimiento = SFVC_fecha_nacimiento;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
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
    [self setTST_sexo:globalVar.UC_user.TST_genre];
    [self setNSD_fecha_nacimiento:globalVar.UC_user.NSD_birthday];
    
    // Actualizamos los UITextField
    [UITF_nombre    setText:globalVar.UC_user.NSS_name];
    [UITF_apellidos setText:globalVar.UC_user.NSS_lastname];
    [UITF_correo    setText:globalVar.UC_user.NSS_email];
    [UITF_ciudad    setText:globalVar.UC_user.NSS_location];
    [UITF_telefono  setText:[NSString stringWithFormat:@"%d", globalVar.UC_user.NSI_phone]];
    
    // Insertamos la UIView en el UIScrollView
    [UISV_scroll addSubview:UIV_contenido];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Editar Cuenta";
    
    // Ocultamos el teclado
    [UITF_nombre     resignFirstResponder];
    [UITF_apellidos  resignFirstResponder];
    [UITF_correo     resignFirstResponder];
    [UITF_ciudad     resignFirstResponder];
    [UITF_telefono   resignFirstResponder];
    [UITF_password01 resignFirstResponder];
    [UITF_password02 resignFirstResponder];
    
    // Posicionamos UIScollView
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 392.0f)];
    [UISV_scroll setContentSize:CGSizeMake(UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}

-(void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    // Comprobamos si estamos realizando un pedido
    if ((globalVar.B_realizando_pedido) && ((globalVar.OC_order.TOT_type != TOT_reserva) || (globalVar.B_login_from_reserva))) {
        
        // Actualizamos propiedad
        [globalVar setB_login_from_reserva:FALSE];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_BACK_NAVBAR_
                                                     target:self
                                                   selector:@selector(backPrevieViewController)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadUsuario)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
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
//#	Procedimiento	: backPrevieViewController
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) backPrevieViewController {
    
    // Comprobamos si el tipo de pedido es reserva
    if (globalVar.OC_order.TOT_type == TOT_reserva) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_reserva_Touched];
    }
    else  if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_pre_datos_Touched];
    }
    else {

        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_dom_mi_pedido_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Comprobamos si estamos realizando un pedido
    if ((globalVar.B_realizando_pedido) && ((globalVar.OC_order.TOT_type != TOT_reserva) || (globalVar.B_login_from_reserva))) {
        
        // Actualizamos propiedad
        [globalVar setB_login_from_reserva:FALSE];
        
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
//#	Procedimiento	: checkFormulario
//#	Fecha Creación	: 22/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
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
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_password01.text length] > _MAX_FORM_SIZE_CLAVE_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo del password (%d caracteres).", _MAX_FORM_SIZE_CLAVE_]];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido el password
    if (![UITF_password01.text isEqualToString:UITF_password02.text]) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Los passwords no coinciden"];
        return FALSE;
    }
    
    // Comprobamos si se ha introducido los apellidos
    if ([UITF_ciudad.text length] > _MAX_FORM_SIZE_UBICACION_) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:[NSString stringWithFormat:@"Ha superado el tamaño máximo de la ciudad (%d caracteres).", _MAX_FORM_SIZE_UBICACION_]];
        return FALSE;
    }
    
    return TRUE;
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

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : registrarUsuario
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) editarUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_SUCCESSFUL_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_NO_INTERNET_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_ERROR_         object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(editarUsuarioSuccessful:) 
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
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading updateUser];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeUsuario
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_USER_SUCCESSFUL_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_USER_NO_INTERNET_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_USER_ERROR_         object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(removeUsuarioSuccessful:) 
                                                 name: _NOTIFICATION_REMOVE_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_REMOVE_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_REMOVE_USER_ERROR_
                                               object: nil];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading removeUser];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUserSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUserSuccessful:(NSNotification *)notification {
    
    // Iniciamos propiedad
    [self setB_teclado_visible:FALSE];
    [self setTST_sexo:globalVar.UC_user.TST_genre];
    [self setNSD_fecha_nacimiento:globalVar.UC_user.NSD_birthday];
    
    // Actualizamos los UITextField
    [UITF_nombre    setText:globalVar.UC_user.NSS_name];
    [UITF_apellidos setText:globalVar.UC_user.NSS_lastname];
    [UITF_correo    setText:globalVar.UC_user.NSS_email];
    [UITF_ciudad    setText:globalVar.UC_user.NSS_location];
    [UITF_telefono  setText:[NSString stringWithFormat:@"%d", globalVar.UC_user.NSI_phone]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : editarUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) editarUsuarioSuccessful:(NSNotification *)notification {
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Comprobamos si estamos en options
    if (globalVar.B_options) {
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
    }
    
    // Mostramos mensaje de operación exitosa
    [globalVar showAlerMsgWith:_ALERT_TITLE_UPDATE_USER_ message:_ALERT_MSG_UPDATE_USER_];
    
    // Ocultamos el teclado
    [UITF_nombre     resignFirstResponder];
    [UITF_apellidos  resignFirstResponder];
    [UITF_correo     resignFirstResponder];
    [UITF_ciudad     resignFirstResponder];
    [UITF_telefono   resignFirstResponder];
    [UITF_password01 resignFirstResponder];
    [UITF_password02 resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeUsuarioSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [globalVar.UC_user setNSI_id:_ID_USER_NO_REGISTRADO_];
    
    // Actualizamos ls BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Comprobamos si estamos en options
    if (globalVar.B_options) {
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
    }
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
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
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    // Comprobamos si el teclado esta ya visible
    if (_B_teclado_visible) return;
    
    // Comprobamos si ya se está mostrando
    if (_SSVC_sexo != nil) {
        
        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        // Reposicionamos los View
        [_SSVC_sexo.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SSVC_sexo.view.frame.size.width, _SSVC_sexo.view.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
    
    if (_SFVC_fecha_nacimiento != nil) {
        
        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        // Reposicionamos los View
        [_SFVC_fecha_nacimiento.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_nacimiento.view.frame.size.width, _SFVC_fecha_nacimiento.view.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    
    // Posicionamos UIVew
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, (UISV_scroll.frame.size.height-170.0f))];
    
    // Ajecutamos animación
    [UIView commitAnimations];
    
    // Actualizamos propiedad
    [self setB_teclado_visible:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidHide:(NSNotification *) notification {
    
    // Comprobamos si el teclado esta ya oculto
    if (!_B_teclado_visible) return;
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    
    // Posicionamos UIVew
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 392.0f)];
    [UISV_scroll setContentSize:CGSizeMake(UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Ajecutamos animación
    [UIView commitAnimations];
    
    // Actualizamos propiedad
    [self setB_teclado_visible:FALSE];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_sexo_TouchUpInside
//#	Fecha Creación	: 12/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_sexo_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SSVC_sexo != nil) || (_SFVC_fecha_nacimiento != nil)) return;
    
    // Creamos SelectSexoViewController
    _SSVC_sexo = [[SelectSexoViewController alloc] initWithNibName:@"SelectSexoView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SSVC_sexo setDelegate:self];
    
    // Insertamos SelectSexoViewController
    [self.view addSubview:_SSVC_sexo.view];
    
    // Iniciamos Propiedades
    [_SSVC_sexo setContentWith:_TST_sexo];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SSVC_sexo.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SSVC_sexo.view.frame.size.width, _SSVC_sexo.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SSVC_sexo.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SSVC_sexo.view.frame.size.height), _SSVC_sexo.view.frame.size.width, _SSVC_sexo.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Ocultamos el teclado
    [UITF_nombre     resignFirstResponder];
    [UITF_apellidos  resignFirstResponder];
    [UITF_correo     resignFirstResponder];
    [UITF_ciudad     resignFirstResponder];
    [UITF_telefono   resignFirstResponder];
    [UITF_password01 resignFirstResponder];
    [UITF_password02 resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_fecha_nacimiento_TouchUpInside
//#	Fecha Creación	: 12/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_fecha_nacimiento_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SSVC_sexo != nil) || (_SFVC_fecha_nacimiento != nil)) return;
    
    // Creamos SelectFechaViewController
    _SFVC_fecha_nacimiento = [[SelectFechaViewController alloc] initWithNibName:@"SelectFechaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SFVC_fecha_nacimiento setDelegate:self];
    
    // Insertamos SelectFechaViewController
    [self.view addSubview:_SFVC_fecha_nacimiento.view];
    
    // Iniciamos Propiedades
    [_SFVC_fecha_nacimiento setContentWith:_NSD_fecha_nacimiento];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SFVC_fecha_nacimiento.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_nacimiento.view.frame.size.width, _SFVC_fecha_nacimiento.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SFVC_fecha_nacimiento.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SFVC_fecha_nacimiento.view.frame.size.height), _SFVC_fecha_nacimiento.view.frame.size.width, _SFVC_fecha_nacimiento.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Ocultamos el teclado
    [UITF_nombre     resignFirstResponder];
    [UITF_apellidos  resignFirstResponder];
    [UITF_correo     resignFirstResponder];
    [UITF_ciudad     resignFirstResponder];
    [UITF_telefono   resignFirstResponder];
    [UITF_password01 resignFirstResponder];
    [UITF_password02 resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_registro_TouchUpInside
//#	Fecha Creación	: 12/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_registro_TouchUpInside:(id)sender {
    
    // Comprobamos si los datos del formulario son correctos
    if (![self checkFormulario]) return;
    
    // Actualizasmos propiedades
    [globalVar.UC_user setNSS_name      :UITF_nombre.text];
    [globalVar.UC_user setNSS_lastname  :UITF_apellidos.text];
    [globalVar.UC_user setNSS_location  :UITF_ciudad.text];
    [globalVar.UC_user setNSS_email     :UITF_correo.text];
    [globalVar.UC_user setNSI_phone     :[UITF_telefono.text integerValue]];
    [globalVar.UC_user setNSD_birthday  :_NSD_fecha_nacimiento];
    [globalVar.UC_user setTST_genre     :_TST_sexo];
    [globalVar.UC_user setTRT_type      :TRT_normal];
    
    // Comprobamos si no se ha introducido un password
    if ([UITF_password01.text length] > 0) {
        
        // Actualizamos el password
        [globalVar.UC_user setNSS_password: UITF_password01.text];
        [globalVar setB_change_password:TRUE];
    }
    else [globalVar setB_change_password:FALSE];
    
    // Registramos el usuario en el servidor
    [self editarUsuario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_bajar_TouchUpInside
//#	Fecha Creación	: 12/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_bajar_TouchUpInside:(id)sender {
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro que desea borrar la cuenta de usuario? Perderá todos los datos asociados a ella."];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_sexo
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_sexo:(typeSexoType)TST_sexo {
    
    // Actualizamos propiedad
    [self setTST_sexo:TST_sexo];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_fecha
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_fecha:(NSDate *)NSD_fecha {
    
    // Actualizamos fecha
    [self setNSD_fecha_nacimiento:NSD_fecha];
    
    // Mostramos el teclado
    //[UITF_nombre becomeFirstResponder];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SFVC_fecha_nacimiento.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_nacimiento.view.frame.size.width, _SFVC_fecha_nacimiento.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_tarjeta
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_sexo {
    
    // Mostramos el teclado
    //[UITF_nombre becomeFirstResponder];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SSVC_sexo.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SSVC_sexo.view.frame.size.width, _SSVC_sexo.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_SSVC_sexo != nil) {
        
        // Quitamos el View Select Tipo Cocina
        [_SSVC_sexo.view removeFromSuperview];
        
        // Liberamos memoria
        _SSVC_sexo = nil;
    }
    else {
        
        // Quitamos el View Select Precio
        [_SFVC_fecha_nacimiento.view removeFromSuperview];
        
        // Liberamos memoria
        _SFVC_fecha_nacimiento = nil;
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Eliminamos el usuario del servidor
        [self removeUsuario];
    }
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
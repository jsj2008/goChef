//
//  OpcionesViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "OpcionesViewController.h"
#import "LoadingViewController.h"
#import "OpcionesAtencionClienteViewController.h"
#import "HelpViewController.h"
#import "OpcionesMiHistorialViewController.h"
#import "MiCuentaEditarCuentaViewController.h"
#import "TarjetasAdministrarViewController.h"
#import "OpcionesTerminosDeUsoViewController.h"
#import "OpcionesSugerenciaViewController.h"
#import "TabbarPrincipalViewController.h"

#import "Appirater.h"
#import "UserClass.h"
#import "CoreDataClass.h"
#import "FacebookClass.h"


@implementation OpcionesViewController

@synthesize UIL_total_spending;
@synthesize UIL_total_saving;
@synthesize UIL_restaurants_visits;
@synthesize UIL_version;
@synthesize UIIV_bakcground;
@synthesize UIV_contenido;
@synthesize UISV_scroll;

@synthesize MCPVC_problemas       = _MCPVC_problemas;
@synthesize HVC_ayuda             = _HVC_ayuda;
@synthesize MCMHVC_historial      = _MCMHVC_historial;
@synthesize MCECVC_editar_cuenta  = _MCECVC_editar_cuenta;
@synthesize TAVC_admin_tarjetas   = _TAVC_admin_tarjetas;
@synthesize MCRLVC_registro_login = _MCRLVC_registro_login;
@synthesize MCTUVC_terminos       = _MCTUVC_terminos;
@synthesize MCSVC_sugerir         = _MCSVC_sugerir;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCPVC_problemas
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCPVC_problemas:(OpcionesAtencionClienteViewController *)MCPVC_problemas {
    
    _MCPVC_problemas = MCPVC_problemas;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setHVC_ayuda
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setHVC_ayuda:(HelpViewController *)HVC_ayuda {
    
    _HVC_ayuda = HVC_ayuda;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCMHVC_historial
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCMHVC_historial:(OpcionesMiHistorialViewController *)MCMHVC_historial {
    
    _MCMHVC_historial = MCMHVC_historial;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCECVC_editar_cuenta
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCECVC_editar_cuenta:(MiCuentaEditarCuentaViewController *)MCECVC_editar_cuenta {
    
    _MCECVC_editar_cuenta = MCECVC_editar_cuenta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTAVC_admin_tarjetas
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTAVC_admin_tarjetas:(TarjetasAdministrarViewController *)TAVC_admin_tarjetas {
    
    _TAVC_admin_tarjetas = TAVC_admin_tarjetas;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCRLVC_registro_login
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCRLVC_registro_login:(MiCuentaRegistroLoginViewController *)MCRLVC_registro_login {
    
    _MCRLVC_registro_login = MCRLVC_registro_login;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCTUVC_terminos
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCTUVC_terminos:(OpcionesTerminosDeUsoViewController *)MCTUVC_terminos {
    
    _MCTUVC_terminos = MCTUVC_terminos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCSVC_sugerir
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCSVC_sugerir:(OpcionesSugerenciaViewController *)MCSVC_sugerir {
    
    _MCSVC_sugerir = MCSVC_sugerir;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos UILabel
    [UIL_version setText:_APP_VERSION_];
    
    // Insertamos UIView en el UIScrollView
    [UISV_scroll addSubview:UIV_contenido];
    
    // Posicionamos UIVew
    [UIV_contenido setFrame:CGRectMake(0.0f, 0.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Actualizamso UIScrollView
    [UISV_scroll setFrame:CGRectMake(0.0f, -45.0f, UISV_scroll.frame.size.width, (UISV_scroll.frame.size.height+10.0f))];
    [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, UIV_contenido.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Opciones";
    
    // Comprobamos si el usuario esta registrado
    if (globalVar.B_usuario_registrado) {
            
        // Colocamos IMageView de fondo
        UIImage *UII_background = [UIImage imageNamed:@"mi_cuenta_ppal_background.png"];
        [UIIV_bakcground setImage:UII_background];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadUsuario)
                                                   userInfo:nil
                                                    repeats:NO];
        
        
        
    }
    else {
        
        // Colocamos IMageView de fondo
        UIImage *UII_background = [UIImage imageNamed:@"mi_cuenta_ppal_logout_background.png"];
        [UIIV_bakcground setImage:UII_background];
        
        // Actualizamos UILabel
        [UIL_total_saving       setText:@""];
        [UIL_total_spending     setText:@""];
        [UIL_restaurants_visits setText:@""];
    }
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
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                        object:self];
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
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUserSuccessful:(NSNotification *)notification {
    
    // Actualizamos UILabel
    [UIL_total_saving       setText:[NSString stringWithFormat:@"%.2f €", [globalVar.UC_user.NSN_saving floatValue]]];
    [UIL_total_spending     setText:[NSString stringWithFormat:@"%.2f €", [globalVar.UC_user.NSN_spending floatValue]]];
    [UIL_restaurants_visits setText:[NSString stringWithFormat:@"%d", [globalVar.UC_user.NSN_restaurants_visits integerValue]]];
    
    //[globalVar.UC_user.NSI_id];
    // recuperamos sus tarjetas
     [globalVar.CDC_coreData getCreaditCardsWithUserId:globalVar.UC_user.NSI_id];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
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
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_problemas_TouchUpInside:(id)sender {
    
    // Creamos View Controller
    _MCPVC_problemas = [[OpcionesAtencionClienteViewController alloc] initWithNibName:@"OpcionesAtencionClienteView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCPVC_problemas animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_como_funciona_TouchUpInside:(id)sender {
    
    // Creamos View Controller
    _HVC_ayuda = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_HVC_ayuda animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_gasto_total_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) return;
    
    // Creamos View Controller
    _MCMHVC_historial = [[OpcionesMiHistorialViewController alloc] initWithNibName:@"OpcionesMiHistorialView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCMHVC_historial animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_total_ahorro_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) return;
    
    // Creamos View Controller
    _MCMHVC_historial = [[OpcionesMiHistorialViewController alloc] initWithNibName:@"OpcionesMiHistorialView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCMHVC_historial animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_sitios_visitados_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) return;
    
    // Creamos View Controller
    _MCMHVC_historial = [[OpcionesMiHistorialViewController alloc] initWithNibName:@"OpcionesMiHistorialView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCMHVC_historial animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_editar_cuenta_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) return;
    
    // Creamos View Controller
    _MCECVC_editar_cuenta = [[MiCuentaEditarCuentaViewController alloc] initWithNibName:@"MiCuentaEditarCuentaView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCECVC_editar_cuenta animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_admin_tarjetas_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) return;
    
    // Creamos View Controller
    _TAVC_admin_tarjetas = [[TarjetasAdministrarViewController alloc] initWithNibName:@"TarjetasAdministrarView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_TAVC_admin_tarjetas animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_logout_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario esta registrado
    if (globalVar.B_usuario_registrado) {
        
        // Mostramos mensage de confirmación
        UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
        [UIAV_confirm setTag:2];
        [UIAV_confirm setTitle:@"Confirmación"];
        [UIAV_confirm setMessage:@"¿Está seguro que desea hacer un logout?"];
        [UIAV_confirm setDelegate:self];
        [UIAV_confirm addButtonWithTitle:@"Si"];
        [UIAV_confirm addButtonWithTitle:@"No"];
        [UIAV_confirm show];
    }
    else {
        
        // Creamos View Controller
        _MCRLVC_registro_login = [[MiCuentaRegistroLoginViewController alloc] initWithNibName:@"MiCuentaRegistroLoginView" bundle:[NSBundle mainBundle]];
        
        // Asignamos delegado
        [_MCRLVC_registro_login setDelegate:self];
        
        // Insertamos View Controller en el Navigation Controller
        [self.navigationController pushViewController:_MCRLVC_registro_login animated:YES];
    }        
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_terminos_de_uso_TouchUpInside:(id)sender {
    
    // Creamos View Controller
    _MCTUVC_terminos = [[OpcionesTerminosDeUsoViewController alloc] initWithNibName:@"OpcionesTerminosDeUsoView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCTUVC_terminos animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_facebook_TouchUpInside:(id)sender {
    
    // Comprobamos si esta dado de alta
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        
        // Mostramos mensage de confirmación
        UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
        [UIAV_confirm setTag:1];
        [UIAV_confirm setTitle:@"Confirmación"];
        [UIAV_confirm setMessage:@"¿Está seguro que desea hacer un logout en Facebook?"];
        [UIAV_confirm setDelegate:self];
        [UIAV_confirm addButtonWithTitle:@"Si"];
        [UIAV_confirm addButtonWithTitle:@"No"];
        [UIAV_confirm show];
    }
    else [globalVar.FC_facebook loginFacebook];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_puntua_app_TouchUpInside:(id)sender {
    
    // App review
    [Appirater rateApp];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_problemas_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_sugerencias_TouchUpInside:(id)sender {
    
    // Creamos View Controller
    _MCSVC_sugerir = [[OpcionesSugerenciaViewController alloc] initWithNibName:@"OpcionesSugerenciaView" bundle:[NSBundle mainBundle]];
    
    // Insertamos View Controller en el Navigation Controller
    [self.navigationController pushViewController:_MCSVC_sugerir animated:YES];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Comprobamos que mensaje es el origen
        if (alertView.tag == 1) {
            
            // Hacemos logout de Facebook
            [globalVar.FC_facebook logoutFacebook];
        }
        else {
            
            // Actualizamos propiedad
            [globalVar.UC_user setNSI_id:_ID_USER_NO_REGISTRADO_];
            
            // Actualizamos ls BB.DD
            [globalVar.CDC_coreData updateUser:globalVar.UC_user];
            
            // Borramos todas las tarjetas
            //[globalVar.CDC_coreData removeAllCreaditCard];
            
            // Refrescamos la ventana
            [self viewWillAppear:FALSE];
            
            // Actualizamos UILabel
            [UIL_total_saving       setText:@""];
            [UIL_total_spending     setText:@""];
            [UIL_restaurants_visits setText:@""];
            
            // Actualizamos el globo de la barra
            [globalVar setNSI_num_new_order:0];
            [globalVar.TPVC_principal updateGlobo];
        }
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_mi_pedido_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_dom_mi_pedido_Touched {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_mi_pedido_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_cuenta_Touched {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_mi_pedido_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_settings_Touched {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_rst_pedir_Touched
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_rst_pedir_Touched {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_reserva_Touched
//#	Fecha Creación	: 26/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_reserva_Touched {
    
}

@end
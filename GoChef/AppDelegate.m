//
//  AppDelegate.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import "CoreLocationClass.h"
#import "CoreDataClass.h"
#import "JSONparseClass.h"
#import "Appirater.h"
#import "UserClass.h"
#import "FacebookClass.h"
#import "OrderClass.h"
#import "AESCryptClass.h"

#import "MiActividadContenedorViewController.h"
#import "MiSacoContenedorViewController.h"
#import "MiCuentaContenedorViewController.h"
#import "RestaurantePagarContenedorViewController.h"
#import "ReservarViewController.h"
#import "SearchRestaurantClass.h"

#import "ImgCacheManager.h"
#import "TransactionsManager.h"

@implementation AppDelegate

@synthesize NST_timer_chec_new_orders = _NST_timer_chec_new_orders;

@synthesize facebook;
@synthesize userPermissions;

@synthesize NSI_active_index   = _NSI_active_index;
@synthesize B_principal_page   = _B_principal_page;
@synthesize B_resetButtonState = _B_resetButtonState;

@synthesize B_show_Tabbar_Principal   = _B_show_Tabbar_Principal;
@synthesize B_show_Tabbar_Domicilio   = _B_show_Tabbar_Domicilio;
@synthesize B_show_Tabbar_Restaurante = _B_show_Tabbar_Restaurante;
@synthesize B_show_Tabbar_AntesLlegar = _B_show_Tabbar_AntesLlegar;
@synthesize B_show_Tabbar_Recoger     = _B_show_Tabbar_Recoger;

@synthesize UIV_tabbars;
@synthesize UINC_principal_mi_actividad;
@synthesize UINC_principal_mi_saco;
@synthesize UINC_principal_mi_cuenta;
@synthesize UINC_principal_help;
@synthesize UINC_principal_opciones;
@synthesize UINC_domicilio_buscar;
@synthesize UINC_domicilio_mi_pedido;
@synthesize UINC_domicilio_historial;
@synthesize UINC_restaurante_pedir;
@synthesize UINC_restaurante_en_cocina;
@synthesize UINC_restaurante_pagar;
@synthesize UINC_antes_llegar_datos;
@synthesize UINC_antes_llegar_pedir;
@synthesize UINC_antes_llegar_mi_pedido;

@synthesize window = _window;

@synthesize MACVC_mi_actividad  = _MACVC_mi_actividad;
@synthesize MSCVC_mi_saco       = _MSCVC_mi_saco;
@synthesize MCCVC_mi_cuenta     = _MCCVC_mi_cuenta;
@synthesize HVC_help            = _HVC_help;
@synthesize OVC_opciones        = _OVC_opciones;
@synthesize RSIC_restaurante    = _RSIC_restaurante;
@synthesize RVC_reservar        = _RVC_reservar;
@synthesize DDVC_buscar         = _DDVC_buscar;
@synthesize MPVC_mi_pedido      = _MPVC_mi_pedido;
@synthesize PVC_pedido          = _PVC_pedido;
@synthesize DHVC_historial      = _DHVC_historial;
@synthesize RPCVC_pedir         = _RPCVC_pedir;
@synthesize RECCVC_en_cocina    = _RECCVC_en_cocina;
@synthesize RPCVC_pagar         = _RPCVC_pagar;
@synthesize ALDCVC_datos        = _ALDCVC_datos;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setNST_timer_chec_new_orders
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNST_timer_chec_new_orders:(NSTimer *)NST_timer_chec_new_orders {
    
    _NST_timer_chec_new_orders = NST_timer_chec_new_orders;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_show_Tabbar_Principal
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_show_Tabbar_Principal:(BOOL)B_show_Tabbar_Principal {
    
    _B_show_Tabbar_Principal = B_show_Tabbar_Principal;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_show_Tabbar_Domicilio
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_show_Tabbar_Domicilio:(BOOL)B_show_Tabbar_Domicilio {
    
    _B_show_Tabbar_Domicilio = B_show_Tabbar_Domicilio;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_show_Tabbar_Restaurante
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_show_Tabbar_Restaurante:(BOOL)B_show_Tabbar_Restaurante {
    
    _B_show_Tabbar_Restaurante = B_show_Tabbar_Restaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_show_Tabbar_AntesLlegar
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_show_Tabbar_AntesLlegar:(BOOL)B_show_Tabbar_AntesLlegar {
    
    _B_show_Tabbar_AntesLlegar = B_show_Tabbar_AntesLlegar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_show_Tabbar_Recoger
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_show_Tabbar_Recoger:(BOOL)B_show_Tabbar_Recoger {
    
    _B_show_Tabbar_Recoger = B_show_Tabbar_Recoger;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setPVC_pedido
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPVC_pedido:(PedidoViewController *)PVC_pedido {
    
    _PVC_pedido = PVC_pedido;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setNSI_active_index
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_active_index:(NSInteger)NSI_active_index {
    
    _NSI_active_index = NSI_active_index;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_principal_page
//#	Fecha Creación	: 14/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 14/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_principal_page:(BOOL)B_principal_page {
    
    _B_principal_page = B_principal_page;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setB_resetButtonState
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_resetButtonState:(BOOL)B_resetButtonState {
    
    _B_resetButtonState = B_resetButtonState;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setMACVC_mi_actividad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMACVC_mi_actividad:(MiActividadContenedorViewController *)MACVC_mi_actividad {
    
    _MACVC_mi_actividad = MACVC_mi_actividad;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setMSCVC_mi_saco
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMSCVC_mi_saco:(MiSacoContenedorViewController *)MSCVC_mi_saco {
    
    _MSCVC_mi_saco = MSCVC_mi_saco;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setMCCVC_mi_cuenta
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCCVC_mi_cuenta:(MiCuentaContenedorViewController *)MCCVC_mi_cuenta {
    
    _MCCVC_mi_cuenta = MCCVC_mi_cuenta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setRSIC_restaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRSIC_restaurante:(RestauranteShortInfoViewController *)RSIC_restaurante {
    
    _RSIC_restaurante = RSIC_restaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setRVC_reservar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRVC_reservar:(ReservarViewController *)RVC_reservar {
    
    _RVC_reservar = RVC_reservar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setDDVC_buscar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDDVC_buscar:(DomicilioDireccionViewController *)DDVC_buscar {
    
    _DDVC_buscar = DDVC_buscar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setMPVC_mi_pedido
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMPVC_mi_pedido:(MiPedidoViewController *)MPVC_mi_pedido {
    
    _MPVC_mi_pedido = MPVC_mi_pedido;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setDHCVC_historial
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDHVC_historial:(DomicilioHistorialViewController *)DHVC_historial {
    
    _DHVC_historial = DHVC_historial;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setRPCVC_pedir
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRPCVC_pedir:(RestaurantePedirContenedorViewController *)RPCVC_pedir {
    
    _RPCVC_pedir = RPCVC_pedir;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setRECCVC_en_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRECCVC_en_cocina:(RestauranteEnCocinaContenedorViewController *)RECCVC_en_cocina {
    
    _RECCVC_en_cocina = RECCVC_en_cocina;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setRPCVC_pagar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRPCVC_pagar:(RestaurantePagarContenedorViewController *)RPCVC_pagar {
    
    _RPCVC_pagar = RPCVC_pagar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setALDCVC_datos
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setALDCVC_datos:(AntesLlegarDatosContenedorViewController *)ALDCVC_datos {
    
    _ALDCVC_datos = ALDCVC_datos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setHVC_help
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setHVC_help:(HelpViewController *)HVC_help {
    
    _HVC_help = HVC_help;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setOVC_opciones
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOVC_opciones:(OpcionesViewController *)OVC_opciones {
    
    _OVC_opciones = OVC_opciones;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: application:didFinishLaunchingWithOptions:
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setB_principal_page  :TRUE];
    [self setB_resetButtonState:TRUE];
    
    // Iniciamos array NavigationController
    [self initNavigationViewController];
    
    // Iniciamos propiedades
    [self setB_show_Tabbar_Principal   :FALSE];
    [self setB_show_Tabbar_Domicilio   :FALSE];
    [self setB_show_Tabbar_Restaurante :FALSE];
    [self setB_show_Tabbar_AntesLlegar :FALSE];
    [self setB_show_Tabbar_Recoger     :FALSE];
    
    // Iniciamos el LoadingViewController
    [self initLoadingViewController];
    
    // Iniciamos el Tabbars
    [self initTabBarRestauranteViewController];
    [self initTabBarPrincipalViewController];
    [self initTabBarDomicilioViewController];
    [self initTabBarAntesLlegarViewController];

    // Iniciamos los componentes de la Windows
    [self.window makeKeyAndVisible];
    
    // Añadimos NSNotificationCenter 
    [self initNotifications];
    
    // Iniciamos LocationManager
    globalVar.CLC_location = [[CoreLocationClass alloc] init];
    
    // Iniciamos el JSON Parse Class
    globalVar.JPC_json = [[JSONparseClass alloc] init];
    
    // Iniciamos AESCryptClass
    globalVar.AES_crypt = [[AESCryptClass alloc] init];
    
    // Iniciamos CoreData
    globalVar.CDC_coreData = [[CoreDataClass alloc] init];
    
    // Recuperamos los datos de la BB.DD
    [globalVar.CDC_coreData getUser];
    [globalVar.CDC_coreData getCreaditCardsWithUserId:globalVar.UC_user.NSI_id];
    
    // Iniciamos el Usuario
    [globalVar setB_usuario_registrado:FALSE];

    // Comprobamos si el usuario estaba registrado
    if (globalVar.UC_user.NSI_id != _ID_USER_NO_REGISTRADO_) [self loginUsuario];
    
    // Iniciamos Boolen propierties
    [globalVar setB_realizando_pedido   :FALSE];
    [globalVar setB_pedido_confirmado   :FALSE];
    [globalVar setB_origen_mi_saco      :FALSE];
    [globalVar setB_come_from_historial :FALSE];
    [globalVar setB_registro_facebook   :FALSE];
    [globalVar setB_login_from_reserva  :FALSE];
    [globalVar setB_active_en_mesa      :FALSE];
    
    // Iniciamos el numero de resgitros por bloque
    [globalVar setNSI_blocksize_restaurants:_GET_LIMIT_VALUE_REST_DEFAULT_];
    [globalVar setNSI_blocksize_offers     :_GET_LIMIT_VALUE_OFFERS_DEFAULT_];
    [globalVar setNSI_blocksize_orders     :_GET_LIMIT_VALUE_ORDERS_DEFAULT_];

    // Cargamos los tipos de Cocina
    [self loadTiposCocina];

    // Iniciamos numero de Orders nuevas
    [globalVar setNSI_num_new_order: 0];

    // Iniciamos el Timer que controla las alarmas
    _NST_timer_chec_new_orders = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHECK_NEW_ORDERS_
                                                  target:self
                                                selector:@selector(initThreadChekNewOrders)
                                                userInfo:nil
                                                 repeats:YES];

    // App review
    [Appirater appLaunched:YES];
    
    // Iniciamos Push Notification
    [self initPushNotification];
    
    // Iniciamos Facebook
    [self initFacebook];
    
    // ready for devolutions notification
    [[TransactionsManager sharedInstance] registerForNotifications];
    
    return YES;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNotifications
//#	Fecha Creación	: 19/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) initNotifications {

    // Añadimos NSNotificationCenter
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(goNavigatioControllerPrincipal:)
                                                 name: _NOTIFICATION_GO_PRINCIPAL_
                                               object: nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(goMiActividadController:)
                                                 name: _NOTIFICATION_GO_MI_ACTIVIDAD_
                                               object: nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(hideTabbarRestauranteButton:)
                                                 name: _NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_
                                               object: nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showTabbarRestauranteButton:)
                                                 name: _NOTIFICATION_SHOW_RESTAURANT_TABBAR_BUTTON_
                                               object: nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(goOptions:)
                                                 name: _NOTIFICATION_GO_OPTIONS_
                                               object: nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationViewController
//#	Fecha Creación	: 19/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) initNavigationViewController {

    // Iniciamos array NavigationController
    globalVar.NSMA_tabbar_viewcontroller = [[NSMutableArray alloc] init];
    
    // Insertamos NavigationController
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_actividad];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_saco];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_cuenta];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_domicilio_buscar];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_domicilio_mi_pedido];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_domicilio_historial];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_restaurante_pedir];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_restaurante_en_cocina];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_restaurante_pagar];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_antes_llegar_datos];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_antes_llegar_pedir];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_antes_llegar_mi_pedido];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_help];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_opciones];
    
    // Asignamos delegados
    [(PrincipalViewController *)[UINC_principal_mi_actividad.viewControllers  objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_principal_mi_saco.viewControllers       objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_principal_mi_cuenta.viewControllers     objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_domicilio_buscar.viewControllers        objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_domicilio_mi_pedido.viewControllers     objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_domicilio_historial.viewControllers     objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_restaurante_pedir.viewControllers       objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_restaurante_en_cocina.viewControllers   objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_restaurante_pagar.viewControllers       objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_antes_llegar_datos.viewControllers      objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_antes_llegar_pedir.viewControllers      objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_antes_llegar_mi_pedido.viewControllers  objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_principal_help.viewControllers          objectAtIndex:0] setDelegate:self];
    [(PrincipalViewController *)[UINC_principal_opciones.viewControllers      objectAtIndex:0] setDelegate:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initLoadingViewcontroller
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initLoadingViewController {
    
    // Insertamos el LoadingViewController
    globalVar.LVC_loading = [[LoadingViewController alloc] initWithNibName:@"LoadingView" bundle:[NSBundle mainBundle]];
    
    // Posicionamos el LoadingViewController
    [globalVar.LVC_loading.view setFrame:CGRectMake(((self.window.frame.size.width/2)-(110.0f/2)), ((self.window.frame.size.height/2)-(110.0f/2)), 110.0f, 110.0f)];
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark Push Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initPushNotification
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initPushNotification {
    
    // Let the device know we want to receive push notifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: 
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: application:didRegisterForRemoteNotificationsWithDeviceToken:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    // Combertimos DeviceToken BinaryHex to StringHex
    globalVar.NSS_deviceToken = [globalVar stringWithHexBytes:deviceToken];
    
    // Actualizamos Profile
    [globalVar.UC_user setNSS_token:globalVar.NSS_deviceToken];
    
    // Mostramos Log
	NSLog(@"MY APNS TOKEN IS: %@", globalVar.NSS_deviceToken);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: application:didFailToRegisterForRemoteNotificationsWithError:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    
    // Combertimos DeviceToken BinaryHex to StringHex
    globalVar.NSS_deviceToken = @"";
    
    // Actualizamos Profile
    [globalVar.UC_user setNSS_token:globalVar.NSS_deviceToken];
    
    // Mostramos Log
	NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark - didReceiveRemoteNotification

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    /* Notification Format
     {"aps" : {
            "alert" : "You got your emails.",
            "badge" : 9,
            "sound" : "bingbong.aiff"
        },
        "acme1" : "bar",
        "acme2" : 42 }
     */
    
    if ([globalVar B_usuario_registrado]){
        [globalVar.JPC_json UMNI_getOrdersDevolution];
    }
}

#pragma mark -
#pragma mark Social Network Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initFacebook
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initFacebook {
    
    // Iniciamos FacebookClass
    globalVar.FC_facebook = [[FacebookClass alloc] init];
    
    // Initialize user permissions
    userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    // Initialize Facebook
    //facebook = [[Facebook alloc] initWithAppId:_FACEBOOK_APP_ID_ andDelegate:globalVar.FC_facebook];
    //facebook = [[FBSession alloc] initWithAppID:_FACEBOOK_APP_ID_ permissions:[NSArray arrayWithObjects: nil] defaultAudience:FBSessionDefaultAudienceEveryone urlSchemeSuffix:@"" tokenCacheStrategy:(FBSessionTokenCachingStrategy *)
    
    facebook = [[FBSession alloc] initWithPermissions:[NSArray arrayWithObjects: nil]];
                
    
    // Check and retrieve authorization information
   /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        [FBSession activeSession].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }*/
    

    
    // Check App ID:
    // This is really a warning for the developer, this should not
    // happen in a completed app
    if (!_FACEBOOK_APP_ID_) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Setup Error"
                                  message:@"Missing app ID. You cannot run the app until you provide this in the code."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil,
                                  nil];
        [alertView show];
    } 
    else {
        
        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
        // be opened, doing a simple check without local app id factored in here
        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",_FACEBOOK_APP_ID_];
        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([aBundleURLTypes isKindOfClass:[NSArray class]] &&
            ([aBundleURLTypes count] > 0)) {
            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                    ([aBundleURLSchemes count] > 0)) {
                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                    if ([scheme isKindOfClass:[NSString class]] &&
                        [url hasPrefix:scheme]) {
                        bSchemeInPlist = YES;
                    }
                }
            }
        }
        // Check if the authorization callback will work
        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
        if (!bSchemeInPlist || !bCanOpenUrl) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Setup Error"
                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil,
                                      nil];
            [alertView show];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateNabvigationControllerToIndex
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateNavigationControllerToIndex:(NSInteger)NSI_index popRoot:(BOOL)B_popRoot {
    
    // Actualizamos Propiedad Global
    [globalVar setNSI_NavController_index:NSI_index];
    
    // Comprobamos si es la llamada inicial
    if (NSI_index == -1) {
        
        // Colocamos el NavigationController que corresponda
        self.window.rootViewController = UINC_principal_mi_actividad;
        
        // Nos posicionamos en el primer View Controller
        [UINC_principal_mi_actividad popToRootViewControllerAnimated:TRUE];
        
        // Iniciamos los Button Tabbar Principal
        [globalVar.TPVC_principal initTabbarButtonsStatus];
        
        // Insertamos LoadingView Controller
        [self.window.rootViewController.view addSubview:globalVar.LVC_loading.view];
        
        // Insertamos Tabbar Controller
        [self.window.rootViewController.view addSubview:UIV_tabbars];
    }
    else {
        
        UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:NSI_index];
        
        // Comprobamos que NavigationBar es el activo
        if (NSI_index == _TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_MACVC_mi_actividad)_MACVC_mi_actividad = [[MiActividadContenedorViewController alloc] initWithNibName:@"MiActividadContenedorView" bundle:[NSBundle mainBundle]];
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MACVC_mi_actividad animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MACVC_mi_actividad animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_PRINCIPAL_MI_SACO_ ) {
            
            // Comprobamos si el View Controller esta creado
            if (!_MSCVC_mi_saco) {
                
                // Creamos el MiSacoContenedorViewController
                _MSCVC_mi_saco = [[MiSacoContenedorViewController alloc] initWithNibName:@"MiSacoContenedorView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_MSCVC_mi_saco setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MSCVC_mi_saco animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MSCVC_mi_saco animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_PRINCIPAL_MI_CUENTA_ ) {
            
            // Comprobamos si el usuario esta registrado
            if (globalVar.B_usuario_registrado) {
                
                // Creamos View Controller
                if (!_MCECVC_editar_cuenta) {
                 
                    // Creamos el MiCuentaEditarCuentaViewController
                    _MCECVC_editar_cuenta = [[MiCuentaEditarCuentaViewController alloc] initWithNibName:@"MiCuentaEditarCuentaView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_MCECVC_editar_cuenta setDelegate:self];
                }
                
                // Comprobamos si el View Controller esta creado
                //if (!_MCCVC_mi_cuenta) _MCCVC_mi_cuenta = [[MiCuentaContenedorViewController alloc] initWithNibName:@"MiCuentaContenedorView" bundle:[NSBundle mainBundle]];
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_MCECVC_editar_cuenta animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_MCECVC_editar_cuenta animated:FALSE];
                }
            }
            else {
                
                // Creamos View Controller
                if (!_MCRLVC_registro_login) {
                    
                    // Creamos el MiCuentaRegistroLoginViewController
                    _MCRLVC_registro_login = [[MiCuentaRegistroLoginViewController alloc] initWithNibName:@"MiCuentaRegistroLoginView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_MCRLVC_registro_login setDelegate:self];
                }
                
                // Comprobamos si el View Controller esta creado
                //if (!_MCCVC_mi_cuenta) _MCCVC_mi_cuenta = [[MiCuentaContenedorViewController alloc] initWithNibName:@"MiCuentaContenedorView" bundle:[NSBundle mainBundle]];
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_MCRLVC_registro_login animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_MCRLVC_registro_login animated:FALSE];
                }
            }
        }
        else if (NSI_index == _TABBAR_INDEX_PRINCIPAL_HELP_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_HVC_help) {
             
                // Creamos el HelpViewController
                _HVC_help = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_HVC_help setDelegate:self];
            }
            
            // Nos posicionamos en el primer View _HVC_help
            [UINC_navigation pushViewController:_HVC_help animated:YES];
            
            // Actualizamos propiedad
            [self setB_principal_page:FALSE];
        }
        else if (NSI_index == _TABBAR_INDEX_PRINCIPAL_OPCIONES_) {
            
            // Creamos View Controller
            if (!_OVC_opciones) {
                
                // Creamos el MiCuentaEditarCuentaViewController
                _OVC_opciones = [[OpcionesViewController alloc] initWithNibName:@"OpcionesView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_OVC_opciones setDelegate:self];
            }
            
            NSLog(@"-----------------------------------------------------------------------------------");
            NSLog(@"     pushViewController:_OVC_opciones");
            NSLog(@"-----------------------------------------------------------------------------------");
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_OVC_opciones animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_OVC_opciones animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_DOMICILIO_BUSCAR_) {
            
            // Comprobamos si venimos de "Mi Saco"
            if (((globalVar.B_realizando_pedido) && 
                (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
                (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_)) || 
                (globalVar.B_come_from_historial) )
            {
                // Comprobamos si el View Controller esta creado
                if (!_PVC_pedido) {
                    
                    // Creamos el PedidoViewController
                    _PVC_pedido = [[PedidoViewController alloc] initWithNibName:@"PedidoView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_PVC_pedido setDelegate:self];
                }
                
                // Comprobamos si "Mi Pedido" se ha creado -> colocamos al principio
                //if (_MPVC_mi_pedido) [_MPVC_mi_pedido
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_PVC_pedido animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_PVC_pedido animated:FALSE];
                }
            }
            else {
                
                // Comprobamos si el View Controller esta creado
                //if (!_DDVC_buscar) {
                    
                    // Creamos el DomicilioDireccionViewController
                    _DDVC_buscar = [[DomicilioDireccionViewController alloc] initWithNibName:@"DomicilioDireccionView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_DDVC_buscar setDelegate:self];
                //}
                
                // Comprobamos si debemos posicionarnos al principio del NavController
                if (B_popRoot) {
                    
                    // Iniciamos el resto de menús
                    [(UINavigationController *)[globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_DOMICILIO_MI_PEDIDO_] popToRootViewControllerAnimated:FALSE];
                    [(UINavigationController *)[globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_DOMICILIO_HISTORIAL_] popToRootViewControllerAnimated:FALSE];
                }
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_DDVC_buscar animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_DDVC_buscar animated:FALSE];
                }
            }
        }
        else if (NSI_index == _TABBAR_INDEX_DOMICILIO_MI_PEDIDO_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_MPVC_mi_pedido) {
                
                // Creamos el MiPedidoViewController
                _MPVC_mi_pedido = [[MiPedidoViewController alloc] initWithNibName:@"MiPedidoView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_MPVC_mi_pedido setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MPVC_mi_pedido animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MPVC_mi_pedido animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_DOMICILIO_HISTORIAL_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_DHVC_historial) {
                
                // Creamos el DomicilioHistorialContenedorViewController
                _DHVC_historial = [[DomicilioHistorialViewController alloc] initWithNibName:@"DomicilioHistorialView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_DHVC_historial setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_DHVC_historial animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_DHVC_historial animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_RESTAURANTE_PEDIR_) {
            
            // Creamos View Controller
            if (!_RPCVC_pedir) {
                
                // Creamos el RestaurantePedirContenedorViewController
                _RPCVC_pedir = [[RestaurantePedirContenedorViewController alloc] initWithNibName:@"RestaurantePedirContenedorView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_RPCVC_pedir setDelegate:self];
            }
            
            // Comprobamos si debemos posicionarnos al principio del NavController
            if (B_popRoot) {
                
                // Iniciamos el resto de menús
                [(UINavigationController *)[globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_RESTAURANTE_EN_COCINA_] popToRootViewControllerAnimated:FALSE];
                [(UINavigationController *)[globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_RESTAURANTE_PAGAR_] popToRootViewControllerAnimated:FALSE];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RPCVC_pedir animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RPCVC_pedir animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_RESTAURANTE_EN_COCINA_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_RECCVC_en_cocina) {
                
                // Creamos el RestauranteEnCocinaContenedorViewController
                _RECCVC_en_cocina = [[RestauranteEnCocinaContenedorViewController alloc] initWithNibName:@"RestauranteEnCocinaContenedorView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_RECCVC_en_cocina setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RECCVC_en_cocina animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RECCVC_en_cocina animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_RESTAURANTE_PAGAR_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_RPCVC_pagar) _RPCVC_pagar = [[RestaurantePagarContenedorViewController alloc] initWithNibName:@"RestaurantePagarContenedorView" bundle:[NSBundle mainBundle]];
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RPCVC_pagar animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_RPCVC_pagar animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_ANTES_LLEGAR_DATOS_) {
            
            // Comprobamos si venimos de "Mi Saco"
            if ((globalVar.B_realizando_pedido) && 
                (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
                (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
            {
                // Comprobamos si el View Controller esta creado
                if (_ALDCVC_datos) {
                    _ALDCVC_datos = nil;
                }
                    
                    // Creamos el AntesLlegarDatosContenedorViewController
                    _ALDCVC_datos = [[AntesLlegarDatosContenedorViewController alloc] initWithNibName:@"AntesLlegarDatosContenedorView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_ALDCVC_datos setDelegate:self];
                
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_ALDCVC_datos animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_ALDCVC_datos animated:FALSE];
                }
            }
            else {
                
                if (globalVar.SRC_search) {
                    [globalVar.SRC_search setB_restauranttype:FALSE];
                    [globalVar.SRC_search setNSS_idrestauranttype:nil];
                }

                
                // Comprobamos si el View Controller esta creado
                //if (!_RSIC_restaurante) {
                    
                    // Creamos el RestauranteShortInfoViewController
                    _RSIC_restaurante = [[RestauranteShortInfoViewController alloc] initWithNibName:@"RestauranteShortInfoView" bundle:[NSBundle mainBundle]];
                    
                    // Asignamos Delegado
                    [_RSIC_restaurante setDelegate:self];
               // }
                
                // Comprobamo si ya era el Navigation activo
                if (_B_principal_page) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_RSIC_restaurante animated:YES];
                    
                    // Actualizamos propiedad
                    [self setB_principal_page:FALSE];
                }
                else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                    
                    // Nos posicionamos en el primer View Controller
                    [UINC_navigation pushViewController:_RSIC_restaurante animated:FALSE];
                }
            }
        }
        else if (NSI_index == _TABBAR_INDEX_ANTES_LLEGAR_PEDIR_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_PVC_pedido) {
                
                // Creamos el MiPedidoViewController
                _PVC_pedido = [[PedidoViewController alloc] initWithNibName:@"PedidoView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_PVC_pedido setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_PVC_pedido animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_PVC_pedido animated:FALSE];
            }
        }
        else if (NSI_index == _TABBAR_INDEX_ANTES_LLEGAR_MI_PEDIDO_) {
            
            // Comprobamos si el View Controller esta creado
            if (!_MPVC_mi_pedido) {
                
                // Creamos el MiPedidoViewController
                _MPVC_mi_pedido = [[MiPedidoViewController alloc] initWithNibName:@"MiPedidoView" bundle:[NSBundle mainBundle]];
                
                // Asignamos Delegado
                [_MPVC_mi_pedido setDelegate:self];
            }
            
            // Comprobamo si ya era el Navigation activo
            if (_B_principal_page) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MPVC_mi_pedido animated:YES];
                
                // Actualizamos propiedad
                [self setB_principal_page:FALSE];
            }
            else if ([UINC_navigation.visibleViewController isMemberOfClass:[PrincipalViewController class]]) {
                
                // Nos posicionamos en el primer View Controller
                [UINC_navigation pushViewController:_MPVC_mi_pedido animated:FALSE];
            }
        }
        
        // Actualizamos el Index activo
        [self setNSI_active_index:NSI_index];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: invalidateAllTimer
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) invalidateAllTimer {
    
    // Cancelamos el NSTimer
    if (_NST_timer_chec_new_orders!= nil) {
     
        [_NST_timer_chec_new_orders invalidate];
        _NST_timer_chec_new_orders = nil;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initThreadChekNewOrders
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) initThreadChekNewOrders {
    
    /*
    // Creamos el Thread que ckequeará si hay new Orders
    NSThread* NST_thread = [[NSThread alloc] initWithTarget:self
                                                   selector:@selector(checkNewOrders)
                                                     object:nil];

    [self performSelectorOnMainThread:@selector(checkNewOrders)
                           withObject:nil
                        waitUntilDone:false];
    
    // Lanzamos el Thread
    [NST_thread start];
     */
    [self checkNewOrders];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuario
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
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
                                             selector: @selector(loginUsuarioSuccessful_ini:)
                                                 name: _NOTIFICATION_VALIDATE_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loginUsuarioError_ini:)
                                                 name: _NOTIFICATION_VALIDATE_USER_NO_VALID_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loginUsuarioBaneado_ini:)
                                                 name: _NOTIFICATION_VALIDATE_USER_BANEADO_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet_ini:)
                                                 name: _NOTIFICATION_VALIDATE_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful_ini:)
                                                 name: _NOTIFICATION_VALIDATE_USER_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loginUser];
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
                                             selector: @selector(loadUserSuccessful_ini:) 
                                                 name: _NOTIFICATION_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet_ini:) 
                                                 name: _NOTIFICATION_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful_ini:) 
                                                 name: _NOTIFICATION_USER_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadUsuario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadTiposCocina {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadTiposCocinaSuccessful_ini:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet_ini:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful_ini:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadTiposCocina];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkActiveEnMesa
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkActiveEnMesa {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_EN_MESA_ACTIVE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_EN_MESA_ACTIVE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_EN_MESA_ACTIVE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(checkActiveEnMesaSuccessful_ini:)
                                                 name: _NOTIFICATION_EN_MESA_ACTIVE_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet_ini:)
                                                 name: _NOTIFICATION_EN_MESA_ACTIVE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful_ini:)
                                                 name: _NOTIFICATION_EN_MESA_ACTIVE_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkActiveEnMesa];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNewOrders
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNewOrders {
    
    // Comprobamos si se ha iniciado sesión con un usuario
    if (!globalVar.B_usuario_registrado) return;
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_NEW_ORDERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_NEW_ORDERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_NEW_ORDERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(checkNewOrdersSuccessful_ini:)
                                                 name: _NOTIFICATION_NUM_NEW_ORDERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet_ini:)
                                                 name: _NOTIFICATION_NUM_NEW_ORDERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful_ini:)
                                                 name: _NOTIFICATION_NUM_NEW_ORDERS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkNewOrders];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNumberofregisters
//#	Fecha Creación	: 25/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNumberofregisters {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_REGRISTROS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_REGRISTROS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_REGRISTROS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(checkNumberofregistersSuccessful_ini:)
                                                 name: _NOTIFICATION_NUM_REGRISTROS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet_ini:)
                                                 name: _NOTIFICATION_NUM_REGRISTROS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful_ini:)
                                                 name: _NOTIFICATION_NUM_REGRISTROS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkNumberofregisters];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioSuccessful_ini:(NSNotification *)notification {

    // Cargamos los datos del Usuario
    [self loadUsuario];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioError
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioError_ini:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Iniciamos el NavigationController que debe activarse
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    [self updateNavigationControllerToIndex:-1 popRoot:FALSE];
    
    // Mostramos Tabbar Principal
    [self showTabbarPrincipal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioBaneado
//#	Fecha Creación	: 19/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioBaneado_ini:(NSNotification *)notification {
    
    // Iniciamos el Usuario
    [globalVar setB_usuario_registrado:FALSE];
    
    // Actualizamos propiedad
    [globalVar.UC_user setNSI_id:_ID_USER_NO_REGISTRADO_];
    
    // Actualizamos ls BB.DD
    [globalVar.CDC_coreData updateUser:globalVar.UC_user];
    
    // Borramos todas las tarjetas
    [globalVar.CDC_coreData removeAllCreaditCard];
    
    // Actualizamos el globo de la barra
    [globalVar setNSI_num_new_order:0];
    [globalVar.TPVC_principal updateGlobo];
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Iniciamos el NavigationController que debe activarse
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    [self updateNavigationControllerToIndex:-1 popRoot:FALSE];
    
    // Mostramos Tabbar Principal
    [self showTabbarPrincipal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUserSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUserSuccessful_ini:(NSNotification *)notification {
    
    // Iniciamos que se ha cargado un usuario
    [globalVar setB_usuario_registrado:TRUE];
    
    // Realizamos la primera comprobación de New Order
    [self initThreadChekNewOrders];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocinaSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadTiposCocinaSuccessful_ini:(NSNotification *)notification {
    
    // Comprobamos si el menú "En Mesa" está activo o no
    //[self checkActiveEnMesa];
    [globalVar setB_active_en_mesa:FALSE];
    
    [self checkNumberofregisters];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkActiveEnMesaSuccessful
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkActiveEnMesaSuccessful_ini:(NSNotification *)notification {
    
    // Comprobamos si el menú "En Mesa" está activo o no
    [self checkNumberofregisters];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNumberofregistersSuccessful
//#	Fecha Creación	: 25/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNumberofregistersSuccessful_ini:(NSNotification *)notification {
    
    // Iniciamos el NavigationController que debe activarse
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    [self updateNavigationControllerToIndex:-1 popRoot:FALSE];
    
    // Mostramos Tabbar Principal
    [self showTabbarPrincipal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNewOrdersSuccessful
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNewOrdersSuccessful_ini:(NSNotification *)notification {
    
    // Actualizamos el globo de la barra
    [globalVar.TPVC_principal updateGlobo];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet_ini:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
    
    // Iniciamos el NavigationController que debe activarse
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    [self updateNavigationControllerToIndex:-1 popRoot:FALSE];
    
    // Mostramos Tabbar Principal
    [self showTabbarPrincipal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful_ini:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Iniciamos el NavigationController que debe activarse
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    [self updateNavigationControllerToIndex:-1 popRoot:FALSE];
    
    // Mostramos Tabbar Principal
    [self showTabbarPrincipal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : goNavigatioControllerPrincipal
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goNavigatioControllerPrincipal:(NSNotification *)notification {
    
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
    
    // Nos posicionamos en el primer View Controller
    //[UINC_navigation popToRootViewControllerAnimated:TRUE];
    [UINC_navigation popViewControllerAnimated:TRUE];
    
    // Iniciamos los Button Tabbar Principal
    [globalVar.TPVC_principal initTabbarButtonsStatus];
    
    // Marcamos que se ha de mostra la Tabbar principal
    [self setB_show_Tabbar_Principal:TRUE];
    
    // Actualizamos propiedad locales
    [self setB_principal_page:TRUE];
    
    // Actualizamos propiedad globales
    [globalVar setB_origen_mi_saco:FALSE];
    [globalVar setB_come_from_historial:FALSE];
    
    // Buscamos el Tabbar que se esta mostrando para ocultarla
    BOOL B_hide = FALSE;
    if (globalVar.TPVC_restaurante.view.frame.origin.y == 0.0f) { [self hideTabbarRestaurante]; B_hide = TRUE; }
    if (globalVar.TPVC_domicilio.view.frame.origin.y   == 0.0f) { [self hideTabbarDomicilio]; B_hide = TRUE; }
    if (globalVar.TPVC_antesllegar.view.frame.origin.y == 0.0f) { [self hideTabbarAntesLlegar]; B_hide = TRUE; }
    if (!B_hide) [self setB_show_Tabbar_Principal:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : goMiActividadController
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goMiActividadController:(NSNotification *)notification {
    
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
    
    // Nos posicionamos en el primer View Controller
    [UINC_navigation popViewControllerAnimated:TRUE];
    
    // Iniciamos los Button Tabbar Principal
    [globalVar.TPVC_principal initTabbarButtonsStatus];
    
    // Realizamos la primera comprobación de New Order
    [self initThreadChekNewOrders];
    
    // Marcamos que se ha de mostra la Tabbar principal
    [self setB_show_Tabbar_Principal:TRUE];
    
    // Actualizamos propiedad
    [self setB_principal_page:TRUE];
    
    // Actualizamos propiedad globales
    [globalVar setB_origen_mi_saco:FALSE];
    [globalVar setB_come_from_historial:FALSE];
    
    // Buscamos el Tabbar que se esta mostrando para ocultarla
    BOOL B_hide = FALSE;
    if (globalVar.TPVC_restaurante.view.frame.origin.y == 0.0f) { [self hideTabbarRestaurante]; B_hide = TRUE; }
    if (globalVar.TPVC_domicilio.view.frame.origin.y   == 0.0f) { [self hideTabbarDomicilio]; B_hide = TRUE; }
    if (globalVar.TPVC_antesllegar.view.frame.origin.y == 0.0f) { [self hideTabbarAntesLlegar]; B_hide = TRUE; }
    if (!B_hide) [self setB_show_Tabbar_Principal:FALSE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_ popRoot:TRUE];
    
    // No esperamos para mostrar el nuevo NavigationViewController
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : goOptions
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goOptions:(NSNotification *)notification {
    
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
    
    // Nos posicionamos en el primer View Controller
    [UINC_navigation popViewControllerAnimated:TRUE];
    
    // Iniciamos los Button Tabbar Principal
    //[globalVar.TPVC_principal initTabbarButtonsStatus];
    
    // Marcamos que se ha de mostra la Tabbar principal
    [self setB_show_Tabbar_Principal:TRUE];
    
    // Actualizamos propiedad
    //[self setB_principal_page:TRUE];
    
    // Buscamos el Tabbar que se esta mostrando para ocultarla
    BOOL B_hide = FALSE;
    if (globalVar.TPVC_restaurante.view.frame.origin.y == 0.0f) { [self hideTabbarRestaurante]; B_hide = TRUE; }
    if (globalVar.TPVC_domicilio.view.frame.origin.y   == 0.0f) { [self hideTabbarDomicilio]; B_hide = TRUE; }
    if (globalVar.TPVC_antesllegar.view.frame.origin.y == 0.0f) { [self hideTabbarAntesLlegar]; B_hide = TRUE; }
    if (!B_hide) [self setB_show_Tabbar_Principal:FALSE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_OPCIONES_ popRoot:TRUE];
    
    // No esperamos para mostrar el nuevo NavigationViewController
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : hideTabbarRestauranteButton
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideTabbarRestauranteButton:(NSNotification *)notification {
 
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Reposicionamos los View
    [globalVar.TPVC_restaurante.view       setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.view.frame.size.width, globalVar.TPVC_restaurante.view.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_tabbar setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.width, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_accion setFrame:CGRectMake(0.0f, 100.0f, globalVar.TPVC_restaurante.UIV_accion.frame.size.width, globalVar.TPVC_restaurante.UIV_accion.frame.size.height)];

    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : showTabbarRestauranteButton
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showTabbarRestauranteButton:(NSNotification *)notification {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 384.0f, 320.0f, 100.0f)];
    
    // Reposicionamos los View
    [globalVar.TPVC_restaurante.view       setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.view.frame.size.width, globalVar.TPVC_restaurante.view.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_tabbar setFrame:CGRectMake(0.0f, 47.0f, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.width, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_accion setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.UIV_accion.frame.size.width, globalVar.TPVC_restaurante.UIV_accion.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Tabbar Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabBarPrincipalViewController
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabBarPrincipalViewController {
    
    // Iniciamos View Controller
    globalVar.TPVC_principal = [[TabbarPrincipalViewController alloc] initWithNibName:@"TabbarPrincipalView" bundle:[NSBundle mainBundle]];
    [UIV_tabbars addSubview:globalVar.TPVC_principal.view];
    
    // Asignamos Delegado
    [globalVar.TPVC_principal setDelegate:self];
    
    // Posicionamos View Controller
    [globalVar.TPVC_principal.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_principal.view.frame.size.width, globalVar.TPVC_principal.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabBarDomicilioViewController
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabBarDomicilioViewController {
    
    // Iniciamos View Controller
    globalVar.TPVC_domicilio = [[TabbarDomicilioViewController alloc] initWithNibName:@"TabbarDomicilioView" bundle:[NSBundle mainBundle]];
    [UIV_tabbars addSubview:globalVar.TPVC_domicilio.view];
    
    // Asignamos Delegado
    [globalVar.TPVC_domicilio setDelegate:self];
    
    // Posicionamos View Controller
    [globalVar.TPVC_domicilio.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_domicilio.view.frame.size.width, globalVar.TPVC_domicilio.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabBarRestauranteViewController
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabBarRestauranteViewController {
    
    // Iniciamos View Controller
    globalVar.TPVC_restaurante = [[TabbarRestauranteViewController alloc] initWithNibName:@"TabbarRestauranteView" bundle:[NSBundle mainBundle]];
    [UIV_tabbars addSubview:globalVar.TPVC_restaurante.view];
    
    // Asignamos Delegado
    [globalVar.TPVC_restaurante setDelegate:self];
    
    // Posicionamos View Controller
    [globalVar.TPVC_restaurante.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_restaurante.view.frame.size.width, globalVar.TPVC_restaurante.view.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_tabbar setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.width, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_accion setFrame:CGRectMake(0.0f, 100.0f, globalVar.TPVC_restaurante.UIV_accion.frame.size.width, globalVar.TPVC_restaurante.UIV_accion.frame.size.height)];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabBarAntesLlegarViewController
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabBarAntesLlegarViewController {
    
    // Iniciamos View Controller
    globalVar.TPVC_antesllegar = [[TabbarAntesLlegarViewController alloc] initWithNibName:@"TabbarAntesLlegarView" bundle:[NSBundle mainBundle]];
    [UIV_tabbars addSubview:globalVar.TPVC_antesllegar.view];
    
    // Asignamos Delegado
    [globalVar.TPVC_antesllegar setDelegate:self];
    
    // Posicionamos View Controller
    [globalVar.TPVC_antesllegar.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_antesllegar.view.frame.size.width, globalVar.TPVC_antesllegar.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showTabbarPrincipal
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showTabbarPrincipal {
    
    // Actualizamos propiedad
    [self setB_show_Tabbar_Principal:FALSE];
    
    // Deselecionamos todos los UIButton de la Tabbar
    if (_B_resetButtonState) [globalVar.TPVC_principal initTabbarButtonsStatus];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Restauramos vaor propiedad
    [self setB_resetButtonState:TRUE];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [globalVar.TPVC_principal.view setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_principal.view.frame.size.width, globalVar.TPVC_principal.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showTabbarDomicilio
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showTabbarDomicilio {
    
    // Actualizamos propiedad
    [self setB_show_Tabbar_Domicilio:FALSE];
    
    // Deselecionamos todos los UIButton de la Tabbar
    [globalVar.TPVC_domicilio initTabbarButtonsStatus];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [globalVar.TPVC_domicilio.view setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_domicilio.view.frame.size.width, globalVar.TPVC_domicilio.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showTabbarRestaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showTabbarRestaurante {
    
    // Actualizamos propiedad
    [self setB_show_Tabbar_Restaurante:FALSE];
    
    // Deselecionamos todos los UIButton de la Tabbar
    [globalVar.TPVC_restaurante initTabbarButtonsStatus];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [globalVar.TPVC_restaurante.view       setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.view.frame.size.width, globalVar.TPVC_restaurante.view.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_tabbar setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.width, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_accion setFrame:CGRectMake(0.0f, 100.0f, globalVar.TPVC_restaurante.UIV_accion.frame.size.width, globalVar.TPVC_restaurante.UIV_accion.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showTabbarAntesLlegar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showTabbarAntesLlegar {
    
    // Actualizamos propiedad
    [self setB_show_Tabbar_AntesLlegar:FALSE];
    
    // Deselecionamos todos los UIButton de la Tabbar
    [globalVar.TPVC_antesllegar initTabbarButtonsStatus];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [globalVar.TPVC_antesllegar.view setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_antesllegar.view.frame.size.width, globalVar.TPVC_antesllegar.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideTabbarPrincipal
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideTabbarPrincipal {
    
    NSLog(@"hideTabbarPrincipal");
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [globalVar.TPVC_principal.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_principal.view.frame.size.width, globalVar.TPVC_principal.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideTabbarDomicilio
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideTabbarDomicilio {
    
    NSLog(@"hideTabbarDomicilio");
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [globalVar.TPVC_domicilio.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_domicilio.view.frame.size.width, globalVar.TPVC_domicilio.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideTabbarRestaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideTabbarRestaurante {
    
    NSLog(@"hideTabbarRestaurante");
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Actualizamos tamaño y posicion UIView tabbar
    [UIV_tabbars setFrame:CGRectMake(0.0f, 431.0f, 320.0f, 49.0f)];
    
    // Reposicionamos los View
    [globalVar.TPVC_restaurante.view       setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_restaurante.view.frame.size.width, globalVar.TPVC_restaurante.view.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_tabbar setFrame:CGRectMake(0.0f, 0.0f, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.width, globalVar.TPVC_restaurante.UIV_tabbar.frame.size.height)];
    [globalVar.TPVC_restaurante.UIV_accion setFrame:CGRectMake(0.0f, 100.0f, globalVar.TPVC_restaurante.UIV_accion.frame.size.width, globalVar.TPVC_restaurante.UIV_accion.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideTabbarAntesLlegar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideTabbarAntesLlegar {
    
    NSLog(@"hideTabbarAntesLlegar");
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [globalVar.TPVC_antesllegar.view setFrame:CGRectMake(0.0f, globalVar.TPVC_restaurante.view.frame.size.height, globalVar.TPVC_antesllegar.view.frame.size.width, globalVar.TPVC_antesllegar.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 30/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    NSLog(@"animationDidStop");
    
    // Abrimos la nueva Tabbar
    if      (_B_show_Tabbar_Principal)   [self showTabbarPrincipal];
    else if (_B_show_Tabbar_Domicilio)   [self showTabbarDomicilio];
    else if (_B_show_Tabbar_Restaurante) [self showTabbarRestaurante];
    else if (_B_show_Tabbar_AntesLlegar) [self showTabbarAntesLlegar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayChangeNavigationController
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayChangeNavigationViewController {
    
    // Marcamos la Tabbar que se debe mostrar
    switch (_NSI_active_index)
    {
        case _TABBAR_INDEX_RESTAURANTE_PEDIR_   : [self setB_show_Tabbar_Restaurante:TRUE]; break;
        case _TABBAR_INDEX_ANTES_LLEGAR_DATOS_  : [self setB_show_Tabbar_AntesLlegar:TRUE]; break;
        case _TABBAR_INDEX_DOMICILIO_BUSCAR_    : [self setB_show_Tabbar_Domicilio:TRUE]; break;
    }
    
    // Ocultamos Tabbar principal
    [self hideTabbarPrincipal];
    
    // Abrimos el NavigationView que corresponde
    [self updateNavigationControllerToIndex:_NSI_active_index popRoot:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayChangeTabbarPrincipalNavigationViewController
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayChangeTabbarNavigationViewController {
    
    // Abrimos el NavigationView que corresponde
    [self updateNavigationControllerToIndex:_NSI_active_index popRoot:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: changeNavigationViewControllerTo
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeNavigationViewControllerTo:(NSInteger)NSI_index popRoot:(BOOL)B_popRoot {
    
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:NSI_index];
    
    // Comprobamos si debemos posicionarnos al principio del NavController
    if (B_popRoot) [UINC_navigation popToRootViewControllerAnimated:FALSE];
    
    // Colocamos el NavigationController que corresponda
    self.window.rootViewController = UINC_navigation;
    
    // Insertamos LoadingView Controller
    [self.window.rootViewController.view addSubview:globalVar.LVC_loading.view];
    
    // Insertamos Tabbar Controller
    [self.window.rootViewController.view addSubview:UIV_tabbars];
    
    // Actualizamos Index actual
    [self setNSI_active_index:NSI_index];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_restaurante_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_restaurante_Touched {

    // Comprobamos si este tipo de pedido está pemitido
    if (!globalVar.B_active_en_mesa) return;
    
    // Comprobamos si venimos de "Mi Saco"
    if ((globalVar.B_come_from_mi_saco) && 
        (globalVar.B_realizando_pedido) && 
        (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
        (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        // Iniciamos variable
        [globalVar setB_come_from_mi_saco:FALSE];
    }
    else {

        // Iniciamos OrderClass
        globalVar.OC_order = [[OrderClass alloc] init];
        
        // Iniciamos propiedad global
        [globalVar setB_realizando_pedido:TRUE];
        
        // Actualizamos propieda que indica el tipo de pedido seleccionado
        [globalVar.OC_order setTOT_type:TOT_pedido_en_el_restaurante];
    }
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_RESTAURANTE_PEDIR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_antes_llegar_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_antes_llegar_Touched {
    
    // Posicionamos "Mi pedido" principio
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_ANTES_LLEGAR_MI_PEDIDO_];
    [UINC_navigation popToRootViewControllerAnimated:FALSE];

    // Comprobamos si venimos de "Mi Saco"
    if ((globalVar.B_come_from_mi_saco) && 
        (globalVar.B_realizando_pedido) && 
        (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
        (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        // Iniciamos variable
        [globalVar setB_come_from_mi_saco:FALSE];
    }
    else {
        
        // Iniciamos OrderClass
        globalVar.OC_order = [[OrderClass alloc] init];
        
        // Iniciamos propiedad global
        [globalVar setB_realizando_pedido:TRUE];
        
        // Actualizamos propieda que indica el tipo de pedido seleccionado
        [globalVar.OC_order setTOT_type:TOT_pedido_antes_de_ir_al_restaurante];
    }
    
    // Iniciamos SerachRestaurantClass
    globalVar.SRC_search = [[SearchRestaurantClass alloc] init];
    
    // Pasamos el Pedido a Cocina
    [globalVar setB_datos_introducidos:FALSE];
    
    // Reiniciamos Tabbar
    [globalVar.TPVC_antesllegar resetGlobo];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_ANTES_LLEGAR_DATOS_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_domicilio_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_Touched {

    // Posicionamos "Mi pedido" principio
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_DOMICILIO_MI_PEDIDO_];
    [UINC_navigation popToRootViewControllerAnimated:FALSE];
    
    // Comprobamos si venimos de "Mi Saco"
    if ((globalVar.B_come_from_mi_saco) && 
        (globalVar.B_realizando_pedido) && 
        (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
        (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        // Actualizamos propiedad
        [globalVar setB_come_from_mi_saco:FALSE];
    }
    else if (globalVar.B_come_from_historial)
    {
        // Cambiamos el NavigationViewController
        [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:TRUE];
        
        // Abrimos el NavigationView que corresponde
        [self updateNavigationControllerToIndex:_NSI_active_index popRoot:TRUE];
        
        // Marcamos Tabbar
        [globalVar.TPVC_domicilio updateTabBarforIndex:0];
        
        return;
    }
    else {
        
        // Iniciamos OrderClass
        globalVar.OC_order = [[OrderClass alloc] init];
        
        // Iniciamos propiedad global
        [globalVar setB_realizando_pedido:TRUE];
        
        // Actualizamos propieda que indica el tipo de pedido seleccionado
        [globalVar.OC_order setTOT_type:TOT_pedido_a_domicilio];
    }
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_recoger_comida_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_recoger_comida_Touched {
    
    // Posicionamos "Mi pedido" principio
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_DOMICILIO_MI_PEDIDO_];
    [UINC_navigation popToRootViewControllerAnimated:FALSE];

    
    // Comprobamos si venimos de "Mi Saco"
    if ((globalVar.B_come_from_mi_saco) && 
        (globalVar.B_realizando_pedido) && 
        (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
        (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        // Iniciamos variable
        [globalVar setB_come_from_mi_saco:FALSE];
    }
    else {
        
        // Iniciamos OrderClass
        globalVar.OC_order = [[OrderClass alloc] init];
        
        // Iniciamos propiedad global
        [globalVar setB_realizando_pedido:TRUE];
        
        // Actualizamos propieda que indica el tipo de pedido seleccionado
        [globalVar.OC_order setTOT_type:TOT_pedido_para_recoger];
    }
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_reservar_mesa_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_reservar_mesa_Touched {
    
    // Comprobamos si venimos de "Mi Saco"
    if ((globalVar.B_come_from_mi_saco) && 
        (globalVar.B_realizando_pedido) && 
        (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) && 
        (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        // Iniciamos variable
        [globalVar setB_come_from_mi_saco:FALSE];

        // Nos posicionamos en el NavigationBar correspondiente
        [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_OPCIONES_];
        UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
        
        // Cambiamos el NavigationViewController
        [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_OPCIONES_ popRoot:TRUE];
        
        // Creamos RestauranteShortInfoViewController
        _RVC_reservar = [[ReservarViewController alloc] initWithNibName:@"ReservarView" bundle:[NSBundle mainBundle]];
        
        // Asignamos delegado
        [_RVC_reservar setDelegate:self];
        
        // Nos posicionamos en el primer View Controller
        [UINC_navigation pushViewController:_RVC_reservar animated:YES];
    }
    else {
        
        // Iniciamos OrderClass
        globalVar.OC_order = [[OrderClass alloc] init];
        
        // Iniciamos propiedad global
        [globalVar setB_realizando_pedido:TRUE];
        
        // Actualizamos propieda que indica el tipo de pedido seleccionado
        [globalVar.OC_order setTOT_type:TOT_reserva];
        
        // Iniciamos SerachRestaurantClass
        globalVar.SRC_search = [[SearchRestaurantClass alloc] init];
        
        UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_TABBAR_INDEX_PRINCIPAL_OPCIONES_];
        
        // Creamos RestauranteShortInfoViewController
        _RSIC_restaurante = [[RestauranteShortInfoViewController alloc] initWithNibName:@"RestauranteShortInfoView" bundle:[NSBundle mainBundle]];
        
        // Asignamos delegado
        [_RSIC_restaurante setDelegate:self];
        
        // Cambiamos el NavigationViewController
        [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_OPCIONES_ popRoot:TRUE];
        
        // Nos posicionamos en el primer View Controller
        [UINC_navigation pushViewController:_RSIC_restaurante animated:YES];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_help_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_help_Touched {
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_HELP_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeTabbarNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_settings_Touched
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_settings_Touched {
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Actualizamos propiedad
    [globalVar setB_options:TRUE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_OPCIONES_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                 target:self
                                               selector:@selector(delayChangeTabbarNavigationViewController)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_restaurante_withoutDelay_Touched
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_restaurante_withoutDelay_Touched {
    
    // Comprobamos si este tipo de pedido está pemitido
    if (!globalVar.B_active_en_mesa) {
     
        UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
        [UINC_navigation popToRootViewControllerAnimated:TRUE];
        return;
    }
    
    // Iniciamos OrderClass
    globalVar.OC_order = [[OrderClass alloc] init];
    
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_en_el_restaurante];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_RESTAURANTE_PEDIR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    [self delayChangeNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_antes_llegar_withoutDelay_Touched
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_antes_llegar_withoutDelay_Touched {
    
    // Iniciamos OrderClass
    globalVar.OC_order = [[OrderClass alloc] init];
    
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_antes_de_ir_al_restaurante];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_ANTES_LLEGAR_DATOS_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    [self delayChangeNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_domicilio_withoutDelay_Touched
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_withoutDelay_Touched {
    
    // Iniciamos OrderClass
    globalVar.OC_order = [[OrderClass alloc] init];
    
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_a_domicilio];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    [self delayChangeNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_recoger_comida_withoutDelay_Touched
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_recoger_comida_withoutDelay_Touched {
    
    // Iniciamos OrderClass
    globalVar.OC_order = [[OrderClass alloc] init];
        
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_para_recoger];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:TRUE];
    
    // Esperamos antes de cambiar el Navigation controller
    [self delayChangeNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_reserva_Touched {
    
    // Actualizamos propiedad
    [globalVar setB_login_from_reserva:FALSE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_OPCIONES_ popRoot:FALSE];

    /*
    // Nos posicionamos en el NavigationBar correspondiente
    [self setNSI_active_index:_TABBAR_INDEX_PRINCIPAL_OPCIONES_];
    UINavigationController *UINC_navigation = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:_NSI_active_index];
    
    // Retrocedmos en el Navigation
    [UINC_navigation popViewControllerAnimated:YES];
     */
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_mi_activida_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_activida_Touched {
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        // Desplazamos "Mi cuenta"
        [self Tabbar_mi_cuenta_Touched];
        
        // Actualizamos menu seleccionado
        [globalVar.TPVC_principal updateTabBarforIndex:2];
        
        return;
    }
    
    // Realizamos la primera comprobación de New Order
    [self initThreadChekNewOrders];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_ popRoot:TRUE];
    
    // comprobamo si estamos en la pantalla principal
    if (_B_principal_page) {
        
        // Esperamos antes de cambiar el Navigation controller
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                     target:self
                                                   selector:@selector(delayChangeTabbarNavigationViewController)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {

        // No esperamos para mostrar el nuevo NavigationViewController
        [self delayChangeTabbarNavigationViewController];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_mi_saco_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_saco_Touched:(BOOL)B_resetTabbarButton {
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    /*
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_MI_SACO_ message:_ALERT_MSG_NO_REGISTRADO_MI_SACO_];
        
        // Desplazamos "Mi cuenta"
        [self Tabbar_mi_cuenta_Touched];
        
        // Actualizamos menu seleccionado
        [globalVar.TPVC_principal updateTabBarforIndex:2];
        
        return;
    }
     */
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_MI_SACO_ popRoot:TRUE];
    
    // Comprobamo si debemos marcar el menú como activo
    if (!B_resetTabbarButton) {
        
        // Restauramos vaor propiedad
        [self setB_resetButtonState:FALSE];
        
        // Iniciamos los Button Tabbar Principal
        [globalVar.TPVC_principal updateTabBarforIndex:1];
        
        // Marcamos que se ha de mostra la Tabbar principal
        [self setB_show_Tabbar_Principal:TRUE];
        
        // Buscamos el Tabbar que se esta mostrando para ocultarla
        BOOL B_hide = FALSE;
        if (globalVar.TPVC_domicilio.view.frame.origin.y   == 0.0f) { [self hideTabbarDomicilio]; B_hide = TRUE; }
        if (globalVar.TPVC_restaurante.view.frame.origin.y == 0.0f) { [self hideTabbarRestaurante]; B_hide = TRUE; }
        if (globalVar.TPVC_antesllegar.view.frame.origin.y == 0.0f) { [self hideTabbarAntesLlegar]; B_hide = TRUE; }
        if (!B_hide) [self setB_show_Tabbar_Principal:FALSE];
    }
    
    // Comprobamo si estamos en la pantalla principal
    if (_B_principal_page) {
        
        // Esperamos antes de cambiar el Navigation controller
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                     target:self
                                                   selector:@selector(delayChangeTabbarNavigationViewController)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {
        
        // No esperamos para mostrar el nuevo NavigationViewController
        [self delayChangeTabbarNavigationViewController];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_cuenta_Touched {
    
    // Actualizamos propiedad
    [globalVar setB_options:FALSE];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_PRINCIPAL_MI_CUENTA_ popRoot:TRUE];
    
    // Comprobamo si estamos en la pantalla principal
    if (_B_principal_page) {
        
        // Esperamos antes de cambiar el Navigation controller
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHANGE_NAVIGATION_CONTROLLER_
                                                     target:self
                                                   selector:@selector(delayChangeTabbarNavigationViewController)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {
        
        // No esperamos para mostrar el nuevo NavigationViewController
        [self delayChangeTabbarNavigationViewController];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_buscar_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_dom_buscar_Touched {
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_domicilio updateTabBarforIndex:0];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_mi_pedido_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_dom_mi_pedido_Touched {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        // Desplazamos "Mi cuenta"
        [self Tabbar_mi_cuenta_Touched];
        
        // Actualizamos menu seleccionado
        [globalVar.TPVC_principal updateTabBarforIndex:2];
        
        return;
    }
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_domicilio updateTabBarforIndex:1];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_MI_PEDIDO_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_dom_historial_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_dom_historial_Touched {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        // Desplazamos "Mi cuenta"
        [self Tabbar_mi_cuenta_Touched];
        
        // Actualizamos menu seleccionado
        [globalVar.TPVC_principal updateTabBarforIndex:2];
        
        return;
    }
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_domicilio updateTabBarforIndex:2];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_HISTORIAL_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_rst_pedir_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_rst_pedir_Touched {

    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_restaurante updateTabBarforIndex:0];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_RESTAURANTE_PEDIR_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_rst_en_cocina_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_rst_en_cocina_Touched {
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_restaurante updateTabBarforIndex:1];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_RESTAURANTE_EN_COCINA_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_rst_pagar_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_rst_pagar_Touched {

    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_restaurante updateTabBarforIndex:2];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_RESTAURANTE_PAGAR_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_pre_datos_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_pre_datos_Touched {
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_antesllegar updateTabBarforIndex:0];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_ANTES_LLEGAR_DATOS_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_pre_pedir_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_pre_pedir_Touched {

    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_antesllegar updateTabBarforIndex:1];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_ANTES_LLEGAR_PEDIR_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_pre_mi_pedido_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_pre_mi_pedido_Touched {
    
    // Actualizamos UIButton Tabbar pulsado
    [globalVar.TPVC_antesllegar updateTabBarforIndex:2];
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_ANTES_LLEGAR_MI_PEDIDO_ popRoot:FALSE];
    [self delayChangeTabbarNavigationViewController];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: back_pedir_domicilio_Touched
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) back_pedir_domicilio_Touched {
    
    // Cambiamos el NavigationViewController
    [self changeNavigationViewControllerTo:_TABBAR_INDEX_DOMICILIO_BUSCAR_ popRoot:FALSE];
    
    // Marcamos la Tabbar que se debe mostrar
    switch (_NSI_active_index)
    {
        case _TABBAR_INDEX_RESTAURANTE_PEDIR_   : [self setB_show_Tabbar_Restaurante:TRUE]; break;
        case _TABBAR_INDEX_ANTES_LLEGAR_DATOS_  : [self setB_show_Tabbar_AntesLlegar:TRUE]; break;
        case _TABBAR_INDEX_DOMICILIO_BUSCAR_    : [self setB_show_Tabbar_Domicilio:TRUE]; break;
    }
    
    // Ocultamos Tabbar principal
    [self hideTabbarPrincipal];
}

#pragma mark -
#pragma mark Backround Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: Sent when the application is about to move from active to inactive state. This can occur for certain types 
//#                   of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application 
//#                   and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers, 
//#                   and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//#
-(void) applicationWillResignActive:(UIApplication *)application {
    
    // Cancelamos los NSTimers
    [self invalidateAllTimer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Use this method to release shared resources, save user data, invalidate timers, and store enough application 
//#                   state information to restore your application to its current state in case it is terminated later. If your 
//#                   application supports background execution, this method is called instead of applicationWillTerminate: when the 
//#                   user quits.
//#
-(void) applicationDidEnterBackground:(UIApplication *)application {
    
    //purge img cache
    if ([[ImgCacheManager sharedInstance] cacheImgs]) {
        [[ImgCacheManager sharedInstance] setCacheImgs:nil];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: Called as part of the transition from the background to the inactive state; here you can undo many of the changes 
//#                   made on entering the background.
//#
-(void) applicationWillEnterForeground:(UIApplication *)application {
    
    // App review
    [Appirater appEnteredForeground:YES];
    
    // Cancelamos los NSTimers
    [self invalidateAllTimer];
    
    // Comprobamos usuario
    if (globalVar.B_usuario_registrado) [self loginUsuario];
    
    // Iniciamos el Timer que controla las alarmas
    _NST_timer_chec_new_orders = [NSTimer scheduledTimerWithTimeInterval:_DELAY_CHECK_NEW_ORDERS_
                                                                  target:self
                                                                selector:@selector(initThreadChekNewOrders)
                                                                userInfo:nil
                                                                 repeats:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Restart any tasks that were paused (or not yet started) while the application was inactive. If the application 
//#                   was previously in the background, optionally refresh the user interface.
//#
-(void) applicationDidBecomeActive:(UIApplication *)application {
    
    // Although the SDK attempts to refresh its access tokens when it makes API calls,
    // it's a good practice to refresh the access token also when the app becomes active.
    // This gives apps that seldom make api calls a higher chance of having a non expired
    // access token.
    //[[self facebook] extendAccessTokenIfNeeded];
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Called when the application is about to terminate.
//#                   Save data if appropriate. 
//#                   See also applicationDidEnterBackground:.
//#
-(void) applicationWillTerminate:(UIApplication *)application {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : application:handleOpenURL:
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [self.facebook handleOpenURL:url];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : application:openURL:sourceApplication:annotation:
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [self.facebook handleOpenURL:url];
}

@end
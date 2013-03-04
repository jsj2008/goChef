//
//  RestaurantePedirContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestaurantePedirContenedorViewController.h"
#import "RestaurantePedirConfirmacionViewController.h"
#import "LoadingViewController.h"
#import "PedidoViewController.h"
#import "TabbarRestauranteViewController.h"

#import "SearchRestaurantClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"
#import "UserClass.h"
#import "CoreDataClass.h"


@implementation RestaurantePedirContenedorViewController

@synthesize UITF_mesa_01;
@synthesize UITF_mesa_02;
@synthesize UITF_mesa_03;
@synthesize UITF_mesa_04;
@synthesize UIL_restaurante;

@synthesize SRVC_resturantes = _SRVC_resturantes;
@synthesize RPCVS_confirmar = _RPCVS_confirmar;
@synthesize PVC_pedir = _PVC_pedir;

@synthesize B_confirmado = _B_confirmado;

@synthesize delegate = _delegate;

UIAlertView *UIAV_alert;


#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_confirmado
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_confirmado:(BOOL)B_confirmado {
    
    _B_confirmado = B_confirmado;
    
    // Construimos la UIImage del UIButton de Tabbar
    UIImage *UII_image;
    if (_B_confirmado) UII_image = [UIImage imageNamed:@"button_enviar_a_cocina.png"];
    else UII_image = [UIImage imageNamed:@"button_confirmar_pedido.png"];

    // Actualizamos UIButton de la Tabbar
    [globalVar.TPVC_restaurante.UIB_accion setImage:UII_image forState:UIControlStateNormal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSRVC_resturantes
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSRVC_resturantes:(SelectRestaurantesViewController *)SRVC_resturantes {
    
    _SRVC_resturantes = SRVC_resturantes;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPVC_pedir
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPVC_pedir:(PedidoViewController *)PVC_pedir {
    
    _PVC_pedir = PVC_pedir;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRPCVS_confirmar
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRPCVS_confirmar:(RestaurantePedirConfirmacionViewController *)RPCVS_confirmar {
    
    _RPCVS_confirmar = RPCVS_confirmar;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos SerachRestaurantClass
    globalVar.SRC_search = [[SearchRestaurantClass alloc] init];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Pasamos el Pedido a Cocina
    [globalVar setB_pedido_en_cocina:FALSE];
    
    // Asignamos delegados
    [UITF_mesa_01 setDelegate:self];
    [UITF_mesa_02 setDelegate:self];
    [UITF_mesa_03 setDelegate:self];
    [UITF_mesa_04 setDelegate:self];
    
    // Asignamos delegados
    [UITF_mesa_01 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [UITF_mesa_02 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [UITF_mesa_03 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [UITF_mesa_04 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Mostramos el teclado
    [UITF_mesa_01 becomeFirstResponder];
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ENVIAR_COCINA_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEGUIR_PIDIENDO_ object:nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(enviarACocina:) 
                                                 name: _NOTIFICATION_ENVIAR_COCINA_
                                               object: nil];
    
    // Añadimos NSNotificationCenter para QRcode escaneado es correcto
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(seguirPidiendo:) 
                                                 name: _NOTIFICATION_SEGUIR_PIDIENDO_
                                               object: nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Pedir";
    
    // Iniciamos propiedades
    [self setB_confirmado:FALSE];
    
    // Iniciamos componentes formulario
    [UITF_mesa_01    setText:@""];
    [UITF_mesa_02    setText:@""];
    [UITF_mesa_03    setText:@""];
    [UITF_mesa_04    setText:@""];
    
    // Comprobamos si ya se está mostrando
    if (_SRVC_resturantes != nil) [self close_select_restaurante];
    
    // Comprobamos si ya se ha seleccionado el retaurante (se viene de "Mi Saco")
    if (globalVar.OC_order.NSI_idrestaurant != _ID_RESTAURANT_NO_SELECTED_) [UIL_restaurante setText:globalVar.OC_order.RC_restaurant.NSS_name];
    else [UIL_restaurante setText:@""];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_       object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_        object:nil];
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_ERROR_       object:nil];
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
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Acualizamos propiedad
    [globalVar setB_realizando_pedido:FALSE];
    
    // Reiniciamos Order
    [globalVar.OC_order reset];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                        object:self];
    
    // Volvemos Viewcontroller padre
    //[self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkTableNumber
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumber {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_       object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_        object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(checkTableNumberSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(checkTableNumberError:) 
                                                 name: _NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_
                                               object: nil];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y - 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkTableNumber];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setOrder
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOrder {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(setOrderSuccessful:) 
                                                 name: _NOTIFICATION_SET_ORDERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_ORDERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_ORDERS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading setOrder];
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

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : sendReporte
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) sendReporte {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_REPORT_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_REPORT_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_REPORT_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(sendReporteSuccessful:)
                                                 name: _NOTIFICATION_SEND_ORDER_REPORT_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_SEND_ORDER_REPORT_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_SEND_ORDER_REPORT_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading sendReporte];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : theTimer
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
- (void) theTimer: (NSTimer *) timer {
    
    [UIAV_alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioSuccessful
//#	Fecha Creación	: 22/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioSuccessful:(NSNotification *)notification {
    
    // Cargamos los datos del Usuario
    [self setOrder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioError
//#	Fecha Creación	: 22/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioError:(NSNotification *)notification {
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUsuarioBaneado
//#	Fecha Creación	: 22/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loginUsuarioBaneado:(NSNotification *)notification {
    
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
    
    // Mostramos mensaje de Error
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : enviarACocina
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) enviarACocina:(NSNotification *)notification {
    
    // Comprobamo si ya esta confirmado
    if (!_B_confirmado) {
        
        [NSTimer scheduledTimerWithTimeInterval: 4.0f target: self selector:@selector(theTimer:) userInfo: nil repeats: NO];
        UIAV_alert = [[UIAlertView alloc] initWithTitle:@"Información"
                                                message:@"Revisa el pedido y cuando estés listo pulsa Enviar a Cocina."
                                               delegate: nil
                                      cancelButtonTitle: nil
                                      otherButtonTitles: @"OK", nil];
        [UIAV_alert show];
        
        
        // Creamos RestaurantePedirConfirmacionViewController
        _RPCVS_confirmar = [[RestaurantePedirConfirmacionViewController alloc] initWithNibName:@"RestaurantePedirConfirmacionView" bundle:[NSBundle mainBundle]];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_RPCVS_confirmar animated:YES];
        
        // Actualizamos propiedad
        [self setB_confirmado:TRUE];
    }
    else {
        
        // Comprobamos si al menos se ha seleccionado un plato
        if ([globalVar.OC_order.NSMA_orderfoods count] == 0) {
            
            // Mostramos mensaje de error
            [globalVar showAlerMsgWith:@"Error" 
                               message:@"Debe seleccionar al menos un plato de la carta o menús."];
            
            return;
        }
        
        // Comprobamos si se ha resgistrado
        if (globalVar.B_usuario_registrado) {
            
            // Mostramos mensage de confirmación
            UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
            [UIAV_confirm setTitle:@"Confirmación"];
            [UIAV_confirm setMessage:@"¿Está seguro de que quiere enviar el pedido a cocina? No podrá realizar más modificaciones."];
            [UIAV_confirm setDelegate:self];
            [UIAV_confirm addButtonWithTitle:@"Si"];
            [UIAV_confirm addButtonWithTitle:@"No"];
            [UIAV_confirm show];
        }
        else {
            
            // Mostramos mensaje de error
            [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
            
            // Generamos la notificación que indica que se ha de ir a la Navigation Principal
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                                object:self];
            
            // Indicamos al delegado que se ha pulsado sobre la celda
            if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : seguirPidiendo
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) seguirPidiendo:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setB_confirmado:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setOrderSuccessful02
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setOrderSuccessful:(NSNotification *)notification {
    
    // ENviamos correo de confirmación
    [self sendReporte];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : sendReporteSuccessful
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) sendReporteSuccessful:(NSNotification *)notification {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_ERROR_       object:nil];
    
    // Pasamos el Pedido a Cocina
    [globalVar setB_pedido_en_cocina:TRUE];
    
    // Actualizamos propiedad
    [self setB_confirmado:FALSE];
    
    // Actualizamos idOrder
    [globalVar.OC_order_en_cocina setNSI_idorder:globalVar.OC_order.NSI_idorder];
    
    // Reseteamos Order
    [globalVar.OC_order resetFood];
    
    // Recuperamos el number actual del globo
    NSString *NSS_number_order     = globalVar.TPVC_restaurante.UIL_pedir_globo.text;
    NSString *NSS_number_en_cocina = globalVar.TPVC_restaurante.UIL_en_cocina_globo.text;
    NSInteger NSI_number = [NSS_number_order integerValue] + [NSS_number_en_cocina integerValue];
    
    // Reseteamos Tabbar globos
    [globalVar.TPVC_restaurante pedir_globo_reset];
    [globalVar.TPVC_restaurante en_cocina_globo_init:NSI_number];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_rst_en_cocina_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkTableNumberSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumberSuccessful:(NSNotification *)notification {
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
    
    // Creamos PedidoViewController
    _PVC_pedir = [[PedidoViewController alloc] initWithNibName:@"PedidoView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_PVC_pedir animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkTableNumberError
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumberError:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NUM_TABLE_ message:_ALERT_MSG_NUM_TABLE_];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
    
    // Posicionamos el LoadingView
    [globalVar.LVC_loading.view setFrame:CGRectMake(globalVar.LVC_loading.view.frame.origin.x, (globalVar.LVC_loading.view.frame.origin.y + 80.0f), globalVar.LVC_loading.view.frame.size.width, globalVar.LVC_loading.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
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
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado 
    if (buttonIndex == 0) {
        
        // Comprobamos si ya hay pedidos en cocina
        if (globalVar.B_pedido_en_cocina) {
            
            // Añadimos Food, Offer y Facebook Offer
            [globalVar.OC_order_en_cocina update:globalVar.OC_order];
        }
        else {
            
            // Guardamos Order que se envia a cocina
            globalVar.OC_order_en_cocina = [[OrderClass alloc] init];
            [globalVar.OC_order_en_cocina copy:globalVar.OC_order];
        }
        
        // Enviamos pedido
        [self loginUsuario];
    }
}

#pragma mark -
#pragma mark Keyboard Notifications Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    // Quitamos el View Select Tipo Cocina
    [self close_select_restaurante];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_restaurante_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_restaurante_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if (_SRVC_resturantes != nil) return;
    
    // Creamos SelectTipoTarjetaViewController
    _SRVC_resturantes = [[SelectRestaurantesViewController alloc] initWithNibName:@"SelectRestaurantesView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SRVC_resturantes setDelegate:self];
    
    // Iniciamos Propiedades
    [_SRVC_resturantes setContentWith:UIL_restaurante.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SRVC_resturantes.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SRVC_resturantes.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SRVC_resturantes.view.frame.size.width, _SRVC_resturantes.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SRVC_resturantes.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SRVC_resturantes.view.frame.size.height), _SRVC_resturantes.view.frame.size.width, _SRVC_resturantes.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Mostramos el teclado
    [UITF_mesa_01 resignFirstResponder];
    [UITF_mesa_02 resignFirstResponder];
    [UITF_mesa_03 resignFirstResponder];
    [UITF_mesa_04 resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_confirmar_restaurante_mesa_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_confirmar_restaurante_mesa_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha seleccionado un restaurante
    if ([UIL_restaurante.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe seleccionar el restaurante donde se encuentra."];
        return;
    }
    
    // Comprobamos si se ha seleccionado una mesa
    if ( ([UITF_mesa_01.text length] == 0) || ([UITF_mesa_02.text length] == 0) || ([UITF_mesa_03.text length] == 0) || ([UITF_mesa_04.text length] == 0) ) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir los 4 dígitos de la mesa."];
        return;
    }
    
    // Guardamos el numero de mesa introducido
    NSString *NSS_code = [NSString stringWithFormat:@"%@%@%@%@", UITF_mesa_01.text, UITF_mesa_02.text, UITF_mesa_03.text, UITF_mesa_04.text];
    [globalVar.OC_order setNSI_number_table:[NSS_code integerValue]];
     
    // Comprobamos la disponibilidad de la mesa
    [self checkTableNumber];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : textFieldDidChange
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) textFieldDidChange:(id)sender {
   
    UITextField *UITF_text = (UITextField *)sender;
    
    // Comprobamos si el tamaño es mayor de 1
    if ([UITF_text.text length] > 1) {
        NSRange NSR_range = NSMakeRange (0, 1);  
        NSString *NSS_text = [UITF_text.text substringWithRange:NSR_range];
        [UITF_text setText:NSS_text];
    }
    
    // Comprobamos en que TextField estamos
    if (UITF_text.tag == 1) [UITF_mesa_02 becomeFirstResponder];
    if (UITF_text.tag == 2) [UITF_mesa_03 becomeFirstResponder];
    if (UITF_text.tag == 3) [UITF_mesa_04 becomeFirstResponder];
    //if (UITF_text.tag == 4) [UITF_mesa_01 becomeFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_restaurante
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_restaurante:(RestaurantClass *)RC_restaurant {
    
    // Actualizamos UILabel
    [UIL_restaurante setText:RC_restaurant.NSS_name];
    
    // Marcamos el restaurante
    [globalVar.OC_order setRC_restaurant:RC_restaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_restaurante {
    
    // Mostramos el teclado
    [UITF_mesa_01 becomeFirstResponder];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SRVC_resturantes.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SRVC_resturantes.view.frame.size.width, _SRVC_resturantes.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Quitamos el View Select Tipo Cocina
    [_SRVC_resturantes.view removeFromSuperview];
    
    // Liberamos memoria
    _SRVC_resturantes = nil;
}


@end
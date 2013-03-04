//
//  DireccionesViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DireccionesViewController.h"
#import "LoadingViewController.h"
#import "DomicilioDireccionFormViewController.h"

#import "DireccionClass.h"
#import "SearchRestaurantClass.h"
#import "OrderClass.h"


@implementation DireccionesViewController

@synthesize UIL_direccion;
@synthesize UIL_direccion_01;
@synthesize UIL_direccion_02;
@synthesize UIL_direccion_03;

@synthesize DDFVC_direccion = _DDFVC_direccion;
@synthesize SDVC_direccion  = _SDVC_direccion;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDDFVC_direccion
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDDFVC_direccion:(DomicilioDireccionFormViewController *)DDFVC_direccion {
    
    _DDFVC_direccion = DDFVC_direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSDVC_direccion
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSDVC_direccion:(SelectDireccionViewController *)SDVC_direccion {
    
    _SDVC_direccion = SDVC_direccion;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos SerachRestaurantClass
    globalVar.SRC_search = [[SearchRestaurantClass alloc] init];
    
    // Iniciamos Array de direcciones
    globalVar.NSMA_direcciones = [[NSMutableArray alloc] init];
    
    // Insertamos Localización actual
    DireccionClass *DC_direccion = [[DireccionClass alloc] init];
    [DC_direccion setNSI_id      :_ID_DIRECCION_LOCALIZACION_ACTUAL_];
    [DC_direccion setNSS_etiqueta:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_];
    [globalVar.NSMA_direcciones addObject:DC_direccion];
    
    // Inidicamos que no hay direcciones seleccionas
    [globalVar.OC_order setDC_useraddress:nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Dirección Envío";
    
    // Comprobamos si ya se está mostrando
    if (_SDVC_direccion != nil) [self close_select_direccion];
    
    // Comprobamos si existe una direccion seleccionada
    if (((globalVar.OC_order.DC_useraddress.NSI_id != _ID_ADDRESS_NO_SELECTED_) && (![UIL_direccion.text isEqualToString:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_])) ||
        (globalVar.OC_order.DC_useraddress.NSI_id == _ID_NEW_ADDRESS_) ) 
    {
        // Actualizamos UILabel
        [UIL_direccion setText:globalVar.OC_order.DC_useraddress.NSS_etiqueta];
        
        // Recuperamos datos a mostrar
        NSString *NSS_telefono  = ([globalVar.OC_order.DC_useraddress.NSS_telefono length]  > 0)?globalVar.OC_order.DC_useraddress.NSS_telefono :@"";
        NSString *NSS_direccion = ([globalVar.OC_order.DC_useraddress.NSS_direccion length] > 0)?globalVar.OC_order.DC_useraddress.NSS_direccion:@"";
        NSString *NSS_cp        = ([globalVar.OC_order.DC_useraddress.NSS_cp length]        > 0)?globalVar.OC_order.DC_useraddress.NSS_cp       :@"";
        NSString *NSS_ciudad    = ([globalVar.OC_order.DC_useraddress.NSS_ciudad length]    > 0)?globalVar.OC_order.DC_useraddress.NSS_ciudad   :@"";
        
        // Iniciamos UILabel
        [UIL_direccion_01 setText:[NSString stringWithFormat:@"%@", NSS_telefono]];
        [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@", NSS_direccion]];
        [UIL_direccion_03 setText:[NSString stringWithFormat:@"%@ %@", NSS_cp, NSS_ciudad]];
    }
    else {
        
        // Actualizamos UILabel
        [UIL_direccion setText:_COMBO_DIRECCION_SELECCIONAR_];
        
        // Iniciamos UILabel
        [UIL_direccion_01 setText:@""];
        [UIL_direccion_02 setText:@""];
        [UIL_direccion_03 setText:@""];        
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
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
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Comprobamos si se viene desde Mi Saco
    if (globalVar.B_come_from_mi_saco) [globalVar.OC_order setTOT_type:TOT_pedido_en_el_restaurante];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkAddress
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddress {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_ADDRESS_SUCCESSFUL_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_ADDRESS_NO_VALID_     object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_ADDRESS_NO_INTERNET_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_ADDRESS_ERROR_        object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(checkAddressSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_ADDRESS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(checkAddressError:) 
                                                 name: _NOTIFICATION_VALIDATE_ADDRESS_NO_VALID_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_VALIDATE_ADDRESS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_VALIDATE_ADDRESS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkAddress];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeDireccion
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeDireccion {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_ADDRESS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_ADDRESS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_ADDRESS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(removeDireccionSuccessful:)
                                                 name: _NOTIFICATION_REMOVE_ADDRESS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_REMOVE_ADDRESS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_REMOVE_ADDRESS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading removeDireccion];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeDireccionSuccessful
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeDireccionSuccessful:(NSNotification *)notification {
    
    // Eliminamos dirección de la lista
    [globalVar.NSMA_direcciones removeObject:globalVar.DC_direccion];
    
    // Actualizamos UILabel
    [UIL_direccion_01 setText:@""];
    [UIL_direccion_02 setText:@""];
    [UIL_direccion_03 setText:@""];
    [UIL_direccion    setText:_COMBO_DIRECCION_SELECCIONAR_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkAddressSuccessful
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddressSuccessful:(NSNotification *)notification {
    
    // Comprobamos si se llamo desde el historial
    if (globalVar.B_come_from_historial) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate cargar_historial];
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {

        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate UIB_pedir_domicilio_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkAddressError
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddressError:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
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
//#	Procedimiento   : UIB_add_new_direccion_TouchUpInside
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_new_direccion_TouchUpInside:(id)sender {
    
    // Creamos DomicilioDireccionFormViewController
    _DDFVC_direccion = [[DomicilioDireccionFormViewController alloc] initWithNibName:@"DomicilioDireccionFormView" bundle:[NSBundle mainBundle]];
    
    // Indicamos que es una nueva dirección
    [_DDFVC_direccion setB_new_address:TRUE];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_DDFVC_direccion animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_comprobar_direccion_TouchUpInside
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_comprobar_direccion_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha seleccionado una dirección
    if ([UIL_direccion.text isEqualToString:_COMBO_DIRECCION_SELECCIONAR_]) {
        
        // Comprobamos si se ha elegido "Recoger"
        if (globalVar.OC_order.TOT_type != TOT_pedido_para_recoger) {
            
            // Mostramos mensaje de error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe seleccionar una dirección"];
            return;
        }
    }
    
    // Fijamos la dirección seleccionada
    for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones)        
        if ([DC_direccion.NSS_etiqueta isEqualToString:UIL_direccion.text]) {
            [globalVar.OC_order setDC_useraddress:DC_direccion];
            break;
        }
    
    // Comprobamos si es válida
    [self checkAddress];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_direccion_TouchUpInside
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_direccion_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if (_SDVC_direccion != nil) return;
    
    // Creamos SelectDireccionViewController
    _SDVC_direccion = [[SelectDireccionViewController alloc] initWithNibName:@"SelectDireccionView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SDVC_direccion setDelegate:self];
    
    // Iniciamos Propiedades
    [_SDVC_direccion setNSS_direccion:UIL_direccion.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SDVC_direccion.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SDVC_direccion.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SDVC_direccion.view.frame.size.width, _SDVC_direccion.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SDVC_direccion.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SDVC_direccion.view.frame.size.height), _SDVC_direccion.view.frame.size.width, _SDVC_direccion.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_edit_direccion_TouchUpInside
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_edit_direccion_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha seleccionado una dirección
    if ([UIL_direccion.text isEqualToString:_COMBO_DIRECCION_SELECCIONAR_]) return;
    
    DireccionClass *DC_direccion = nil;
    
    // Buscamos la dirección seleccionada
    for (DireccionClass *DC_actual_direccion in globalVar.NSMA_direcciones)        
        if ([DC_actual_direccion.NSS_etiqueta isEqualToString:UIL_direccion.text]) {
            DC_direccion = DC_actual_direccion;
            break;
        }
    
    // Creamos DomicilioDireccionFormViewController
    _DDFVC_direccion = [[DomicilioDireccionFormViewController alloc] initWithNibName:@"DomicilioDireccionFormView" bundle:[NSBundle mainBundle]];
    
    // Indicamos que es una nueva dirección
    [_DDFVC_direccion setB_new_address:FALSE];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_DDFVC_direccion animated:YES];
    
    // Actualizamos UITextField
    [_DDFVC_direccion.UITF_telefono     setText: DC_direccion.NSS_telefono];
    [_DDFVC_direccion.UITF_direccion    setText: DC_direccion.NSS_direccion];
    [_DDFVC_direccion.UITF_numero       setText: DC_direccion.NSS_numero];
    [_DDFVC_direccion.UITF_piso         setText: DC_direccion.NSS_piso];
    [_DDFVC_direccion.UITF_letra        setText: DC_direccion.NSS_letra];
    [_DDFVC_direccion.UITF_portal       setText: DC_direccion.NSS_portal];
    [_DDFVC_direccion.UITF_escalera     setText: DC_direccion.NSS_escalera];
    [_DDFVC_direccion.UITF_cp           setText: DC_direccion.NSS_cp];
    [_DDFVC_direccion.UITF_ciudad       setText: DC_direccion.NSS_ciudad];
    [_DDFVC_direccion.UITF_etiqueta     setText: DC_direccion.NSS_etiqueta];
    
    // Actualizsmo DireccionClass
    [_DDFVC_direccion setDC_direccion:DC_direccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_edit_direccion_TouchUpInside
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_remove_direccion_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha seleccionado una dirección
    if ([UIL_direccion.text isEqualToString:_COMBO_DIRECCION_SELECCIONAR_]) return;
    
    // Buscamos la dirección seleccionada
    for (DireccionClass *DC_actual_direccion in globalVar.NSMA_direcciones)
        if ([DC_actual_direccion.NSS_etiqueta isEqualToString:UIL_direccion.text]) {
            globalVar.DC_direccion = DC_actual_direccion;
            break;
        }
    
    // Comprobamos que no esté seleccionada la Localización actual
    if (globalVar.DC_direccion.NSI_id != _ID_DIRECCION_LOCALIZACION_ACTUAL_) {
        
        // Mostramos mensage de confirmación
        UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
        [UIAV_confirm setTitle:@"Confirmación"];
        [UIAV_confirm setMessage:@"¿Está seguro de que quiere eliminar la dirección?"];
        [UIAV_confirm setDelegate:self];
        [UIAV_confirm addButtonWithTitle:@"Si"];
        [UIAV_confirm addButtonWithTitle:@"No"];
        [UIAV_confirm show];
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Comprobamos si es una dirección que está en el servidor
        if (globalVar.DC_direccion.NSI_id > 0) {
            
            // Borramos la dirección del servidor
            [self removeDireccion];
        }
        else {
            
            // Eliminamos dirección de la lista
            [globalVar.NSMA_direcciones removeObject:globalVar.DC_direccion];
            
            // Actualizamos UILabel
            [UIL_direccion_01 setText:@""];
            [UIL_direccion_02 setText:@""];
            [UIL_direccion_03 setText:@""];
            [UIL_direccion    setText:_COMBO_DIRECCION_SELECCIONAR_];
        }
    }
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_precio
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_direccion:(NSString *)NSS_direccion {
    
    // Actualizamos UILabel
    [UIL_direccion setText:NSS_direccion];
    
    // Buscamos el DirectionClass seleccionado
    for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones) {
        
        // Comprobamo si es la etiqueta activa
        if ([DC_direccion.NSS_etiqueta isEqualToString:NSS_direccion])  {
            
            // Iniciamos UILabel
            [UIL_direccion_01 setText:[NSString stringWithFormat:@"%@", DC_direccion.NSS_telefono]];
            [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@", DC_direccion.NSS_direccion]];
            [UIL_direccion_03 setText:[NSString stringWithFormat:@"%@ %@", DC_direccion.NSS_cp, DC_direccion.NSS_ciudad]];
            
            // Actualizamos variable global
            [globalVar.OC_order setDC_useraddress:DC_direccion];
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_direccion {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SDVC_direccion.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SDVC_direccion.view.frame.size.width, _SDVC_direccion.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Quitamos el View Select Precio
    [_SDVC_direccion.view removeFromSuperview];
    
    // Liberamos memoria
    _SDVC_direccion = nil;
    
    // Comprobamos si se ha seleccionado la localización actual
    if ([globalVar.OC_order.DC_useraddress.NSS_etiqueta isEqualToString:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_]) {
        
        // Creamos DomicilioDireccionFormViewController
        _DDFVC_direccion = [[DomicilioDireccionFormViewController alloc] initWithNibName:@"DomicilioDireccionFormView" bundle:[NSBundle mainBundle]];
        
        // Indicamos que es una nueva dirección
        [_DDFVC_direccion setB_new_address:FALSE];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_DDFVC_direccion animated:YES];
    }
}


@end
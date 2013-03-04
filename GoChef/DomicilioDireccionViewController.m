//
//  DomicilioDireccionViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DomicilioDireccionViewController.h"
#import "LoadingViewController.h"
#import "DomicilioDireccionFormViewController.h"
#import "RestauranteShortInfoViewController.h"

#import "DireccionClass.h"
#import "TipoCocinaClass.h"
#import "SearchRestaurantClass.h"
#import "OrderClass.h"


@implementation DomicilioDireccionViewController

@synthesize UIL_direccion;
@synthesize UIL_tipo_comida;
@synthesize UIB_a_domicilio;
@synthesize UIB_recoger;
@synthesize UIL_direccion_01;
@synthesize UIL_direccion_02;
@synthesize UIL_direccion_03;
@synthesize UIV_direccion;
@synthesize UIV_tipo_cocina;

@synthesize DDFVC_direccion = _DDFVC_direccion;
@synthesize RSIVC_restaurantes = _RSIVC_restaurantes;

@synthesize STCVC_tipo_comida = _STCVC_tipo_comida;
@synthesize SDVC_direccion = _SDVC_direccion;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRSIVC_restaurantes
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRSIVC_restaurantes:(RestauranteShortInfoViewController *)RSIVC_restaurantes {
    
    _RSIVC_restaurantes = RSIVC_restaurantes;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDDFVC_direccion
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDDFVC_direccion:(DomicilioDireccionFormViewController *)DDFVC_direccion {
    
    _DDFVC_direccion = DDFVC_direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSTCVC_tipo_comida
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTCVC_tipo_comida:(SelectTipoCocinaViewController *)STCVC_tipo_comida {
    
    _STCVC_tipo_comida = STCVC_tipo_comida;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSDVC_direccion
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSDVC_direccion:(SelectDireccionViewController *)SDVC_direccion {
    
    _SDVC_direccion = SDVC_direccion;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
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
    
    // Insertamos UIView
    [self.view addSubview:UIV_direccion];
    [self.view addSubview:UIV_tipo_cocina];
    
    // Posicionamos UIView
    [UIV_direccion   setFrame:CGRectMake(0.0f, 65.0f, UIV_direccion.frame.size.width, UIV_direccion.frame.size.height)];
    [UIV_tipo_cocina setFrame:CGRectMake(0.0f, 265.0f, UIV_tipo_cocina.frame.size.width, UIV_tipo_cocina.frame.size.height)];
    
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
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Filtros";
    
    // Comprobamos si ya se está mostrando
    if (_STCVC_tipo_comida != nil) [self close_select_tipo_cocina];
    if (_SDVC_direccion    != nil) [self close_select_direccion];
        
    NSArray *cats = [globalVar.SRC_search.NSS_idrestauranttype componentsSeparatedByString:@","];
    if (!globalVar.SRC_search.B_restauranttype) [UIL_tipo_comida setText:_COMBO_TIPOS_COCINA_];
    else {
        
        if ([cats count] > 1) {
            [UIL_tipo_comida setText:@"Múltiples categorías"];
        } else {
            [UIL_tipo_comida setText:[(TipoCocinaClass *)[globalVar getRestautanttypeWithId:globalVar.SRC_search.NSS_idrestauranttype] NSS_name]];
        }
    }
    
    // Iniciamos el UILabel Tipo de cocina
    //if (!globalVar.SRC_search.B_restauranttype) [UIL_tipo_comida setText:_COMBO_TIPOS_COCINA_];
    //else [UIL_tipo_comida setText:[(TipoCocinaClass *)[globalVar getRestautanttypeWithId:globalVar.SRC_search.NSS_idrestauranttype] NSS_name]];
    
    // Comprobamos si existe una direccion seleccionada
    if (((![UIL_direccion.text isEqualToString:_COMBO_DIRECCION_LOCALIZACION_ACTUAL_])) || (globalVar.OC_order.DC_useraddress.NSI_id == _ID_NEW_ADDRESS_) ) {
        
        // Actualizamos UILabel
        [UIL_direccion setText:globalVar.OC_order.DC_useraddress.NSS_etiqueta];
        
        // Recuperamos datos a mostrar
        NSString *NSS_telefono  = ([globalVar.OC_order.DC_useraddress.NSS_telefono  length] > 0)?globalVar.OC_order.DC_useraddress.NSS_telefono  :@"";
        NSString *NSS_direccion = ([globalVar.OC_order.DC_useraddress.NSS_direccion length] > 0)?globalVar.OC_order.DC_useraddress.NSS_direccion :@"";
        NSString *NSS_numero    = ([globalVar.OC_order.DC_useraddress.NSS_numero    length] > 0)?globalVar.OC_order.DC_useraddress.NSS_numero    :@"";
        NSString *NSS_cp        = ([globalVar.OC_order.DC_useraddress.NSS_cp        length] > 0)?globalVar.OC_order.DC_useraddress.NSS_cp        :@"";
        NSString *NSS_ciudad    = ([globalVar.OC_order.DC_useraddress.NSS_ciudad    length] > 0)?globalVar.OC_order.DC_useraddress.NSS_ciudad    :@"";
        
        // Iniciamos UILabel
        [UIL_direccion_01 setText:[NSString stringWithFormat:@"%@", NSS_telefono]];
        [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@ %@", NSS_direccion, NSS_numero]];
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
    
    // Iniciamos los UIButton filter
    [UIB_a_domicilio setSelected:FALSE];
    [UIB_recoger     setSelected:FALSE];
    
    // Actualizamos UIButton filer sengún corresponda
    if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
     
        [UIB_a_domicilio setSelected:TRUE];
        [self showUIVDireccion];
    }
    else {
        
        [UIB_recoger setSelected:TRUE];
        [self hideUIVDireccion];
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
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Acualizamos propiedad
    [globalVar setB_realizando_pedido:FALSE];
    
    // Reiniciamos Order
    [globalVar.OC_order reset];
    
    // Inidicamos que no hay direcciones seleccionas
    [globalVar.OC_order setDC_useraddress:nil];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showUIVDireccion
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showUIVDireccion {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_UIVIEW_DIRECCION_DURATION_];
    
    // Reposicionamos los View
    [UIV_direccion setAlpha:1.0f];
    [UIV_tipo_cocina setFrame:CGRectMake(0.0f, 265.0f, UIV_tipo_cocina.frame.size.width, UIV_tipo_cocina.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideUIVDireccion
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) hideUIVDireccion {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_UIVIEW_DIRECCION_DURATION_];
    
    // Reposicionamos los View
    [UIV_direccion setAlpha:0.0f];
    [UIV_tipo_cocina setFrame:CGRectMake(0.0f, 70.0f, UIV_tipo_cocina.frame.size.width, UIV_tipo_cocina.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
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
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Mostramos mensaje
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) noSuccessful:(NSNotification *)notification {

    // Mostramos mensaje
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_form_direccion_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_form_direccion_TouchUpInside:(id)sender {
    
    // Creamos DomicilioDireccionFormViewController
    _DDFVC_direccion = [[DomicilioDireccionFormViewController alloc] initWithNibName:@"DomicilioDireccionFormView" bundle:[NSBundle mainBundle]];
    
    // Indicamos que es una nueva dirección
    [_DDFVC_direccion setB_new_address:TRUE];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_DDFVC_direccion animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_buscar_restaurante_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_buscar_restaurante_TouchUpInside:(id)sender {

    // Comprobamos si NO se ha seleccionado una dirección
    if ([UIL_direccion.text isEqualToString:_COMBO_DIRECCION_SELECCIONAR_]) {
        
        // Comprobamos si se ha elegido "Recoger"
        if (globalVar.OC_order.TOT_type != TOT_pedido_para_recoger) {

            // Mostramos mensaje de error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe seleccionar una dirección"];
            return;
        }
    }
    else {

        // Fijamos la dirección seleccionada
        for (DireccionClass *DC_direccion in globalVar.NSMA_direcciones)
            if ([DC_direccion.NSS_etiqueta isEqualToString:UIL_direccion.text]) {
                [globalVar.OC_order setDC_useraddress:DC_direccion];
                break;
            }
        
        // Comprobamos que tiene el CP
        if ([globalVar.OC_order.DC_useraddress.NSS_cp isEqualToString:@""]) {
            
            // Mostramos mensaje de error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"La dirección seleccionada no tiene el CP asignado."];
            return;
        }
    }
    
    // Creamos RestauranteShortInfoViewController
    _RSIVC_restaurantes = [[RestauranteShortInfoViewController alloc] initWithNibName:@"RestauranteShortInfoView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_RSIVC_restaurantes setDelegate:self];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RSIVC_restaurantes animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_tipo_comida_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_tipo_comida_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ((_STCVC_tipo_comida != nil) || (_SDVC_direccion != nil)) return;
        
    // Creamos SelectTipoCocinaViewController
    _STCVC_tipo_comida = [[SelectTipoCocinaViewController alloc] initWithNibName:@"SelectTipoCocinaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STCVC_tipo_comida setDelegate:self];
    
    // Iniciamos Propiedades
    [_STCVC_tipo_comida setTCC_tipo_cocina:[globalVar getRestautanttypeWithId:globalVar.SRC_search.NSS_idrestauranttype]];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STCVC_tipo_comida.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STCVC_tipo_comida.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_comida.view.frame.size.width, _STCVC_tipo_comida.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STCVC_tipo_comida.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STCVC_tipo_comida.view.frame.size.height), _STCVC_tipo_comida.view.frame.size.width, _STCVC_tipo_comida.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_direccion_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_direccion_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ((_STCVC_tipo_comida != nil) || (_SDVC_direccion != nil)) return;
    
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
//#	Procedimiento   : UIB_select_direccion_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_filtro_domicilio_TouchUpInside:(id)sender {
    
    // Actualizamos los UIButton filter
    [UIB_a_domicilio setSelected:TRUE];
    [UIB_recoger     setSelected:FALSE];
    
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_a_domicilio];
    
    // Mostramos el UIView de la Direccion
    [self showUIVDireccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_direccion_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_filtro_recoger_TouchUpInside:(id)sender {
    
    // Actualizamos los UIButton filter
    [UIB_a_domicilio setSelected:FALSE];
    [UIB_recoger     setSelected:TRUE];
    
    // Actualizamos propieda que indica el tipo de pedido seleccionado
    [globalVar.OC_order setTOT_type:TOT_pedido_para_recoger];
    
    // Ocultamos el UIView de la Direccion
    [self hideUIVDireccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_edit_direccion_TouchUpInside
//#	Fecha Creación	: 24/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
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
//#	Fecha Creación	: 24/04/2012  (pjoramas)
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
//#	Fecha Creación	: 24/04/2012  (pjoramas)
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
//#	Procedimiento   : Tabbar_mi_saco_Touched
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_saco_Touched:(BOOL)B_resetTabbarButton {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_saco_Touched:B_resetTabbarButton];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_cocina:(NSString*)TCC_tipo_cocina {
    
    NSLog(@"TCC_tipo_cocina %@",TCC_tipo_cocina);
    // Comprobamos si no se ha seleccionado ninguno
    if ([TCC_tipo_cocina isEqualToString:@""]){
        
        NSLog(@" globalVar.SRC_search.NSS_idrestauranttype%@",globalVar.SRC_search.NSS_idrestauranttype);
        // Actualizamos propiedad
        [globalVar.SRC_search setB_restauranttype:FALSE];
        [globalVar.SRC_search setNSS_idrestauranttype:nil];
        
        // Actualizamos UILabel
        [UIL_tipo_comida setText:_COMBO_TIPOS_COCINA_];
    }
    else {
     
        // Actualizamos propiedad
        [globalVar.SRC_search setB_restauranttype:TRUE];
        
        NSArray *ids = [TCC_tipo_cocina componentsSeparatedByString:@","];
        
        // Actualizamos propiedad
        [globalVar.SRC_search setNSS_idrestauranttype:TCC_tipo_cocina];
        
        // Actualizamos UILabel
        if ([ids count]> 1) {
            [UIL_tipo_comida setText:@"Múltiples categorías"];
        } else {
            [UIL_tipo_comida setText:[(TipoCocinaClass *)[globalVar getRestautanttypeWithId:[NSString stringWithFormat:@"%d",[[ids objectAtIndex:0] intValue]]] NSS_name]];
        }

    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_tipo_cocina {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_STCVC_tipo_comida.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_comida.view.frame.size.width, _STCVC_tipo_comida.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_precio
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
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
            [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@ %@", DC_direccion.NSS_direccion, DC_direccion.NSS_numero]];
            [UIL_direccion_03 setText:[NSString stringWithFormat:@"%@ %@", DC_direccion.NSS_cp, DC_direccion.NSS_ciudad]];
            
            // Actualizamos variable global
            [globalVar.OC_order setDC_useraddress:DC_direccion];
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Fecha Creación	: 30/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_STCVC_tipo_comida != nil) {
        
        // Quitamos el View Select Tipo Cocina
        [_STCVC_tipo_comida.view removeFromSuperview];
        
        // Liberamos memoria
        _STCVC_tipo_comida = nil;
    }
    else {
        
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
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_pre_pedir_Touched
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_pre_pedir_Touched {
    
    NSLog(@"Tabbar_pre_pedir_Touched");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_mi_cuenta_Touched {
    
    NSLog(@"Tabbar_mi_cuenta_Touched");
}

@end
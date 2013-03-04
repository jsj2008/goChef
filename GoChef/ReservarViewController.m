//
//  ReservarViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "ReservarViewController.h"
#import "LoadingViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "FacebookClass.h"
#import "FacebookOfferClass.h"
#import "UserClass.h"
#import "CoreDataClass.h"
#import "JSONparseClass.h"

@interface  ReservarViewController (Private)

-(void) loadOffersWithDate;

@end


@implementation ReservarViewController

@synthesize B_favorite = _B_favorite;

@synthesize UIL_fecha_hora;
@synthesize UIL_personas;
@synthesize UIL_facebook_text;
@synthesize UIL_recoger_oferta;
@synthesize UIIV_facebook;
@synthesize UIB_favorites;

@synthesize SFHVC_fechaHora = _SFHVC_fechaHora;
@synthesize S_hora = _S_hora;
@synthesize SPVC_personas   = _SPVC_personas;
@synthesize SOVC_oferta     = _SOVC_oferta;
@synthesize UIL_hora = _UIL_hora;
@synthesize datesArray = _datesArray;
@synthesize hoursArray = _hoursArray;

@synthesize delegate = _delegate;

#pragma mark - Private Methods

-(void) loadOffersWithDate{
    
    BOOL B_datos_cagados = FALSE;
    
    
    // Comprobamos si hay que cargar las Offer
  //  if ([globalVar.UC_user.NSMA_offers count] == 0) {
        
        B_datos_cagados = TRUE;
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadOffers)
                                                   userInfo:nil
                                                    repeats:NO];
 //   }
  //  else
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        B_datos_cagados = TRUE;
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFacebookOffer)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    
    // Comprobamos si no se han cargado los datos
    if (!B_datos_cagados) {
        
        // Comprobamos si hay una Offerta seleccionada
        if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [UIL_recoger_oferta setText:globalVar.OC_order.OC_offer.NSS_nameoffer];
    }


}

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSFHVC_fechaHora
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSFHVC_fechaHora:(SelectHoraViewController *)SFHVC_fechaHora {
    
    _SFHVC_fechaHora = SFHVC_fechaHora;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSPVC_personas
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSPVC_personas:(SelectPersonasViewController *)SPVC_personas {
    
    _SPVC_personas = SPVC_personas;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSOVC_oferta
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setSOVC_oferta:(SelectOfertaViewController *)SOVC_oferta {
    
    _SOVC_oferta = SOVC_oferta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_favorite
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_favorite:(BOOL)B_favorite {
    
    _B_favorite = B_favorite;
    
    // Comprobamos estado
    if (_B_favorite) {
        
        // Creamos UIImage
        UIImage *UII_favorite = [UIImage imageNamed:@"mi_actividad_redo_favoritos.png"];
        
        // Actaluzamos UIButton favorite
        [UIB_favorites setImage:UII_favorite forState:UIControlStateNormal];
    }
    else {
        
        // Creamos UIImage
        UIImage *UII_favorite = [UIImage imageNamed:@"mi_actividad_add_favoritos.png"];
        
        // Actaluzamos UIButton favorite
        [UIB_favorites setImage:UII_favorite forState:UIControlStateNormal];
    }
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
    
    globalVar = [SingletonGlobal sharedGlobal];
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
	
    [formatDate setDateFormat:@"yyyy-MM"];
    self.datesArray = [globalVar.JPC_json UMNI_getDatesOffers:globalVar.OC_order.RC_restaurant.NSI_idrestaurant inMonth:[formatDate stringFromDate:[NSDate date]]];
    
    [formatDate setDateFormat:@"yyyy-MM-dd"];
    self.hoursArray = [globalVar.JPC_json UMNI_getHoursOffers:globalVar.OC_order.RC_restaurant.NSI_idrestaurant service:@"reserva" inDate:[formatDate stringFromDate:[NSDate date]]];
        
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos componentes
    [UIL_facebook_text setText:@""];
    
    // Iniciamos propiedades
    [self setB_favorite:globalVar.OC_order.RC_restaurant.B_favorite];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Reservar mesa";
    
    [self loadFacebookOffer];

    
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
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavorite
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavorite {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(changeFavoriteSuccessful:) 
                                                 name: _NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_FAVORITES_STARS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_FAVORITES_STARS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading changeFavorite];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateViewComponent
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateViewComponent {
    
    // Actualizamos UILabel Fecha
    NSDateFormatter *NSDF_date_hora = [[NSDateFormatter alloc] init];
    [NSDF_date_hora setDateFormat:@"dd/MM"];
    [UIL_fecha_hora setText:[NSString stringWithFormat:@"%@", [NSDF_date_hora stringFromDate:globalVar.OC_order.NSD_date_reservation]]];

    [NSDF_date_hora setDateFormat:@"HH:mm"];

    [_UIL_hora setText:[NSString stringWithFormat:@"%@", [NSDF_date_hora stringFromDate:globalVar.OC_order.NSD_date_reservation]]];

    // Actualizamos UILabel
    [UIL_personas setText:[NSString stringWithFormat:@"%d", globalVar.OC_order.NSI_persons]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setOrder
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
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
//#	Procedimiento   : loadOffers
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadOffers {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_OFFERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_OFFERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_OFFERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadOffersSuccessful:)
                                                 name: _NOTIFICATION_OFFERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_OFFERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_OFFERS_ERROR_
                                               object: nil];
    
    // Indicamos si queremos cargar las imagenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadOffers];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFacebookOffer {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GET_FACEBOOK_OFFERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GET_FACEBOOK_OFFERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadFacebookOfferSuccessful:) 
                                                 name: _NOTIFICATION_GET_FACEBOOK_OFFERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_GET_FACEBOOK_OFFERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading getFacebookOffer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOffer {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_FACEBOOK_OFFERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_FACEBOOK_OFFERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(setFacebookOfferSuccessful:) 
                                                 name: _NOTIFICATION_SET_FACEBOOK_OFFERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_FACEBOOK_OFFERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading setFacebookOffer];
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
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    BOOL B_datos_cagados = FALSE;
    
    // Comprobamos si ya están cargadas las ofertas de Facebook
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        B_datos_cagados = TRUE;
        
        // Actualizamos los datos
    }
    
    // Comprobamos si no se han cargado los datos
    if (!B_datos_cagados) {
        
        // Comprobamos si hay una Offerta seleccionada
        if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [UIL_recoger_oferta setText:globalVar.OC_order.OC_offer.NSS_nameoffer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setOrderSuccessful
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
    
    // Mostramos mensaje
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_RESERVA_ message:_ALERT_MSG_RESERVA_];
    
    
    // Volvemos Viewcontroller padre
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavoriteSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavoriteSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setB_favorite:!_B_favorite];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Creamos UIImage
    UIImage *UII_facebook;
    
    // Comprobamos si hay una Offerta seleccionada
    if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [UIL_recoger_oferta setText:globalVar.OC_order.OC_offer.NSS_nameoffer];
    
    // Comprobamos si tiene Facebook Offer
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Comprobamos si ya ha sido utilizada
        if (globalVar.OC_order.FC_facebook_offer.B_utilizada) {
            
            // Ocultamos texto
            [UIL_facebook_text setAlpha:0.0f];
            
            // Seleccionamo imagen correspondiente
            UII_facebook = [UIImage imageNamed:@"mi_actividad_facebook_enviado.png"];
        }
        else {
            
            // Actualizamos componentes
            [UIL_facebook_text setText:globalVar.OC_order.FC_facebook_offer.NSS_offer_description];
            
            // Seleccionamo imagen correspondiente
            UII_facebook = [UIImage imageNamed:@"mi_actividad_facebook.png"];
        }
    }
    else {
        
        // Ocultamos texto
        [UIL_facebook_text setAlpha:0.0f];
        
        // Seleccionamo imagen correspondiente
        UII_facebook = [UIImage imageNamed:@"mi_actividad_facebook_normal.png"];
    }
    
    // Acualizamos UIImageView Facebook
    [UIIV_facebook setImage:UII_facebook];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Marcamos que ya se ha utilizado la Facebook Offer
    [globalVar.OC_order.FC_facebook_offer setB_utilizada:TRUE];
    
    // Añadimos descuento a la Order
    [globalVar.OC_order setNSI_idoffer_facebook:globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook];
    
    // Ocultamos texto
    [UIL_facebook_text setAlpha:0.0f];
    
    // Cambiamos UIImageView
    UIImage *UII_facebook = [UIImage imageNamed:@"mi_actividad_facebook_enviado.png"];
    [UIIV_facebook setImage:UII_facebook];
    
    // Mostramos mensage
    [globalVar showAlerMsgWith:_ALERT_TITLE_FACEBOOK_ message:_ALERT_MSG_FACEBOOK_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initSetFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initSetFacebookOffer:(NSNotification *)notification {
    
    // Comprobamos si es una recomendación "normal"
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Mostramos mensage
        [globalVar showAlerMsgWith:_ALERT_TITLE_FACEBOOK_ message:_ALERT_MSG_FACEBOOK_];
    }
    else {
        
        // Actualizamos Facebook Offer
        //[globalVar.OC_order.FC_facebook_offer setB_future:TRUE];
        
        // Actauzliasmo BB.DD
        [self setFacebookOffer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
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
//#	Procedimiento   : UIB_favorites_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_favorites_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        return;
    }
    
    // Comprobamos si se ha agregado o quitado
    if (!_B_favorite) {
        
        // Actualizamos propiedades
        [globalVar setNSI_value:1];
        [globalVar setB_valueFavoritos:TRUE];
        
        // Enviamos puntuación al servidor
        [self changeFavorite];
    }
    else {
        
        // Actualizamos propiedades
        [globalVar setNSI_value:0];
        [globalVar setB_valueFavoritos:TRUE];
        
        // Enviamos puntuación al servidor
        [self changeFavorite];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_faceboock_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_faceboock_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        return;
    }
    
    // Comprobamos si tiene Facebook Offer y ha sido utilizada
    if ((globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && (globalVar.OC_order.FC_facebook_offer.B_utilizada)) return;
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FACEBOOK_WALL_OK_ object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(initSetFacebookOffer:) 
                                                 name: _NOTIFICATION_FACEBOOK_WALL_OK_
                                               object: nil];
    
    // Post in Facebook Wall
    [globalVar recomiendo_en_facebook];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_dia_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_fecha_hora_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SPVC_personas != nil) || (_SFHVC_fechaHora != nil) || (self.S_hora != nil) ) return;
    
    // Creamos SelectFechaHoraViewController
    _SFHVC_fechaHora = [[SelectHoraViewController alloc] initWithNibName:@"SelectHoraView" bundle:[NSBundle mainBundle]];
    [_SFHVC_fechaHora setType:@"date"];
    [_SFHVC_fechaHora setDataSourceArray:self.datesArray];
    
    if (![UIL_fecha_hora.text isEqualToString:@"--/--"]) {
        [_SFHVC_fechaHora setPreviousDate:globalVar.OC_order.NSD_date_reservation];
    }
    
    // Asignamos Delegado
    [_SFHVC_fechaHora setDelegate:self];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SFHVC_fechaHora.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SFHVC_fechaHora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFHVC_fechaHora.view.frame.size.width, _SFHVC_fechaHora.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SFHVC_fechaHora.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SFHVC_fechaHora.view.frame.size.height), _SFHVC_fechaHora.view.frame.size.width, _SFHVC_fechaHora.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

-(IBAction) UIB_select_hora_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SPVC_personas != nil) || (_SFHVC_fechaHora != nil) || (self.S_hora != nil) ) return;
    
    if ([UIL_fecha_hora.text isEqualToString:@"--/--"]) {
        [[[UIAlertView alloc] initWithTitle:@"Reservar mesa" message:@"Debe seleccionar primero un dia para la reserva. Gracias" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        return;
    }
    
    // Creamos SelectFechaHoraViewController
    self.S_hora = [[SelectHoraViewController alloc] initWithNibName:@"SelectHoraView" bundle:nil];
    [self.S_hora setType:@"time"];
    [self.S_hora setDataSourceArray:self.hoursArray];
    
    // Asignamos Delegado
    [self.S_hora setDelegate:self];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_S_hora.view];

    // Posicionamos SelectTipoCocinaViewController
    [self.S_hora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, self.S_hora.view.frame.size.width, self.S_hora.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [self.S_hora.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - 258), self.S_hora.view.frame.size.width, _S_hora.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_personas_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_personas_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SPVC_personas != nil) || (_SFHVC_fechaHora != nil) || (self.S_hora != nil) ) return;
    
    // Creamos SelectPersonasViewController
    _SPVC_personas = [[SelectPersonasViewController alloc] initWithNibName:@"SelectPersonasView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SPVC_personas setDelegate:self];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SPVC_personas.view];

    // Iniciamos Propiedades
    [_SPVC_personas setContentWith:globalVar.OC_order.NSI_persons];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SPVC_personas.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SPVC_personas.view.frame.size.width, _SPVC_personas.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SPVC_personas.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SPVC_personas.view.frame.size.height), _SPVC_personas.view.frame.size.width, _SPVC_personas.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_reservar_mesa_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_reservar_mesa_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        // Actualizamos propiedad
        [globalVar setB_login_from_reserva:TRUE];
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
        
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if (globalVar.OC_order.NSI_persons == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir el número de personas de la reserva."];
        return;
    }
    
    // Realizamos la reserva
    [self loginUsuario];    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_oferta_TouchUpInside
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(IBAction) UIB_select_oferta_TouchUpInside:(id)sender {
    
    if ([UIL_fecha_hora.text isEqualToString:@"--/--"] || [self.UIL_hora.text isEqualToString:@"--:--"]) {
        [[[UIAlertView alloc] initWithTitle:@"Reservar mesa" message:@"Debe seleccionar una fecha y una hora para conocer las ofertas." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        return;
    }
    
    // Comprobamos si el usuario tiene ofertas para el restaurante
    if (![globalVar.UC_user haveOffersForRestaurant:globalVar.OC_order.RC_restaurant.NSI_idrestaurant]) {
        
        // Mostramos mensaje de falta de ofertas
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_OFFERS_ message:_ALERT_MSG_NO_OFFERS_];
        
        return;
    }
    
    // Comprobamos si ya se está mostrando
    if (_SOVC_oferta != nil) return;
    
    // Creamos SelectTipoCocinaViewController
    _SOVC_oferta = [[SelectOfertaViewController alloc] initWithNibName:@"SelectOfertaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SOVC_oferta setDelegate:self];
    
    // Iniciamos Propiedades
    [_SOVC_oferta setContentWith:globalVar.OC_order.OC_offer];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SOVC_oferta.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SOVC_oferta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SOVC_oferta.view.frame.size.width, _SOVC_oferta.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SOVC_oferta.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SOVC_oferta.view.frame.size.height), _SOVC_oferta.view.frame.size.width, _SOVC_oferta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_fecha
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_hora:(NSString *)NSD_fecha andType:(NSString*)type withOffer:(BOOL)offer{
    
    if ([type isEqualToString:@"date"]) {
        self.hoursArray = [globalVar.JPC_json UMNI_getHoursOffers:globalVar.OC_order.RC_restaurant.NSI_idrestaurant service:@"reserva" inDate:NSD_fecha];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSDate *selectedDate = [formater dateFromString:NSD_fecha];
        NSDate *todayDate = [formater dateFromString:[formater stringFromDate:[NSDate date]]];
        
        if ([selectedDate compare:todayDate] != NSOrderedAscending) {
            
            [globalVar.OC_order setNSD_date_reservation:selectedDate];
            
            NSDate *theDate = [formater dateFromString:NSD_fecha];
            [formater setDateFormat:@"dd/MM"];
            
            NSString *dateDos = [formater stringFromDate:theDate];
            
            [UIL_fecha_hora setText:dateDos];
            [self.UIL_hora setText:@"--:--"];
            // Iniciamos animacion
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            
            // Reposicionamos los View
            [_SFHVC_fechaHora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFHVC_fechaHora.view.frame.size.width, _SFHVC_fechaHora.view.frame.size.height)];
            
            
            // Ejecutamos animacion
            [UIView commitAnimations];
            
        } else {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            
            // Reposicionamos los View
            [_SFHVC_fechaHora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFHVC_fechaHora.view.frame.size.width, _SFHVC_fechaHora.view.frame.size.height)];
            
            
            // Ejecutamos animacion
            [UIView commitAnimations];
            
            [[[UIAlertView alloc] initWithTitle:@"Reservar mesa" message:@"Debe seleccionar una fecha posterior o igual al dia de hoy" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
            return;
            
        }
        
    } else if([type isEqualToString:@"time"]){
        
        UIImageView *offerBg = (UIImageView*)[self.view viewWithTag:666];

        [UIView animateWithDuration:0.3 animations:^{
            
            if (offer) {
                [(UIButton*)[self.view viewWithTag:444] setEnabled:TRUE];
                [offerBg setFrame:CGRectMake(offerBg.frame.origin.x,
                                             offerBg.frame.origin.y,
                                             offerBg.frame.size.width, 181)];
                [self.view viewWithTag:999].transform = CGAffineTransformMakeTranslation(0, 50);

            } else {
                [(UIButton*)[self.view viewWithTag:444] setEnabled:FALSE];
                [offerBg setFrame:CGRectMake(offerBg.frame.origin.x,
                                             offerBg.frame.origin.y,
                                             offerBg.frame.size.width, 136)];
                [self.view viewWithTag:999].transform = CGAffineTransformIdentity;
            }
        }];
        
        [self.UIL_hora setText:NSD_fecha];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy"];
        NSString *year = [formater stringFromDate:[NSDate date]];
        [formater setDateFormat:@"yyyy/dd/MM HH:mm"];
        
        NSDate *theDate = [formater dateFromString:[NSString stringWithFormat:@"%@/%@ %@",year,UIL_fecha_hora.text,NSD_fecha]];
        
        // Marcamos como tarjeta seleccionada
        [globalVar.OC_order setNSD_date_reservation:theDate];
        [self loadOffersWithDate];
        
        // Actualizamso View Component
        [self updateViewComponent];
        
        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        // Reposicionamos los View
        [_S_hora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _S_hora.view.frame.size.width, _S_hora.view.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
    

}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_personas
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_personas:(NSInteger)NSI_personas {
    
    // Marcamos como tarjeta seleccionada
    [globalVar.OC_order setNSI_persons:NSI_personas];
    
    // Actualizamso View Component
    [self updateViewComponent];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_personas
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_personas {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SPVC_personas.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SPVC_personas.view.frame.size.width, _SPVC_personas.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_oferta
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) select_oferta:(UserOfferClass *)UOC_offer {
    
    // Comprobamos si es la misma que ya se tenía
    if (globalVar.OC_order.OC_offer == UOC_offer) return;
    
    // Fijamos la oferta en el Order
    [globalVar.OC_order setOC_offer:UOC_offer];
    
    // Cargamos los datos de nuevo
    [UIL_recoger_oferta setText:UOC_offer.NSS_nameoffer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_cocina
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) close_select_oferta {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SOVC_oferta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SOVC_oferta.view.frame.size.width, _SOVC_oferta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_SPVC_personas != nil) {
        
        // Quitamos el View Select Personas
        [_SPVC_personas.view removeFromSuperview];
        
        // Liberamos memoria
        _SPVC_personas = nil;
    }
    else if (_SFHVC_fechaHora != nil) {
        
        // Quitamos el View Select Fecha/Hora
        [_SFHVC_fechaHora.view removeFromSuperview];
        
        // Liberamos memoria
        _SFHVC_fechaHora = nil;
    }else if (self.self.S_hora != nil) {
        // Quitamos el View Select Fecha/Hora
        [self.self.S_hora.view removeFromSuperview];
        // Liberamos memoria
        [self setS_hora:nil];
    } else {
        
        // Quitamos el View Select Tipo Cocina
        [_SOVC_oferta.view removeFromSuperview];
        
        // Liberamos memoria
        _SOVC_oferta = nil;
    }
}


@end
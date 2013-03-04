//
//  AntesLlegarDatosContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "AntesLlegarDatosContenedorViewController.h"
#import "LoadingViewController.h"
#import "TabbarAntesLlegarViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "FacebookClass.h"
#import "FacebookOfferClass.h"
#import "JSONparseClass.h"


@implementation AntesLlegarDatosContenedorViewController

@synthesize B_favorite = _B_favorite;

@synthesize UIL_hora;
@synthesize UIL_personas;
@synthesize UIL_facebook_text;
@synthesize UIIV_facebook;
@synthesize UIB_favorites;

@synthesize SHVC_hora = _SHVC_hora;
@synthesize SPVC_personas = _SPVC_personas;

@synthesize delegate = _delegate;

@synthesize hoursArray = _hoursArray;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSHVC_hora
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSHVC_hora:(SelectHoraViewController *)SHVC_hora {
    
    _SHVC_hora = SHVC_hora;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSPVC_personas
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSPVC_personas:(SelectPersonasViewController *)SPVC_personas {
    
    _SPVC_personas = SPVC_personas;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_favorite
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
	    
    [formatDate setDateFormat:@"yyyy-MM-dd"];
    self.hoursArray = [globalVar.JPC_json UMNI_getHoursOffers:globalVar.OC_order.RC_restaurant.NSI_idrestaurant service:@"antesrestaurante" inDate:[formatDate stringFromDate:[NSDate date]]];
    
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos propiedades
    [self setB_favorite:globalVar.OC_order.RC_restaurant.B_favorite];

    // Iniciamos componentes
    [UIL_facebook_text setText:@""];
    
    // Iniciamos propiedades globales
    [globalVar setB_datos_introducidos:FALSE];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadFacebookOffer)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Datos";
    
    // Iniciamos los componentes
    //[self updateViewComponent];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro de que desea abandonar el pedido en curso?"];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateViewComponent
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateViewComponent {
    
    // Actualizamos UILabel
    [UIL_personas setText:[NSString stringWithFormat:@"%d", globalVar.OC_order.NSI_persons]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavorite
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Procedimiento   : changeFavoriteSuccessful
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavoriteSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setB_favorite:!_B_favorite];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Creamos UIImage
    UIImage *UII_facebook;
    
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
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
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
        [globalVar.OC_order.FC_facebook_offer setB_future:FALSE];
        
        // Actauzliasmo BB.DD
        [self setFacebookOffer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Iniciamos propiedad global
        //[globalVar setB_realizando_pedido:FALSE];
        
        // Reseteamos Order
        [globalVar.OC_order reset];
        
        // Reseteamos el Globo de la Tabbar
        [globalVar.TPVC_antesllegar resetGlobo];
        
        // Pasamos el Pedido a Cocina
        [globalVar setB_datos_introducidos:FALSE];
        
        // Comprobamos si venimos de Mi Saco
        if (globalVar.B_origen_mi_saco) {
            
            // Generamos la notificación que indica que se ha de ir a la Navigation Principal
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                                object:self];
        }
        else {

            // Volvemos Viewcontroller padre
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark -  
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_favorites_TouchUpInside
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_hora_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SPVC_personas != nil) || (_SHVC_hora != nil) ) return;
    
    // Creamos SelectHoraViewController
    _SHVC_hora = [[SelectHoraViewController alloc] initWithNibName:@"SelectHoraView" bundle:nil];
    [_SHVC_hora setType:@"time"];
    [_SHVC_hora setDataSourceArray:self.hoursArray];
    
    NSDateFormatter *dFormat = [[NSDateFormatter alloc] init];
    [dFormat setDateFormat:@"e"];
    
    // Asignamos Delegado
    [_SHVC_hora setDelegate:self];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SHVC_hora.view];
    
    // Iniciamos Propiedades
  //  [_SHVC_hora setContentWith:globalVar.OC_order.NSD_date_reservation];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SHVC_hora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SHVC_hora.view.frame.size.width, _SHVC_hora.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SHVC_hora.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - 258), _SHVC_hora.view.frame.size.width, _SHVC_hora.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_personas_TouchUpInside
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_personas_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_SPVC_personas != nil) || (_SHVC_hora != nil) ) return;
    
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_go_pedir_TouchUpInside:(id)sender {
    
    // Comprobamos si el usuario NO esta registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
        
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if (globalVar.OC_order.NSI_persons == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir el número de personas del pedido."];
        return;
    } else if([UIL_hora.text isEqualToString:@"--:--"]){
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir una hora para el pedido."];
        return;
    }
    
    // Actualizamos propiedad
    [globalVar setB_datos_introducidos:TRUE];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_pre_pedir_Touched];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_hora
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_hora:(NSString *)NSD_fecha andType:(NSString*)type withOffer:(BOOL)offer{
    
    [self.UIL_hora setText:NSD_fecha];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/dd/MM"];
    NSString *year_day_month = [formater stringFromDate:[NSDate date]];
    
    [formater setDateFormat:@"yyyy/dd/MM HH:mm"];
    NSDate *theDate = [formater dateFromString:[NSString stringWithFormat:@"%@ %@",year_day_month,NSD_fecha]];

    // Marcamos como tarjeta seleccionada
    [globalVar.OC_order setNSD_date_reservation:theDate];
    
    // Actualizamos UILabel Fecha
    NSDateFormatter *NSDF_date_hora = [[NSDateFormatter alloc] init];
    [NSDF_date_hora setDateFormat:@"HH:mm"];
    [UIL_hora setText:[NSString stringWithFormat:@"%@", [NSDF_date_hora stringFromDate:globalVar.OC_order.NSD_date_reservation]]];
    
    // Actualizamso View Component
    //[self updateViewComponent];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SHVC_hora.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SHVC_hora.view.frame.size.width, _SHVC_hora.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_personas
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
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
    else {
        
        // Quitamos el View Select Fecha/Hora
        [_SHVC_hora.view removeFromSuperview];
        
        // Liberamos memoria
        _SHVC_hora = nil;
    }
}


@end
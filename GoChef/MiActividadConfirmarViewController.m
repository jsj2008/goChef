//
//  MiActividadConfirmarViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiActividadConfirmarViewController.h"
#import "LoadingViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "FacebookClass.h"
#import "FacebookOfferClass.h"


@implementation MiActividadConfirmarViewController

@synthesize NSI_starts = _NSI_starts;
@synthesize B_favorite = _B_favorite;

@synthesize UIL_facebook_text;
@synthesize UITV_text;
@synthesize UIB_star_01;
@synthesize UIB_star_02;
@synthesize UIB_star_03;
@synthesize UIB_star_04;
@synthesize UIB_star_05;
@synthesize UIIV_facebook;
@synthesize UIB_favorites;
@synthesize UIB_eviar_mail;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_starts
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_starts:(NSInteger)NSI_starts {
    
    _NSI_starts = NSI_starts;
    
    // Creamos UIImage
    UIImage *UII_star_ok = [UIImage imageNamed:@"mi_actividad_puntuar_estrella.png"];
    UIImage *UII_star_ko = [UIImage imageNamed:@"mi_actividad_puntuar_estrella_empty.png"];
    
    // Actaluzamos UIButton start
    if (_NSI_starts > 0) [UIB_star_01 setImage:UII_star_ok forState:UIControlStateNormal];
    else [UIB_star_01 setImage:UII_star_ko forState:UIControlStateNormal];
    
    if (_NSI_starts > 1) [UIB_star_02 setImage:UII_star_ok forState:UIControlStateNormal];
    else [UIB_star_02 setImage:UII_star_ko forState:UIControlStateNormal];
    
    if (_NSI_starts > 2) [UIB_star_03 setImage:UII_star_ok forState:UIControlStateNormal];
    else [UIB_star_03 setImage:UII_star_ko forState:UIControlStateNormal];
    
    if (_NSI_starts > 3) [UIB_star_04 setImage:UII_star_ok forState:UIControlStateNormal];
    else [UIB_star_04 setImage:UII_star_ko forState:UIControlStateNormal];
    
    if (_NSI_starts > 4) [UIB_star_05 setImage:UII_star_ok forState:UIControlStateNormal];
    else [UIB_star_05 setImage:UII_star_ko forState:UIControlStateNormal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_favorite
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos propiedades
    [self setNSI_starts:0];
    [self setB_favorite:globalVar.OC_order.RC_restaurant.B_favorite];
    
    // Iniciamos componentes
    [UIL_facebook_text setText:@""];
    
    // Iniciamos UIButton Enviar Por Correo
    switch (globalVar.OC_order.TOS_status)
    {
        case TOS_pagado_con_tarjeta               : { [UIB_eviar_mail setAlpha:1.0f]; break; }
        case TOS_confirmado_y_pagado_con_tarjeta  : { [UIB_eviar_mail setAlpha:1.0f]; break; }
        case TOS_confirmado_y_pagado_con_efectivo : { [UIB_eviar_mail setAlpha:1.0f]; break; }
        case TOS_confirmado                       : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_pagado_con_efectivo              : { [UIB_eviar_mail setAlpha:1.0f]; break; }
        case TOS_pendiente_de_confirmar_y_pago    : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_confirmado_y_pendiente_de_pago   : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_cobro_fallido                    : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_devolucion_fallida               : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_devolucion_efectuada             : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_devolucion_pendiente             : { [UIB_eviar_mail setAlpha:0.0f]; break; }
        case TOS_cancelado                        : { [UIB_eviar_mail setAlpha:0.0f]; break; }
    }
     
    // Comprobamos si debemos cargar los datos
    if (!globalVar.OC_order.RC_restaurant.NSS_name) {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadRestaurante)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFacebookOffer)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Ticket";
    
    // Comprobamos si los datos ya están cargados
    if (globalVar.OC_order.RC_restaurant.NSS_name) {
        
        // Construimos el texto
        NSMutableString *NSMS_text = [[NSMutableString alloc] init];
        
        // Insertamos la base de la consulta
        [NSMS_text appendString:[NSString stringWithFormat:@"Has efectuado correctamente el pago de %.2f€ en el Restaurante %@\n\nResumen Comida:\n", globalVar.OC_order.CGF_total, globalVar.OC_order.RC_restaurant.NSS_name]]; 
        
        // Insertamos la comida
        int iPos = 0;
        for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods) {
            
            // Comprobamos si hay más de elemnto de comida -> inserta coma
            if (iPos != 0) [NSMS_text appendString:@", "];
            else iPos += 1;
            
            // Insertamos el detalle de la comida
            [NSMS_text appendString:[NSString stringWithFormat:@"%d %@", OFC_food.NSI_amount, OFC_food.NSS_namefood]];
        }
        
        // Iniciamos el UITextView
        [UITV_text setText:NSMS_text];
    }
    else {
        
        // Iniciamos el UITextView
        [UITV_text setText:@""];
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
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestaurante
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestaurante {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadRestauranteSuccessful:) 
                                                 name: _NOTIFICATION_RESTAURANTE_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_RESTAURANTE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_RESTAURANTE_ERROR_
                                               object: nil];
    
    // Indicamos que no queremos cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrderFood
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFood {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDER_FOOD_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDER_FOOD_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDER_FOOD_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadOrderFoodSuccessful:) 
                                                 name: _NOTIFICATION_ORDER_FOOD_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_ORDER_FOOD_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_ORDER_FOOD_ERROR_
                                               object: nil];
    
    // Indicamos que no quieremos cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadOrderFood];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mailOrderticket
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mailOrderticket {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_TICKET_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_TICKET_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_TICKET_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(mailOrderticketSuccessful:) 
                                                 name: _NOTIFICATION_SEND_ORDER_TICKET_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SEND_ORDER_TICKET_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SEND_ORDER_TICKET_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading mailOrderticket];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : valueRestaurant
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) valueRestaurant {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(valueRestaurantSuccessful:) 
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
    [globalVar.LVC_loading valueRestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavorite
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
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
//#	Procedimiento   : loadRestauranteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadOrderFood];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrderFoodSuccessful
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFoodSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadFacebookOffer];
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
    
    // Refrescamos la ventana
    [self viewWillAppear:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Marcamos que ya se ha utilizado la Facebook Offer
    [globalVar.OC_order.FC_facebook_offer setB_utilizada:TRUE];
    
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
        [globalVar.OC_order.FC_facebook_offer setB_future:TRUE];
        
        // Actauzliasmo BB.DD
        [self setFacebookOffer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mailOrderticketSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mailOrderticketSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_SEND_TICKET_ message:_ALERT_MSG_SEND_TICKET_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : valueRestaurantSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) valueRestaurantSuccessful:(NSNotification *)notification {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavoriteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavoriteSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad
    [self setB_favorite:!_B_favorite];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
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
}

#pragma mark -  
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_favorites_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_favorites_TouchUpInside:(id)sender {
    
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
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_faceboock_TouchUpInside:(id)sender {
    
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
//#	Procedimiento   : UIB_enviar_ticket_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_enviar_ticket_TouchUpInside:(id)sender {
    
    // Enviamos ticket por correo
    [self mailOrderticket];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_star_01_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_star_01_TouchUpInside:(id)sender {
    
    // Comprobamos si ha cambiado
    if (_NSI_starts != 1) {

        // Actualizamos stars
        [self setNSI_starts:1];

        // Actualizamos propiedades
        [globalVar setNSI_value:_NSI_starts];
        [globalVar setB_valueFavoritos:FALSE];
        
        // Enviamos puntuación al servidor
        [self valueRestaurant];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_star_02_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_star_02_TouchUpInside:(id)sender {
    
    // Comprobamos si ha cambiado
    if (_NSI_starts != 2) {
        
        // Actualizamos stars
        [self setNSI_starts:2];
        
        // Actualizamos propiedades
        [globalVar setNSI_value:_NSI_starts];
        [globalVar setB_valueFavoritos:FALSE];
        
        // Enviamos puntuación al servidor
        [self valueRestaurant];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_star_03_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_star_03_TouchUpInside:(id)sender {
    
    // Comprobamos si ha cambiado
    if (_NSI_starts != 3) {
        
        // Actualizamos stars
        [self setNSI_starts:3];
        
        // Actualizamos propiedades
        [globalVar setNSI_value:_NSI_starts];
        [globalVar setB_valueFavoritos:FALSE];
        
        // Enviamos puntuación al servidor
        [self valueRestaurant];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_star_04_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_star_04_TouchUpInside:(id)sender {
    
    // Comprobamos si ha cambiado
    if (_NSI_starts != 4) {
        
        // Actualizamos stars
        [self setNSI_starts:4];
        
        // Actualizamos propiedades
        [globalVar setNSI_value:_NSI_starts];
        [globalVar setB_valueFavoritos:FALSE];
        
        // Enviamos puntuación al servidor
        [self valueRestaurant];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_star_05_TouchUpInside
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_star_05_TouchUpInside:(id)sender {
    
    // Comprobamos si ha cambiado
    if (_NSI_starts != 5) {
        
        // Actualizamos stars
        [self setNSI_starts:5];
        
        // Actualizamos propiedades
        [globalVar setNSI_value:_NSI_starts];
        [globalVar setB_valueFavoritos:FALSE];
        
        // Enviamos puntuación al servidor
        [self valueRestaurant];
    }
}


@end
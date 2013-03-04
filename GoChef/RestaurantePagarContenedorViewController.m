//
//  RestaurantePagarContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestaurantePagarContenedorViewController.h"
#import "RestauranteConfirmacionViewController.h"
#import "LoadingViewController.h"
#import "TabbarRestauranteViewController.h"
#import "TarjetasAltaViewController.h"
#import "TabbarRestauranteViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "FacebookClass.h"
#import "FacebookOfferClass.h"
#import "TarjetaClass.h"


@implementation RestaurantePagarContenedorViewController

@synthesize B_favorite = _B_favorite;
@synthesize B_con_tarjeta = _B_con_tarjeta;
@synthesize B_come_from_tarjeta = _B_come_from_tarjeta;

@synthesize UIL_restaurantename;
@synthesize UIL_total;
@synthesize UIL_tarjeta;
@synthesize UIL_facebook_text;
@synthesize UIIV_facebook;
@synthesize UIB_favorites;
@synthesize UIV_contenido;
@synthesize UIV_general;
@synthesize UIV_tarjeta;

@synthesize RCVC_confirm      = _RCVC_confirm;
@synthesize TAVC_alta_tarjeta = _TAVC_alta_tarjeta;
@synthesize STVC_tarjeta      = _STVC_tarjeta;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_come_from_tarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_come_from_tarjeta:(BOOL)B_come_from_tarjeta {
    
    _B_come_from_tarjeta = B_come_from_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_con_tarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_con_tarjeta:(BOOL)B_con_tarjeta {
    
    _B_con_tarjeta = B_con_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTAVC_alta_tarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTAVC_alta_tarjeta:(TarjetasAltaViewController *)TAVC_alta_tarjeta {
    
    _TAVC_alta_tarjeta = TAVC_alta_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setSTVC_tarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTVC_tarjeta:(SelectTarjetaViewController *)STVC_tarjeta {
    
    _STVC_tarjeta = STVC_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setRCVC_confirm
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRCVC_confirm:(RestauranteConfirmacionViewController *)RCVC_confirm {
    
    _RCVC_confirm = RCVC_confirm;
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
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos propiedades
    [self setB_favorite:globalVar.OC_order_en_cocina.RC_restaurant.B_favorite];
    [self setB_con_tarjeta:FALSE];
    [self setB_come_from_tarjeta:FALSE];
    
    // Iniciamos componentes
    [UIL_restaurantename setText:globalVar.OC_order_en_cocina.RC_restaurant.NSS_name];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Pagar";
    
    // Actualizamos UILabel total
    [UIL_total setText:[NSString stringWithFormat:@"%.2f €", globalVar.OC_order_en_cocina.CGF_total]];
    
    // Actualizamos propiedad
    if (!_B_come_from_tarjeta) [self setB_con_tarjeta:FALSE];
    else [self setB_come_from_tarjeta:FALSE];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Comprobamos si ya hemos enviado pedido a cocina
    if (globalVar.B_pedido_en_cocina) {
     
        // Mostramos UIView contenido
        [UIV_contenido setAlpha:1.0f];
        
        // Insertamos UIViews
        [UIV_contenido addSubview:UIV_general];
        [UIV_contenido addSubview:UIV_tarjeta];
        
        // Comprobamos si debemos mostrar tarjetas
        if (_B_con_tarjeta) {
            
            // Posicionamos UIViews
            [UIV_general setFrame:CGRectMake(-UIV_general.frame.size.width, 53.0f, UIV_general.frame.size.width, UIV_general.frame.size.height)];
            [UIV_tarjeta setFrame:CGRectMake(0.0f, 53.0f, UIV_tarjeta.frame.size.width, UIV_tarjeta.frame.size.height)];
        }
        else {

            // Posicionamos UIViews
            [UIV_general setFrame:CGRectMake(0.0f, 53.0f, UIV_general.frame.size.width, UIV_general.frame.size.height)];
            [UIV_tarjeta setFrame:CGRectMake(UIV_general.frame.size.width, 53.0f, UIV_tarjeta.frame.size.width, UIV_tarjeta.frame.size.height)];
        }
    }
    else [UIV_contenido setAlpha:0.0f];
    
    // Creamos UIImage
    UIImage *UII_facebook;
    
    // Comprobamos si tiene Facebook Offer
    if (globalVar.OC_order_en_cocina.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Comprobamos si ya ha sido utilizada
        if (globalVar.OC_order_en_cocina.FC_facebook_offer.B_utilizada) {
            
            // Ocultamos texto
            [UIL_facebook_text setAlpha:0.0f];
            
            // Seleccionamo imagen correspondiente
            UII_facebook = [UIImage imageNamed:@"mi_actividad_facebook_enviado.png"];
        }
        else {
            
            // Actualizamos componentes
            [UIL_facebook_text setText:globalVar.OC_order_en_cocina.FC_facebook_offer.NSS_offer_description];
            
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
    //[UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
    //[UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
    //[UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
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
//#	Procedimiento	: selectDefaultCreditCard
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) selectDefaultCreditCard {
    
    // Recorremos el array de tarjetas
    for (TarjetaClass *TC_tarjeta in globalVar.NSMA_tarjetas) {
        
        // Comprobamo si es la tarjeta por defecto
        if (TC_tarjeta.B_default) {
            
            // Marcamos como tarjeta seleccionada
            [globalVar.OC_order_en_cocina setTC_creditcard:TC_tarjeta];
            
            // Actualizamos UILabel
            [UIL_tarjeta setText:[globalVar formatTarjetaNumber:globalVar.OC_order_en_cocina.TC_creditcard]];
            
            break;
        }
    }
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
//#	Procedimiento   : pedirCuenta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedirCuenta {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(pedirCuentaSuccessful:) 
                                                 name: _NOTIFICATION_CHECK_OUT_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_CHECK_OUT_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_CHECK_OUT_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading pedirCuenta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pagarConTarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pagarConTarjeta {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(pagarConTarjetaSuccessful:) 
                                                 name: _NOTIFICATION_CHECK_OUT_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_CHECK_OUT_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_CHECK_OUT_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading pagarConTarjeta];
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
//#	Procedimiento   : pedirCuentaSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedirCuentaSuccessful:(NSNotification *)notification {
    
    // Mostramos mensaje de operación correcta
    [globalVar showAlerMsgWith:_ALERT_TITLE_PEDIR_CUENTA_ message:_ALERT_MSG_PEDIR_CUENTA_];
    
    // Actualizamos propiedades
    [globalVar setB_realizando_pedido:FALSE];
    [globalVar setB_pedido_confirmado:TRUE];
    [globalVar setB_pedido_en_cocina :FALSE];
    
    // Iniciamos Tabbar
    [globalVar.TPVC_restaurante en_cocina_globo_reset];
    
    // Creamos RestauranteConfirmacionViewController
    _RCVC_confirm = [[RestauranteConfirmacionViewController alloc] initWithNibName:@"RestauranteConfirmacionView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RCVC_confirm animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pagarConTarjetaSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pagarConTarjetaSuccessful:(NSNotification *)notification {
    
    // Mostramos mensaje de operación correcta
    [globalVar showAlerMsgWith:_ALERT_TITLE_PAGAR_TARJETA_ message:_ALERT_MSG_PAGAR_TARJETA_];
    
    // Actualizamos propiedades
    [globalVar setB_realizando_pedido:FALSE];
    [globalVar setB_pedido_confirmado:TRUE];
    [globalVar setB_pedido_en_cocina :FALSE];
    
    // Iniciamos Tabbar
    [globalVar.TPVC_restaurante en_cocina_globo_reset];
    
    // Creamos RestauranteConfirmacionViewController
    _RCVC_confirm = [[RestauranteConfirmacionViewController alloc] initWithNibName:@"RestauranteConfirmacionView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RCVC_confirm animated:YES];
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
//#	Procedimiento   : setFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Marcamos que ya se ha utilizado la Facebook Offer
    [globalVar.OC_order_en_cocina.FC_facebook_offer setB_utilizada:TRUE];
    
    // Recuperamos el plato de regalo
    FoodClass *FC_food = [globalVar getFoodWithId:globalVar.OC_order_en_cocina.FC_facebook_offer.NSI_idfood];
    
    // Construimos OrderFoodClass
    OrderFoodClass *OFC_order_food = [[OrderFoodClass alloc] init];
    
    // Iniciamos propiedades OrderFoodClass
    [OFC_order_food setNSI_idfood               : FC_food.NSI_idfood];
    [OFC_order_food setNSI_idfoodcategories     : FC_food.NSI_idfoodcategories];
    [OFC_order_food setNSS_namefood             : FC_food.NSS_namefood];
    [OFC_order_food setCGF_price                : FC_food.CGF_price];
    [OFC_order_food setCGF_priceplusfoodgroup   : FC_food.CGF_priceplusfoodgroup];
    
    // Añadimos el plato al pedido
    [globalVar.OC_order_en_cocina.NSMA_orderfoods addObject:OFC_order_food];
    
    // Lo marcamos como Offer (coste 0)
    [OFC_order_food setB_is_offer_facebook:TRUE];
    
    // Añadimos descuento a la Order
    [globalVar.OC_order_en_cocina setNSI_idoffer_facebook:globalVar.OC_order_en_cocina.FC_facebook_offer.NSI_idoffer_facebook];
    [globalVar.OC_order_en_cocina setCGF_facebook_discount:FC_food.CGF_price];
    
    // Actualizamos Tabbar Globe
    [globalVar.TPVC_restaurante en_cocina_globo_addValue:1];
    
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
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initSetFacebookOffer:(NSNotification *)notification {
    
    // Comprobamos si es una recomendación "normal"
    if (globalVar.OC_order_en_cocina.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        // Mostramos mensage
        [globalVar showAlerMsgWith:_ALERT_TITLE_FACEBOOK_ message:_ALERT_MSG_FACEBOOK_];
    }
    else {
        
        // Actualizamos Facebook Offer
        [globalVar.OC_order_en_cocina.FC_facebook_offer setB_future:FALSE];
        
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
    
    // Comprobamos si tiene Facebook Offer y ha sido utilizada
    if ((globalVar.OC_order_en_cocina.FC_facebook_offer.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && 
        (globalVar.OC_order_en_cocina.FC_facebook_offer.B_utilizada)) return;
            
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
//#	Procedimiento   : UIB_pedir_cuenta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_cuenta_TouchUpInside:(id)sender {
    
    // Actualizamos estado
    [globalVar.OC_order_en_cocina setTOS_status:TOS_confirmado_y_pagado_con_efectivo];
    
    // Realizamos la operación
    [self pedirCuenta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_next_view_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_next_view_tarjeta_TouchUpInside:(id)sender {
    
    // Actualizamos propiedad
    [self setB_con_tarjeta:TRUE];
    
    // Seleccionamos la Default CreditCard
    [self selectDefaultCreditCard];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [UIV_general setFrame:CGRectMake(-UIV_general.frame.size.width, 53.0f, UIV_general.frame.size.width, UIV_general.frame.size.height)];
    [UIV_tarjeta setFrame:CGRectMake(0.0f, 53.0f, UIV_tarjeta.frame.size.width, UIV_tarjeta.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_prev_view_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_prev_view_tarjeta_TouchUpInside :(id)sender {
    
    // Actualizamos propiedad
    [self setB_con_tarjeta:FALSE];
    
    // Indicamos que no hay tarjeta
    globalVar.OC_order_en_cocina.TC_creditcard = [[TarjetaClass alloc] init];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [UIV_general setFrame:CGRectMake(0.0f, 53.0f, UIV_general.frame.size.width, UIV_general.frame.size.height)];
    [UIV_tarjeta setFrame:CGRectMake(UIV_general.frame.size.width, 53.0f, UIV_tarjeta.frame.size.width, UIV_tarjeta.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pagar_con_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pagar_con_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos que si se ha seleccionado pago con tarjeta
    if (_B_con_tarjeta) {
        
        // Quitamos los posibles espacios
        NSString *NSS_tarjeta = [UIL_tarjeta.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // Comprobamos si no se ha seleccionado una tarjeta
        if ([NSS_tarjeta isEqualToString:@"Ninguna seleccionada"]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe seleccionar una tarjeta"];
            return;
        }
        
        // Comprobamos si el restaurante acepta ese tipo de tarjeta
        if ((([globalVar.OC_order.TC_creditcard.NSS_type isEqualToString:_CREDITCARD_VISA_TEXT_]) && (!globalVar.OC_order.RC_restaurant.B_visa)) ||
            (([globalVar.OC_order.TC_creditcard.NSS_type isEqualToString:_CREDITCARD_MASTERCARD_TEXT_]) && (!globalVar.OC_order.RC_restaurant.B_mastercard)))
        {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"El restaurante no permite pagos con el tipo de tarjeta seleccionado."];
            return;
        }
        
        // Comprobamos si la tarjeta tiene el CVV
        if ([globalVar.OC_order.TC_creditcard.NSS_cvv isEqualToString:_CVV_CREDIT_CARD_NULL]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Los datos de la tarjeta seleccionada están incompletos. Complete la información pendiente y vuelva a intentarlo."];
            return;
        }
    }
    
    // Cambiamos el estado de la Order
    [globalVar.OC_order_en_cocina setTOS_status:TOS_confirmado_y_pendiente_de_pago];
    
    // Realizamos la operación
    [self pagarConTarjeta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos si no hay tarjetas
    if ([globalVar.NSMA_tarjetas count] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"No hay tarjetas creadas."];
        
        return;
    }
    
    // Comprobamos si ya se está mostrando
    if (_STVC_tarjeta != nil) return;
    
    // Creamos SelectTarjetaViewController
    _STVC_tarjeta = [[SelectTarjetaViewController alloc] initWithNibName:@"SelectTarjetaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STVC_tarjeta setDelegate:self];
    
    // Iniciamos Propiedades
    [_STVC_tarjeta setNSS_tarjeta:UIL_tarjeta.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STVC_tarjeta.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STVC_tarjeta.view.frame.size.height), _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_alta_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_alta_tarjeta_TouchUpInside:(id)sender {
    
    // Atualizamos propiedad
    [self setB_come_from_tarjeta:TRUE];
    
    // Creamos TarjetasAltaViewController
    _TAVC_alta_tarjeta = [[TarjetasAltaViewController alloc] initWithNibName:@"TarjetasAltaView" bundle:[NSBundle mainBundle]];
    
    // Actualizamos propiedad
    [globalVar setTC_creditcard:nil];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_TAVC_alta_tarjeta animated:YES];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tarjeta:(TarjetaClass *)TC_tarjeta {
    
    // Marcamos como tarjeta seleccionada
    [globalVar.OC_order_en_cocina setTC_creditcard:TC_tarjeta];
    
    // Actualizamos UILabel
    [UIL_tarjeta setText:[globalVar formatTarjetaNumber:globalVar.OC_order_en_cocina.TC_creditcard]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_tarjeta {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Quitamos el View Select Tipo Cocina
    [_STVC_tarjeta.view removeFromSuperview];
    
    // Liberamos memoria
    _STVC_tarjeta = nil;
}


@end
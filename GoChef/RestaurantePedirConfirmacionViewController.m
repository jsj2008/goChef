//
//  RestaurantePedirConfirmacionViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestaurantePedirConfirmacionViewController.h"
#import "LoadingViewController.h"
#import "EnviarPedidoViewController.h"
#import "PedidoPlatoViewController.h"
#import "TabbarDomicilioViewController.h"
#import "TabbarRestauranteViewController.h"

#import "RestaurantClass.h"
#import "OrderClass.h"
#import "UserOfferClass.h"
#import "UserClass.h"
#import "FacebookClass.h"
#import "FacebookOfferClass.h"


@implementation RestaurantePedirConfirmacionViewController

@synthesize UITV_listado;

@synthesize CUITVCP_cell = _CUITVCP_cell; 
@synthesize CUITVCP_cabecera = _CUITVCP_cabecera;
@synthesize CUITVCP_pie = _CUITVCP_pie;

@synthesize EPVC_enviar = _EPVC_enviar;
@synthesize PPVC_plato  = _PPVC_plato;

@synthesize SOVC_oferta = _SOVC_oferta;

NSMutableArray *NSMA_cells;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cell:(CustomUITableViewCellPedido *)CUITVCP_cell {
    
    _CUITVCP_cell = CUITVCP_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cabecera:(CustomUITableViewCellPedidoCabecera *)CUITVCP_cabecera {
    
    _CUITVCP_cabecera = CUITVCP_cabecera;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_pie:(CustomUITableViewCellPedidoPie *)CUITVCP_pie {
    
    _CUITVCP_pie = CUITVCP_pie;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setEPVC_enviar
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setEPVC_enviar:(EnviarPedidoViewController *)EPVC_enviar {
    
    _EPVC_enviar = EPVC_enviar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPPVC_plato
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPPVC_plato:(PedidoPlatoViewController *)PPVC_plato {
    
    _PPVC_plato = PPVC_plato;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSOVC_oferta:(SelectOfertaViewController *)SOVC_oferta {
    
    _SOVC_oferta = SOVC_oferta;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos las propiedades
    NSMA_cells = [[NSMutableArray alloc] init];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    BOOL B_datos_cagados = FALSE;
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Confirmar";
    
    // Comprobamos si hay que cargar las Offer
    if ([globalVar.UC_user.NSMA_offers count] == 0) {
        
        B_datos_cagados = TRUE;
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadOffers)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
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
        if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [self addOffer];
        
        // Comprobamos si hay una Facebook Offer seleccionada
        if ((globalVar.OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && (globalVar.OC_order.CGF_facebook_discount == 0.0f)) [self addFacebookOffer];
    }
    
    // Actualizamos los datos
    [UITV_listado reloadData];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SHOW_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
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
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEGUIR_PIDIENDO_ 
                                                        object:self];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: addOffer
//#	Fecha Creación	: 30/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) addOffer {
    
    // Comprobamos si hay una oferta seleecionada
    if (globalVar.OC_order.OC_offer.NSI_idoffer == _ID_OFFER_NO_SELECTED_) return;
    
    // Comprobamos el tipo de oferta
    switch (globalVar.OC_order.OC_offer.TOT_typediscount)
    {
        case TOT_descuento_sobre_carta:
        {
            BOOL B_plato_carta = FALSE;
            
            // Recorremos array de platos buscando los que pertenecen a la carta
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                if (OFC_order_food.NSI_idfood != _ID_FOOD_NO_SELECCIONADA_) B_plato_carta = TRUE;
            
            // Comprobamos que exista, al menos, un plato de la carta
            if (!B_plato_carta) {
                
                // Desasociamos la offerta
                globalVar.OC_order.OC_offer = [[UserOfferClass alloc] init];
                
                // Quitamos el descuento aplicado
                [globalVar.OC_order setCGF_offer_discount:0.0f];
                
                // Mostramos mensaje de oferta no permitida
                [globalVar showNoOfferAllowedMessage];
            }
            
            break;
        }
        case TOT_regalo_plato_categoria:
        {
            CGFloat CGF_precio_max = -1.0f;
            OrderFoodClass *OFC_order_food_offer;
            
            // Recorremso array de comida del pedido
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                
                // Buscamos el plato más caro de la categoría
                if ((!OFC_order_food.B_is_offer) && 
                    (OFC_order_food.NSI_idfoodcategories == globalVar.OC_order.OC_offer.NSI_idfoodCategories) &&
                    (OFC_order_food.NSI_iddailymenu_food == _ID_FOOD_NO_SELECCIONADA_) &&
                    (OFC_order_food.CGF_price > CGF_precio_max) )
                {
                    OFC_order_food_offer = OFC_order_food;
                    CGF_precio_max = OFC_order_food.CGF_price;
                }
            
            // Comprobamos si encontró un plato
            if (CGF_precio_max > -1.0f) {
                
                // Marcamos plato como offer
                [OFC_order_food_offer setB_is_price_offer:TRUE];
                
                // Añadimos descuento a la Order
                [globalVar.OC_order setCGF_offer_discount:OFC_order_food_offer.CGF_price];
            }
            else {
                
                // Desasociamos la offerta
                globalVar.OC_order.OC_offer = [[UserOfferClass alloc] init];
                
                // Quitamos el descuento aplicado
                [globalVar.OC_order setCGF_offer_discount:0.0f];
                
                // Mostramos mensaje de oferta aplicable por no tener platos de la categoria
                [globalVar showNoOfferCategoryMessage];
            }
            
            break;
        }
        case TOT_regalo_plato:
        {
            // Recuperamos el plato de regalo
            FoodClass *FC_food = [globalVar getFoodWithId:globalVar.OC_order.OC_offer.NSI_idfood];
            
            // Construimos OrderFoodClass
            OrderFoodClass *OFC_order_food = [[OrderFoodClass alloc] init];
            
            // Iniciamos propiedades OrderFoodClass
            [OFC_order_food setNSI_idfood               : FC_food.NSI_idfood];
            [OFC_order_food setNSI_idfoodcategories     : FC_food.NSI_idfoodcategories];
            [OFC_order_food setNSS_namefood             : FC_food.NSS_namefood];
            [OFC_order_food setCGF_price                : FC_food.CGF_price];
            [OFC_order_food setCGF_priceplusfoodgroup   : FC_food.CGF_priceplusfoodgroup];
            
            // Añadimos el plato al pedido
            [globalVar.OC_order.NSMA_orderfoods addObject:OFC_order_food];
            
            // Actualizamos Tabbar Globe
            [globalVar.TPVC_restaurante pedir_globo_addValue:1];
            
            // Lo marcamos como Offer (coste 0)
            [OFC_order_food setB_is_offer:TRUE];
            
            // Añadimos descuento a la Order
            [globalVar.OC_order setCGF_offer_discount:FC_food.CGF_price];
            
            break;
        }
        case TOT_2x1_en_categoria:
        {
            CGFloat CGF_precio_max = -1.0f;
            OrderFoodClass *OFC_order_food_offer;
            
            // Recorremso array de comida del pedido
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                
                // Buscamos el plato más caro de la categoría
                if ((!OFC_order_food.B_is_offer) && 
                    (OFC_order_food.NSI_idfoodcategories == globalVar.OC_order.OC_offer.NSI_idfoodCategories) &&
                    (OFC_order_food.NSI_iddailymenu_food == _ID_FOOD_NO_SELECCIONADA_) &&
                    (OFC_order_food.CGF_price > CGF_precio_max) &&
                    (OFC_order_food.NSI_amount > 1))
                {
                    OFC_order_food_offer = OFC_order_food;
                    CGF_precio_max = OFC_order_food.CGF_price;
                }
            
            // Comprobamos si encontró un plato
            if (CGF_precio_max > -1.0f) {
                
                // Marcamos plato como offer
                [OFC_order_food_offer setB_is_price_offer:TRUE];
                
                // Añadimos descuento a la Order
                [globalVar.OC_order setCGF_offer_discount:OFC_order_food_offer.CGF_price];
            }
            else {
                
                // Desasociamos la offerta
                globalVar.OC_order.OC_offer = [[UserOfferClass alloc] init];
                
                // Quitamos el descuento aplicado
                [globalVar.OC_order setCGF_offer_discount:0.0f];
                
                // Mostramos mensaje de oferta aplicable por no tener platos de la categoria
                [globalVar showNoOfferCategoryMessage];
            }
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: redoOffer
//#	Fecha Creación	: 30/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) redoOffer {
    
    // Quitamos anterior oferta
    switch (globalVar.OC_order.OC_offer.TOT_typediscount)
    {
        case TOT_descuento_sobre_carta:
        {
            // Quitamos el descuento aplicado
            [globalVar.OC_order setCGF_offer_discount:0.0f];
            break;
        }
        case TOT_regalo_plato_categoria:
        {
            OrderFoodClass *OFC_order_food_offer;
            
            // Buscamos el plato
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                if (OFC_order_food.B_is_price_offer) {
                    OFC_order_food_offer = OFC_order_food;
                    break;
                }
            
            // Marcamos plato como offer
            [OFC_order_food_offer setB_is_price_offer:FALSE];
            
            // Actualizamos descuento
            [globalVar.OC_order setCGF_offer_discount:0.0f];
            
            break;
        }
        case TOT_regalo_plato:
        {
            OrderFoodClass *OFC_order_food_offer;
            
            // Buscamos el plato
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                if (OFC_order_food.NSI_idfood == globalVar.OC_order.OC_offer.NSI_idfood) {
                    OFC_order_food_offer = OFC_order_food;
                    break;
                }
            
            // Eliminamos el plato
            [globalVar.OC_order.NSMA_orderfoods removeObject:OFC_order_food_offer];
            
            // Actualizamos Tabbar Globe
            [globalVar.TPVC_restaurante pedir_globo_redoValue:1];
            
            // Actualizamos descuento
            [globalVar.OC_order setCGF_offer_discount:0.0f];
            
            break;            
        }
        case TOT_2x1_en_categoria:
        {
            OrderFoodClass *OFC_order_food_offer;
            
            // Buscamos el plato
            for (OrderFoodClass *OFC_order_food in globalVar.OC_order.NSMA_orderfoods)
                if (OFC_order_food.B_is_price_offer) {
                    OFC_order_food_offer = OFC_order_food;
                    break;
                }
            
            // Marcamos plato como offer
            [OFC_order_food_offer setB_is_price_offer:FALSE];
            
            // Actualizamos descuento
            [globalVar.OC_order setCGF_offer_discount:0.0f];
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: addFacebookOffer
//#	Fecha Creación	: 30/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) addFacebookOffer {
    
    // Recuperamos el plato de regalo
    FoodClass *FC_food = [globalVar getFoodWithId:globalVar.OC_order.FC_facebook_offer.NSI_idfood];
    
    // Construimos OrderFoodClass
    OrderFoodClass *OFC_order_food = [[OrderFoodClass alloc] init];
    
    // Iniciamos propiedades OrderFoodClass
    [OFC_order_food setNSI_idfood               : FC_food.NSI_idfood];
    [OFC_order_food setNSI_idfoodcategories     : FC_food.NSI_idfoodcategories];
    [OFC_order_food setNSS_namefood             : FC_food.NSS_namefood];
    [OFC_order_food setCGF_price                : FC_food.CGF_price];
    [OFC_order_food setCGF_priceplusfoodgroup   : FC_food.CGF_priceplusfoodgroup];
    
    // Añadimos el plato al pedido
    [globalVar.OC_order.NSMA_orderfoods addObject:OFC_order_food];
    
    // Actualizamos Tabbar Globe
    [globalVar.TPVC_restaurante pedir_globo_addValue:1];
    
    // Lo marcamos como Offer (coste 0)
    [OFC_order_food setB_is_offer_facebook:TRUE];
    
    // Añadimos descuento a la Order
    [globalVar.OC_order setNSI_idoffer_facebook:globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook];
    [globalVar.OC_order setCGF_facebook_discount:FC_food.CGF_price];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffers
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
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
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    BOOL B_datos_cagados = FALSE;
    
    // Comprobamos si ya están cargadas las ofertas de Facebook
    if (globalVar.OC_order.FC_facebook_offer.NSI_idoffer_facebook == _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {
        
        B_datos_cagados = TRUE;
        
        // Actualizamos los datos
        [self loadFacebookOffer];
    }
    
    // Comprobamos si no se han cargado los datos
    if (!B_datos_cagados) {
        
        // Comprobamos si hay una Offerta seleccionada
        if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [self addOffer];
        
        // Comprobamos si hay una Facebook Offer seleccionada
        if ((globalVar.OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && (globalVar.OC_order.CGF_facebook_discount == 0.0f)) [self addFacebookOffer];
        
        // Actualizamos los datos
        [UITV_listado reloadData];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Comprobamos si hay una Offerta seleccionada
    if ((globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) && (globalVar.OC_order.CGF_offer_discount == 0.0f)) [self addOffer];
    
    // Comprobamos si hay una Facebook Offer seleccionada
    if ((globalVar.OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) && (globalVar.OC_order.CGF_facebook_discount == 0.0f)) [self addFacebookOffer];
    
    // Actualizamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Mostramos mensage
    [globalVar showAlerMsgWith:_ALERT_TITLE_FACEBOOK_ message:_ALERT_MSG_FACEBOOK_];
    
    // Marcamos que ya se ha utilizado la Facebook Offer
    [globalVar.OC_order.FC_facebook_offer setB_utilizada:TRUE];
    
    // Cargamos Facebook Offer
    [self addFacebookOffer];
    
    // Actualizamos los datos
    [UITV_listado reloadData];  
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
        
        // Actauzliasmo BB.DD
        [self setFacebookOffer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
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
//#	Fecha Creación	: 22/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Reseteamos el Globo de la Tabbar
        [globalVar.TPVC_domicilio resetGlobo];
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                            object:self];
    }
}

#pragma mark -
#pragma mark Table view data source

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfSectionsInTableView
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: Customize the number of sections in the table view.
//#
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:numberOfRowsInSection
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Actualizamos el valor dependiendo que datos se muestren en la lista
    return ([globalVar.OC_order.NSMA_orderfoods count]+2);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:titleForHeaderInSection:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:cellForRowAtIndexPath:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == 0) {
        
        // Creamos el Cell View Controller
        _CUITVCP_cabecera = [[CustomUITableViewCellPedidoCabecera alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCP_cabecera setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_cabecera setContentWith:globalVar.OC_order.RC_restaurant.NSS_name];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_cabecera];
        
        return _CUITVCP_cabecera;
    }
    else if (indexPath.row == [globalVar.OC_order.NSMA_orderfoods count]+1) {
        
        // Creamos el Cell View Controller
        _CUITVCP_pie = [[CustomUITableViewCellPedidoPie alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCP_pie setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_pie setContentWith:globalVar.OC_order];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_pie];
        
        return _CUITVCP_pie;
    }
    else {
        
        // Recuperamos el PedidoClass de la celda
        OrderFoodClass *OFC_food = [globalVar.OC_order.NSMA_orderfoods objectAtIndex:(indexPath.row-1)];
        
        // Creamos el Cell View Controller
        _CUITVCP_cell = [[CustomUITableViewCellPedido alloc] init];
        
        // Asignamos delegado
        [_CUITVCP_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_cell setContentWith:OFC_food];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_cell];
        
        return _CUITVCP_cell;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:canEditRowAtIndexPath:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: Override to support conditional editing of the table view.
//#
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return NO;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:heightForRowAtIndexPath:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) return 130.0f;
    else if (indexPath.row == [globalVar.OC_order.NSMA_orderfoods count]+1) return 340.0f;
    else return 42.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(OrderFoodClass *)OFC_food {
    
    // Comprobamos si es de Menú o Carta
    if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEGUIR_PIDIENDO_ 
                                                            object:self];
        
        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        // Creamos PedidoPlatoViewController
        _PPVC_plato = [[PedidoPlatoViewController alloc] initWithNibName:@"PedidoPlatoView" bundle:[NSBundle mainBundle]];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_PPVC_plato animated:YES];
        
        // Recuperamos la foodclass
        for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods)
            if (FC_food.NSI_idfood == OFC_food.NSI_idfood) {
                
                // Marcamos OrderFoodClass como activa
                [globalVar setOFC_order_food:OFC_food];
                
                // Actualizamos porpiedades
                [_PPVC_plato setFC_food:FC_food];
            }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_mas_comida_Touched {
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEGUIR_PIDIENDO_ 
                                                        object:self];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : enviar_pedido_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) enviar_pedido_Touched {
    
    // Comprobamos que el pedido sea mayor del minimo establecido
    CGFloat CGF_total = globalVar.OC_order.CGF_total;
    if (CGF_total < globalVar.OC_order.RC_restaurant.CGF_min_price_homedelivery) {
        
        // Mostramos msg
        [globalVar showAlerMsgWith:@"Información"
                           message:[NSString stringWithFormat:@"El pedido debe ser, como mínimo, de %.2f €.", globalVar.OC_order.RC_restaurant.CGF_min_price_homedelivery]];
    }
    else {
        
        // Creamos EnviarPedidoViewController
        _EPVC_enviar = [[EnviarPedidoViewController alloc] initWithNibName:@"EnviarPedidoView" bundle:[NSBundle mainBundle]];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_EPVC_enviar animated:YES];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : recomiendo_en_facebook
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recomiendo_en_facebook {
    
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
//#	Procedimiento   : cancelar_pedido_Touched
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cancelar_pedido_Touched {
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro de que desea cancelar el pedido en curso?"];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_oferta_Touched {
    
    // Comprobamos si el usuario tiene ofertas para el restaurante
    if (![globalVar.UC_user haveOffersForRestaurant:globalVar.OC_order.RC_restaurant.NSI_idrestaurant]) {
        
        // Mostramos mensaje de falta de ofertas
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_OFFERS_ message:_ALERT_MSG_NO_OFFERS_];
        
        return;
    }
    
    // Comprobamos si ya se han enviado ofertas a cocina
    if ((globalVar.B_pedido_en_cocina) &&
        (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) && 
        (globalVar.OC_order_en_cocina.NSI_idoffer != _ID_OFFER_NO_SELECTED_))
    {
        
        // Mostramos mensaje de falta de ofertas
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_MORE_OFFERS_ message:_ALERT_MSG_NO_MORE_OFFERS_];
        
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

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_oferta:(UserOfferClass *)UOC_offer {
    
    // Comprobamos si es la misma que ya se tenía
    if (globalVar.OC_order.OC_offer == UOC_offer) return;
    
    // Quitamos anterior Offer
    [self redoOffer];
    
    // Fijamos la oferta en el Order
    [globalVar.OC_order setOC_offer:UOC_offer];
    
    // Añadismo Offer
    [self addOffer];
    
    // Cargamos los datos de nuevo
    [UITV_listado reloadData];
    
    // Actualizamos UILabel
    //if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) [_CUITVCP_pie.CUITVCPVC_cell.UIL_domicilio_oferta setText:UOC_offer.NSS_nameoffer];
    //else [_CUITVCP_pie.CUITVCPVC_cell.UIL_recoger_oferta setText:UOC_offer.NSS_nameoffer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Fecha Creación	: 30/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Quitamos el View Select Tipo Cocina
    [_SOVC_oferta.view removeFromSuperview];
    
    // Liberamos memoria
    _SOVC_oferta = nil;
}

@end

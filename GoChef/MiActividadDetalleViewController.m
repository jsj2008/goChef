//
//  MiActividadDetalleViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiActividadDetalleViewController.h"
#import "LoadingViewController.h"
#import "CustomUITableViewCellPedidoConfirmacion.h"
#import "CustomUITableViewCellPedidoConfirmacionCabecera.h"
#import "MiActividadConfirmarViewController.h"

#import "RestaurantClass.h"
#import "OrderClass.h"
#import "FacebookOfferClass.h"
#import "FoodClass.h"
#import "UserOfferClass.h"
#import "UserClass.h"
#import "JSONparseClass.h"


@implementation MiActividadDetalleViewController

@synthesize UITV_listado;

@synthesize CUITVCP_cell = _CUITVCP_cell; 
@synthesize CUITVCP_cabecera = _CUITVCP_cabecera;
@synthesize CUITVCP_pie = _CUITVCP_pie;

@synthesize PIVC_instruction = _PIVC_instruction;
@synthesize MACVC_confirmar = _MACVC_confirmar;

NSMutableArray *NSMA_cells;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setMACVC_confirmar
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMACVC_confirmar:(MiActividadConfirmarViewController *)MACVC_confirmar {
    
    _MACVC_confirmar = MACVC_confirmar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPIVC_instruction
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPIVC_instruction:(PedidoInstructionsViewController *)PIVC_instruction {
    
    _PIVC_instruction = PIVC_instruction;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cell:(CustomUITableViewCellPedidoConfirmacion *)CUITVCP_cell {
    
    _CUITVCP_cell = CUITVCP_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cabecera:(CustomUITableViewCellPedidoConfirmacionCabecera *)CUITVCP_cabecera {
    
    _CUITVCP_cabecera = CUITVCP_cabecera;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_pie:(CustomUITableViewCellMiActividadPie *)CUITVCP_pie {
    
    _CUITVCP_pie = CUITVCP_pie;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
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
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadOrderFood)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Confirmación";
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
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
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
    
    // Indicamos que no quieremos cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategories
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategories {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_CATEGORIES_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_CATEGORIES_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_CATEGORIES_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadFoodCategoriesSuccessful:) 
                                                 name: _NOTIFICATION_FOOD_CATEGORIES_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_FOOD_CATEGORIES_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_FOOD_CATEGORIES_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadFoodCategories];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoods
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoods {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadFoodsSuccessful:) 
                                                 name: _NOTIFICATION_FOOD_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_FOOD_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_FOOD_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusCategories
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategories {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_CATEGORIES_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_CATEGORIES_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadDailymenusCategoriesSuccessful:)
                                                 name: _NOTIFICATION_DAILY_MENU_CATEGORIES_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_DAILY_MENU_CATEGORIES_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadDailymenusCategories];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenus
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenus {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadDailymenusSuccessful:) 
                                                 name: _NOTIFICATION_DAILY_MENU_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_DAILY_MENU_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_DAILY_MENU_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadDailymenus];
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

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrderFoodSuccessful
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFoodSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestauranteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    //[self loadFoodCategories];
    [self loadFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategoriesSuccessful
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategoriesSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsSuccessful
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodsSuccessful:(NSNotification *)notification {
    
    // Recorremos el array de OrderFood para recuperar las options
    for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods) {
        
        // Comprobamos que no sea un menú
        if (OFC_food.NSI_iddailymenu_food == _ID_FOOD_NO_SELECCIONADA_) {

            // Buscamos la Food relacionada
            for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods) {
                
                // Comprobamos si es la que buscamos
                if (OFC_food.NSI_idfood == FC_food.NSI_idfood) {
                    
                    // Comprobanos si tiene options
                    if (FC_food.B_options) {
                        
                        [globalVar.JPC_json UMNI_getFoodOptions:FC_food obligatory:FALSE images:FALSE];
                        [globalVar.JPC_json UMNI_getFoodOptions:FC_food obligatory:TRUE images:FALSE];
                    }
                }
            }
        }
    }
    
    // Recuperamos listado de menus del resturante
    //[self loadDailymenusCategories];
    [self loadDailymenus];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusCategoriesSuccessful
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategoriesSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de menus del resturante
    [self loadDailymenus];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusSuccessful
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenusSuccessful:(NSNotification *)notification {
    
    // Comprobamos si hay Facebook Offer
    if (globalVar.OC_order.NSI_idoffer_facebook != _ID_FACEBOOK_OFFER_NO_SELECCIONADA_) {

        // Actualizamos Facebook Offer
        [globalVar.OC_order.FC_facebook_offer setNSI_idoffer_facebook:globalVar.OC_order.NSI_idoffer_facebook];
        
        // Actualizamos los datos
        [self loadFacebookOffer];
    }
    else if (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Actualizamos los datos
        [self loadOffers];
    }
    else {
        
        // Actualizamos los datos
        [UITV_listado reloadData];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFacebookOfferSuccessful
//#	Fecha Creación	: 23/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Comprobamos si hay Offer
    if (globalVar.OC_order.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Actualizamos los datos
        [self loadOffers];
    }
    
    // Recuperamos el plato de regalo
    FoodClass *FC_food = [globalVar getFoodWithId:globalVar.OC_order.FC_facebook_offer.NSI_idfood];
    
    // Construimos OrderFoodClass
    OrderFoodClass *OFC_order_food = [[OrderFoodClass alloc] init];
    
    // Iniciamos propiedades OrderFoodClass
    [OFC_order_food setNSI_idfood           : FC_food.NSI_idfood];
    [OFC_order_food setNSI_idfoodcategories : FC_food.NSI_idfoodcategories];
    [OFC_order_food setNSS_namefood         : FC_food.NSS_namefood];
    [OFC_order_food setCGF_price            : globalVar.OC_order.CGF_facebook_discount];
    
    // Añadimos el plato al pedido
    [globalVar.OC_order.NSMA_orderfoods addObject:OFC_order_food];
    
    // Añadirmos la cantidad el subtotal
    [globalVar.OC_order setCGF_subtotal:(globalVar.OC_order.CGF_subtotal + globalVar.OC_order.CGF_facebook_discount)];
    
    // Actualizamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 30/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    UserOfferClass *UOC_offer_selected;
    
    // Buscamos Offer
    for (UserOfferClass *UOC_offer in globalVar.UC_user.NSMA_offers)
        if (UOC_offer.NSI_idoffer == globalVar.OC_order.NSI_idoffer) {
            UOC_offer_selected = UOC_offer;
            break;
        }

    // Comprobamos que sea de tipo 'regalar plato'
    if (UOC_offer_selected.TOT_typediscount == TOT_regalo_plato) {
        
        // Recuperamos el plato de regalo
        FoodClass *FC_food = [globalVar getFoodWithId:UOC_offer_selected.NSI_idfood];
        
        // Construimos OrderFoodClass
        OrderFoodClass *OFC_order_food = [[OrderFoodClass alloc] init];
        
        // Iniciamos propiedades OrderFoodClass
        [OFC_order_food setNSI_idfood           : FC_food.NSI_idfood];
        [OFC_order_food setNSI_idfoodcategories : FC_food.NSI_idfoodcategories];
        [OFC_order_food setNSS_namefood         : FC_food.NSS_namefood];
        [OFC_order_food setCGF_price            : globalVar.OC_order.CGF_offer_discount];
        
        // Añadimos el plato al pedido
        [globalVar.OC_order.NSMA_orderfoods addObject:OFC_order_food];
        
        // Añadirmos la cantidad el subtotal
        [globalVar.OC_order setCGF_subtotal:globalVar.OC_order.CGF_subtotal];
    }

    // Actualizamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == 0) {
        
        // Creamos el Cell View Controller
        _CUITVCP_cabecera = [[CustomUITableViewCellPedidoConfirmacionCabecera alloc] initWithFrame:CGRectZero];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_cabecera setContentWith:globalVar.OC_order];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_cabecera];
        
        return _CUITVCP_cabecera;
    }
    else if (indexPath.row == [globalVar.OC_order.NSMA_orderfoods count]+1) {
        
        // Creamos el Cell View Controller
        _CUITVCP_pie = [[CustomUITableViewCellMiActividadPie alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegado
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
        _CUITVCP_cell = [[CustomUITableViewCellPedidoConfirmacion alloc] initWithFrame:CGRectZero];
        
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
    
    if (indexPath.row == 0) return 110.0f;
    else if (indexPath.row == [globalVar.OC_order.NSMA_orderfoods count]+1) return 340.0f;
    else return 42.0f;
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : show_instructions_Touched
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) show_instructions_Touched {
    
    // Creamos PedidoInstructionsViewController
    _PIVC_instruction = [[PedidoInstructionsViewController alloc] initWithNibName:@"PedidoInstructionsView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_PIVC_instruction setDelegate:self];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_PIVC_instruction animated:YES];
    
    // Actualizamos las instrucciones especiales
    [_PIVC_instruction.UITV_instructions setText:globalVar.OC_order.NSS_instructions];
    
    // Actualizamos ReadOnbly mode
    [_PIVC_instruction setB_readonly:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : guardar_instructions_Touched
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 05/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) guardar_instructions_Touched:(NSString *)NSS_instructions {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : status_Touched
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) status_Touched {
    
    BOOL B_realizar_llamada = FALSE;
    
    // Iniciamos UIButton Enviar Por Correo
    switch (globalVar.OC_order.TOS_status)
    {
        case TOS_pagado_con_tarjeta               : { B_realizar_llamada = TRUE;  break; }
        case TOS_confirmado_y_pagado_con_tarjeta  : { B_realizar_llamada = TRUE;  break; }
        case TOS_confirmado_y_pagado_con_efectivo : { B_realizar_llamada = TRUE;  break; }
        case TOS_confirmado                       : { B_realizar_llamada = FALSE; break; }
        case TOS_pagado_con_efectivo              : { B_realizar_llamada = TRUE;  break; }
        case TOS_pendiente_de_confirmar_y_pago    : { B_realizar_llamada = FALSE; break; }
        case TOS_confirmado_y_pendiente_de_pago   : { B_realizar_llamada = FALSE; break; }
        case TOS_cobro_fallido                    : { B_realizar_llamada = FALSE; break; }
        case TOS_devolucion_efectuada             : { B_realizar_llamada = FALSE; break; }
        case TOS_devolucion_fallida               : { B_realizar_llamada = FALSE; break; }
        case TOS_devolucion_pendiente             : { B_realizar_llamada = FALSE; break; }
        case TOS_cancelado                        : { B_realizar_llamada = FALSE; break; }

    }
    
    // Comprobamos que el estado sea diferente del 5
    if (B_realizar_llamada) {
        
        // Creamos ViewController
        _MACVC_confirmar = [[MiActividadConfirmarViewController alloc] initWithNibName:@"MiActividadConfirmarView" bundle:[NSBundle mainBundle]];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_MACVC_confirmar animated:YES];
    }
}
@end
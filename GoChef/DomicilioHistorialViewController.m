//
//  DomicilioHistorialViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "DomicilioHistorialViewController.h"
#import "LoadingViewController.h"
#import "TabbarDomicilioViewController.h"
#import "CustomUITableViewCellMore.h"

#import "UserClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"
#import "JSONparseClass.h"


@implementation DomicilioHistorialViewController

@synthesize UITV_listado;

@synthesize CUITVCMA_cell = _CUITVCMA_cell;
@synthesize DVC_direccion = _DVC_direccion;

@synthesize OC_order = _OC_order;
@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells_DomicilioHistorialViewController;


#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCM_more
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) setCUITVCM_more:(CustomUITableViewCellMore *)CUITVCM_more {
    
    _CUITVCM_more = CUITVCM_more;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDVC_direccion
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDVC_direccion:(DireccionesViewController *)DVC_direccion {
    
    _DVC_direccion = DVC_direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCMA_cell
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMA_cell:(CustomUITableViewCellPedirHistorial *)CUITVCMA_cell {
    
    _CUITVCMA_cell = CUITVCMA_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setOC_order
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Iniciamos propiedades
    NSMA_cells_DomicilioHistorialViewController = [[NSMutableArray alloc] init];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Mi Historial";
    
    // Borramos restaurantes
    [globalVar.NSMA_orders removeAllObjects];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.NSMA_orders = [[NSMutableArray alloc] init];
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadOrders)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
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
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrders
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrders {
    
    // Comprobamos si ya se esta ejecutando
    if (globalVar.B_UMNI_getOrders_active) return;
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:TRUE];
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDERS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDERS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDERS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadOrdersSuccessful:)
                                                 name: _NOTIFICATION_ORDERS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_ORDERS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_ORDERS_ERROR_
                                               object: nil];
    
    // Indicamos que no se tiene que cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar setB_FromHistory:TRUE];
    [globalVar.LVC_loading loadOrders];
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
//#	Fecha Creación	: 21/06/2012  (pjoramas)
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
    
    // Indicamos que si queremos cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategories
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
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
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
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
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
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

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrdersSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrdersSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    // Actualizamos el Número del Bloque
    [globalVar setNSI_numRecordBlock:(globalVar.NSI_numRecordBlock + 1)];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrderFoodSuccessful
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFoodSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestauranteSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadFoodCategories];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategoriesSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategoriesSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
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
                        
                        [globalVar.JPC_json UMNI_getFoodOptions:FC_food obligatory:FALSE images:TRUE];
                        [globalVar.JPC_json UMNI_getFoodOptions:FC_food obligatory:TRUE images:TRUE];
                    }
                }
            }
        }
    }
    
    // Recuperamos listado de menus del resturante
    [self loadDailymenusCategories];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusCategoriesSuccessful
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategoriesSuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadDailymenus];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenusSuccessful:(NSNotification *)notification {
    
    // Actualizamos propieda
    [globalVar setB_come_from_historial:TRUE];
    [globalVar setB_data_historico_updated:FALSE];
    
    // Reseteamoa el ORder id
    [globalVar.OC_order setNSI_idorder :_ID_ORDER_NO_VALUE_];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_pedir_domicilio_Touched];
    
    // Actualizamos los datos
    [globalVar showAlerMsgWith:@"Información" 
                       message:@"Los datos del pedido se han cargado con éxito."];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark Table view data source

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfSectionsInTableView
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: Customize the number of sections in the table view.
//#
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:numberOfRowsInSection
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Comprobamos si aun no se han cargado datos
    if (globalVar.NSI_numRecordBlock == _NUM_RECORD_BLOCK_INIT_) return 0;
    
    // En caso de no sea vacía -> Controlamos si hay más registros o están todos
    if ([globalVar.NSMA_orders count] == ((globalVar.NSI_numRecordBlock+1)*globalVar.NSI_blocksize_orders))
        return ([globalVar.NSMA_orders count]+1);
    else
        return [globalVar.NSMA_orders count];;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:titleForHeaderInSection:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:cellForRowAtIndexPath:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // comprobamos en que celda estamos
    if (indexPath.row < [globalVar.NSMA_orders count]) {
        
        // Recuperamos el CategoryClass de la celda
        OrderClass *OC_order = [globalVar.NSMA_orders objectAtIndex:indexPath.row];
        
        // Creamos el Cell View Controller
        _CUITVCMA_cell = [[CustomUITableViewCellPedirHistorial alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCMA_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCMA_cell setContentWith:OC_order];
        
        // La añadimos a la lista de cells
        [NSMA_cells_DomicilioHistorialViewController addObject:_CUITVCMA_cell];
        
        return _CUITVCMA_cell;
    }
    else {
        
        // Creamos el CustomUITableViewCell
        _CUITVCM_more = [[CustomUITableViewCellMore alloc] initWithFrame:CGRectZero];
        
        // Iniciamos la carga de los datos
        [self loadOrders];
        
        return _CUITVCM_more;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:canEditRowAtIndexPath:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: Override to support conditional editing of the table view.
//#
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return NO;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:heightForRowAtIndexPath:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [globalVar.NSMA_orders count]) return 50.0f;
    else return 75.0f;
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Marcamos Order seleccionada como la actual
        [globalVar setOC_order:_OC_order];
        
        // Resetesmoa los offertas
        [globalVar.OC_order resetOffers];
        
        // Comprobamos el tipo de pedido
        if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
            
            // Actualizamos propieda
            [globalVar setB_come_from_historial:TRUE];
            
            // Creamos DireccionesViewController
            _DVC_direccion = [[DireccionesViewController alloc] initWithNibName:@"DireccionesView" bundle:[NSBundle mainBundle]];
            
            // Nos posicionamos en el primer View Controller
            [self.navigationController pushViewController:_DVC_direccion animated:YES];
            
            // Asignamos delegado
            [_DVC_direccion setDelegate:self];
        }
        else  {

            // Cargamos los datos del Restaurante
            [self loadOrderFood];
        }
    }
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(OrderClass *)OC_order {

    // Guardamos OrderClass
    [self setOC_order:OC_order];
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro de que desea cargar el pedido? Perderá todos los datos del actual."];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_domicilio_Touched
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_Touched {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cargar_historial {

    // Cargamos los datos del Restaurante
    [self loadOrderFood];
}


@end
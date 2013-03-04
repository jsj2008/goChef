//
//  RestauranteShortInfoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteShortInfoViewController.h"
#import "LoadingViewController.h"
#import "CustomUITableViewCellMore.h"

#import "RestaurantClass.h"
#import "MiSacoClass.h"
#import "TipoCocinaClass.h"
#import "SearchRestaurantClass.h"
#import "OrderClass.h"


@implementation RestauranteShortInfoViewController

@synthesize UITV_listado;

@synthesize CUITVCBR_cell   = _CUITVCBR_cell;
@synthesize CUITVCBR_header = _CUITVCBR_header;
@synthesize CUITVCM_more    = _CUITVCM_more;

@synthesize RAIVC_restaurante = _RAIVC_restaurante;

@synthesize STCVC_tipo_cocina = _STCVC_tipo_cocina;
@synthesize SRVC_restaurante = _SRVC_restaurante;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells_RestauranteShortInfoViewController;
NSMutableArray *NSMA_restaurantes_RestauranteShortInfoViewController;

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
//#	Propiedad   	: setCUITVCBR_cell
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCBR_cell:(CustomUITableViewCellBuscarRestaurante *)CUITVCBR_cell {
    
    _CUITVCBR_cell = CUITVCBR_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCBR_header
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCBR_header:(CustomUITableViewCellBuscarRestauranteHeader *)CUITVCBR_header {
    
    _CUITVCBR_header = CUITVCBR_header;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRAIVC_restaurante
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRAIVC_restaurante:(RestauranteAllInfoViewController *)RAIVC_restaurante {
    
    _RAIVC_restaurante = RAIVC_restaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSTCVC_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTCVC_tipo_cocina:(SelectTipoCocinaViewController *)STCVC_tipo_cocina {
    
    _STCVC_tipo_cocina = STCVC_tipo_cocina;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSRVC_restaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSRVC_restaurante:(SelectRestauranteViewController *)SRVC_restaurante {
    
    _SRVC_restaurante = SRVC_restaurante;
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
    
    // Iniciamos la lista de Mi Actividad
    //[globalVar initBuscarRestaurantes];
    
    // Iniciamos las propiedades
    NSMA_cells_RestauranteShortInfoViewController = [[NSMutableArray alloc] init];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Buscar Restaurantes";
    
    // Borramos restaurantes
    [globalVar.NSMA_restaurants removeAllObjects];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getRestaurants_active:TRUE];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadRestaurantes)
                                               userInfo:nil
                                                repeats:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    

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
    
    // Comprobamos que tipo de pedido se esta haciendo
    if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                            object:self];
    }
    else {

        // Volvemos Viewcontroller padre
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestaurantes {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:TRUE];
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTES_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTES_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTES_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadRestaurantesSuccessful:) 
                                                 name: _NOTIFICATION_RESTAURANTES_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_RESTAURANTES_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_RESTAURANTES_ERROR_
                                               object: nil];
    
    // Indicamos que si quieremos cargar las imágenes
    [globalVar setB_cargar_imagenes:TRUE];
    
    // Actualizamos el Número del Bloque
    [globalVar setNSI_numRecordBlock:(globalVar.NSI_numRecordBlock + 1)];
    
    // Actualizamos el registro de inicio
    [globalVar.SRC_search setNSI_start:(globalVar.NSI_numRecordBlock * globalVar.NSI_blocksize_restaurants)];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadRestaurantes];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestaurantesSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadRestaurantesSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getRestaurants_active:FALSE];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getRestaurants_active:FALSE];
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getRestaurants_active:FALSE];
    
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
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Comprobamos si aun no se han cargado datos
    if (globalVar.NSI_numRecordBlock == _NUM_RECORD_BLOCK_INIT_) return 0;
    
    // Iniciamos el NSMytableArray
    NSMA_restaurantes_RestauranteShortInfoViewController = [[NSMutableArray alloc] init];
    
    // Contamos los restaurantes cuyo servicio asociado al tipo de pedido no sea "0" -> Servicio no incluido
    for (RestaurantClass *RC_restaurant in globalVar.NSMA_restaurants) {
        
        // Comprobamos el tipo de pedido actual
        switch (globalVar.OC_order.TOT_type)
        {
            case TOT_pedido_a_domicilio:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (RC_restaurant.TRS_service_adomicilio != TRS_no_incluido) [NSMA_restaurantes_RestauranteShortInfoViewController addObject:RC_restaurant];
                break;
            }
            case TOT_pedido_en_el_restaurante:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (RC_restaurant.TRS_service_enrestaurante != TRS_no_incluido) [NSMA_restaurantes_RestauranteShortInfoViewController addObject:RC_restaurant];
                break;
            }
            case TOT_pedido_antes_de_ir_al_restaurante:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (RC_restaurant.TRS_service_antesrestaurante != TRS_no_incluido) [NSMA_restaurantes_RestauranteShortInfoViewController addObject:RC_restaurant];
                break;
            }
            case TOT_pedido_para_recoger:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (RC_restaurant.TRS_service_arecoger != TRS_no_incluido) [NSMA_restaurantes_RestauranteShortInfoViewController addObject:RC_restaurant];
                break;
            }
            case TOT_reserva:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (RC_restaurant.TRS_service_reserva != TRS_no_incluido) [NSMA_restaurantes_RestauranteShortInfoViewController addObject:RC_restaurant];
                break;
            }
        }
    }
    
    // En caso de no sea vacía -> Controlamos si hay más registros o están todos
    if ([NSMA_restaurantes_RestauranteShortInfoViewController count] == (globalVar.NSI_numRecordBlock+1)*globalVar.NSI_blocksize_restaurants)
        return ([NSMA_restaurantes_RestauranteShortInfoViewController count]+2);
    else
        return ([NSMA_restaurantes_RestauranteShortInfoViewController count]+1);
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
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == 0) {
        
        // Creamos el Cell View Controller
        _CUITVCBR_header = [[CustomUITableViewCellBuscarRestauranteHeader alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCBR_header setDelegate:self];
        
        // La añadimos a la lista de cells
        [NSMA_cells_RestauranteShortInfoViewController addObject:_CUITVCBR_header];
        
        return _CUITVCBR_header;
    }
    else if (indexPath.row < ([NSMA_restaurantes_RestauranteShortInfoViewController count]+1)) {

        // Recuperamos el restaurante
        RestaurantClass *RC_restaurant = [NSMA_restaurantes_RestauranteShortInfoViewController objectAtIndex:(indexPath.row-1)];
      
        // Creamos el Cell View Controller
        _CUITVCBR_cell = [[CustomUITableViewCellBuscarRestaurante alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCBR_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCBR_cell setContentWith:RC_restaurant];
        
        // La añadimos a la lista de cells
        [NSMA_cells_RestauranteShortInfoViewController addObject:_CUITVCBR_cell];
        
        return _CUITVCBR_cell;
    }
    else {
        
        // Creamos el CustomUITableViewCell
        _CUITVCM_more = [[CustomUITableViewCellMore alloc] initWithFrame:CGRectZero];
        
        // comprobamos si aun se está relizando la llamada antriore
        if (!globalVar.B_UMNI_getRestaurants_active) {
            
            // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
            [globalVar setB_UMNI_getRestaurants_active:TRUE];
            
            // Esperamos antes de ir al menú de la aplicación
            [self performSelector:@selector(loadRestaurantes) withObject:nil afterDelay:_DELAY_INIT_JSON_PARSE_];
        }

        return _CUITVCM_more;
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
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == ([NSMA_restaurantes_RestauranteShortInfoViewController count]+1)) return 50.0f;
    else return 95.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(RestaurantClass *)RC_restaurant {
    
    // Actualizamos Restaurante 
    [globalVar.OC_order setRC_restaurant:RC_restaurant];
    
    // Creamos RestauranteAllInfoViewController
    _RAIVC_restaurante = [[RestauranteAllInfoViewController alloc] initWithNibName:@"RestauranteAllInfoView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RAIVC_restaurante animated:YES];

    // Actualizamos el contenido RestauranteAllInfoViewController
    [_RAIVC_restaurante setContentWith:globalVar.OC_order.RC_restaurant];
    
    // Asignamos delegado
    [_RAIVC_restaurante setDelegate:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_mi_saco_Touched
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_mi_saco_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_saco_Touched:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_mi_cuenta_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_cercania_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_cercania_Touched {

    // Comprobamos si ya es el método de ordenación seleccionado
    if (globalVar.SRC_search.TRO_order == TRO_distancia) return;
    
    // Actualizamos el método de ordenación
    [globalVar.SRC_search setTRO_order:TRO_distancia];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
    
    // Actualizamos los datos
    [self loadRestaurantes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_ofertas_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_ofertas_Touched {
    
    // Comprobamos si ya es el método de ordenación seleccionado
    if (globalVar.SRC_search.TRO_order == TRO_ofertas) return;
    
    // Actualizamos el método de ordenación
    [globalVar.SRC_search setTRO_order:TRO_ofertas];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
    
    // Actualizamos los datos
    [self loadRestaurantes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : filtro_descuentos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) filtro_descuentos_Touched {
    
    // Comprobamos si ya es el método de ordenación seleccionado
    if (globalVar.SRC_search.TRO_order == TRO_descuentos) return;
    
    // Actualizamos el método de ordenación
    [globalVar.SRC_search setTRO_order:TRO_descuentos];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
    
    // Actualizamos los datos
    [self loadRestaurantes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_cocina_Touched {
    
    // Comprobamos si ya se está mostrando
    if ( (_STCVC_tipo_cocina != nil) || (_SRVC_restaurante != nil) ) return;
    
    // Creamos SelectTipoCocinaViewController
    _STCVC_tipo_cocina = [[SelectTipoCocinaViewController alloc] initWithNibName:@"SelectTipoCocinaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STCVC_tipo_cocina setDelegate:self];
    
    // Iniciamos Propiedades
    [_STCVC_tipo_cocina setContentWith:[globalVar getRestautanttypeWithId:globalVar.SRC_search.NSS_idrestauranttype]];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STCVC_tipo_cocina.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STCVC_tipo_cocina.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_cocina.view.frame.size.width, _STCVC_tipo_cocina.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STCVC_tipo_cocina.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STCVC_tipo_cocina.view.frame.size.height), _STCVC_tipo_cocina.view.frame.size.width, _STCVC_tipo_cocina.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_cocina:(NSString *)TCC_tipo_cocina {

    // Comprobamos si no se ha seleccionado ninguno
    if ([TCC_tipo_cocina isEqualToString:@""]){
        
        // Actualizamos propiedad
        [globalVar.SRC_search setB_restauranttype:FALSE];
        [globalVar.SRC_search setNSS_idrestauranttype:nil];

        
        // Actualizamos UILabel
        [_CUITVCBR_header.CUITVCMSH_cell.UIL_tipo_comida setText:_COMBO_TIPOS_COCINA_];
    }
    else {
        
        // Actualizamos propiedad
        [globalVar.SRC_search setB_restauranttype:TRUE];
        
        // Actualizamos propiedad
        [globalVar.SRC_search setNSS_idrestauranttype:TCC_tipo_cocina];
        
        // Actualizamos UILabel
        [_CUITVCBR_header.CUITVCMSH_cell.UIL_tipo_comida setText:@"Múltiples categorías"];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_restaurantes_Touche
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_restaurantes_Touched {
    
    // Comprobamos si es un usuario registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        return;
    }
    
    // Comprobamos si ya se está mostrando
    if ( (_STCVC_tipo_cocina != nil) || (_SRVC_restaurante != nil) ) return;
    
    // Creamos SelectRestauranteViewController
    _SRVC_restaurante = [[SelectRestauranteViewController alloc] initWithNibName:@"SelectRestauranteView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SRVC_restaurante setDelegate:self];
    
    // Recuperamos el texto a mostrar
    NSString *NSS_filtro;
    switch (globalVar.SRC_search.TFR_filter)
    {
        case TFR_todos    : NSS_filtro = _COMBO_FILTRO_RESTAURATES_; break;
        case TFR_favoritos: NSS_filtro = _COMBO_FILTRO_RESTAURATES_FAVORITOS_; break;
        case TFR_historico: NSS_filtro = _COMBO_FILTRO_RESTAURATES_HISTORICO_; break;
    }
    
    // Iniciamos Propiedades
    [_SRVC_restaurante setContentWith:NSS_filtro];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SRVC_restaurante.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SRVC_restaurante.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SRVC_restaurante.view.frame.size.width, _SRVC_restaurante.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SRVC_restaurante.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SRVC_restaurante.view.frame.size.height), _SRVC_restaurante.view.frame.size.width, _SRVC_restaurante.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_restaurante
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_restaurante:(NSString *)NSS_restaurante {
    
    // Actualizamos UILabel
    [_CUITVCBR_header.CUITVCMSH_cell.UIL_restaurantes setText:NSS_restaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_cocina
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
    [_STCVC_tipo_cocina.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_cocina.view.frame.size.width, _STCVC_tipo_cocina.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_restaurante
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_restaurante {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SRVC_restaurante.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SRVC_restaurante.view.frame.size.width, _SRVC_restaurante.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 30/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_STCVC_tipo_cocina != nil) {
        
        // Quitamos el View Select Tipo Cocina
        [_STCVC_tipo_cocina.view removeFromSuperview];
        
        // Liberamos memoria
        _STCVC_tipo_cocina = nil;
        
        // Comprobamos si no se ha seleccionado un filtro
        if ([_CUITVCBR_header.CUITVCMSH_cell.UIL_tipo_comida.text isEqualToString:_COMBO_TIPOS_COCINA_])
        {
            // Comprobamos si era el filtro ya seleccionado
            //if (!globalVar.SRC_search.B_restauranttype) return;
            
            // Atualizamos propiedad
            [globalVar.SRC_search setB_restauranttype:FALSE];
            
            // Iniciamos propiedades globales
            [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
            
            // Iniciamos el array de tipos
            globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
            
            // Actualizamos listado de restaurantes
            [self loadRestaurantes];
        }
        else {
            
           // TipoCocinaClass *TCC_restauranttype = [globalVar getRestautanttypeWithName:_CUITVCBR_header.CUITVCMSH_cell.UIL_tipo_comida.text];
            
            // Comprobamos si era el filtro ya seleccionado
            //if ( (globalVar.SRC_search.B_restauranttype) && (globalVar.SRC_search.NSI_idrestauranttype == TCC_restauranttype.NSI_id) ) return;
            
            // Atualizamos propiedad
            //[globalVar.SRC_search setNSS_idrestauranttype:[NSString stringWithFormat:@"%d",TCC_restauranttype.NSI_id]];
            
            // Iniciamos propiedades globales
            [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
            
            // Iniciamos el array de tipos
            globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
            
            // Actualizamos listado de restaurantes
            [self loadRestaurantes];
        }
    }
    else {
        
        // Quitamos el View Select Precio
        [_SRVC_restaurante.view removeFromSuperview];
        
        // Liberamos memoria
        _SRVC_restaurante = nil;
        
        // Recuperamos el typo filtro seleccionado
        typeFilterRestaurant TFR_filtro;
        if      ([_CUITVCBR_header.CUITVCMSH_cell.UIL_restaurantes.text isEqualToString:_COMBO_FILTRO_RESTAURATES_])           TFR_filtro = TFR_todos;
        else if ([_CUITVCBR_header.CUITVCMSH_cell.UIL_restaurantes.text isEqualToString:_COMBO_FILTRO_RESTAURATES_FAVORITOS_]) TFR_filtro = TFR_favoritos;
        else if ([_CUITVCBR_header.CUITVCMSH_cell.UIL_restaurantes.text isEqualToString:_COMBO_FILTRO_RESTAURATES_HISTORICO_]) TFR_filtro = TFR_historico;
        
        // Comprobamos si ha cambiado
        if (globalVar.SRC_search.TFR_filter != TFR_filtro) {
            
            // Actualizamos propiedad
            [globalVar.SRC_search setTFR_filter:TFR_filtro];
            
            // Iniciamos propiedades globales
            [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
            
            // Iniciamos el array de tipos
            globalVar.NSMA_restaurants = [[NSMutableArray alloc] init];
            
            // Actualizamos listado de restaurantes
            [self loadRestaurantes];
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
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_pre_pedir_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_restaurante_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_restaurante_Touched {
    
    NSLog(@"UIB_pedir_restaurante_Touched");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_antes_llegar_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_antes_llegar_Touched {
    
    NSLog(@"UIB_pedir_antes_llegar_Touched");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_domicilio_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_Touched {
    
    NSLog(@"UIB_pedir_domicilio_Touched");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_recoger_comida_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_recoger_comida_Touched {
    
    NSLog(@"UIB_recoger_comida_Touched");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_reservar_mesa_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_reservar_mesa_Touched {
    
    NSLog(@"UIB_reservar_mesa_Touched");
}


@end
//
//  MiActividadContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiActividadContenedorViewController.h"
#import "LoadingViewController.h"
#import "MiActividadDetalleViewController.h"
#import "TabbarPrincipalViewController.h"
#import "CustomUITableViewCellMore.h"

#import "OrderClass.h"
#import "RestaurantClass.h"


@implementation MiActividadContenedorViewController

@synthesize UITV_listado;

@synthesize MADVC_detalle = _MADVC_detalle;

@synthesize CUITVCMA_cell = _CUITVCMA_cell;
@synthesize CUITVCM_more  = _CUITVCM_more;

NSMutableArray *NSMA_cells_MiActividadContenedorViewController;

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
//#	Propiedad   	: setMADVC_detalle
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMADVC_detalle:(MiActividadDetalleViewController *)MADVC_detalle {
    
    _MADVC_detalle = MADVC_detalle;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCMA_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMA_cell:(CustomUITableViewCellMiActividad *)CUITVCMA_cell {
    
    _CUITVCMA_cell = CUITVCMA_cell;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos las propiedades
    NSMA_cells_MiActividadContenedorViewController = [[NSMutableArray alloc] init];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Mi Actividad";
    
    // Iniciamos Boolen propierties
    [globalVar setB_realizando_pedido:FALSE];
    [globalVar setB_pedido_confirmado:FALSE];
    
    // Borramos restaurantes
    //[globalVar.NSMA_orders removeAllObjects];
    
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
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrders
//#	Fecha Creación	: 30/05/2012  (pjoramas)
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
    [globalVar.LVC_loading loadOrders];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrdersSuccessful
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrdersSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    // Actualizamos el Número del Bloque
    [globalVar setNSI_numRecordBlock:(globalVar.NSI_numRecordBlock + 1)];
    
    // Actualizamos el globo de la barra
    [globalVar.TPVC_principal updateGlobo];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOrders_active:FALSE];
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
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
    
    // Comprobamos en que celda estamos
    if (indexPath.row < [globalVar.NSMA_orders count]) {
        
        // Recuperamos el CategoryClass de la celda
        OrderClass *OC_order = [globalVar.NSMA_orders objectAtIndex:indexPath.row];
        
        // Creamos el Cell View Controller
        _CUITVCMA_cell = [[CustomUITableViewCellMiActividad alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCMA_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCMA_cell setContentWith:OC_order];
        
        // La añadimos a la lista de cells
        [NSMA_cells_MiActividadContenedorViewController addObject:_CUITVCMA_cell];
        
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [globalVar.NSMA_orders count]) return 50.0f;
    else return 75.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(OrderClass *)OC_order {
    
    // Creamos MiActividadDetalleViewController
    _MADVC_detalle = [[MiActividadDetalleViewController alloc] initWithNibName:@"MiActividadDetalleView" bundle:[NSBundle mainBundle]];
    
    // Actualizamos propieda global
    [globalVar setOC_order:OC_order];
    
    // Actualizamos idrestaurant
    [globalVar.OC_order.RC_restaurant setNSI_idrestaurant:OC_order.NSI_idrestaurant];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_MADVC_detalle animated:YES];
}


@end
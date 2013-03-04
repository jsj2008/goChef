//
//  MiSacoContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiSacoContenedorViewController.h"
#import "LoadingViewController.h"
#import "CustomUITableViewCellMore.h"

#import "UserOfferClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"
#import "UserClass.h"


@implementation MiSacoContenedorViewController

@synthesize UITV_listado;

@synthesize RAIVC_restaurante = _RAIVC_restaurante;

@synthesize CUITVCMS_cell   = _CUITVCMS_cell;
@synthesize CUITVCMS_header = _CUITVCMS_header;
@synthesize CUITVCM_more    = _CUITVCM_more;
@synthesize filterSel = _filterSel;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells_MiSacoContenedorViewController;

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
//#	Propiedad   	: setRSIVC_restaurante
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRAIVC_restaurante:(RestauranteAllInfoViewController *)RAIVC_restaurante {
    
    _RAIVC_restaurante = RAIVC_restaurante;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCMS_cell
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMS_cell:(CustomUITableViewCellMiSaco *)CUITVCMS_cell {
    
    _CUITVCMS_cell = CUITVCMS_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCMS_header
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMS_header:(CustomUITableViewCellMiSacoHeader *)CUITVCMS_header {
    
    _CUITVCMS_header = CUITVCMS_header;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos las propiedades
    NSMA_cells_MiSacoContenedorViewController = [[NSMutableArray alloc] init];
    
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
    
    // Actualizamso propiedad que indica que se ha realizado la llamada desde "Mi saco"
    [globalVar setB_come_from_mi_saco:FALSE];
    
    // Borramos restaurantes
    //[globalVar.UC_user.NSMA_offers removeAllObjects];
    
    // Actualizamos los datos de la tabla
    [UITV_listado reloadData];
    
    // Iniciamos propiedades globales
    [globalVar setNSI_numRecordBlock:_NUM_RECORD_BLOCK_INIT_];
    
    // Iniciamos el array de tipos
    globalVar.UC_user.NSMA_offers = [[NSMutableArray alloc] init];
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOffers_active:FALSE];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadOffers)
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
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Mi Saco";
    
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
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Comprobamos si se viene de un pedido
    if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) && (globalVar.B_realizando_pedido)) {
        
        // Indicamos al delegado que se ha seleccionado el Menú
        if (_delegate != nil) [_delegate back_pedir_domicilio_Touched];
    }
    else {

        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                            object:self];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffers
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffers {
    
    // Comprobamos si ya se esta ejecutando
    if (globalVar.B_UMNI_getOffers_active) return;
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOffers_active:TRUE];
    
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
    [globalVar setB_cargar_imagenes:TRUE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadOffers];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestaurante
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
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
    
    // Indicamos que si quieremos cargar las imágenes
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadRestaurante];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    // Iniciamos que iniciamos la ejecución de una llamada al procedimiento
    [globalVar setB_UMNI_getOffers_active:FALSE];
    
    // Actualizamos el Número del Bloque
    [globalVar setNSI_numRecordBlock:(globalVar.NSI_numRecordBlock + 1)];
    
    // Actualizamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestauranteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteSuccessful:(NSNotification *)notification {
    
    // Actualizamos propiedad que indica que se ha realizado la llamada desde "Mi saco"
    [globalVar setB_come_from_mi_saco:TRUE];
    [globalVar setB_realizando_pedido:TRUE];
    [globalVar setB_origen_mi_saco   :TRUE];
    
    // Creamos RestauranteAllInfoViewController
    _RAIVC_restaurante = [[RestauranteAllInfoViewController alloc] initWithNibName:@"RestauranteAllInfoView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_RAIVC_restaurante setDelegate:self];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RAIVC_restaurante animated:YES];
    
    // Iniciamos RestauranteContenedorViewController
    [_RAIVC_restaurante setContentWith:globalVar.OC_order.RC_restaurant];
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
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Comprobamos si aun no se han cargado datos
    if (globalVar.NSI_numRecordBlock == _NUM_RECORD_BLOCK_INIT_) return 0;
    
    // En caso de no sea vacía -> Controlamos si hay más registros o están todos
    if ([globalVar.UC_user.NSMA_offers count] == ((globalVar.NSI_numRecordBlock+1)*globalVar.NSI_blocksize_offers))
        return ([globalVar.UC_user.NSMA_offers count]+2);
    else
        return ([globalVar.UC_user.NSMA_offers count]+1);
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
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == 0) {
        
        // Creamos el Cell View Controller
        _CUITVCMS_header = [[CustomUITableViewCellMiSacoHeader alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCMS_header setDelegate:self];
        
        // La añadimos a la lista de cells
        [NSMA_cells_MiSacoContenedorViewController addObject:_CUITVCMS_header];
        
        
        [self.CUITVCMS_header.CUITVCMSH_cell.UIB_ultimos setSelected:FALSE];
        [self.CUITVCMS_header.CUITVCMSH_cell.UIB_cercania setSelected:FALSE];
        [self.CUITVCMS_header.CUITVCMSH_cell.UIB_favoritos setSelected:FALSE];
        [self.CUITVCMS_header.CUITVCMSH_cell.UIB_hoy setSelected:FALSE];
        
        if (self.filterSel == 1) {
            [self.CUITVCMS_header.CUITVCMSH_cell.UIB_ultimos setSelected:TRUE];
        } else if(self.filterSel == 2){
            [self.CUITVCMS_header.CUITVCMSH_cell.UIB_cercania setSelected:TRUE];
        } else if(self.filterSel == 3){
            [self.CUITVCMS_header.CUITVCMSH_cell.UIB_favoritos setSelected:TRUE];
        } else if(self.filterSel == 4){
            [self.CUITVCMS_header.CUITVCMSH_cell.UIB_hoy setSelected:TRUE];
        } else {
            [self.CUITVCMS_header.CUITVCMSH_cell.UIB_ultimos setSelected:TRUE];
        }
        
        return _CUITVCMS_header;
    }
    else if (indexPath.row < ([globalVar.UC_user.NSMA_offers count]+1)) {
        
        // Recuperamos el CategoryClass de la celda
        UserOfferClass *UOC_offer = [globalVar.UC_user.NSMA_offers objectAtIndex:(indexPath.row-1)];
        
        // Creamos el Cell View Controller
        _CUITVCMS_cell = [[CustomUITableViewCellMiSaco alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCMS_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCMS_cell setContentWith:UOC_offer];
        
        // La añadimos a la lista de cells
        [NSMA_cells_MiSacoContenedorViewController addObject:_CUITVCMS_cell];
        
        return _CUITVCMS_cell;
    }
    else {
        
        // Creamos el CustomUITableViewCell
        _CUITVCM_more = [[CustomUITableViewCellMore alloc] initWithFrame:CGRectZero];
        
        // Iniciamos la carga de los datos
        [self loadOffers];
        
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
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == ([globalVar.UC_user.NSMA_offers count]+1)) return 50.0f;
    else return 75.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(UserOfferClass *)UOC_offer {

    // Iniciamos OrderClass
    globalVar.OC_order = [[OrderClass alloc] init];
    
    // Actualizamos restaurante
    [globalVar.OC_order setNSI_idrestaurant:UOC_offer.NSI_idrestaurant];

    // Actualizamos Offer
    [globalVar.OC_order setNSI_idoffer:UOC_offer.NSI_idoffer];
    [globalVar.OC_order setOC_offer:UOC_offer];

    // Cargamos los datos de Restaurante
    [self loadRestaurante];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_ultimos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_ultimos_Touched {
    
    self.filterSel = 1;
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"NSI_idoffer" ascending:NO]];
    [globalVar.UC_user.NSMA_offers sortUsingDescriptors:sortDescriptors];
    
    [self.UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_cercania_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_cercania_Touched {
    
    self.filterSel = 2;
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"NSS_distance" ascending:YES]];
    [globalVar.UC_user.NSMA_offers sortUsingDescriptors:sortDescriptors];
    [self.UITV_listado reloadData];

    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_favoritos_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_favoritos_Touched {
    
    self.filterSel = 3;
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"B_favorite" ascending:NO]];
    [globalVar.UC_user.NSMA_offers sortUsingDescriptors:sortDescriptors];
    [self.UITV_listado reloadData];
    

    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : ordenar_hoy_Touched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) ordenar_hoy_Touched {
    
    self.filterSel = 4;
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"NSI_idoffer" ascending:NO]];
    [globalVar.UC_user.NSMA_offers sortUsingDescriptors:sortDescriptors];
    [self.UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : Tabbar_pre_pedir_Touched
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

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_restaurante_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_restaurante_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_pedir_restaurante_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_antes_llegar_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_antes_llegar_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_pedir_antes_llegar_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_domicilio_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_pedir_domicilio_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_recoger_comida_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_recoger_comida_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_recoger_comida_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_reservar_mesa_Touched
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_reservar_mesa_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_reservar_mesa_Touched];
}


@end
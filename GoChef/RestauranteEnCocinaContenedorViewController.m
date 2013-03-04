//
//  RestauranteEnCocinaContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteEnCocinaContenedorViewController.h"
#import "LoadingViewController.h"
#import "EnviarPedidoViewController.h"
#import "PedidoPlatoViewController.h"
#import "TabbarDomicilioViewController.h"
#import "TabbarRestauranteViewController.h"
#import "CustomUITableViewCellEnCocina.h"

#import "RestaurantClass.h"
#import "OrderClass.h"
#import "UserOfferClass.h"
#import "UserClass.h"
#import "FacebookClass.h"


@implementation RestauranteEnCocinaContenedorViewController

@synthesize UITV_listado;

@synthesize CUITVCP_cell = _CUITVCP_cell; 
@synthesize CUITVCP_pie  = _CUITVCP_pie;

@synthesize EPVC_enviar = _EPVC_enviar;
@synthesize PPVC_plato  = _PPVC_plato;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cell:(CustomUITableViewCellEnCocina *)CUITVCP_cell {
    
    _CUITVCP_cell = CUITVCP_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_pie
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_pie:(CustomUITableViewCellEnCocinaPie *)CUITVCP_pie {
    
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

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"En cocina";
    
    // Actualizamos los datos
    [UITV_listado reloadData];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Comprobamos si ya hemos enviado pedido a cocina
    if (globalVar.B_pedido_en_cocina) [UITV_listado setAlpha:1.0f];
    else [UITV_listado setAlpha:0.0f];
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
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Actualizamos el valor dependiendo que datos se muestren en la lista
    return ([globalVar.OC_order_en_cocina.NSMA_orderfoods count]+1);
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
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == [globalVar.OC_order_en_cocina.NSMA_orderfoods count]) {
        
        // Creamos el Cell View Controller
        _CUITVCP_pie = [[CustomUITableViewCellEnCocinaPie alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegado
        [_CUITVCP_pie setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_pie setContentWith:globalVar.OC_order_en_cocina];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_pie];
        
        return _CUITVCP_pie;
    }
    else {
        
        // Recuperamos el PedidoClass de la celda
        OrderFoodClass *OFC_food = [globalVar.OC_order_en_cocina.NSMA_orderfoods objectAtIndex:indexPath.row];
        
        // Creamos el Cell View Controller
        _CUITVCP_cell = [[CustomUITableViewCellEnCocina alloc] init];
        
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
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [globalVar.OC_order_en_cocina.NSMA_orderfoods count]) return 265.0f;
    else return 42.0f;
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pagar_touched
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pagar_touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_rst_pagar_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedir_mas_comida_touched
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_mas_comida_touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_rst_pedir_Touched];
}


@end
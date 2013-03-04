//
//  RestauranteConfirmacionViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteConfirmacionViewController.h"
#import "LoadingViewController.h"
#import "CustomUITableViewCellPedidoConfirmacion.h"
#import "CustomUITableViewCellPedidoConfirmacionCabecera.h"
#import "TabbarRestauranteViewController.h"

#import "RestaurantClass.h"
#import "OrderClass.h"


@implementation RestauranteConfirmacionViewController

@synthesize UITV_listado;

@synthesize CUITVCP_cell = _CUITVCP_cell; 
@synthesize CUITVCP_cabecera = _CUITVCP_cabecera;
@synthesize CUITVCP_pie = _CUITVCP_pie;

@synthesize PIVC_instruction = _PIVC_instruction;

NSMutableArray *NSMA_cells;

#pragma mark -
#pragma mark Properties

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
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_pie:(CustomUITableViewCellPedidoConfirmacionPie *)CUITVCP_pie {
    
    _CUITVCP_pie = CUITVCP_pie;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Confirmación";
    
    // Actualizamos los datos
    [UITV_listado reloadData];
    
    // Actualizamos propiedades
    // Iniciamos Boolen propierties
    [globalVar setB_realizando_pedido:FALSE];
    [globalVar setB_pedido_confirmado:TRUE];
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
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_MI_ACTIVIDAD_ 
                                                        object:self];
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
    return ([globalVar.OC_order_en_cocina.NSMA_orderfoods count]+2);
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
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Comprobamo si estamos en la primera row
    if (indexPath.row == 0) {
        
        // Creamos el Cell View Controller
        _CUITVCP_cabecera = [[CustomUITableViewCellPedidoConfirmacionCabecera alloc] initWithFrame:CGRectZero];
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_cabecera setContentWith:globalVar.OC_order_en_cocina];
        
        // La añadimos a la lista de cells
        [NSMA_cells addObject:_CUITVCP_cabecera];
        
        return _CUITVCP_cabecera;
    }
    else if (indexPath.row == [globalVar.OC_order_en_cocina.NSMA_orderfoods count]+1) {
        
        // Creamos el Cell View Controller
        _CUITVCP_pie = [[CustomUITableViewCellPedidoConfirmacionPie alloc] initWithFrame:CGRectZero];
        
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
        OrderFoodClass *OFC_food = [globalVar.OC_order_en_cocina.NSMA_orderfoods objectAtIndex:(indexPath.row-1)];
        
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
    else if (indexPath.row == [globalVar.OC_order_en_cocina.NSMA_orderfoods count]+1) return 152.0f;
    else return 42.0f;
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : show_instructions_Touched
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
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
    [_PIVC_instruction.UITV_instructions setText:globalVar.OC_order_en_cocina.NSS_instructions];
    
    // Actualizamos ReadOnbly mode
    [_PIVC_instruction setB_readonly:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : guardar_instructions_Touched
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) guardar_instructions_Touched:(NSString *)NSS_instructions {
    
    // Guardamos las instrucciones especiales
    [globalVar.OC_order_en_cocina setNSS_instructions:NSS_instructions];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : status_Touched
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) status_Touched {
    
    // Reseteamos Order
    [globalVar.OC_order_en_cocina reset];
    [globalVar.OC_order reset];
    
    // Indicamos que no se esta realizando un pedido
    [globalVar setB_realizando_pedido:FALSE];
    
    // Reseteamos el Globo de la Tabbar
    [globalVar.TPVC_restaurante pedir_globo_reset];
    [globalVar.TPVC_restaurante en_cocina_globo_reset];
    
    // Actualizamos propiedades globales
    [globalVar setB_pedido_en_cocina:FALSE];
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_MI_ACTIVIDAD_ 
                                                        object:self];
}


@end
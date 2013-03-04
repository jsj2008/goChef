//
//  PedidoOptionsViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "PedidoOptionsViewController.h"
#import "LoadingViewController.h"

#import "FoodClass.h"
#import "OrderClass.h"


@implementation PedidoOptionsViewController

@synthesize UITV_listado;

@synthesize FC_food = _FC_food;
@synthesize CUITVCBR_cell = _CUITVCBR_cell;

NSMutableArray *NSMA_cells;
NSMutableArray *NSMA_new_options;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPC_plato
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFC_food:(FoodClass *)FC_food {
    
    _FC_food = FC_food;
    
    // Recargamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCBR_cell
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCBR_cell:(CustomUITableViewCellIngrediente *)CUITVCBR_cell {
    
    _CUITVCBR_cell = CUITVCBR_cell;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos las propiedades
    NSMA_cells = [[NSMutableArray alloc] init];
    
    // Iniciamos el Array de ingredientes
    NSMA_new_options = [[NSMutableArray alloc] initWithArray:globalVar.OFC_order_food.NSMA_options];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Más Ingredientes";
    
    // Recargamos los datos
    [UITV_listado reloadData];
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
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
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
    return ([_FC_food.NSMA_options count]);
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
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Recuperamos el PlatoIngredientesClass de la celda
    FoodOptionClass *FOC_food_option = [_FC_food.NSMA_options objectAtIndex:indexPath.row];
    
    // Creamos el Cell View Controller
    _CUITVCBR_cell = [[CustomUITableViewCellIngrediente alloc] initWithFrame:CGRectZero];
    
    // Asignamos delegados
    [_CUITVCBR_cell setDelegate:self];
    
    // Calculamos si debe estar activo
    BOOL B_activo = FALSE;
    for (FoodOptionClass *FOC_option in NSMA_new_options)
        if (FOC_option.NSI_idfoodoption == FOC_food_option.NSI_idfoodoption) {
            B_activo = TRUE;
            break;
        }
    
    // Iniciamos el Cell View Controller
    [_CUITVCBR_cell setContentWith:FOC_food_option active:B_activo onlyCheck:TRUE];
    
    // La añadimos a la lista de cells
    [NSMA_cells addObject:_CUITVCBR_cell];
    
    return _CUITVCBR_cell;
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
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 42.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(FoodOptionClass *)FOC_food_option options:(BOOL)B_options {
    
    FoodOptionClass *FOC_food_option_actual = nil;
    
    // Buscamos el ingrediente en el Array
    for (FoodOptionClass *FOC_option in NSMA_new_options)
        if (FOC_option.NSI_idfoodoption == FOC_food_option.NSI_idfoodoption) {
            
            // Fijamos el FoddOptionClass encontrado
            FOC_food_option_actual = FOC_option;
            break;
        }
    
    // Comprobamos si se ha encontrado
    if (FOC_food_option_actual != nil) [NSMA_new_options removeObject:FOC_food_option_actual];
    else [NSMA_new_options addObject:FOC_food_option];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_guardar_seleccion_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_guardar_seleccion_TouchUpInside:(id)sender {
    
    // Borramos lista de ingredientes
    [globalVar.OFC_order_food.NSMA_options removeAllObjects];
    
    // Actualizamos ocn nueva valores
    [globalVar.OFC_order_food.NSMA_options addObjectsFromArray:NSMA_new_options];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}


@end
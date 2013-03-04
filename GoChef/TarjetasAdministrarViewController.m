//
//  TarjetasAdministrarViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TarjetasAdministrarViewController.h"
#import "LoadingViewController.h"
#import "TarjetasAltaViewController.h"

#import "TarjetaClass.h"
#import "CoreDataClass.h"


@implementation TarjetasAdministrarViewController

@synthesize UITV_listado;

@synthesize B_edit_mode = _B_edit_mode;
@synthesize TAVC_alta_tarjeta = _TAVC_alta_tarjeta;
@synthesize CUITVCBR_cell = _CUITVCBR_cell;

UIButton *UIB_edit;

NSMutableArray *NSMA_cells_TarjetasAdministrarViewController;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_edit_mode
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_edit_mode:(BOOL)B_edit_mode {
    
    _B_edit_mode = B_edit_mode;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setTAVC_alta_tarjeta
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTAVC_alta_tarjeta:(TarjetasAltaViewController *)TAVC_alta_tarjeta {
    
    _TAVC_alta_tarjeta = TAVC_alta_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCBR_cell
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCBR_cell:(CustomUITableViewCellCreditCard *)CUITVCBR_cell {
    
    _CUITVCBR_cell = CUITVCBR_cell;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos las propiedades
    NSMA_cells_TarjetasAdministrarViewController = [[NSMutableArray alloc] init];
    
    // Configuración de delegados
	UITV_listado.delegate   = self;
	UITV_listado.dataSource = self;
    
    // Iniciamos propiedad
    [self setB_edit_mode:FALSE];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Gestionar Tarjetas";

    // Actualizamos los datos
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
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
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
    
    // Creamos contenedor de UIButtons
    UIView* UIV_rightContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIB_edit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    [UIB_edit setImage:[UIImage imageNamed:@"topbar_button_edit_normal.png"] forState:UIControlStateNormal];
    [UIB_edit setImage:[UIImage imageNamed:@"topbar_button_edit_select.png"] forState:UIControlStateHighlighted];
    [UIB_edit setImage:[UIImage imageNamed:@"topbar_button_edit_select.png"] forState:UIControlStateSelected];
    [UIB_edit addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_rightContainer addSubview:UIB_edit];
    
    // Adaptamos tamaño de la UIView
    [UIV_rightContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 32.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_rightItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_rightContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.rightBarButtonItem = UIBBI_rightItems;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: editTapped
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) editTapped:(id)sender  {
    
    // Actualizamos propiedad
    [self setB_edit_mode:!_B_edit_mode];
    
    // Comprobamos el estado
    if (_B_edit_mode) {
        
        // Cambiamos estado UIButon edit
        [UIB_edit setSelected:TRUE];
    }
    else {
        
        // Cambiamos estado UIButon edit
        [UIB_edit setSelected:FALSE];
    }
    
    // Cambiamos el estado de todas las celdas
    for (CustomUITableViewCellCreditCard *CUITVCBR_cell in NSMA_cells_TarjetasAdministrarViewController) 
        [CUITVCBR_cell.CUITVCPVC_cell changeEditMode:_B_edit_mode];
}

#pragma mark -
#pragma mark Table view data source

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfSectionsInTableView
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: Customize the number of sections in the table view.
//#
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:numberOfRowsInSection
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Actualizamos el valor dependiendo que datos se muestren en la lista
    return ([globalVar.NSMA_tarjetas count]);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:titleForHeaderInSection:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    return nil;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:cellForRowAtIndexPath:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Recuperamos el PlatoIngredientesClass de la celda
    TarjetaClass *TC_creditcard = [globalVar.NSMA_tarjetas objectAtIndex:indexPath.row];
    
    // Creamos el Cell View Controller
    _CUITVCBR_cell = [[CustomUITableViewCellCreditCard alloc] initWithFrame:CGRectZero];
    
    // Asignamos delegados
    [_CUITVCBR_cell setDelegate:self];
    
    // Iniciamos el Cell View Controller
    [_CUITVCBR_cell setContentWith:TC_creditcard edit_mode:_B_edit_mode];
    
    // La añadimos a la lista de cells
    [NSMA_cells_TarjetasAdministrarViewController addObject:_CUITVCBR_cell];
    
    return _CUITVCBR_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:canEditRowAtIndexPath:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: Override to support conditional editing of the table view.
//#
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return NO;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:heightForRowAtIndexPath:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 42.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(TarjetaClass *)TC_creditcard {
    
    // Comprobamos si esta en modo edición
    if (!_B_edit_mode) {
        
        // La fijamos como la tarjeta actual
        [globalVar setTC_creditcard:TC_creditcard];
        
        // Cambiamos la propiedad de default
        [globalVar.TC_creditcard setB_default:TRUE];
        
        // Recorremos el array de tarjetas
        for (TarjetaClass *TC_creditcard_actual in globalVar.NSMA_tarjetas) {
            
            // Comprobamos si es la que debemos marcar como Default
            if (TC_creditcard_actual.NSI_id == TC_creditcard.NSI_id) [TC_creditcard_actual setB_default:TRUE];
            else [TC_creditcard_actual setB_default:FALSE];
            
            // Actualizamos la BB.DD
            [globalVar.CDC_coreData updateCreaditCard:TC_creditcard_actual];
        }
        
        // Actualizamos los datos
        [UITV_listado reloadData];
    }
    else {
        
        // Creamos TarjetasAltaViewController
        _TAVC_alta_tarjeta = [[TarjetasAltaViewController alloc] initWithNibName:@"TarjetasAltaView" bundle:[NSBundle mainBundle]];
        
        // Actualizamos propiedad
        [globalVar setTC_creditcard:TC_creditcard];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_TAVC_alta_tarjeta animated:YES];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeTouched
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeTouched:(TarjetaClass *)TC_creditcard {
    
    // La fijamos como la tarjeta actual
    [globalVar setTC_creditcard:TC_creditcard];
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro de que quiere eliminar la tarjeta?"];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Lo eliminamos del Array
        [globalVar.NSMA_tarjetas removeObject:globalVar.TC_creditcard];
        
        // Actualizamos la BB.DD
        [globalVar.CDC_coreData removeCreaditCard:globalVar.TC_creditcard];
        
        // Actualizamos los datos
        [UITV_listado reloadData];
    }
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_add_creditcard_TouchUpInside
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_creditcard_TouchUpInside:(id)sender {
    
    // Creamos TarjetasAltaViewController
    _TAVC_alta_tarjeta = [[TarjetasAltaViewController alloc] initWithNibName:@"TarjetasAltaView" bundle:[NSBundle mainBundle]];
    
    // Actualizamos propiedad
    [globalVar setTC_creditcard:nil];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_TAVC_alta_tarjeta animated:YES];
}


@end
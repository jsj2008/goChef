//
//  PedidoPlatoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "PedidoPlatoViewController.h"
#import "PedidoOptionsViewController.h"
#import "LoadingViewController.h"
#import "TabbarDomicilioViewController.h"
#import "TabbarRestauranteViewController.h"
#import "TabbarAntesLlegarViewController.h"

#import "FoodClass.h"
#import "OrderClass.h"
#import "ImageClass.h"


@implementation PedidoPlatoViewController

@synthesize B_loading_finish = _B_loading_finish;
@synthesize B_update = _B_update;

@synthesize CGF_price = _CGF_price;
@synthesize NSI_init_amount = _NSI_init_amount;

@synthesize FC_food = _FC_food;

@synthesize UIL_namefood;
@synthesize UIL_amount;
@synthesize UIL_price;
@synthesize UIV_options;
@synthesize UIV_options_obligatories;
@synthesize UIV_add_mi_pedido;
@synthesize UIIV_image;
@synthesize UISV_scroll;
@synthesize UITV_options;
@synthesize UITV_options_obligatories;

@synthesize POVC_options = _POVC_options;
@synthesize PIVC_instruction  = _PIVC_instruction;

@synthesize CUITVCBR_cell = _CUITVCBR_cell;

NSMutableArray *NSMA_cells_PedidoPlatoViewController;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_loading_finish
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setB_loading_finish:(BOOL)B_loading_finish {
 
    _B_loading_finish = B_loading_finish;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_init_amount
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_init_amount:(NSInteger)NSI_init_amount {
    
    _NSI_init_amount = NSI_init_amount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCGF_price
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_update:(BOOL)B_update {
    
    _B_update = B_update;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCGF_price
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price:(CGFloat)CGF_price {
    
    _CGF_price = CGF_price;
    
    // Actualizamos UILabel del Precio
    NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
    [UIL_price setText:[NSString stringWithFormat:@"Añadir - %.2f%@", _CGF_price, NSS_symbol]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setFC_food
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFC_food:(FoodClass *)FC_food {
    
    _FC_food = FC_food;
    
    // Comprobamos si ya existe OrderFoodClass
    if (globalVar.OFC_order_food == nil) {
        
        // Actualizamos propiedad
        [self setB_update:FALSE];
        
        // Creamos OrderFoodClass
        globalVar.OFC_order_food = [[OrderFoodClass alloc] init];
        
        // Iniciamos propiedades OrderFoodClass
        [globalVar.OFC_order_food setNSI_idfood             : _FC_food.NSI_idfood];
        [globalVar.OFC_order_food setNSI_idfoodcategories   : _FC_food.NSI_idfoodcategories];
        [globalVar.OFC_order_food setNSS_namefood           : _FC_food.NSS_namefood];
        [globalVar.OFC_order_food setCGF_price              : _FC_food.CGF_price];
        [globalVar.OFC_order_food setCGF_priceplusfoodgroup : _FC_food.CGF_priceplusfoodgroup];
        
        // Comprobamos si hay alguna options obligatoria
        if ([_FC_food.NSMA_options_obligatories count] > 0) {
            
            // Recuperamos el primero
            FoodOptionClass *FOC_option = [_FC_food.NSMA_options_obligatories objectAtIndex:0];
            
            // Lo insertamos
            [globalVar.OFC_order_food.NSMA_options addObject:FOC_option];
        }
        
        // Actualizamos propiedad
        [self setNSI_init_amount:0];
    }
    else {
        
        // Actualizamos UIlabel
        [UIL_amount setText:[NSString stringWithFormat:@"%d", globalVar.OFC_order_food.NSI_amount]];
        
        // Actualizamos propiedad
        [self setNSI_init_amount:globalVar.OFC_order_food.NSI_amount];
                
        // Actualizamos propiedad
        [self setB_update:TRUE];
    }
    
    // Actualizamos ULlabel
    [UIL_namefood setText:_FC_food.NSS_descriptionfood];
    
    // Iniciamos precio
    [self setCGF_price:[globalVar.OFC_order_food CGF_total_price]];
    
    // Actualizamos UIImage
    //UIImage *UII_image = [UIImage imageWithData:_FC_food.IC_imagefood.NSD_image];
    //[UIIV_image setImage:UII_image];
    [UIIV_image loadImageFromURLString:_FC_food.IC_imagefood.NSS_imageUrl andActiveCache:TRUE];
    
    // Reload Data
    [UITV_options reloadData];
    [UITV_options_obligatories reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPOVC_options
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPOVC_options:(PedidoOptionsViewController *)POVC_options {
    
    _POVC_options = POVC_options;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPIVC_instruction
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPIVC_instruction:(PedidoInstructionsViewController *)PIVC_instruction {
    
    _PIVC_instruction = PIVC_instruction;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCBR_cell
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos MutableArray
    NSMA_cells_PedidoPlatoViewController = [[NSMutableArray alloc] init];
    
    // Iniciamos OrderFoodClass
    //globalVar.OFC_order_food = nil;
    
    // Iniciamos propiedades
    [globalVar setB_come_from_instrucciones:FALSE];
    [self setNSI_init_amount:0];
    [self setB_update:FALSE];
    [self setB_loading_finish:FALSE];
    
    // Configuración de delegados
	UITV_options.delegate   = self;
	UITV_options.dataSource = self;
    UITV_options_obligatories.delegate   = self;
	UITV_options_obligatories.dataSource = self;
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Comprobamos si se viene de intrudcir las instacucciones especiales
    if (globalVar.B_come_from_instrucciones) {
        [globalVar setB_come_from_instrucciones:FALSE];
        return;
    }
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Pedir";
    
    // Insertamos los UIView
    [UISV_scroll addSubview:UIV_options];
    [UISV_scroll addSubview:UIV_options_obligatories];
    [UISV_scroll addSubview:UIV_add_mi_pedido];
    
    // Posicionamos UISV_scroll
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, UISV_scroll.frame.size.height)];
    
    // Comprobamos si debemos actualizar datos
    if (globalVar.OFC_order_food != nil) {

        // Iniciamos precio
        [self setCGF_price:[globalVar.OFC_order_food CGF_total_price]];
        
        // Asignamos Food
        [self setFC_food:globalVar.FC_food];
        
        // Actualizamos propiedades
        [self setB_loading_finish:TRUE];
    }
    else {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodsOptionsObligatory)
                                                   userInfo:nil
                                                    repeats:NO];
    }
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
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsObligatory
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsObligatory {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadFoodsOptionsObligatorySuccessful:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadFoodsOptionsObligatory];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsNoObligatory
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsNoObligatory {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadFoodsOptionsNoObligatorySuccessful:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadFoodsOptionsNoObligatory];
}

#pragma mark -
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsObligatorySuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsObligatorySuccessful:(NSNotification *)notification {
    
    // Recuperamos listado de foods del resturante
    [self loadFoodsOptionsNoObligatory];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsNoObligatorySuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsNoObligatorySuccessful:(NSNotification *)notification {
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    // Asignamos Food
    [self setFC_food:globalVar.FC_food];
    
    // Actualizamos propiedades
    [self setB_loading_finish:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) noInternet:(NSNotification *)notification {
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
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
    
    CGFloat CGF_separacion = 10.0f;
    CGFloat CGF_offset     = 160.0f;
    CGFloat CGF_size       = 0.0f;
    
    // Comprobamo si el UITableView es el de Options Obligatorias
    if (tableView.tag == 1) {
     
        // Recuperamos el numero de registros
        NSInteger NSI_options = [_FC_food.NSMA_options_obligatories count];
        
        // Comprobamos si hay obligaciones
        if (NSI_options > 0) {
            
            // Ocultamos el UIView Options obligatories
            [UIV_options_obligatories setAlpha:1.0f];
            
            CGF_size += 30.0f + (42.0f * NSI_options);
            
            // Posicionamos UIView Options Obligatories
            [UIV_options_obligatories setFrame:CGRectMake(0.0f, CGF_offset, UIV_options_obligatories.frame.size.width, CGF_size)];
            
            // Recalculamos Offset
            CGF_offset += 30.0f + (42.0f * NSI_options) + CGF_separacion;
        }
        else {
            
            // Ocultamos el UIView Options obligatories
            [UIV_options_obligatories setAlpha:0.0f];
        }
            
        return NSI_options;
    }
    else {
        
        // Recuperamos el numero de registros
        NSInteger NSI_options = [_FC_food.NSMA_options_obligatories count];
        
        // Comprobamos si hay obligaciones
        if (NSI_options > 0) CGF_offset += 30.0f + (42.0f * NSI_options) + CGF_separacion;
        
        // Recuperamos el numero de options
        int iCount = [_FC_food.NSMA_options count];
        
        // Comprobamos si hay Options
        if (iCount == 0) {
            
            // Ocultamos el UIView Options obligatories
            [UIV_options setAlpha:0.0f];
        }
        else {
            
            // Ocultamos el UIView Options obligatories
            [UIV_options setAlpha:1.0f];
            
            CGF_size += 30.0f + (42.0f * iCount);
            
            // Posicionamos UIView Options Obligatories
            [UIV_options setFrame:CGRectMake(0.0f, CGF_offset, UIV_options.frame.size.width, CGF_size)];
            
            
            // Recalculamos Offset
            CGF_offset += 30.0f + (42.0f * iCount) + CGF_separacion;
        }
        
        // Posicionamos UIView Add Mi Pedido
        [UIV_add_mi_pedido setFrame:CGRectMake(0.0f, CGF_offset, UIV_add_mi_pedido.frame.size.width, UIV_add_mi_pedido.frame.size.height)];
        
        // Recalculamos tamaño del UIScrollView
        if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, CGF_offset + UIV_add_mi_pedido.frame.size.height + CGF_separacion+50.0f)];
        else [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, CGF_offset + UIV_add_mi_pedido.frame.size.height + CGF_separacion)];
        
        return iCount;
    }
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
    
    // Comprobamo si el UITableView es el de Carta
    if (tableView.tag == 1) {

        // Recuperamos FoodOptionClass
        FoodOptionClass *FOC_option_obligatories = [_FC_food.NSMA_options_obligatories objectAtIndex:indexPath.row];
        
        // Creamos el Cell View Controller
        _CUITVCBR_cell = [[CustomUITableViewCellIngrediente alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCBR_cell setDelegate:self];
        
        // Calculamos si debe estar activo
        BOOL B_activo = FALSE;
        for (FoodOptionClass *FOC_option_actual in globalVar.OFC_order_food.NSMA_options)
            if (FOC_option_actual.NSI_idfoodoption == FOC_option_obligatories.NSI_idfoodoption) {
                B_activo = TRUE;
                break;
            }
        
        // Iniciamos el Cell View Controller
        [_CUITVCBR_cell setContentWith:FOC_option_obligatories active:B_activo onlyCheck:FALSE];
        
        // La añadimos a la lista de cells
        [NSMA_cells_PedidoPlatoViewController addObject:_CUITVCBR_cell];
        
        return _CUITVCBR_cell;
    }
    else {

        // Recuperamos el PlatoIngredientesClass de la celda
        FoodOptionClass *FOC_food_option = [_FC_food.NSMA_options objectAtIndex:indexPath.row];
        
        // Creamos el Cell View Controller
        _CUITVCBR_cell = [[CustomUITableViewCellIngrediente alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCBR_cell setDelegate:self];
        
        // Calculamos si debe estar activo
        BOOL B_activo = FALSE;
        for (FoodOptionClass *FOC_option in globalVar.OFC_order_food.NSMA_options)
            if (FOC_option.NSI_idfoodoption == FOC_food_option.NSI_idfoodoption) {
                B_activo = TRUE;
                break;
            }
        
        // Iniciamos el Cell View Controller
        [_CUITVCBR_cell setContentWith:FOC_food_option active:B_activo onlyCheck:TRUE];
        
        // La añadimos a la lista de cells
        [NSMA_cells_PedidoPlatoViewController addObject:_CUITVCBR_cell];
        
        return _CUITVCBR_cell;
    }
    
    return nil;
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
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(FoodOptionClass *)FOC_food_option options:(BOOL)B_options {

    // Comprobamo si NO es una options obligatorie
    if (FOC_food_option != nil) {

        FoodOptionClass *FOC_food_option_actual = nil;
        
        // Buscamos el ingrediente en el Array
        for (FoodOptionClass *FOC_option in globalVar.OFC_order_food.NSMA_options)
            if (FOC_option.NSI_idfoodoption == FOC_food_option.NSI_idfoodoption) {
                
                // Fijamos el FoddOptionClass encontrado
                FOC_food_option_actual = FOC_option;
                break;
            }
        
        // Comprobamos si se ha encontrado
        if (FOC_food_option_actual != nil) [globalVar.OFC_order_food.NSMA_options removeObject:FOC_food_option_actual];
        else [globalVar.OFC_order_food.NSMA_options addObject:FOC_food_option];
    }
    
    // Iniciamos precio
    [self setCGF_price:[globalVar.OFC_order_food CGF_total_price]];
    
    // Reload Data
    [UITV_options reloadData];
    [UITV_options_obligatories reloadData];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_add_mi_pedido_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_mi_pedido_TouchUpInside:(id)sender {

    // Comprobamos si hemos terminado la carga
    if (!_B_loading_finish) return;
    
    // Comprobamos si es una actualización
    if (_CGF_price == 0.0f) {
        
        // Eliminamos el OrderFood
        if (_B_update) [globalVar.OC_order.NSMA_orderfoods removeObject:globalVar.OFC_order_food];
        
        // Comprobamos el tipo de pedido
        if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_domicilio redoValueGlobo:_NSI_init_amount];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_restaurante pedir_globo_redoValue:_NSI_init_amount];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_antesllegar redoValueGlobo:_NSI_init_amount];
        }
    }
    else if (_CGF_price > 0.0f) {
        
        // Insertamos PedidoClass en el Array
        if (!_B_update) [globalVar.OC_order.NSMA_orderfoods addObject:globalVar.OFC_order_food];
        
        // Comprobamos el tipo de pedido
        if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ) {
            
            // Actualizamos Globo Tabbar
            if (globalVar.TPVC_domicilio.UIV_globo.alpha == 0.0f)
                [globalVar.TPVC_domicilio initGlobo:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else if ((globalVar.OFC_order_food.NSI_amount - _NSI_init_amount) > 0)
                [globalVar.TPVC_domicilio addValueGlobo:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else
                [globalVar.TPVC_domicilio redoValueGlobo:(_NSI_init_amount- globalVar.OFC_order_food.NSI_amount)];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Actualizamos Globo Tabbar
            if (globalVar.TPVC_restaurante.UIV_pedir_globo.alpha == 0.0f)
                [globalVar.TPVC_restaurante pedir_globo_init:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else if ((globalVar.OFC_order_food.NSI_amount - _NSI_init_amount) > 0)
                [globalVar.TPVC_restaurante pedir_globo_addValue:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else
                [globalVar.TPVC_restaurante pedir_globo_redoValue:(_NSI_init_amount - globalVar.OFC_order_food.NSI_amount)];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos Globo Tabbar
            if (globalVar.TPVC_antesllegar.UIV_globo.alpha == 0.0f)
                [globalVar.TPVC_antesllegar initGlobo:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else if ((globalVar.OFC_order_food.NSI_amount - _NSI_init_amount) > 0)
                [globalVar.TPVC_antesllegar addValueGlobo:(globalVar.OFC_order_food.NSI_amount - _NSI_init_amount)];
            else
                [globalVar.TPVC_antesllegar redoValueGlobo:(_NSI_init_amount - globalVar.OFC_order_food.NSI_amount)];
        }
    }
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_add_amount_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_amount_TouchUpInside:(id)sender {
 
    // Comprobamos si hemos terminado la carga
    if (!_B_loading_finish) return;
    
    // Incrementamos la cantidad
    [globalVar.OFC_order_food setNSI_amount:globalVar.OFC_order_food.NSI_amount+1];
    
    // Iniciamos precio
    [self setCGF_price:[globalVar.OFC_order_food CGF_total_price]];
    
    // Actualizamos UIlabel
    [UIL_amount setText:[NSString stringWithFormat:@"%d", globalVar.OFC_order_food.NSI_amount]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_redo_amount_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_redo_amount_TouchUpInside:(id)sender {
    
    // Comprobamos si hemos terminado la carga
    if (!_B_loading_finish) return;
    
    // Comprobamos si ya llegamos al máximo permitido
    if (globalVar.OFC_order_food.NSI_amount > 0.0f) {
        
        // Incrementamos la cantidad
        [globalVar.OFC_order_food setNSI_amount:globalVar.OFC_order_food.NSI_amount-1];
        
        // Iniciamos precio
        [self setCGF_price:[globalVar.OFC_order_food CGF_total_price]];
        
        // Actualizamos UIlabel
        [UIL_amount setText:[NSString stringWithFormat:@"%d", globalVar.OFC_order_food.NSI_amount]];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_instructions_TouchUpInside
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_instructions_TouchUpInside:(id)sender {
    
    // Comprobamos si hemos terminado la carga
    if (!_B_loading_finish) return;
    
    // Creamos PedidoInstructionsViewController
    _PIVC_instruction = [[PedidoInstructionsViewController alloc] initWithNibName:@"PedidoInstructionsView" bundle:[NSBundle mainBundle]];
    
    // Asignamos delegado
    [_PIVC_instruction setDelegate:self];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_PIVC_instruction animated:YES];
    
    // Actualizamos las instrucciones especiales
    [_PIVC_instruction.UITV_instructions setText:globalVar.OFC_order_food.NSS_instructions];
    
    // Actualizamos ReadOnbly mode
    [_PIVC_instruction setB_readonly:FALSE];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : guardar_instructions_Touched
//#	Fecha Creación	: 15/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) guardar_instructions_Touched:(NSString *)NSS_instructions {
    
    // Guardamos las instrucciones especiales
    [globalVar.OFC_order_food setNSS_instructions:NSS_instructions];
}


@end
//
//  PedidoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "PedidoViewController.h"
#import "PedidoPlatoViewController.h"
#import "LoadingViewController.h"
#import "CustomUITableViewHeaderSectionPlatosViewController.h"
#import "CustomUITableViewCellPlatosViewController.h"
#import "TabbarDomicilioViewController.h"
#import "TabbarRestauranteViewController.h"
#import "TabbarAntesLlegarViewController.h"

#import "RestaurantClass.h"
#import "FoodClass.h"
#import "OrderClass.h"
#import "DailymenuClass.h"


@implementation PedidoViewController

@synthesize UIL_number;
@synthesize UIL_tipo_carta;
@synthesize UIL_tipo_menu;
@synthesize UIL_precio;
@synthesize UITV_listado_carta;
@synthesize UITV_listado_menus;
@synthesize UISV_contenido;
@synthesize UIV_carta;
@synthesize UIV_menus;

@synthesize NSMA_max_number = _NSMA_max_number;
@synthesize NSMA_categoria_number = _NSMA_categoria_number;

@synthesize NSI_idmenu_selected = _NSI_idmenu_selected;

@synthesize CUITVCP_cell = _CUITVCP_cell;
@synthesize CUITVCC_cell = _CUITVCC_cell;
@synthesize CUITVCP_header = _CUITVCP_header;

@synthesize PPVC_plato = _PPVC_plato;

@synthesize STCVC_tipo_carta = _STCVC_tipo_carta;
@synthesize SPVC_precio = _SPVC_precio;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells_menus;
NSMutableArray *NSMA_cells_carta;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_idmenu_selected
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idmenu_selected:(NSInteger)NSI_idmenu_selected {
    
    _NSI_idmenu_selected = NSI_idmenu_selected;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_max_number
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_max_number:(NSMutableArray *)NSMA_max_number {
    
    _NSMA_max_number = NSMA_max_number;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSMA_categoria_number
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_categoria_number:(NSMutableArray *)NSMA_categoria_number {
    
    _NSMA_categoria_number = NSMA_categoria_number;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_cell
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_cell:(CustomUITableViewCellPlatos *)CUITVCP_cell {
    
    _CUITVCP_cell = CUITVCP_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCC_cell
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCC_cell:(CustomUITableViewCellCarta *)CUITVCC_cell {
    
    _CUITVCC_cell = CUITVCC_cell;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCP_header
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCP_header:(CustomUITableViewHeaderSectionPlatosViewController *)CUITVCP_header {
    
    _CUITVCP_header = CUITVCP_header;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPPVC_plato
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPPVC_plato:(PedidoPlatoViewController *)PPVC_plato {
    
    _PPVC_plato = PPVC_plato;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSTCVC_tipo_carta
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTCVC_tipo_carta:(SelectTipoCartaViewController *)STCVC_tipo_carta {
    
    _STCVC_tipo_carta = STCVC_tipo_carta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSPVC_precio
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSPVC_precio:(SelectPrecioViewController *)SPVC_precio {
    
    _SPVC_precio = SPVC_precio;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos el Array de Cantidades por Categoría
    if (_NSMA_max_number == nil) _NSMA_max_number = [[NSMutableArray alloc] init];
    else [_NSMA_max_number removeAllObjects];
    
    // Iniciamos el Array de Cantidades por Categoría
    if (_NSMA_categoria_number == nil) _NSMA_categoria_number = [[NSMutableArray alloc] init];
    else [_NSMA_categoria_number removeAllObjects];
    
    // Reseteamos el Globo de la Tabbar
    [globalVar.TPVC_domicilio resetGlobo];
    
    // Comprobamos que ya hay elementos (se ha recuperado del historico)
    if ([globalVar.OC_order.NSMA_orderfoods count] > 0) {

        // Actualizamos Tabbar
        [globalVar.TPVC_domicilio initGlobo:[globalVar.OC_order.NSMA_orderfoods count]];
    }
    
    // Actualizamos propiedades
    [globalVar setB_data_historico_updated:FALSE];
    
    // Iniciamos UILabel cantidad
    [UIL_number setText:@"0"];
    
    // Iniciamos las Arrays
    NSMA_cells_menus = [[NSMutableArray alloc] init];
    NSMA_cells_carta = [[NSMutableArray alloc] init];
    
    // Configuración de delegados
	UITV_listado_carta.delegate   = self;
	UITV_listado_carta.dataSource = self;
    UITV_listado_menus.delegate   = self;
	UITV_listado_menus.dataSource = self;
    
    // Insertamos las UIView
    [UISV_contenido addSubview:UIV_menus];
    [UISV_contenido addSubview:UIV_carta];
    
    // Posicioanmso UIView
    [UISV_contenido setFrame:CGRectMake(0.0f, -40.0f, UISV_contenido.frame.size.width, UISV_contenido.frame.size.height)];
    [UIV_menus setFrame:CGRectMake(UIV_menus.frame.size.width, 0.0f, UIV_menus.frame.size.width, UIV_menus.frame.size.height)];
    [UIV_carta setFrame:CGRectMake(0.0f, 0.0f, UIV_carta.frame.size.width, UIV_carta.frame.size.height)];
    
    // Actualizamos Content UIScrollView
    [UISV_contenido setContentSize:CGSizeMake((UIV_menus.frame.size.width+UIV_carta.frame.size.width), UIV_menus.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:TRUE];
    
    // Posicionamos UIScroll al principio
    [UISV_contenido setContentOffset:CGPointMake(0.0f, 0.0f)];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Pedir";
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Comprobamo si el tipo de pedido es en el restaurante
    if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
     
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SHOW_RESTAURANT_TABBAR_BUTTON_ 
                                                            object:self];
        
        // Actualizamos Tamaño UITableView
        [UITV_listado_carta setFrame:CGRectMake(UITV_listado_carta.frame.origin.x, UITV_listado_carta.frame.origin.y, UITV_listado_carta.frame.size.width, 293.0f)];
        [UITV_listado_menus setFrame:CGRectMake(UITV_listado_menus.frame.origin.x, UITV_listado_menus.frame.origin.y, UITV_listado_menus.frame.size.width, 267.0f)];
        
        // Aumentamos el Content del UISvrollView
        [UISV_contenido setContentSize:CGSizeMake(UISV_contenido.frame.size.width, UISV_contenido.frame.size.height+57.0f)];
    }
    else {
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                            object:self];
        
        // Actualizamos Tamaño UITableView
        [UITV_listado_carta setFrame:CGRectMake(UITV_listado_carta.frame.origin.x, UITV_listado_carta.frame.origin.y, UITV_listado_carta.frame.size.width, 348.0f)];
        [UITV_listado_menus setFrame:CGRectMake(UITV_listado_menus.frame.origin.x, UITV_listado_menus.frame.origin.y, UITV_listado_menus.frame.size.width, 322.0f)];
    }
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Comprobamos si debemos cargar la comida
    if ([globalVar.OC_order.RC_restaurant.NSMA_foods count] == 0) {
        
        // Iniciamos Array Order
        [globalVar.OC_order.NSMA_orderfoods removeAllObjects];
        if (globalVar.OC_order.TOT_type != TOT_pedido_antes_de_ir_al_restaurante) [globalVar.OC_order setNSI_persons:0];
        [globalVar.OC_order setCGF_subtotal             :0.0f];
        [globalVar.OC_order setCGF_membership_discount  :0.0f];
        [globalVar.OC_order setCGF_offer_discount       :0.0f];
        [globalVar.OC_order setCGF_facebook_discount    :0.0f];
        [globalVar.OC_order setCGF_price_homedelivery   :0.0f];
        [globalVar.OC_order setCGF_total                :0.0f];
        
        // Iniciamos Food and DaialyMenuFood
        [globalVar.OC_order.RC_restaurant.NSMA_foodcategories       removeAllObjects];
        [globalVar.OC_order.RC_restaurant.NSMA_foods                removeAllObjects];
        [globalVar.OC_order.RC_restaurant.NSMA_dailymenus           removeAllObjects];
        [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories removeAllObjects];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodCategories)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {
        
        // Comprobamo si aún no se ha actualizado los datos
        if ( (globalVar.B_come_from_historial) && (!globalVar.B_data_historico_updated)) {
            
            // Actualizamos Tabbar
            [globalVar.TPVC_domicilio initGlobo:[globalVar.OC_order.NSMA_orderfoods count]];
            
            // Actualizamos propiedad
            [globalVar setB_data_historico_updated:TRUE];
            
            // Iniciamos el Array de Cantidades por Categoría
            if (_NSMA_max_number == nil) _NSMA_max_number = [[NSMutableArray alloc] init];
            else [_NSMA_max_number removeAllObjects];
            
            // Iniciamos el Array de Cantidades por Categoría
            if (_NSMA_categoria_number == nil) _NSMA_categoria_number = [[NSMutableArray alloc] init];
            else [_NSMA_categoria_number removeAllObjects];
            
            // Rellenamos el Array de Cantidades por Categoría
            for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
                
                // Creamos el Array para el menu actual
                NSMutableArray *NSMA_menu = [[NSMutableArray alloc] init];
                
                // Rellenamos el Array del menú actual
                for (FoodCategoryClass *FCC_foodcategory in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories) {
                    NSNumber *NSN_numer = [NSNumber numberWithInt:0];
                    [NSMA_menu addObject:NSN_numer];
                }
                
                // Insertamos el Array de categorias del menú actual en el Array general            
                [_NSMA_categoria_number addObject:NSMA_menu];
                
                // Iniciamos Cantidad Máxima
                for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
                    NSNumber *NSN_numer = [NSNumber numberWithInt:0];
                    [_NSMA_max_number addObject:NSN_numer];
                }
            }
            
            // Actualizamos los datos por si venimos de recuperar el histórico
            [self updateMenusData];
        }
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
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    
    // Comprobamos si es un pedido desde el resturante y la comida ya está en cocina
    if ((globalVar.OC_order.TOT_type != TOT_pedido_en_el_restaurante) || (!globalVar.B_pedido_en_cocina)) {

        // Creamos UIButton Back
        [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
        [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
        [UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Añadimos UIButton
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
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Comprobamos que tipo de pedido se esta haciendo
    if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
        
        // Indicamos al delegado que se ha pulsado sobre la celda
        if (_delegate != nil) [_delegate Tabbar_pre_datos_Touched];
    }
    else {
     
        // Mostramos mensage de confirmación
        UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
        [UIAV_confirm setTitle:@"Confirmación"];
        [UIAV_confirm setMessage:@"¿Está seguro de que desea abandonar el pedido en curso?"];
        [UIAV_confirm setDelegate:self];
        [UIAV_confirm addButtonWithTitle:@"Si"];
        [UIAV_confirm addButtonWithTitle:@"No"];
        [UIAV_confirm show];
    }        
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateMenusData
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateMenusData {
    
    // Verificamos que venimos de recuperar un pedido del histórico
    if (!globalVar.B_come_from_historial) return;
    
    // Recorremos el array de food de la Order
    for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods) {
        
        // Comprobamos si es un food de un menu
        if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
            
            // Buscamos el menú al que pertenece
            int iPosMenu = [globalVar iPosMenuOfFood:OFC_food];
            if (iPosMenu == -1) continue;
            
            // Buscamos la posición de la categoria seleccionada
            int iPos = 0;
            for (FoodCategoryClass *FCC_foodcategories in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories)
                if (FCC_foodcategories.NSI_idfoodcategories == OFC_food.NSI_idfoodcategories) break;
                else iPos += 1;
            
            // Recuperamos el number actual de la categoría
            NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:iPosMenu];
            NSInteger NSI_number = [(NSNumber *)[NSMA_categories objectAtIndex:iPos] intValue];
            NSI_number += OFC_food.NSI_amount;
            
            // Actualizamos el Array
            [NSMA_categories replaceObjectAtIndex:iPos withObject:[NSNumber numberWithInt:NSI_number]];
            
            // Actualizamos UIlabel
            if (iPosMenu == _NSI_idmenu_selected) [UIL_precio setText:[NSString stringWithFormat:@"%@", [globalVar nameOfMenuOfFood:OFC_food]]];
        }
    }
    
    // Actualizamos num menus
    int iPosMenu = 0;
    for (DailymenuClass *DC_menus in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
        
        int iPosCategoria = 0;
        for (FoodCategoryClass *FCC_foodcategories in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories) {
            
            // Recuperamos el number actual de la categoría
            NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:iPosMenu];
            NSInteger NSI_number = [(NSNumber *)[NSMA_categories objectAtIndex:iPosCategoria] intValue];
            
            // Recuperamos el number actual del menú
            NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:iPosMenu];
            NSInteger NSI_max_number = [NSN_max_number integerValue];

            // Comprobamos si el número de la categoía es mayor que el del menu
            if (NSI_max_number < NSI_number) [_NSMA_max_number replaceObjectAtIndex:iPosMenu withObject:[NSNumber numberWithInt:NSI_number]];
            
            // Incrementamos el numero de menu
            iPosCategoria += 1;
        }
        
        // Actualizamos UIlabel
        if (iPosMenu == _NSI_idmenu_selected) {
            
            // Recuperamos el number actual del menú
            NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:iPosMenu];
            NSInteger NSI_max_number = [NSN_max_number integerValue];
            
            // Actualizamos compornentes View
            //[UIL_precio setText:[NSString stringWithFormat:@"%.2f€", [globalVar priceOfMenuOfFood:OFC_food]]];
            [UIL_number setText:[NSString stringWithFormat:@"%d", NSI_max_number]];
        }
        
        // Incrementamos el numero de menu
        iPosMenu += 1;
    }
    
    // Actualizamos el numero menús de cada Order Food
    for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods) {
        
        // Comprobamos si es un food de un menu
        if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
            
            // Buscamos el menú al que pertenece
            int iPosMenu = [globalVar iPosMenuOfFood:OFC_food];
            if (iPosMenu == -1) continue;
            
            // Buscamos la posición de la categoria seleccionada
            int iPos = 0;
            for (FoodCategoryClass *FCC_foodcategories in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories)
                if (FCC_foodcategories.NSI_idfoodcategories == OFC_food.NSI_idfoodcategories) break;
                else iPos += 1;
            
            // Recuperamos el number actual de la categoría
            NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:iPosMenu];
            NSInteger NSI_number = [(NSNumber *)[NSMA_categories objectAtIndex:iPos] intValue];
            
            // Actualizamos Order Food
            [OFC_food setNSI_menus:NSI_number];
        }
    }
    
    // Actualizamos los datos
    [UITV_listado_carta reloadData];
    [UITV_listado_menus reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategories
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
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
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
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
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
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
//#	Procedimiento   : loadFoodCategoriesSuccessful
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategoriesSuccessful:(NSNotification *)notification {
 
    // Recuperamos listado de foods del resturante
    [self loadFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsSuccessful
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodsSuccessful:(NSNotification *)notification {
    
    // Actualizamos los datos
    [UITV_listado_carta reloadData];
    
    // Recuperamos listado de menus del resturante
    //[self loadDailymenusCategories];
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
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenusSuccessful:(NSNotification *)notification {
    
    // Iniciamos el menú seleccionado
    if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] > 0) {
    
        // Rellenamos el Array de Cantidades por Categoría
        for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
            
            // Creamos el Array para el menu actual
            NSMutableArray *NSMA_menu = [[NSMutableArray alloc] init];
            
            // Rellenamos el Array del menú actual
            for (FoodCategoryClass *FCC_foodcategory in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories) {
                NSNumber *NSN_numer = [NSNumber numberWithInt:0];
                [NSMA_menu addObject:NSN_numer];
            }
            
            // Insertamos el Array de categorias del menú actual en el Array general            
            [_NSMA_categoria_number addObject:NSMA_menu];
            
            // Iniciamos Cantidad Máxima
            for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
                NSNumber *NSN_numer = [NSNumber numberWithInt:0];
                [_NSMA_max_number addObject:NSN_numer];
            }
        }
        
        // Marcamos el primer menú como el seleccionado
        [self setNSI_idmenu_selected:0];
        
        // Recuperamos el primero de los menús
        DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:0];
        
        // Actualizamos el UILabel de menú
        [UIL_precio setText:[NSString stringWithFormat:@"%@", DMC_menu.NSS_name]];
    }
    else {
        
        // Indicamos que no hay menús para el restaurante
        [self setNSI_idmenu_selected:-1];
    }
    
    // Actualizamos los datos
    [UITV_listado_carta reloadData];
    [UITV_listado_menus reloadData];
    
    // Actualizamos los datos por si venimos de recuperar el histórico
    [self updateMenusData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
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
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 22/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
        
        // Iniciamos propiedad global
        //[globalVar setB_realizando_pedido:FALSE];
        
        // Reseteamos Order
        [globalVar.OC_order reset];
        
        // Comprobamos el tipo de pedido
        if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ) {
            
            // Reseteamos el Globo de la Tabbar
            [globalVar.TPVC_domicilio resetGlobo];
            
            // Comprobamos si venimos de Mi Saco
            if ((globalVar.B_origen_mi_saco) || (globalVar.B_come_from_historial)) {
                
                // Generamos la notificación que indica que se ha de ir a la Navigation Principal
                [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                                    object:self];
            }
            else {
                
                // Volvemos Viewcontroller padre
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Reseteamos el Globo de la Tabbar
            [globalVar.TPVC_restaurante pedir_globo_reset];
            [globalVar.TPVC_restaurante en_cocina_globo_reset];
            
            // Actualizamos propiedades globales
            [globalVar setB_pedido_en_cocina:FALSE];
            
            // Volvemos Viewcontroller padre
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark -
#pragma mark Table view data source

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfSectionsInTableView
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: Customize the number of sections in the table view.
//#
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Comprobamo si el UITableView es el de Carta
    if (tableView.tag == 2) return [globalVar.OC_order.RC_restaurant.NSMA_foodcategories count];
    else return [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:numberOfRowsInSection
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Comprobamo si el UITableView es el de Carta
    if (tableView.tag == 2) {

        // Comprobamos que la lista no esté vacía
        if ([globalVar.OC_order.RC_restaurant.NSMA_foods count] == 0) return 0;
        
        // Recuperamos información categoria
        FoodCategoryClass *FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_foodcategories objectAtIndex:section];
        NSInteger NSI_id_categoria = FCC_category.NSI_idfoodcategories;
        
        // Contamos en función de la categoría
        int iCount = 0;
        for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods)
            if (NSI_id_categoria == FC_food.NSI_idfoodcategories)
                iCount += 1;
        
        return iCount;
    }
    else {
        
        // Comprobamos que la lista no esté vacía
        if (_NSI_idmenu_selected == -1) return 0;
        
        // Recuperamos información categoria
        FoodCategoryClass *FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories objectAtIndex:section];
        NSInteger NSI_id_categoria = FCC_category.NSI_idfoodcategories;
        
        int iCount = 0;

        if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count]) {
            // Recuperamos el primero de los menús
            DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:_NSI_idmenu_selected];
            
            // Contamos en función de la categoría
            for (DailymenufoodClass *MFC_food in DMC_menu.NSMA_dailymenufoods)
                if (NSI_id_categoria == MFC_food.NSI_idfoodcategories)
                    iCount += 1;
        }

        
        return iCount;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:titleForHeaderInSection:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
    FoodCategoryClass *FCC_category;
    
    // Recuperamos información categoria
    if (tableView.tag == 2) FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_foodcategories objectAtIndex:section];
    else FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories objectAtIndex:section];
    
    return FCC_category.NSS_namefoodcategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:viewForHeaderInSection:
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    FoodCategoryClass *FCC_category;
    
    // Calculamos la row a cargar
    if (tableView.tag == 2) FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_foodcategories objectAtIndex:section];
    else FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories objectAtIndex:section];
    
    // Creamos el Header View Controller
    _CUITVCP_header = [[CustomUITableViewHeaderSectionPlatosViewController alloc] init];
    
    // Actualizasmo Header View Controller
    [_CUITVCP_header setContentWith:FCC_category.NSS_namefoodcategories];
    
    return _CUITVCP_header.view;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:cellForRowAtIndexPath:
//#	Fecha Creación	: 10/02/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodCategoryClass *FCC_category;
    
    // Calculamos la row a cargar
    if (tableView.tag == 2) FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_foodcategories objectAtIndex:indexPath.section];
    else FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories objectAtIndex:indexPath.section];
    
    // Calculamos la row a cargar
    NSInteger NSI_id_categoria = FCC_category.NSI_idfoodcategories;
    NSInteger NSI_row_pos = indexPath.row;
    
    // Comprobamo si el UITableView es el de Carta
    if (tableView.tag == 2) {

        // Recuperamos el Food correspondiente
        FoodClass *FC_food;
        for (FoodClass *FC_food_actual in globalVar.OC_order.RC_restaurant.NSMA_foods)
            if (NSI_id_categoria == FC_food_actual.NSI_idfoodcategories) {
                if (NSI_row_pos == 0) { FC_food = FC_food_actual; break; }
                else NSI_row_pos -= 1;
            }
        
        // Creamos el Cell View Controller
        _CUITVCC_cell = [[CustomUITableViewCellCarta alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCC_cell setDelegate:self];
        
        // Iniciamos el Cell View Controller
        [_CUITVCC_cell setContentWith:FC_food readOnlyMode:FALSE];
        
        // La añadimos a la lista de cells
        [NSMA_cells_carta addObject:_CUITVCC_cell];
        
        return _CUITVCC_cell;
    }
    else {
        
        // Recuperamos el primero de los menús
        DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:_NSI_idmenu_selected];
        
        // Recuperamos el Food correspondiente
        DailymenufoodClass *MFC_food;
        for (DailymenufoodClass *MFC_food_actual in DMC_menu.NSMA_dailymenufoods)
            if (NSI_id_categoria == MFC_food_actual.NSI_idfoodcategories) {
                if (NSI_row_pos == 0) { MFC_food = MFC_food_actual; break; }
                else NSI_row_pos -= 1;
            }
        
        // Creamos el Cell View Controller
        _CUITVCP_cell = [[CustomUITableViewCellPlatos alloc] initWithFrame:CGRectZero];
        
        // Asignamos delegados
        [_CUITVCP_cell setDelegate:self];
        
        // Buscamos el Plato en el pedido
        NSInteger NSI_cantidad = 0;
        for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods)
            if (OFC_food.NSI_iddailymenu_food == MFC_food.NSI_idfood) {
                
                NSI_cantidad = OFC_food.NSI_amount;
                break;
            }
        
        // Iniciamos el Cell View Controller
        [_CUITVCP_cell setContentWith:MFC_food readOnlyMode:FALSE cantidad:NSI_cantidad];
        
        // La añadimos a la lista de cells
        [NSMA_cells_menus addObject:_CUITVCP_cell];
        
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
//#	Fecha Ult. Mod.	: 10/02/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodCategoryClass *FCC_category;
    
    // Calculamos la row a cargar
    if (tableView.tag == 2) FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_foodcategories objectAtIndex:indexPath.section];
    else FCC_category = [globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories objectAtIndex:indexPath.section];
    
    // Calculamos la row a cargar
    NSInteger NSI_id_categoria = FCC_category.NSI_idfoodcategories;
    NSInteger NSI_row_pos = indexPath.row;
    
    if (tableView.tag == 2) {
        
        // Recuperamos el Food correspondiente
        FoodClass *FC_food;
        for (FoodClass *FC_food_actual in globalVar.OC_order.RC_restaurant.NSMA_foods)
            if (NSI_id_categoria == FC_food_actual.NSI_idfoodcategories) {
                if (NSI_row_pos == 0) { FC_food = FC_food_actual; break; }
                else NSI_row_pos -= 1;
            }
        
        if (FC_food.NSS_namefood.length > 25) {
            return 55.0f;
        }        
    } else {
    
        // Recuperamos el primero de los menús
        DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:_NSI_idmenu_selected];
        
        // Recuperamos el Food correspondiente
        DailymenufoodClass *MFC_food;
        for (DailymenufoodClass *MFC_food_actual in DMC_menu.NSMA_dailymenufoods)
            if (NSI_id_categoria == MFC_food_actual.NSI_idfoodcategories) {
                if (NSI_row_pos == 0) { MFC_food = MFC_food_actual; break; }
                else NSI_row_pos -= 1;
            }
    
        if (MFC_food.NSS_namefood.length > 25) {
            return  55.0f;
        }
    }
    return 42.0f;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : tableView:heightForHeaderInSection:
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 25.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(FoodClass *)FC_food {
    
    // Comprobamos si estamos en cocina
    //if (globalVar.B_pedido_en_cocina) return;
    
    // Iniciamos OrderFoodClass
    globalVar.OFC_order_food = nil;
    [globalVar setFC_food:FC_food];
    
    // Creamos PedidoPlatoViewController
    _PPVC_plato = [[PedidoPlatoViewController alloc] initWithNibName:@"PedidoPlatoView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_PPVC_plato animated:YES];
    
    // Actualizamos porpiedades
    //[_PPVC_plato setFC_food:FC_food];
    
    // Ocultamos UIButton Tabbar
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) add_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria {

    // Comprobamos si estamos en cocina
    //if (globalVar.B_pedido_en_cocina) return;
    
    // Comprobamos si existen menus en el restaurante
    if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] == 0) return;
    
    // Buscamos la posición de la categoria seleccionado
    int iPos = 0;
    for (FoodCategoryClass *FCC_foodcategories in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories)
        if (FCC_foodcategories.NSI_idfoodcategories == NSI_id_categoria) break;
        else iPos += 1;
    
    // Recuperamos el number actual de la categoría
    NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:_NSI_idmenu_selected];
    NSInteger NSI_number = [(NSNumber *)[NSMA_categories objectAtIndex:iPos] intValue];
    
    // Recuperamos el numero máximo de food para este menú
    NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:_NSI_idmenu_selected];
    
    // Comprobamos que no hemos llegado al máximo
    if (NSI_number < [NSN_max_number integerValue]) {
        
        // Actualizamos el Array
        NSI_number += 1;
        [NSMA_categories replaceObjectAtIndex:iPos withObject:[NSNumber numberWithInt:NSI_number]];
        
        // Actualizamos el UILabel
        CustomUITableViewCellPlatosViewController *CUITVCPVC_cell = (CustomUITableViewCellPlatosViewController *)sender;
        
        // Comprobamos el tipo de pedido
        if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ) {

             // Actualizamos Globo Tabbar
            if (globalVar.TPVC_domicilio.UIV_globo.alpha == 0.0f) [globalVar.TPVC_domicilio initGlobo:1];
            else [globalVar.TPVC_domicilio addValueGlobo:1];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Actualizamos Globo Tabbar
            if (globalVar.TPVC_restaurante.UIV_pedir_globo.alpha == 0.0f) [globalVar.TPVC_restaurante pedir_globo_init:1];
            else [globalVar.TPVC_restaurante pedir_globo_addValue:1];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos Globo Tabbar
            if (globalVar.TPVC_antesllegar.UIV_globo.alpha == 0.0f) [globalVar.TPVC_antesllegar initGlobo:1];
            else [globalVar.TPVC_antesllegar addValueGlobo:1];
        }
        
        // Iniciamos FoodClass
        OrderFoodClass *OFC_food = nil;
        DailymenufoodClass *MFC_food = CUITVCPVC_cell.MFC_food;
        
        // Buscamos el plato seleccionado en el pedido
        for (OrderFoodClass *OFC_food_actual in globalVar.OC_order.NSMA_orderfoods)
            if (OFC_food_actual.NSI_iddailymenu_food == MFC_food.NSI_idfood) {
                OFC_food = OFC_food_actual;
                break;
            }
        
        // Comprobamos si el plato ya está en el pedido
        if (OFC_food != nil) {
            
            // Incrementamos la cantidad
            OFC_food.NSI_amount += 1;
        }
        else {
         
            // Recuperamos el primero de los menús
            DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:_NSI_idmenu_selected];
            
            // Creamos el PedidoClass
            OFC_food = [[OrderFoodClass alloc] init];
            
            // Actualizamos propiedades
            [OFC_food setNSI_iddailymenu_food : MFC_food.NSI_idfood];
            [OFC_food setNSS_namefood         : MFC_food.NSS_namefood];
            [OFC_food setCGF_price            : DMC_menu.CGF_price];
            
            // Insertamos PedidoClass en el Array
            [globalVar.OC_order.NSMA_orderfoods addObject:OFC_food];
        }
        
        // Recuperamos el numero máximo de food para este menú
        NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:_NSI_idmenu_selected];
        NSInteger NSI_max_number = [NSN_max_number integerValue];
        
        // Actualizamos Num menus
        [OFC_food setNSI_menus: NSI_max_number];

        // Actualizamos el UILabel
        [CUITVCPVC_cell setContentWith:MFC_food readOnlyMode:FALSE cantidad:OFC_food.NSI_amount];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) redo_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria {
    
    // Comprobamos si estamos en cocina
    //if (globalVar.B_pedido_en_cocina) return;
    
    // Comprobamos si existen menus en el restaurante
    if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] == 0) return;
    
    // Recuperamos Cell
    CustomUITableViewCellPlatosViewController *CUITVCPVC_cell = (CustomUITableViewCellPlatosViewController *)sender;
    NSInteger NSI_number = [CUITVCPVC_cell.UIL_number.text intValue];
    
    // Comprobamos que no hemos llegado al máximo
    if (NSI_number > 0) {
        
        // Buscamos la posición de la categoria seleccionado
        int iPos = 0;
        for (FoodCategoryClass *FCC_foodcategories in globalVar.OC_order.RC_restaurant.NSMA_dailymenuscategories)
            if (FCC_foodcategories.NSI_idfoodcategories == NSI_id_categoria) break;
            else iPos += 1;
        
        // Actualizamos el Array
        NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:_NSI_idmenu_selected];
        NSInteger NSI_actual_number = [(NSNumber *)[NSMA_categories objectAtIndex:iPos] intValue];
        [NSMA_categories replaceObjectAtIndex:iPos withObject:[NSNumber numberWithInt:(NSI_actual_number-1)]];
        
        // Comprobamos el tipo de pedido
        if ((globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) || (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) ) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_domicilio redoValueGlobo:1];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_en_el_restaurante) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_restaurante pedir_globo_redoValue:1];
        }
        else if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
            
            // Actualizamos Globo Tabbar
            [globalVar.TPVC_antesllegar redoValueGlobo:1];
        }
        
        // Iniciamos FoodClass
        OrderFoodClass *OFC_food = nil;
        DailymenufoodClass *MFC_food = CUITVCPVC_cell.MFC_food;
        
        // Buscamos el plato seleccionado en el pedido
        for (OrderFoodClass *OFC_food_actual in globalVar.OC_order.NSMA_orderfoods)
            if (OFC_food_actual.NSI_iddailymenu_food == MFC_food.NSI_idfood) {
                OFC_food = OFC_food_actual;
                break;
            }
        
        // Comprobamos si el plato ya está en el pedido
        if (OFC_food.NSI_amount > 1) {
            
            // Incrementamos la cantidad
            OFC_food.NSI_amount -= 1;
            
            // Actualizamos el UILabel
            [CUITVCPVC_cell setContentWith:MFC_food readOnlyMode:FALSE cantidad:OFC_food.NSI_amount];
        }
        else {
            
            // Insertamos PedidoClass en el Array
            [globalVar.OC_order.NSMA_orderfoods removeObject:OFC_food];
            
            // Actualizamos el UILabel
            [CUITVCPVC_cell setContentWith:MFC_food readOnlyMode:FALSE cantidad:0];
        }
    }
}

#pragma mark -  
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_add_number_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_add_number_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en cocina
    //if (globalVar.B_pedido_en_cocina) return;
    
    // Comprobamos si existen menus en el restaurante
    if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] == 0) return;
    
    // Recuperamos el numero máximo de food para este menú
    NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:_NSI_idmenu_selected];
    NSInteger NSI_max_number = [NSN_max_number integerValue];
    NSI_max_number += 1;
    
    // Actualizamos numero máximo
    [_NSMA_max_number replaceObjectAtIndex:_NSI_idmenu_selected withObject:[NSNumber numberWithInt:NSI_max_number]];
    
    // Actualizamos menus
    //[globalVar.OC_order setNSI_persons:_NSI_max_number];
    
    // Actualizamos UIlabel
    [UIL_number setText:[NSString stringWithFormat:@"%d", NSI_max_number]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_redo_number_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_redo_number_TouchUpInside:(id)sender {

    // Comprobamos si estamos en cocina
    //if (globalVar.B_pedido_en_cocina) return;
    
    // Comprobamos si existen menus en el restaurante
    if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] == 0) return;
    
    // Recuperamos Array de categorias para el menñu actual
    NSMutableArray *NSMA_categories = [_NSMA_categoria_number objectAtIndex:_NSI_idmenu_selected];
    
    // Calculamos el numero máximo actual por categoria
    NSInteger NSI_max = 0;
    for (NSNumber *NSN_number in NSMA_categories)
        if (NSI_max < [NSN_number intValue]) NSI_max = [NSN_number intValue];
    
    // Recuperamos el numero máximo de food para este menú
    NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:_NSI_idmenu_selected];
    NSInteger NSI_max_number = [NSN_max_number integerValue];
    
    // Comprobamos si ya llegamos al máximo permitido
    if ( (NSI_max_number > 0) && (NSI_max < NSI_max_number) ) {
        
        // Actualizamos numero máximo
         NSI_max_number -= 1;
        [_NSMA_max_number replaceObjectAtIndex:_NSI_idmenu_selected withObject:[NSNumber numberWithInt:NSI_max_number]];
        
        // Actuzalizamos menus
        //[globalVar.OC_order setNSI_persons:_NSI_max_number];
        
        // Actualizamos UIlabel
        [UIL_number setText:[NSString stringWithFormat:@"%d", NSI_max_number]];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_tipo_carta_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_tipo_carta_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ((_STCVC_tipo_carta != nil) || (_SPVC_precio != nil)) return;
    
    // Creamos SelectTipoCocinaViewController
    _STCVC_tipo_carta = [[SelectTipoCartaViewController alloc] initWithNibName:@"SelectTipoCartaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STCVC_tipo_carta setDelegate:self];
    
    // Iniciamos Propiedades
    [_STCVC_tipo_carta setNSS_tipo_carta:UIL_tipo_menu.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STCVC_tipo_carta.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STCVC_tipo_carta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_carta.view.frame.size.width, _STCVC_tipo_carta.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STCVC_tipo_carta.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STCVC_tipo_carta.view.frame.size.height), _STCVC_tipo_carta.view.frame.size.width, _STCVC_tipo_carta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_precio_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_precio_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ((_STCVC_tipo_carta != nil) || (_SPVC_precio != nil) || (_NSI_idmenu_selected == -1)) return;
    
    // Creamos SelectTipoCocinaViewController
    _SPVC_precio = [[SelectPrecioViewController alloc] initWithNibName:@"SelectPrecioView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SPVC_precio setDelegate:self];
    
    // Recuperamos el primero de los menús
    DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:_NSI_idmenu_selected];
    
    // Iniciamos Propiedades
    [_SPVC_precio setDMC_menu:DMC_menu];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SPVC_precio.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SPVC_precio.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SPVC_precio.view.frame.size.width, _SPVC_precio.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SPVC_precio.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SPVC_precio.view.frame.size.height), _SPVC_precio.view.frame.size.width, _SPVC_precio.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_carta:(NSString *)NSS_tipo_carta {
    
    // Actualizamos UILabel
    [UIL_tipo_menu  setText:NSS_tipo_carta];
    [UIL_tipo_carta setText:NSS_tipo_carta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_tipo_carta {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_STCVC_tipo_carta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STCVC_tipo_carta.view.frame.size.width, _STCVC_tipo_carta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_precio
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_precio:(DailymenuClass *)DMC_menu {
    
    // Actualizamos UILabel
    [UIL_precio setText:[NSString stringWithFormat:@"%@", DMC_menu.NSS_name]];
    
    // Buscamos el DailyMenu seleccionado
    int iPos = 0;
    for (DailymenuClass *DMC_menu_actual in globalVar.OC_order.RC_restaurant.NSMA_dailymenus)
        if (DMC_menu_actual.NSI_iddailymenu == DMC_menu.NSI_iddailymenu) break;
        else iPos += 1;

    // Marcamos el dailymenu seleccionado
    [self setNSI_idmenu_selected:iPos];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_cocina
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_precio {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SPVC_precio.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SPVC_precio.view.frame.size.width, _SPVC_precio.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 30/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_STCVC_tipo_carta != nil) {
        
        // Quitamos el View Select Tipo Cocina
        [_STCVC_tipo_carta.view removeFromSuperview];
        
        // Liberamos memoria
        _STCVC_tipo_carta = nil;
        
        // Comprobamos Tipo seleccionado
        if ([UIL_tipo_carta.text isEqualToString:@"Menú"]) {
            
            // Comprobamo si no es ya el seleccionado
            if (UISV_contenido.contentOffset.x != UIV_menus.frame.size.width) {
                
                // Reiniciamos los componentes
                //[self resetPedidoComponnet];
                
                // Actualizamos UIView
                [UISV_contenido setContentOffset:CGPointMake(UIV_menus.frame.size.width, 0.0f) animated:TRUE];
                
                // Comprobamos si debemos cargar la comida
                if ([globalVar.OC_order.RC_restaurant.NSMA_dailymenus count] == 0) {
                    
                    // Recuperamos listado de menus del resturante
                    [self loadDailymenusCategories];
                }
            }
        }
        else {
            
            // Comprobamo si no es ya el seleccionado
            if (UISV_contenido.contentOffset.x != 0.0f) {
                
                // Reiniciamos los componentes
                //[self resetPedidoComponnet];
                
                // Actualizamos UIView
                [UISV_contenido setContentOffset:CGPointMake(0.0f, 0.0f) animated:TRUE];
            }
        }
    }
    else {
        
        // Quitamos el View Select Precio
        [_SPVC_precio.view removeFromSuperview];
        
        // Liberamos memoria
        _SPVC_precio = nil;
        
        // Recuperamos el numero máximo de food para este menú
        NSNumber *NSN_max_number = [_NSMA_max_number objectAtIndex:_NSI_idmenu_selected];
        NSInteger NSI_max_number = [NSN_max_number integerValue];

        // Actualizamos UIlabel
        [UIL_number setText:[NSString stringWithFormat:@"%d", NSI_max_number]];
        
        // Actualizamos los datos UITableview
        [UITV_listado_menus reloadData];
    }
}


@end
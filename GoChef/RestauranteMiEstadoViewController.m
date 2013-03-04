//
//  RestauranteMiEstadoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteMiEstadoViewController.h"
#import "LoadingViewController.h"

#import "UserClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"
#import "UserMembershipClass.h"


@implementation RestauranteMiEstadoViewController

@synthesize UIL_discount;
@synthesize UIL_description;
@synthesize UIIV_name;
@synthesize UIIV_price;
@synthesize UIIV_accumulated;
@synthesize UITV_listado;

@synthesize CUITVCMS_cell = _CUITVCMS_cell;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_cells;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCUITVCMS_cell
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCUITVCMS_cell:(CustomUITableViewCellMiEstado *)CUITVCMS_cell {
    
    _CUITVCMS_cell = CUITVCMS_cell;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Mi Estado";
    
    // Iniciamos componentes
    [UIL_discount     setText:@""];
    [UIL_description  setText:@""];
    [UIIV_name        setAlpha:0.0f];
    [UIIV_accumulated setAlpha:0.0f];
    [UIIV_price       setAlpha:0.0f];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(loadUsuarioMembership)
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
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuarioMembership
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuarioMembership {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_MEMBERSHIP_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_MEMBERSHIP_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_MEMBERSHIP_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadUsuarioMembershipSuccessful:) 
                                                 name: _NOTIFICATION_USER_MEMBERSHIP_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_USER_MEMBERSHIP_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_USER_MEMBERSHIP_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadUsuarioMembership];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffers
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffers {
    
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
    [globalVar setB_cargar_imagenes:FALSE];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadOffers];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuarioMembershipSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuarioMembershipSuccessful:(NSNotification *)notification {
    
    // Comprobamos si el usuario tiene estado
    if (globalVar.UC_user.UMC_membership.NSI_idmembership != _ID_USER_MEMBERSHIP_NO_VALUE_) {

        // Recuperamo MembershipClass
        UserMembershipClass *UMC_membership = globalVar.UC_user.UMC_membership;
        
        // Actualizamos UILabel
        [UIL_discount    setText:UMC_membership.NSS_discount];
        [UIL_description setText:UMC_membership.NSS_membershipdescription];
        
        // Mostramos UIImagesView
        [UIIV_name  setAlpha:1.0f];
        [UIIV_price setAlpha:1.0f];
        
        // Actualizamos membershipname
        if ([UMC_membership.NSS_membershipname isEqualToString:_ESTADO_ORO_]) {
            
            // Actualizamos UIImage estado
            UIImage *UII_name = [UIImage imageNamed:@"mi_estado_oro.png"];
            [UIIV_name setImage:UII_name];
            
            // Actualizamos UIImage estado
            UIImage *UII_price = [UIImage imageNamed:@"mi_estado_grafico_plata_platino.png"];
            [UIIV_price setImage:UII_price];
        }
        else if ([UMC_membership.NSS_membershipname isEqualToString:_ESTADO_PLATINO_]) {
            
            // Actualizamos UIImage estado
            UIImage *UII_name = [UIImage imageNamed:@"mi_estado_platino.png"];
            [UIIV_name setImage:UII_name];
            
            // Actualizamos UIImage estado
            UIImage *UII_price = [UIImage imageNamed:@"mi_estado_grafico_oro_nada.png"];
            [UIIV_price setImage:UII_price];
        }
        else if ([UMC_membership.NSS_membershipname isEqualToString:_ESTADO_PLATA_]) {
            
            // Actualizamos UIImage estado
            UIImage *UII_name = [UIImage imageNamed:@"mi_estado_plata.png"];
            [UIIV_name setImage:UII_name];
            
            // Actualizamos UIImage estado
            UIImage *UII_price = [UIImage imageNamed:@"mi_estado_grafico_nada_oro.png"];
            [UIIV_price setImage:UII_price];
        }
        else {
            
            // Ocultamos UIImageView
            [UIIV_name  setAlpha:0.0f];
            [UIIV_price setAlpha:0.0f];
        }
        
        // Recuperamos valores price
        CGFloat CGF_pricemin = [UMC_membership.NSS_membershippricemin floatValue];
        CGFloat CGF_pricemax = [UMC_membership.NSS_membershippricemax floatValue];
        CGFloat CGF_accumulated = UMC_membership.CGF_priceaccumulated;
        
        // Calculamos la posición 
        CGFloat CGF_pos_x = 28.0f + (218.0f * (CGF_accumulated - CGF_pricemin))/(CGF_pricemax - CGF_pricemin);
        
        // Mostramos UIimageView
        [UIIV_accumulated setAlpha:1.0f];
        
        // Posicionamos al principio la UIimageView
        [UIIV_accumulated setFrame:CGRectMake(28.0f, UIIV_accumulated.frame.origin.y, UIIV_accumulated.frame.size.width, UIIV_accumulated.frame.size.height)];
        
        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_MI_ESTADO_ACCUMULATED_DURATION_];
        
        // Reposicionamos los View
        [UIIV_accumulated setFrame:CGRectMake(CGF_pos_x, UIIV_accumulated.frame.origin.y, UIIV_accumulated.frame.size.width, UIIV_accumulated.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
    
    // Abrimos Offers
    [self loadOffers];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    // Actualizamos los datos
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: Customize the number of rows in the table view.
//#
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Actualizamos el valor dependiendo que datos se muestren en la lista
    return [globalVar.UC_user.NSMA_offers count];
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
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: Customize the appearance of table view cells.
//#
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Recuperamos el CategoryClass de la celda
    UserOfferClass *UOC_offer = [globalVar.UC_user.NSMA_offers objectAtIndex:indexPath.row];
    
    // Creamos el Cell View Controller
    _CUITVCMS_cell = [[CustomUITableViewCellMiEstado alloc] initWithFrame:CGRectZero];
    
    // Asignamos delegados
    [_CUITVCMS_cell setDelegate:self];
    
    // Iniciamos el Cell View Controller
    [_CUITVCMS_cell setContentWith:UOC_offer];
    
    // La añadimos a la lista de cells
    [NSMA_cells addObject:_CUITVCMS_cell];
    
    return _CUITVCMS_cell;
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
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : cellTouched
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cellTouched:(UserOfferClass *)UOC_offer {
    
}


@end
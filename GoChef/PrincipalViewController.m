//
//  PrincipalViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "PrincipalViewController.h"
#import "LoadingViewController.h"
#import "JSONparseClass.h"


@implementation PrincipalViewController

@synthesize UIIV_logo;
@synthesize UIIV_menus;
@synthesize UIB_en_mesa;
@synthesize UISV_scroll;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos  Topbar Logo
    UIImage *UII_logo = [UIImage imageNamed:@"topbar_logo.png"];
    UIIV_logo = [[UIImageView alloc] initWithImage:UII_logo];
    [UIIV_logo setFrame:CGRectMake(66.0f, 0.0f, UIIV_logo.frame.size.width, UIIV_logo.frame.size.height)];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];

    // Comprobamos si el "En mesa" debe estar activo
    if (globalVar.B_active_en_mesa) {
        
        // Activamos UIButton
        [UIB_en_mesa setEnabled:TRUE];
        
        // Creamos UIImage
        UIImage *UII_menus = [UIImage imageNamed:@"principal_menus_en_mesa_active.png"];
        
        // Actualizamos UIImageView menus
        [UIIV_menus setImage:UII_menus];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el Topbar Logo
    [self.navigationController.view addSubview:UIIV_logo];
    
    // Iniciamos ScrollView
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, UISV_scroll.frame.size.height+4)];
    [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, (UISV_scroll.frame.size.height+5))];
    
    //check for devolutions
    if ([globalVar B_usuario_registrado]){
        [globalVar.JPC_json UMNI_getOrdersDevolution];
    }
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Quiamos el Topbar Logo
    [UIIV_logo removeFromSuperview];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_rightContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_help = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, 39)];
    [UIB_help setImage:[UIImage imageNamed:@"topbar_button_help_normal.png"] forState:UIControlStateNormal];
    [UIB_help setImage:[UIImage imageNamed:@"topbar_button_help_select.png"] forState:UIControlStateHighlighted];
    [UIB_help addTarget:self action:@selector(goHelpTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_rightContainer addSubview:UIB_help];
    
    // Adaptamos tamaño de la UIView
    [UIV_rightContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 40.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_rightItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_rightContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.rightBarButtonItem = UIBBI_rightItems;
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_settings = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 60, 39)];
    [UIB_settings setImage:[UIImage imageNamed:@"topbar_button_settings_normal.png"] forState:UIControlStateNormal];
    [UIB_settings setImage:[UIImage imageNamed:@"topbar_button_settings_select.png"] forState:UIControlStateHighlighted];
    [UIB_settings addTarget:self action:@selector(goSettingsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_leftContainer addSubview:UIB_settings];
    
    // Adaptamos tamaño de la UIView
    [UIV_leftContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 40.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_leftItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_leftContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.leftBarButtonItem = UIBBI_leftItems;
    
    // Ocultamos Back button
    [self.navigationItem hidesBackButton];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goHelpTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goHelpTapped:(id)sender  {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_help_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goSettingsTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goSettingsTapped:(id)sender  {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_settings_Touched];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_restaurante_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_restaurante_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_pedir_restaurante_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_antes_llegar_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_antes_llegar_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_pedir_antes_llegar_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pedir_domicilio_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_domicilio_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_pedir_domicilio_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_recoger_comida_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_recoger_comida_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_recoger_comida_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_reservar_mesa_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_reservar_mesa_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate UIB_reservar_mesa_Touched];
}


@end
//
//  MiCuentaContenedorViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "MiCuentaContenedorViewController.h"
#import "LoadingViewController.h"
#import "MiCuentaEditarCuentaViewController.h"
#import "MiCuentaRegistroLoginViewController.h"


@implementation MiCuentaContenedorViewController

@synthesize UISV_scroll;

@synthesize MCECVC_editar_cuenta  = _MCECVC_editar_cuenta;
@synthesize MCRLVC_registro_login = _MCRLVC_registro_login;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCECVC_editar_cuenta
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCECVC_editar_cuenta:(MiCuentaEditarCuentaViewController *)MCECVC_editar_cuenta {
    
    _MCECVC_editar_cuenta = MCECVC_editar_cuenta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMCRLVC_registro_login
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setMCRLVC_registro_login:(MiCuentaRegistroLoginViewController *)MCRLVC_registro_login {
    
    _MCRLVC_registro_login = MCRLVC_registro_login;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Iniciamos propiedad global
    [globalVar setB_realizando_pedido:FALSE];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Mi Cuenta";
    
    // Quitamos los UIView
    if (_MCECVC_editar_cuenta  != nil) [_MCECVC_editar_cuenta.view  removeFromSuperview];
    if (_MCRLVC_registro_login != nil) [_MCRLVC_registro_login.view removeFromSuperview];
    
    // Actualizamso UIScrollView
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, UISV_scroll.frame.size.width, UISV_scroll.frame.size.height)];
    
    // Comprobamos si el usuario esta registrado
    if (globalVar.B_usuario_registrado) {
        
        // Creamos View Controller
        _MCECVC_editar_cuenta = [[MiCuentaEditarCuentaViewController alloc] initWithNibName:@"MiCuentaEditarCuentaView" bundle:[NSBundle mainBundle]];
        
        // Insertamos UIView
        [UISV_scroll addSubview:_MCECVC_editar_cuenta.view];
        
        // Posicionamos UIView
        [_MCECVC_editar_cuenta.view setFrame:CGRectMake(0.0f, 0.0f, _MCECVC_editar_cuenta.view.frame.size.width, _MCECVC_editar_cuenta.view.frame.size.height)];
        
        // Actualizamso UIScrollView
        [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, 472.0f)];
    }
    else {
        
        // Creamos View Controller
        _MCRLVC_registro_login = [[MiCuentaRegistroLoginViewController alloc] initWithNibName:@"MiCuentaRegistroLoginView" bundle:[NSBundle mainBundle]];
        
        // Insertamos UIView
        [UISV_scroll addSubview:_MCRLVC_registro_login.view];
        
        // Posicionamos UIView
        [_MCRLVC_registro_login.view setFrame:CGRectMake(0.0f, 0.0f, _MCRLVC_registro_login.view.frame.size.width, _MCRLVC_registro_login.view.frame.size.height)];
        
        // Actualizamso UIScrollView
        [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, _MCRLVC_registro_login.view.frame.size.height)];
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
    
    // Generamos la notificación que indica que se ha de ir a la Navigation Principal
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GO_PRINCIPAL_ 
                                                        object:self];
}


@end
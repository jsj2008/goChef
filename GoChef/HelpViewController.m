//
//  HelpViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "HelpViewController.h"
#import "LoadingViewController.h"


@implementation HelpViewController

@synthesize UIB_domicilio;
@synthesize UIB_restaurante;
@synthesize UIB_antes_llegar;
@synthesize UIB_accion;
@synthesize UIIV_text;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos Barra
    [UIB_domicilio    setSelected:FALSE];
    //[UIB_restaurante  setSelected:TRUE];
    [UIB_antes_llegar setSelected:TRUE];
    
    // Iniciamos UIImageView
    UIImage *UII_text = [UIImage imageNamed:@"ayuda_antes_llegar_text.png"];
    [UIIV_text setImage:UII_text];
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
	self.navigationItem.title = @"Cómo funciona";
    
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

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_accion_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_accion_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) {
    
        if      (UIB_domicilio.selected)    [_delegate UIB_pedir_domicilio_withoutDelay_Touched];
        else if (UIB_restaurante.selected)  [_delegate UIB_pedir_restaurante_withoutDelay_Touched];
        else if (UIB_antes_llegar.selected) [_delegate UIB_pedir_antes_llegar_withoutDelay_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_domicilio_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_domicilio_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    [UIB_domicilio    setSelected:TRUE];
    [UIB_restaurante  setSelected:FALSE];
    [UIB_antes_llegar setSelected:FALSE];
    
    // Creamos la UIImage que debemos mostrar
    UIImage *UII_button = [UIImage imageNamed:@"button_a_domicilio.png"];
    
    // Actualizamos UIImageView
    [UIB_accion setImage:UII_button forState:UIControlStateNormal];
    
    // Actualizamos UIImageView Text
    UIImage *UII_text = [UIImage imageNamed:@"ayuda_a_domicilio_text.png"];
    [UIIV_text setImage:UII_text];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_restaurante_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_restaurante_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    [UIB_domicilio    setSelected:FALSE];
    [UIB_restaurante  setSelected:TRUE];
    [UIB_antes_llegar setSelected:FALSE];
    
    // Creamos la UIImage que debemos mostrar
    UIImage *UII_button = [UIImage imageNamed:@"button_en_el _restaurante.png"];
    
    // Actualizamos UIImageView
    [UIB_accion setImage:UII_button forState:UIControlStateNormal];
    
    // Actualizamos UIImageView Text
    UIImage *UII_text = [UIImage imageNamed:@"ayuda_en_restaurante_text.png"];
    [UIIV_text setImage:UII_text];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_antes_llegar_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_antes_llegar_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    [UIB_domicilio    setSelected:FALSE];
    [UIB_restaurante  setSelected:FALSE];
    [UIB_antes_llegar setSelected:TRUE];
    
    // Creamos la UIImage que debemos mostrar
    UIImage *UII_button = [UIImage imageNamed:@"button_ante_llegar.png"];
    
    // Actualizamos UIImageView
    [UIB_accion setImage:UII_button forState:UIControlStateNormal];
    
    // Actualizamos UIImageView Text
    UIImage *UII_text = [UIImage imageNamed:@"ayuda_antes_llegar_text.png"];
    [UIIV_text setImage:UII_text];
}


@end
//
//  OpcionesSugerenciaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "OpcionesSugerenciaViewController.h"
#import "LoadingViewController.h"

#import "MensajeClass.h"


@implementation OpcionesSugerenciaViewController

@synthesize UITV_text;
@synthesize UIV_contenido;

@synthesize B_enviar = _B_enviar;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_enviar
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_enviar:(BOOL)B_enviar {
    
    _B_enviar = B_enviar;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Insertamos UIView en el UIScrollView
    [self.view addSubview:UIV_contenido];
    
    // Posicionamos UIVew
    [UIV_contenido setFrame:CGRectMake(0.0f, 0.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Sugerencias";
    
    // Iniciamos propiedad
    [self setB_enviar:TRUE];
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
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
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
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Actualizamos propiedad
    [self setB_enviar:FALSE];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Keyboard Notifications Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidShow
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    
    // Posicionamos UIVew
    [UIV_contenido setFrame:CGRectMake(0.0f, -70.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Ajecutamos animación
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidHide:(NSNotification *) notification {
    
    // Iniciamos animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_ANIMATION_SHOW_KEYBOARD_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Posicionamos UIVew
    [UIV_contenido setFrame:CGRectMake(0.0f, 0.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Ajecutamos animación
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos si debemos realizar la operación
    if (_B_enviar) {
        
        // Creamos el MensajeClass
        globalVar.MC_mensaje = [[MensajeClass alloc] init];
        
        // Iniciamos propiedades
        [globalVar.MC_mensaje setNSS_description:UITV_text.text];
        [globalVar.MC_mensaje setTMT_type:TMT_sugerencia];
        
        // Realizamos llamada el servidor
        [self setsuggestionsproblems];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuario
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setsuggestionsproblems {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_MENSAJE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_MENSAJE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_MENSAJE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(setsuggestionsproblemsSuccessful:) 
                                                 name: _NOTIFICATION_SET_MENSAJE_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_MENSAJE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_MENSAJE_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading setsuggestionsproblems];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setsuggestionsproblemsSuccessful
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setsuggestionsproblemsSuccessful:(NSNotification *)notification {
    
    // Borramos conenido UITextView
    [UITV_text setText:@""];
    
    // Mostramos mensaje OK
    [globalVar showAlerMsgWith:@"Información"
                       message:@"El mensaje ha sido enviado correctamente. Muchas gracias por su aporte."];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_enviar_TouchUpInside
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_enviar_TouchUpInside:(id)sender {
    
    // Comprobamos el tamaño del texto
    if ([UITV_text.text length] < 20) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"El texto debe ser superior a 20 caracteres"];
        return;
    }
    
    // Ocultamos teclado
    [UITV_text resignFirstResponder];
}


@end
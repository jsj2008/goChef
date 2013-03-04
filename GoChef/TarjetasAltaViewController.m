//
//  TarjetasAltaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TarjetasAltaViewController.h"
#import "LoadingViewController.h"

#import "TarjetaClass.h"
#import "OrderClass.h"
#import "UserClass.h"
#import "CoreDataClass.h"


@implementation TarjetasAltaViewController

@synthesize NSD_fecha_caducidad = _NSD_fecha_caducidad;

@synthesize UITF_nombre;
@synthesize UITF_numero;
@synthesize UITF_fecha_caducidad;
@synthesize UITF_cvv;
@synthesize UIL_tipo_tarjeta;
@synthesize UIV_formulairo;

@synthesize STTVC_tipo_tarjeta = _STTVC_tipo_tarjeta;
@synthesize SFVC_fecha_caducidad = _SFVC_fecha_caducidad;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSD_fecha_caducidad
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSD_fecha_caducidad:(NSDate *)NSD_fecha_caducidad {
    
    _NSD_fecha_caducidad = NSD_fecha_caducidad;
    
    // Actualizamos UILT fecha caducidad
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    [NSDF_date setDateFormat:@"MMMM ' de ' yyyy"];
    NSString *NSS_date = [NSDF_date stringFromDate:_NSD_fecha_caducidad];
    [UITF_fecha_caducidad setText:NSS_date];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSTTVC_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 09/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTTVC_tipo_tarjeta:(SelectTipoTarjetaViewController *)STTVC_tipo_tarjeta {
    
    _STTVC_tipo_tarjeta = STTVC_tipo_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSFVC_fecha_caducidad
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSFVC_fecha_caducidad:(SelectMonthYearViewController *)SFVC_fecha_caducidad {
    
    _SFVC_fecha_caducidad = SFVC_fecha_caducidad;
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
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Insertamos UIView formulario en la View general
    [self.view addSubview:UIV_formulairo];
    
    // Posisiocnamos loa UIView Formulario
    [UIV_formulairo setFrame:CGRectMake(0.0f, 0.0f, UIV_formulairo.frame.size.width, UIV_formulairo.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Alta Tarjeta";
    
    // Mostramos el teclado
    [UITF_nombre becomeFirstResponder];
    
    // Comprobamos si es una modificacion
    if (globalVar.TC_creditcard != nil) {
        
        // Actualizamos los campos del formulario
        [UIL_tipo_tarjeta setText:globalVar.TC_creditcard.NSS_type];
        [UITF_nombre      setText:globalVar.TC_creditcard.NSS_name];
        [UITF_numero      setText:globalVar.TC_creditcard.NSS_number];
        [UITF_cvv         setText:globalVar.TC_creditcard.NSS_cvv];
        
        // Actualizsmo fecha
        [self setNSD_fecha_caducidad:globalVar.TC_creditcard.NSD_date_expiration];
    }
    else {

        // Comprobamos si ha introducido el nombre
        if ([globalVar.UC_user.NSS_name length] > 0) {
         
            // Comprobamos si ha introducir los pellidos
            if ([globalVar.UC_user.NSS_lastname length] > 0) [UITF_nombre setText:[NSString stringWithFormat:@"%@ %@", globalVar.UC_user.NSS_name, globalVar.UC_user.NSS_lastname]];
            else [UITF_nombre setText:[NSString stringWithFormat:@"%@", globalVar.UC_user.NSS_name]];
        }
        else [UITF_nombre setText:@""];
        
        // Actualizamos el resto de campos del formulario
        [UITF_numero setText:@""];
        [UITF_cvv    setText:@""];
        
        // Actualizamos fecha
        [self setNSD_fecha_caducidad:[NSDate date]];
        
        // Quitamos el texto de UITextField fecha caducidad
        [UITF_fecha_caducidad setText:@""];
    }
    
    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
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

#pragma mark -
#pragma mark Keyboard Notifications Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 27/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    // Comprobamos si hay que ocultar alguno de los listados
    if (_STTVC_tipo_tarjeta != nil) {
     
        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        // Reposicionamos los View
        [_STTVC_tipo_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STTVC_tipo_tarjeta.view.frame.size.width, _STTVC_tipo_tarjeta.view.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
    else if (_SFVC_fecha_caducidad != nil) {

        // Iniciamos animacion
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        // Reposicionamos los View
        [_SFVC_fecha_caducidad.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_caducidad.view.frame.size.width, _SFVC_fecha_caducidad.view.frame.size.height)];
        
        // Ejecutamos animacion
        [UIView commitAnimations];
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_guardar_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_guardar_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ([UIL_tipo_tarjeta.text isEqualToString:@"Tipo de Tarjeta"]) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe seleccionar un Tipo de tarjeta"];
        
        [self UIB_select_tipo_tarjeta_TouchUpInside:nil];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ([UITF_nombre.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir su nombre"];
        
        [UITF_nombre becomeFirstResponder];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ( ([UIL_tipo_tarjeta.text isEqualToString:_CREDITCARD_VISA_TEXT_]) && ([UITF_numero.text length] != 16) ) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un número de tarjeta válido"];
        
        [UITF_numero becomeFirstResponder];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ( ([UIL_tipo_tarjeta.text isEqualToString:_CREDITCARD_MASTERCARD_TEXT_]) && ([UITF_numero.text length] != 16) ) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un número de tarjeta válido"];
        
        [UITF_numero becomeFirstResponder];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ([UITF_fecha_caducidad.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir la fecha de caducidad de la tarjeta"];
        
        [UITF_fecha_caducidad becomeFirstResponder];
        [self UIB_select_fecha_caducidad_TouchUpInside:nil];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ( ([UIL_tipo_tarjeta.text isEqualToString:_CREDITCARD_VISA_TEXT_]) && ([UITF_cvv.text length] != 3) ) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un CVV válido"];
        
        [UITF_cvv becomeFirstResponder];
        return;
    }
    
    // Comprobamos si se ha seleccionado un tipo de tarjeta
    if ( ([UIL_tipo_tarjeta.text isEqualToString:_CREDITCARD_MASTERCARD_TEXT_]) && ([UITF_cvv.text length] != 3) ) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un CVV válido"];
        
        [UITF_cvv becomeFirstResponder];
        return;
    }
    
    // Comprobamos si es una modificacion o inserción
    if (globalVar.TC_creditcard == nil) {
        
        // Creamos la TarjetaClass
        globalVar.TC_creditcard = [[TarjetaClass alloc] init];
        
        // Asignamos nuevo id
        [globalVar.TC_creditcard setNSI_id:[globalVar newCreditCardId]];
        
        // Actualizamos datos
        [globalVar.TC_creditcard setNSS_type             : UIL_tipo_tarjeta.text];
        [globalVar.TC_creditcard setNSS_name             : UITF_nombre.text];
        [globalVar.TC_creditcard setNSS_number           : UITF_numero.text];
        [globalVar.TC_creditcard setNSD_date_expiration  : _NSD_fecha_caducidad];
        [globalVar.TC_creditcard setNSS_cvv              : UITF_cvv.text];
        
        // Comprobamos si no existen mas tarjetas -> la marcamos con default
        if ([globalVar.NSMA_tarjetas count] == 0) [globalVar.TC_creditcard setB_default:TRUE];
        
        // Insertamos Tarjeta en el Array
        [globalVar.NSMA_tarjetas addObject:globalVar.TC_creditcard];
    }
    else {
        
        // Actualizamos datos
        [globalVar.TC_creditcard setNSS_type             : UIL_tipo_tarjeta.text];
        [globalVar.TC_creditcard setNSS_name             : UITF_nombre.text];
        [globalVar.TC_creditcard setNSS_number           : UITF_numero.text];
        [globalVar.TC_creditcard setNSD_date_expiration  : _NSD_fecha_caducidad];
        [globalVar.TC_creditcard setNSS_cvv              : UITF_cvv.text];
    }
    
    // Marcamos como tarjeta seleccionada
    [globalVar.OC_order setTC_creditcard:globalVar.TC_creditcard];
    
    // Actualizamos la BB.DD
    [globalVar.CDC_coreData updateCreaditCard:globalVar.TC_creditcard];
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_tipo_tarjeta_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_tipo_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_STTVC_tipo_tarjeta != nil) || (_SFVC_fecha_caducidad != nil)) return;
    
    // Creamos SelectTipoTarjetaViewController
    _STTVC_tipo_tarjeta = [[SelectTipoTarjetaViewController alloc] initWithNibName:@"SelectTipoTarjetaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STTVC_tipo_tarjeta setDelegate:self];
    
    // Iniciamos Propiedades
    [_STTVC_tipo_tarjeta setNSS_tipo_tarjeta:UIL_tipo_tarjeta.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STTVC_tipo_tarjeta.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STTVC_tipo_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STTVC_tipo_tarjeta.view.frame.size.width, _STTVC_tipo_tarjeta.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STTVC_tipo_tarjeta.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STTVC_tipo_tarjeta.view.frame.size.height), _STTVC_tipo_tarjeta.view.frame.size.width, _STTVC_tipo_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Mostramos el teclado
    [UITF_nombre            resignFirstResponder];
    [UITF_numero            resignFirstResponder];
    [UITF_fecha_caducidad   resignFirstResponder];
    [UITF_cvv               resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_fecha_caducidad_TouchUpInside
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 09/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_fecha_caducidad_TouchUpInside:(id)sender {
    
    // Comprobamos si ya se está mostrando
    if ( (_STTVC_tipo_tarjeta != nil) || (_SFVC_fecha_caducidad != nil)) return;
    
    // Creamos SelectFechaViewController
    _SFVC_fecha_caducidad = [[SelectMonthYearViewController alloc] initWithNibName:@"SelectMonthYearView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_SFVC_fecha_caducidad setDelegate:self];
    
    // Iniciamos Propiedades
    [_SFVC_fecha_caducidad setNSD_fecha:_NSD_fecha_caducidad];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_SFVC_fecha_caducidad.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_SFVC_fecha_caducidad.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_caducidad.view.frame.size.width, _SFVC_fecha_caducidad.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_SFVC_fecha_caducidad.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _SFVC_fecha_caducidad.view.frame.size.height), _SFVC_fecha_caducidad.view.frame.size.width, _SFVC_fecha_caducidad.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Mostramos el teclado
    [UITF_nombre            resignFirstResponder];
    [UITF_numero            resignFirstResponder];
    [UITF_fecha_caducidad   resignFirstResponder];
    [UITF_cvv               resignFirstResponder];
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tipo_tarjeta:(NSString *)NSS_tipo_tarjeta {
    
    // Actualizamos UILabel
    [UIL_tipo_tarjeta setText:NSS_tipo_tarjeta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_fecha:(NSDate *)NSD_fecha {
    
    // Actualizamos fecha
    [self setNSD_fecha_caducidad:NSD_fecha];
    
    // Mostramos el teclado
    [UITF_cvv becomeFirstResponder];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_SFVC_fecha_caducidad.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _SFVC_fecha_caducidad.view.frame.size.width, _SFVC_fecha_caducidad.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_tipo_tarjeta {
    
    // Mostramos el teclado
    [UITF_nombre becomeFirstResponder];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_STTVC_tipo_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STTVC_tipo_tarjeta.view.frame.size.width, _STTVC_tipo_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Comprobamos cual es el que hay que ocultar
    if (_STTVC_tipo_tarjeta != nil) {
        
        // Quitamos el View Select Tipo Cocina
        [_STTVC_tipo_tarjeta.view removeFromSuperview];
        
        // Liberamos memoria
        _STTVC_tipo_tarjeta = nil;
    }
    else {
        
        // Quitamos el View Select Precio
        [_SFVC_fecha_caducidad.view removeFromSuperview];
        
        // Liberamos memoria
        _SFVC_fecha_caducidad = nil;
    }
}


@end
//
//  LoadingViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "LoadingViewController.h"

#import "JSONparseClass.h"
#import "CoreLocationClass.h"
#import "DireccionClass.h"
#import "UserClass.h"
#import "OrderClass.h"
#import "TarjetaClass.h"
#import "RestaurantClass.h"
#import "ImageClass.h"
#import "FacebookOfferClass.h"
#import "FoodClass.h"
#import "tpvDAO.h"

@implementation LoadingViewController

@synthesize NSS_text = _NSS_text;
@synthesize UIL_text;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_text
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_text:(NSString *)NSS_text {

    _NSS_text = NSS_text;
    
    // Actualizamos el UILabel
    [UIL_text setText:_NSS_text];
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initWithNibName:bundle:
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: viewDidLoad
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
 
    // Iniciamos las propiedades
    [self setNSS_text:_LOADING_DEFAULT_TEXT_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getGoogleMapAddress
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getGoogleMapAddress {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GOOGLE_ADDRESS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_PARSE_JSON_ object:nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(delayGetGoogleMapAddress)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayGetGoogleMapAddress
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayGetGoogleMapAddress {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Recogemos la posición actual
    CLLocation *CLL_posActual = [[CLLocation alloc] initWithLatitude:globalVar.CLC_location.CLLM_manager.location.coordinate.latitude 
                                                           longitude:globalVar.CLC_location.CLLM_manager.location.coordinate.longitude];
    
    // Obtenemos dirección actual
    DireccionClass *DC_direccion = [globalVar.JPC_json parseGoogleMapAddressWith:CLL_posActual];
    
    // Actualizamos propiedad global
    [globalVar.OC_order setDC_useraddress:DC_direccion];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GOOGLE_ADDRESS_SUCCESSFUL_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadTiposCocina {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_TIPOS_COCINA_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(parseLoadTiposCocinaSuccessful:) 
                                                     name: _NOTIFICATION_TIPOS_COCINA_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(delayLoadTiposCocina)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayLoadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayLoadTiposCocina {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getRestauranttype];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : parseLoadTiposCocinaSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) parseLoadTiposCocinaSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_ 
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDirecciones
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDirecciones {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DIRECCIONES_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DIRECCIONES_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(parseLoadDireccionesSuccessful:) 
                                                     name: _NOTIFICATION_DIRECCIONES_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(delayLoadDirecciones)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayLoadDirecciones
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayLoadDirecciones {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getUseraddress];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : parseLoadDireccionesSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) parseLoadDireccionesSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DIRECCIONES_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestaurantes
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestaurantes {
    
    // Mostramos el View
    if (globalVar.NSI_numRecordBlock == (_NUM_RECORD_BLOCK_INIT_+1)) [self.view setAlpha:1.0f];
    else [self.view setAlpha:0.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTES_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTES_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(parseLoadRestaurantesSuccessful:) 
                                                     name: _NOTIFICATION_RESTAURANTES_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(delayLoadRestaurantes)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayLoadRestaurantes
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayLoadRestaurantes {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getRestaurants:globalVar.B_cargar_imagenes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : parseLoadRestaurantesSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) parseLoadRestaurantesSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTES_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestaurante
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestaurante {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTE_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_RESTAURANTE_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadRestauranteSuccessful:) 
                                                     name: _NOTIFICATION_RESTAURANTE_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadRestauranteDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadRestauranteDelay
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getRestaurant:globalVar.OC_order.NSI_idrestaurant images:globalVar.B_cargar_imagenes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadRestauranteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadRestauranteSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_RESTAURANTE_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadUsuario
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuario {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(parseLoadUsuarioSuccessful:) 
                                                     name: _NOTIFICATION_USER_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(delayLoadUsuario)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: delayLoadUsuario
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) delayLoadUsuario {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getUser];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : parseLoadUsuarioSuccessful
//#	Fecha Creación	: 19/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 19/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) parseLoadUsuarioSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_SUCCESSFUL_
                                                        object:self];
    
    //check for devolutions
    if ([globalVar B_usuario_registrado]){
        [globalVar.JPC_json UMNI_getOrdersDevolution];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setsuggestionsproblems
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setsuggestionsproblems {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_MENSAJE_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(setsuggestionsproblemsSuccessful:) 
                                                     name: _NOTIFICATION_SET_MENSAJE_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(setsuggestionsproblemsDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: setsuggestionsproblemsDelay
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setsuggestionsproblemsDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setSuggestionsproblems:globalVar.MC_mensaje];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setsuggestionsproblemsSuccessful
//#	Fecha Creación	: 20/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setsuggestionsproblemsSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_MENSAJE_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUser {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(setUserSuccessful:) 
                                                     name: _NOTIFICATION_SET_USER_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(setUserDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: setUserDelay
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUserDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setUser:globalVar.UC_user update:FALSE changePassword:globalVar.B_change_password];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setUserSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUserSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUser {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(updateUserSuccessful:) 
                                                     name: _NOTIFICATION_SET_USER_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(updateUserDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUserDelay
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUserDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setUser:globalVar.UC_user update:TRUE changePassword:globalVar.B_change_password];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateUserSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUserSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_USER_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUser {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_USER_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loginUserSuccessful:) 
                                                     name: _NOTIFICATION_VALIDATE_USER_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loginUserDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loginUserDelay
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUserDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_validateLogin:globalVar.UC_user];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loginUserSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loginUserSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_USER_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : recordarPassword
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recordarPassword {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMEMBER_PASSWORD_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(recordarPasswordSuccessful:) 
                                                     name: _NOTIFICATION_REMEMBER_PASSWORD_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(recordarPasswordDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: recordarPasswordDelay
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recordarPasswordDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_rememberPassword:globalVar.UC_user.NSS_email];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : recordarPasswordSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) recordarPasswordSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMEMBER_PASSWORD_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeUser {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_USER_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(removeUserSuccessful:) 
                                                     name: _NOTIFICATION_REMOVE_USER_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(removeUserDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: removeUserDelay
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeUserDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_deleteUser:globalVar.UC_user.NSI_id];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeUserSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) removeUserSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_USER_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : comprobarCorreo
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) comprobarCorreo {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_EMAIL_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(comprobarCorreoSuccessful:) 
                                                     name: _NOTIFICATION_VALIDATE_EMAIL_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(comprobarCorreoUserDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: comprobarCorreoUserDelay
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 14/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) comprobarCorreoUserDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_validateEmail:globalVar.UC_user.NSS_email type:globalVar.UC_user.TRT_type];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : comprobarCorreoSuccessful
//#	Fecha Creación	: 22/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) comprobarCorreoSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_EMAIL_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoods
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoods {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadFoodsSuccessful:) 
                                                     name: _NOTIFICATION_FOOD_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodsDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodsDelay
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodsDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFoods];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsSuccessful
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodsSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodCategories
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategories {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_CATEGORIES_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_CATEGORIES_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadFoodCategoriesSuccessful:) 
                                                     name: _NOTIFICATION_FOOD_CATEGORIES_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodCategoriesDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodCategoriesDelay
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategoriesDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFoodCategories:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodCategoriesSuccessful
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadFoodCategoriesSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_CATEGORIES_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenus
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenus {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadDailymenusSuccessful:) 
                                                     name: _NOTIFICATION_DAILY_MENU_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadDailymenusDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadDailymenusDelay
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenusDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getDailymenu];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusSuccessful
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadDailymenusSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadDailymenusCategories
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategories {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_CATEGORIES_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_DAILY_MENU_CATEGORIES_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadDailymenusCategoriesSuccessful:)
                                                     name: _NOTIFICATION_DAILY_MENU_CATEGORIES_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadDailymenusCategoriesDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadDailymenusCategoriesDelay
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategoriesDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFoodCategories:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadDailymenusCategoriesSuccessful
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadDailymenusCategoriesSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_DAILY_MENU_CATEGORIES_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOffers
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffers {
    
    // Mostramos el View
    if (globalVar.NSI_numRecordBlock == _NUM_RECORD_BLOCK_INIT_) [self.view setAlpha:1.0f];
    else [self.view setAlpha:0.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_OFFERS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_OFFERS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadOffersSuccessful:) 
                                                     name: _NOTIFICATION_OFFERS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadOffersDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOffersDelay
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 09/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getOffers:globalVar.B_cargar_imagenes idrestaurant:globalVar.OC_order.NSI_idrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOffersSuccessful
//#	Fecha Creación	: 24/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOffersSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_OFFERS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrders
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrders {
    
    // Mostramos el View
    if (globalVar.NSI_numRecordBlock == _NUM_RECORD_BLOCK_INIT_) [self.view setAlpha:1.0f];
    else [self.view setAlpha:0.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDERS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadOrdersSuccessful:) 
                                                     name: _NOTIFICATION_ORDERS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadOrdersDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOrdersDelay
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrdersDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getOrders:globalVar.B_cargar_imagenes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrdersSuccessful
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrdersSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDERS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOrdersDelay
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDireccion {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ADDRESS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(setDireccionSuccessful:) 
                                                     name: _NOTIFICATION_SET_ADDRESS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(setDireccionDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: setDireccionDelay
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDireccionDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setUseraddress:globalVar.OC_order.DC_useraddress update:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setDireccionSuccessful
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDireccionSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ADDRESS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOrdersDelay
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateDireccion {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {

        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_UPDATE_ADDRESS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(updateDireccionSuccessful:) 
                                                     name: _NOTIFICATION_UPDATE_ADDRESS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(updateDireccionDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateDireccionDelay
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateDireccionDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setUseraddress:globalVar.OC_order.DC_useraddress update:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateDireccionSuccessful
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateDireccionSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_UPDATE_ADDRESS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: removeDireccion
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeDireccion {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_REMOVE_ADDRESS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(removeDireccionSuccessful:)
                                                     name: _NOTIFICATION_REMOVE_ADDRESS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(removeDireccionDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: removeDireccionDelay
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeDireccionDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_deleteUseraddress:globalVar.DC_direccion.NSI_id];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : removeDireccionSuccessful
//#	Fecha Creación	: 23/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeDireccionSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_REMOVE_ADDRESS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: setOrder
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOrder {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tpvOkNotification" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tpvFailNotification" object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_PARSE_JSON_ object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ORDERS_ERROR_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(setOrderSuccessful:) name: _NOTIFICATION_SET_ORDERS_PARSE_JSON_ object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(setOrderFail:) name: _NOTIFICATION_SET_ORDERS_ERROR_ object: nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPaymentOk) name:@"tpvOkNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPaymentFail) name:@"tpvFailNotification" object:nil];
                
        
        if (globalVar.OC_order.TOT_type == TOT_reserva || [globalVar.OC_order.NSS_payment_type isEqualToString:@""]) {
            [globalVar.JPC_json UMNI_setOrder:globalVar.OC_order];
        } else {
            
            // Formateamos los datos para el pago por tpv
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            //expiration date format
            [formatter setDateFormat:@"yyMM"];
            NSString *expDate = [formatter stringFromDate:globalVar.OC_order.TC_creditcard.NSD_date_expiration];
            
            //order id with timestamp + id user
            [formatter setDateFormat:@"MMddHHmm"];
            NSString *timeStamp = [[formatter stringFromDate:[NSDate date]] stringByAppendingFormat:@"%d",globalVar.UC_user.NSI_id];
            
            // amount format
            int amount = [[NSNumber numberWithFloat:globalVar.OC_order.CGF_total*100] intValue];
            
            // Realizamos el pago por tpv
            [[tpvDAO sharedInstance] requestPaymentWithCard:globalVar.OC_order.TC_creditcard.NSS_number expiration:expDate amount:amount order:timeStamp andCVV2:globalVar.OC_order.TC_creditcard.NSS_cvv];
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setOrderSuccessful
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOrderSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    if (globalVar.OC_order.TOT_type == TOT_reserva || [globalVar.OC_order.NSS_payment_type isEqualToString:@""]) {
        // Generamos la notificación que indica que los datos se han cargado correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_SUCCESSFUL_
                                                            object:self];
    } else {
    
        if (globalVar.OC_order.TOS_status == TOS_cobro_fallido) {
            
            [globalVar showAlerMsgWith:_ALERT_TITLE_TPV_ message:globalVar.NSS_msg_error];
            
        } else if (globalVar.OC_order.TOS_status == TOS_pagado_con_tarjeta){
            
            // Generamos la notificación que indica que los datos se han cargado correctamente
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_SUCCESSFUL_
                                                                object:self];
        }
    }
}

-(void) setOrderFail:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    if (globalVar.OC_order.TOT_type == TOT_reserva || [globalVar.OC_order.NSS_payment_type isEqualToString:@""]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_ORDERS_ERROR_
                                                            object:self];
    } else {
        [globalVar showAlerMsgWith:_ALERT_TITLE_TPV_ message:globalVar.NSS_msg_error];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: requestPaymentOk
//#	Fecha Creación	: 30/05/2012  (iMario)
//#	Fecha Ult. Mod.	: 30/05/2012  (iMario)
//# Descripción		:
//#
-(void) requestPaymentOk {
    
    [globalVar.OC_order setTOS_status:TOS_pagado_con_tarjeta];
    [globalVar.JPC_json UMNI_setOrder:globalVar.OC_order];
}

-(void) requestPaymentFail{
    
    if (globalVar.OC_order.TOS_status != TOS_cobro_fallido) {
        // retry
        [[[UIAlertView alloc] initWithTitle:_ALERT_TITLE_TPV_ message:globalVar.NSS_msg_error delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Reintentar", nil] show];
    } else {
        
        [globalVar.JPC_json UMNI_setOrder:globalVar.OC_order];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mailOrderticket
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mailOrderticket {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_TICKET_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(mailOrderticketSuccessful:) 
                                                     name: _NOTIFICATION_SEND_ORDER_TICKET_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(mailOrderticketDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: mailOrderticketDelay
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mailOrderticketDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_sendOrderticket];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mailOrderticketSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mailOrderticketSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_TICKET_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : valueRestaurant
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) valueRestaurant {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(valueRestaurantSuccessful:) 
                                                     name: _NOTIFICATION_FAVORITES_STARS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(valueRestaurantDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: valueRestaurantDelay
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) valueRestaurantDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setRestaurantStarsfavorites:globalVar.OC_order.RC_restaurant.NSI_idrestaurant 
                                                    type:globalVar.B_valueFavoritos 
                                                   value:globalVar.NSI_value];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : valueRestaurantSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) valueRestaurantSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavorite
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavorite {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FAVORITES_STARS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(changeFavoriteSuccessful:) 
                                                     name: _NOTIFICATION_FAVORITES_STARS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(changeFavoriteDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: changeFavoriteDelay
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavoriteDelay {
    
    // Comprobamos si estamos en cocina
    if (!globalVar.B_pedido_en_cocina) {

        // Recuperamos la información del servidor y la cargamos en memoria
        [globalVar.JPC_json UMNI_setRestaurantStarsfavorites:globalVar.OC_order.RC_restaurant.NSI_idrestaurant 
                                                        type:globalVar.B_valueFavoritos 
                                                       value:globalVar.NSI_value];
    }
    else {
        
        // Recuperamos la información del servidor y la cargamos en memoria
        [globalVar.JPC_json UMNI_setRestaurantStarsfavorites:globalVar.OC_order_en_cocina.RC_restaurant.NSI_idrestaurant 
                                                        type:globalVar.B_valueFavoritos 
                                                       value:globalVar.NSI_value];

    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeFavoriteSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeFavoriteSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkTableNumber
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumber {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_TABLE_NUMBER_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(checkTableNumberSuccessful:) 
                                                     name: _NOTIFICATION_VALIDATE_TABLE_NUMBER_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkTableNumberDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkTableNumberDelay
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumberDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_validateTablenumber:globalVar.OC_order.RC_restaurant.NSI_idrestaurant code:globalVar.OC_order.NSI_number_table];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkTableNumberSuccessful
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkTableNumberSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedirCuenta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedirCuenta {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(pedirCuentaSuccessful:) 
                                                     name: _NOTIFICATION_CHECK_OUT_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(pedirCuentaDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pedirCuentaDelay
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedirCuentaDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setCheckout:globalVar.OC_order_en_cocina type:TCO_solicitud_de_cuenta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pedirCuentaSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedirCuentaSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pagarConTarjeta
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pagarConTarjeta {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_CHECK_OUT_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(pagarConTarjetaSuccessful:)
                                                     name: _NOTIFICATION_CHECK_OUT_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(pagarConTarjetaDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pagarConTarjetaDelay
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		:
//#
-(void) pagarConTarjetaDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_setCheckout:globalVar.OC_order_en_cocina type:TCO_pago_con_tarjeta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pagarConTarjetaSuccessful
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		:
//#
-(void) pagarConTarjetaSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_CHECK_OUT_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getImage
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getImage {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(getImageSuccessful:) 
                                                     name: _NOTIFICATION_IMAGE_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(getImageDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getImageDelay
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getImageDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getImage:globalVar.IC_image objectId:globalVar.OC_order.RC_restaurant.NSI_idrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getImageSuccessful
//#	Fecha Creación	: 20/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getImageSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_IMAGE_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuarioMembership
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuarioMembership {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_MEMBERSHIP_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_USER_MEMBERSHIP_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadUsuarioMembershipSuccessful:) 
                                                     name: _NOTIFICATION_USER_MEMBERSHIP_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadUsuarioMembershipDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadUsuarioMembershipDelay
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuarioMembershipDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getUsermembership:globalVar.OC_order.RC_restaurant.NSI_idrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadUsuarioMembershipSuccessful
//#	Fecha Creación	: 21/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadUsuarioMembershipSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_USER_MEMBERSHIP_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getFacebookOffer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getFacebookOffer {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GET_FACEBOOK_OFFERS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_GET_FACEBOOK_OFFERS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(getFacebookOfferSuccessful:) 
                                                     name: _NOTIFICATION_GET_FACEBOOK_OFFERS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(getFacebookOfferDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getFacebookOfferDelay
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getFacebookOfferDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFacebookOffer:globalVar.OC_order.FC_facebook_offer 
                                   restaurant:globalVar.OC_order.RC_restaurant.NSI_idrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_GET_FACEBOOK_OFFERS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadUsuarioMembershipDelay
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOffer {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_FACEBOOK_OFFERS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_FACEBOOK_OFFERS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(setFacebookOfferSuccessful:) 
                                                     name: _NOTIFICATION_SET_FACEBOOK_OFFERS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(setFacebookOfferDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: setFacebookOfferDelay
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferDelay {
    
    // Comprobamos si estamos en cocina
    if (!globalVar.B_pedido_en_cocina) {

        // Recuperamos la información del servidor y la cargamos en memoria
        [globalVar.JPC_json UMNI_setFacebookOffer:globalVar.OC_order.FC_facebook_offer];
    }
    else {
        
        // Recuperamos la información del servidor y la cargamos en memoria
        [globalVar.JPC_json UMNI_setFacebookOffer:globalVar.OC_order_en_cocina.FC_facebook_offer];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setFacebookOfferSuccessful
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFacebookOfferSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SET_FACEBOOK_OFFERS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOrderFood
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFood {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDER_FOOD_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_ORDER_FOOD_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(loadOrderFoodSuccessful:) 
                                                     name: _NOTIFICATION_ORDER_FOOD_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadOrderFoodDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadOrderFoodDelay
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFoodDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getOrderfood:globalVar.OC_order images:globalVar.B_cargar_imagenes];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadOrderFoodSuccessful
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadOrderFoodSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ORDER_FOOD_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkAddress
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddress {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_NO_INTERNET_ 
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_VALIDATE_ADDRESS_PARSE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(checkAddressSuccessful:) 
                                                     name: _NOTIFICATION_VALIDATE_ADDRESS_PARSE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkAddressDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkAddressDelay
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddressDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getRestaurantpostalcode:globalVar.OC_order.NSI_idrestaurant address:globalVar.OC_order.NSI_iduseraddress];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkAddressSuccessful
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) checkAddressSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Generamos la notificación que indica que los datos se han cargado correctamente
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_VALIDATE_ADDRESS_SUCCESSFUL_
                                                        object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkFidelizacion
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacion {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_MEMBERSHIPVALIDATE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(checkFidelizacionSuccessful:)
                                                     name: _NOTIFICATION_MEMBERSHIPVALIDATE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkFidelizacionDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkFidelizacionDelay
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacionDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getmembershipvalidate:globalVar.OC_order.NSI_idrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkFidelizacionSuccessful
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacionSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    if (globalVar.B_restaurante_con_fidelizacion) [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_SUCCESSFUL_ object:self];
    else [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_MEMBERSHIPVALIDATE_NO_ALLOWED_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkActiveEnMesa
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkActiveEnMesa {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_EN_MESA_ACTIVE_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_EN_MESA_ACTIVE_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(checkActiveEnMesaSuccessful:)
                                                     name: _NOTIFICATION_EN_MESA_ACTIVE_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkActiveEnMesaDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkActiveEnMesaDelay
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkActiveEnMesaDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_activeenrestaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkActiveEnMesaSuccessful
//#	Fecha Creación	: 15/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkActiveEnMesaSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_EN_MESA_ACTIVE_SUCCESSFUL_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkNewOrders
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNewOrders {
    
    // Mostramos el View
    //[self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_NEW_ORDERS_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_NEW_ORDERS_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(checkNewOrdersSuccessful:)
                                                     name: _NOTIFICATION_NUM_NEW_ORDERS_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkNewOrdersDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkNewOrdersDelay
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNewOrdersDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getordersnew];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNewOrdersSuccessful
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNewOrdersSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    //[self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_NEW_ORDERS_SUCCESSFUL_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodsOptionsObligatory
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsObligatory {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadFoodsOptionsObligatorySuccessful:)
                                                     name: _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodsOptionsObligatoryDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodsOptionsObligatoryDelay
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsObligatoryDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFoodOptions:globalVar.FC_food obligatory:TRUE images:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsObligatorySuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsObligatorySuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsNoObligatory
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsNoObligatory {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadFoodsOptionsNoObligatorySuccessful:)
                                                     name: _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(loadFoodsOptionsNoObligatoryDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loadFoodsOptionsNoObligatoryDelay
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsNoObligatoryDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getFoodOptions:globalVar.FC_food obligatory:FALSE images:TRUE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadFoodsOptionsNoObligatorySuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) loadFoodsOptionsNoObligatorySuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkNumberofregisters
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNumberofregisters {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_REGRISTROS_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_NUM_REGRISTROS_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(checkNumberofregistersSuccessful:)
                                                     name: _NOTIFICATION_NUM_REGRISTROS_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(checkNumberofregistersDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: checkNumberofregistersDelay
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNumberofregistersDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_numberofregisters];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkNumberofregistersSuccessful
//#	Fecha Creación	: 23/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkNumberofregistersSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_NUM_REGRISTROS_SUCCESSFUL_ object:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : sendReporte
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) sendReporte {
    
    // Mostramos el View
    [self.view setAlpha:1.0f];
    
    // Comprobamos si hay conexión a Internet
    if (![globalVar chekInternetConnection]) {
        
        // Generamos la notificación que indica que no hay conexión a Internet
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_REPORT_NO_INTERNET_
                                                            object:self];
        
        // Ocultamos el View
        [self.view setAlpha:0.0f];
    }
    else {
        
        // Eliminamos los posible Observadores
        [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SEND_ORDER_REPORT_JSON_ object:nil];
        
        // Añadimos NSNotificationCenter para la lectura de datos
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(sendReporteSuccessful:)
                                                     name: _NOTIFICATION_SEND_ORDER_REPORT_JSON_
                                                   object: nil];
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(sendReporteDelay)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: sendReporteDelay
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) sendReporteDelay {
    
    // Recuperamos la información del servidor y la cargamos en memoria
    [globalVar.JPC_json UMNI_getreportepedidos:globalVar.OC_order.NSI_idorder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : sendReporteSuccessful
//#	Fecha Creación	: 08/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) sendReporteSuccessful:(NSNotification *)notification {
    
    // Ocultamos el View
    [self.view setAlpha:0.0f];
    
    // Comprobamos el resultado
    [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_SEND_ORDER_REPORT_SUCCESSFUL_ object:self];
}

#pragma mark - Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [globalVar.OC_order setTOS_status:TOS_cobro_fallido];

    if (buttonIndex == 1) {
        [self setOrder];
    } else {
        [self requestPaymentFail];
    }
}
@end
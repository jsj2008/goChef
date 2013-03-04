//
//  RestauranteAllInfoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteAllInfoViewController.h"
#import "LoadingViewController.h"
#import "RestauranteMiEstadoViewController.h"
#import "RestauranteFotosViewController.h"
#import "RestauranteInformacionViewController.h"
#import "PedidoViewController.h"
#import "ReservarViewController.h"
#import "RestauranteAllInfoGooleMapsViewController.h"

#import "RestaurantClass.h"
#import "AnnotationClass.h"
#import "CoreLocationClass.h"
#import "OrderClass.h"
#import "ImageClass.h"


@implementation RestauranteAllInfoViewController

@synthesize UIL_nombre_restaurante;
@synthesize UIL_direccion_restaurante;
@synthesize UIL_cp_provincia;
@synthesize UIB_en_restaurante;
@synthesize UIB_antes_llegar;
@synthesize UIB_a_domicilio;
@synthesize UIB_recoger;
@synthesize UIB_reservar;
@synthesize UIB_mis_ofertas;
@synthesize UIV_contenido;
@synthesize UIV_menu;
@synthesize UIIV_close;
@synthesize UIIV_restaurant;
@synthesize UIIV_mis_ofertas_background;
@synthesize UISV_scroll;

@synthesize RC_restaurant = _RC_restaurant;

@synthesize RMEVC_mi_estado  = _RMEVC_mi_estado;
@synthesize RFVC_fotos       = _RFVC_fotos;
@synthesize RIVC_informaicon = _RIVC_informaicon;
@synthesize RAIGMVC_map      = _RAIGMVC_map;

@synthesize ALDCVC_datos = _ALDCVC_datos;

@synthesize PVC_pedir = _PVC_pedir;
@synthesize RVC_reservar = _RVC_reservar;

@synthesize DVC_direccion = _DVC_direccion;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDVC_direccion
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDVC_direccion:(DireccionesViewController *)DVC_direccion {
    
    _DVC_direccion = DVC_direccion;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setALDCVC_datos
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setALDCVC_datos:(AntesLlegarDatosContenedorViewController *)ALDCVC_datos {
    
    _ALDCVC_datos = ALDCVC_datos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRAIGMVC_map
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRAIGMVC_map:(RestauranteAllInfoGooleMapsViewController *)RAIGMVC_map {
    
    _RAIGMVC_map = RAIGMVC_map;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRC_restaurant
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRC_restaurant:(RestaurantClass *)RC_restaurant {
    
    _RC_restaurant = RC_restaurant;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRMEVC_mi_estado
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRMEVC_mi_estado:(RestauranteMiEstadoViewController *)RMEVC_mi_estado {
    
    _RMEVC_mi_estado = RMEVC_mi_estado;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRFVC_fotos
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRFVC_fotos:(RestauranteFotosViewController *)RFVC_fotos {
    
    _RFVC_fotos = RFVC_fotos;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setRIVC_informaicon
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRIVC_informaicon:(RestauranteInformacionViewController *)RIVC_informaicon {
    
    _RIVC_informaicon = RIVC_informaicon;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setPVC_pedir
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setPVC_pedir:(PedidoViewController *)PVC_pedir {
    
    _PVC_pedir = PVC_pedir;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDPVC_domicilio
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRVC_reservar:(ReservarViewController *)RVC_reservar {
    
    _RVC_reservar = RVC_reservar;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Iniciamos los componentes
    [UIB_mis_ofertas setEnabled:FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Esperamos antes de ir al menú de la aplicación
    NSTimer *NST_timer;
    NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                 target:self
                                               selector:@selector(checkFidelizacion)
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
//#	Procedimiento	: setContentWith
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(RestaurantClass *)newRC_restaurant {
    
    CGFloat CGF_offset = 183.0f;
    
    // Actualizamos propiedad
    [self setRC_restaurant:newRC_restaurant];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = _RC_restaurant.NSS_name;
    
    // Actualizamos el UILabel Nombre Restaurante
    [UIL_nombre_restaurante    setText:_RC_restaurant.NSS_name];
    [UIL_direccion_restaurante setText:_RC_restaurant.NSS_address1];
    [UIL_cp_provincia          setText:_RC_restaurant.NSS_address2];
    
    // Comprobamos si tiene imagenes
    if ([_RC_restaurant.NSMA_images count] > 0) {
        
        // Recuperamos la priema imagen
        ImageClass *IC_image = [_RC_restaurant.NSMA_images objectAtIndex:0];
        
        // Actualizamos UIImage
        //UIImage *UII_image = [UIImage imageWithData:IC_image.NSD_image];
        //[UIIV_restaurant setImage:UII_image];
        
        [UIIV_restaurant loadImageFromURLString:IC_image.NSS_imageUrl andActiveCache:TRUE];
    }
    
    // Insertamos contenido
    [UISV_scroll addSubview:UIV_contenido];
    [UISV_scroll addSubview:UIV_menu];
    
    // Posicionamos UIView
    [UISV_scroll   setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [UIV_contenido setFrame:CGRectMake(0.0f, 0.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    
    // Comprobamos si venimos de "Mi Saco"
    if (globalVar.B_come_from_mi_saco) {
        
        // Inidicamos que está cerrado
        [UIIV_close setAlpha:1.0f];
        
        // Comprobamos si efectivamente está cerrado (todos tipos de pedidos NO activos)
        if      (_RC_restaurant.TRS_service_adomicilio       == TRS_si_incluido) [UIIV_close setAlpha:0.0f];
        else if (_RC_restaurant.TRS_service_enrestaurante    == TRS_si_incluido) [UIIV_close setAlpha:0.0f];
        else if (_RC_restaurant.TRS_service_antesrestaurante == TRS_si_incluido) [UIIV_close setAlpha:0.0f];
        else if (_RC_restaurant.TRS_service_arecoger         == TRS_si_incluido) [UIIV_close setAlpha:0.0f];
        else if (_RC_restaurant.TRS_service_reserva          == TRS_si_incluido) [UIIV_close setAlpha:0.0f];
    }
    else {
        
        // Comprobamos si esta cerrado
        switch (globalVar.OC_order.TOT_type)
        {
            case TOT_pedido_a_domicilio:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (_RC_restaurant.TRS_service_adomicilio == TRS_no_activo) [UIIV_close setAlpha:1.0f];
                else [UIIV_close setAlpha:0.0f];
                
                break;
            }
            case TOT_pedido_en_el_restaurante:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if ((_RC_restaurant.TRS_service_enrestaurante == TRS_no_activo) || (!globalVar.B_active_en_mesa)) [UIIV_close setAlpha:1.0f];
                else [UIIV_close setAlpha:0.0f];
                
                break;
            }
            case TOT_pedido_antes_de_ir_al_restaurante:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (_RC_restaurant.TRS_service_antesrestaurante == TRS_no_activo) [UIIV_close setAlpha:1.0f];
                else [UIIV_close setAlpha:0.0f];
                
                break;
            }
            case TOT_pedido_para_recoger:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (_RC_restaurant.TRS_service_arecoger == TRS_no_activo) [UIIV_close setAlpha:1.0f];
                else [UIIV_close setAlpha:0.0f];
                
                break;
            }
            case TOT_reserva:
            {
                // Comprobamos si está cerrado para ese tipo de pedido
                if (_RC_restaurant.TRS_service_reserva == TRS_no_activo) [UIIV_close setAlpha:1.0f];
                else [UIIV_close setAlpha:0.0f];
                
                break;
            }
        }
    }
    
    // Posicionamos los UIButton en su posición inicial
    [UIB_en_restaurante setFrame:CGRectMake(UIB_en_restaurante.frame.origin.x, 183.0f, UIB_en_restaurante.frame.size.width, UIB_en_restaurante.frame.size.height)];
    [UIB_antes_llegar   setFrame:CGRectMake(UIB_antes_llegar.frame.origin.x,   221.0f, UIB_antes_llegar.frame.size.width, UIB_antes_llegar.frame.size.height)];
    [UIB_a_domicilio    setFrame:CGRectMake(UIB_a_domicilio.frame.origin.x,    259.0f, UIB_a_domicilio.frame.size.width, UIB_a_domicilio.frame.size.height)];
    [UIB_recoger        setFrame:CGRectMake(UIB_recoger.frame.origin.x,        297.0f, UIB_recoger.frame.size.width, UIB_recoger.frame.size.height)];
    [UIB_reservar       setFrame:CGRectMake(UIB_reservar.frame.origin.x,       335.0f, UIB_reservar.frame.size.width, UIB_reservar.frame.size.height)];
    
    // Inciamos Alpha todos los UIButton
    [UIB_en_restaurante setAlpha:0.0f];
    [UIB_antes_llegar   setAlpha:0.0f];
    [UIB_a_domicilio    setAlpha:0.0f];
    [UIB_recoger        setAlpha:0.0f];
    [UIB_reservar       setAlpha:0.0f];
    
    // Inciamos Alpha todos los UIButton
    [UIB_en_restaurante setSelected:FALSE];
    [UIB_antes_llegar   setSelected:FALSE];
    [UIB_a_domicilio    setSelected:FALSE];
    [UIB_recoger        setSelected:FALSE];
    [UIB_reservar       setSelected:FALSE];
    
    // Comprobamos si venimos de "Mi Saco"
    if (globalVar.B_come_from_mi_saco) {
    
        // Comprobamos si el restaurante permite pedidos en el restaurante
        switch (_RC_restaurant.TRS_service_enrestaurante)
        {
            case TRS_no_incluido: break;
            case TRS_si_incluido:
            {
                // Comprobamos si está activo este tipo de pedido
                if (globalVar.B_active_en_mesa) {
                    
                    // Posicionamos el UIButton
                    [UIB_en_restaurante setFrame:CGRectMake(UIB_en_restaurante.frame.origin.x, CGF_offset, UIB_en_restaurante.frame.size.width, UIB_en_restaurante.frame.size.height)];
                    
                    //Mostramos UIButton
                    [UIB_en_restaurante setAlpha:1.0f];
                    
                    // Incrementamos el Offset
                    CGF_offset += 38.0f;
                }
                
                break;
            }
            case TRS_no_activo:
            {
                // Comprobamos si está activo este tipo de pedido
                if (globalVar.B_active_en_mesa) {
                    
                    // Posicionamos el UIButton
                    [UIB_en_restaurante setFrame:CGRectMake(UIB_en_restaurante.frame.origin.x, CGF_offset, UIB_en_restaurante.frame.size.width, UIB_en_restaurante.frame.size.height)];
                    
                    //Mostramos UIButton
                    [UIB_en_restaurante setAlpha:1.0f];
                    [UIB_en_restaurante setSelected:TRUE];
                    
                    // Incrementamos el Offset
                    CGF_offset += 38.0f;
                }
                
                break;
            }
        }
        
        // Comprobamos si el restaurante permite pedidos en el restaurante
        switch (_RC_restaurant.TRS_service_antesrestaurante)
        {
            case TRS_no_incluido: break;
            case TRS_si_incluido:
            {
                // Posicionamos el UIButton
                [UIB_antes_llegar setFrame:CGRectMake(UIB_antes_llegar.frame.origin.x, CGF_offset, UIB_antes_llegar.frame.size.width, UIB_antes_llegar.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_antes_llegar setAlpha:1.0f];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
            case TRS_no_activo:
            {
                // Posicionamos el UIButton
                [UIB_antes_llegar setFrame:CGRectMake(UIB_antes_llegar.frame.origin.x, CGF_offset, UIB_antes_llegar.frame.size.width, UIB_antes_llegar.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_antes_llegar setAlpha:1.0f];
                [UIB_antes_llegar setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
        }
        
        // Comprobamos si el restaurante permite pedidos en el restaurante
        switch (_RC_restaurant.TRS_service_adomicilio)
        {
            case TRS_no_incluido: break;
            case TRS_si_incluido:
            {
                // Posicionamos el UIButton
                [UIB_a_domicilio setFrame:CGRectMake(UIB_a_domicilio.frame.origin.x, CGF_offset, UIB_a_domicilio.frame.size.width, UIB_a_domicilio.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_a_domicilio setAlpha:1.0f];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
            case TRS_no_activo:
            {
                // Posicionamos el UIButton
                [UIB_a_domicilio setFrame:CGRectMake(UIB_a_domicilio.frame.origin.x, CGF_offset, UIB_a_domicilio.frame.size.width, UIB_a_domicilio.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_a_domicilio setAlpha:1.0f];
                [UIB_a_domicilio setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
        }
        
        // Comprobamos si el restaurante permite pedidos en el restaurante
        switch (_RC_restaurant.TRS_service_arecoger)
        {
            case TRS_no_incluido: break;
            case TRS_si_incluido:
            {
                // Posicionamos el UIButton
                [UIB_recoger setFrame:CGRectMake(UIB_recoger.frame.origin.x, CGF_offset, UIB_recoger.frame.size.width, UIB_recoger.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_recoger setAlpha:1.0f];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
            case TRS_no_activo:
            {
                // Posicionamos el UIButton
                [UIB_recoger setFrame:CGRectMake(UIB_recoger.frame.origin.x, CGF_offset, UIB_recoger.frame.size.width, UIB_recoger.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_recoger setAlpha:1.0f];
                [UIB_recoger setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
        }
        
        // Comprobamos si el restaurante permite pedidos en el restaurante
        switch (_RC_restaurant.TRS_service_reserva)
        {
            case TRS_no_incluido: break;
            case TRS_no_activo  : break;
            case TRS_si_incluido:
            {
                // Posicionamos el UIButton
                [UIB_reservar setFrame:CGRectMake(UIB_reservar.frame.origin.x, CGF_offset, UIB_reservar.frame.size.width, UIB_reservar.frame.size.height)];
                
                //Mostramos UIButton
                [UIB_reservar setAlpha:1.0f];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
        }
    }
    else {
        
        // Comprobamos si sólo debemos mostrar el UIButton de un tipo de pedido
        switch (globalVar.OC_order.TOT_type)
        {
            case TOT_pedido_antes_de_ir_al_restaurante:
            {
                // Posicionamos el UIButton al principio
                [UIB_antes_llegar setFrame:CGRectMake(UIB_antes_llegar.frame.origin.x, 183.0f, UIB_antes_llegar.frame.size.width, UIB_antes_llegar.frame.size.height)];
                
                // Ocultamos el resto de UIButton
                [UIB_antes_llegar setAlpha:1.0f];
                
                // Comprobamos si el restaurante permite este servicio
                if (_RC_restaurant.TRS_service_antesrestaurante == TRS_no_activo) [UIB_antes_llegar setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
                
            case TOT_pedido_a_domicilio:
            {
                // Posicionamos el UIButton al principio
                [UIB_a_domicilio setFrame:CGRectMake(UIB_a_domicilio.frame.origin.x, 183.0f, UIB_a_domicilio.frame.size.width, UIB_a_domicilio.frame.size.height)];
                
                // Ocultamos el resto de UIButton
                [UIB_a_domicilio setAlpha:1.0f];
                
                // Comprobamos si el restaurante permite este servicio
                if (_RC_restaurant.TRS_service_adomicilio == TRS_no_activo) [UIB_a_domicilio setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
                
            case TOT_pedido_para_recoger:
            {
                // Posicionamos el UIButton al principio
                [UIB_recoger setFrame:CGRectMake(UIB_recoger.frame.origin.x, 183.0f, UIB_recoger.frame.size.width, UIB_recoger.frame.size.height)];
                
                // Ocultamos el resto de UIButton
                [UIB_recoger setAlpha:1.0f];
                
                // Comprobamos si el restaurante permite este servicio
                if (_RC_restaurant.TRS_service_arecoger == TRS_no_activo) [UIB_recoger setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
                
            case TOT_pedido_en_el_restaurante:
            {
                // Comprobamos si está activo este tipo de pedido
                if (globalVar.B_active_en_mesa) {
                    
                    // Posicionamos el UIButton al principio
                    [UIB_en_restaurante setFrame:CGRectMake(UIB_en_restaurante.frame.origin.x, 183.0f, UIB_en_restaurante.frame.size.width, UIB_en_restaurante.frame.size.height)];
                    
                    // Ocultamos el resto de UIButton
                    [UIB_en_restaurante setAlpha:1.0f];
                    
                    // Comprobamos si el restaurante permite este servicio
                    if (_RC_restaurant.TRS_service_enrestaurante == TRS_no_activo) [UIB_en_restaurante setSelected:TRUE];
                    
                    // Incrementamos el Offset
                    CGF_offset += 38.0f;
                }

                break;
            }
                
            case TOT_reserva:
            {
                // Posicionamos el UIButton al principio
                [UIB_reservar setFrame:CGRectMake(UIB_reservar.frame.origin.x, 183.0f, UIB_reservar.frame.size.width, UIB_reservar.frame.size.height)];
                
                // Ocultamos el resto de UIButton
                [UIB_reservar setAlpha:1.0f];
                
                // Comprobamos si el restaurante permite este servicio
                if (_RC_restaurant.TRS_service_reserva == TRS_no_activo) [UIB_reservar setSelected:TRUE];
                
                // Incrementamos el Offset
                CGF_offset += 38.0f;
                
                break;
            }
        }
    }
    
    // Posicionamos UIView Menu
    [UIV_menu setFrame:CGRectMake(0.0f, CGF_offset, UIV_menu.frame.size.width, UIV_menu.frame.size.height)];
    
    // Calculamos UIScrollView contentSize
    [UISV_scroll setContentSize:CGSizeMake(UISV_scroll.frame.size.width, (CGF_offset+UIV_menu.frame.size.height+40.0f))];
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
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) downloadRestaurantImages {
    
    // Creamos ImageClass
    globalVar.IC_image = [[ImageClass alloc] init];
    [globalVar.IC_image setTIT_type:TIT_restaurants];
    [globalVar.IC_image setCGF_width :640.0f];
    [globalVar.IC_image setCGF_height:334.0f];
    [globalVar.IC_image setNSI_number:1];
    
    // Download Image
    [self getImage];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getImage
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getImage {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(getImageSuccessful:) 
                                                 name: _NOTIFICATION_IMAGE_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_IMAGE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_IMAGE_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading getImage];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkFidelizacion
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacion {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_MEMBERSHIPVALIDATE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_MEMBERSHIPVALIDATE_NO_ALLOWED_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_MEMBERSHIPVALIDATE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(checkFidelizacionSuccessful:)
                                                 name: _NOTIFICATION_MEMBERSHIPVALIDATE_SUCCESSFUL_
                                               object: nil];

    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(checkFidelizacionNoSuccessful:)
                                                 name: _NOTIFICATION_MEMBERSHIPVALIDATE_NO_ALLOWED_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_MEMBERSHIPVALIDATE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading checkFidelizacion];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkFidelizacionSuccessful
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacionSuccessful:(NSNotification *)notification {
    
    // Actualizamos con la UIImage que corresponde
    UIImage *UII_oferta = [UIImage imageNamed:@"restaurante_menus.png"];
    [UIIV_mis_ofertas_background setImage:UII_oferta];
    
    // Habilitamos el UIButton
    [UIB_mis_ofertas setEnabled:TRUE];
    
    // Comprobamos si aun NO se han descargado las imágenes del restaurante
    if (!globalVar.OC_order.RC_restaurant.IC_image_ficha) {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(downloadRestaurantImages)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : checkFidelizacionSuccessful
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) checkFidelizacionNoSuccessful:(NSNotification *)notification {
    
    // Actualizamos con la UIImage que corresponde
    UIImage *UII_oferta = [UIImage imageNamed:@"restaurante_menus_off.png"];
    [UIIV_mis_ofertas_background setImage:UII_oferta];
    
    // Deshabilitamos el UIButton
    [UIB_mis_ofertas setEnabled:FALSE];
    
    // Comprobamos si aun NO se han descargado las imágenes del restaurante
    if ([globalVar.OC_order.RC_restaurant.NSMA_images count] == 0) {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(downloadRestaurantImages)
                                                   userInfo:nil
                                                    repeats:NO];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getImageSuccessful
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getImageSuccessful:(NSNotification *)notification {
    
    // Comprobamos si la imagen no se encontro -> Sacamos Image del Array
    if (globalVar.IC_image.NSS_imageUrl != nil) {
     
        // Fijamos la ImageData
        [_RC_restaurant setIC_image_ficha:globalVar.IC_image];
        
        // Actualizamos UIImage
        //UIImage *UII_image = [UIImage imageWithData:_RC_restaurant.IC_image_ficha.NSD_image];
        //[UIIV_restaurant setImage:UII_image];
        [UIIV_restaurant loadImageFromURLString:globalVar.IC_image.NSS_imageUrl andActiveCache:TRUE];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
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
//#	Procedimiento   : UIB_mi_estado_TouchUpInside
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_mi_estado_TouchUpInside:(id)sender {
    
    // Creamos RestauranteMiEstadoViewController
    _RMEVC_mi_estado = [[RestauranteMiEstadoViewController alloc] initWithNibName:@"RestauranteMiEstadoView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RMEVC_mi_estado animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_fotos_TouchUpInside
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_fotos_TouchUpInside:(id)sender {
    
    // Creamos RestauranteFotosViewController
    _RFVC_fotos = [[RestauranteFotosViewController alloc] initWithNibName:@"RestauranteFotosView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RFVC_fotos animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_informacion_TouchUpInside
//#	Fecha Creación	: 12/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_informacion_TouchUpInside:(id)sender {
    
    // Creamos RestauranteInformacionViewController
    _RIVC_informaicon = [[RestauranteInformacionViewController alloc] initWithNibName:@"RestauranteInformacionView" bundle:[NSBundle mainBundle]];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_RIVC_informaicon animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_accion_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_accion_TouchUpInside:(id)sender {
    
    // Recogemos el UIBoutton que generó el evento
    UIButton *UIB_accion = (UIButton *)sender;
    
    // Comprobamos si esta en estado selected
    if (UIB_accion.selected) {
    
        [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_
                           message:_ALERT_MSG_UMNI_ERROR_tipo_pedido_disable_];
        
        return;
    }
    
    // Comprobamos desde donde se ha realizado la llamada
    switch (UIB_accion.tag)
    {
        case 1:
        {
            // Actualizamos tipo de pedido
            [globalVar.OC_order setTOT_type:TOT_pedido_en_el_restaurante];
            
            // Indicamos al delegado que se ha pulsado sobre la celda
            if (_delegate != nil) [_delegate UIB_pedir_restaurante_Touched];
            
            break;
        }
        case 2:
        {
            // Comprobamos si estamos en un pedido antes de llegar al restaurante
            if (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) {
                
                // Creamos AntesLlegarDatosContenedorViewController
                _ALDCVC_datos = [[AntesLlegarDatosContenedorViewController alloc] initWithNibName:@"AntesLlegarDatosContenedorView" bundle:[NSBundle mainBundle]];
                
                // Nos posicionamos en el primer View Controller
                [self.navigationController pushViewController:_ALDCVC_datos animated:YES];
                
                // Asignamos delegado
                [_ALDCVC_datos setDelegate:self];
            }
            else {
                
                // Actualizamos tipo de pedido
                [globalVar.OC_order setTOT_type:TOT_pedido_antes_de_ir_al_restaurante];
                
                // Indicamos al delegado que se ha pulsado sobre la celda
                if (_delegate != nil) [_delegate UIB_pedir_antes_llegar_Touched];
            }
            
            break;
        }
        case 3:
        {
            // Comprobamos si estamos en un pedido a domicilio
            if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
                
                // Creamos PedidoViewController
                _PVC_pedir = [[PedidoViewController alloc] initWithNibName:@"PedidoView" bundle:[NSBundle mainBundle]];
                
                // Nos posicionamos en el primer View Controller
                [self.navigationController pushViewController:_PVC_pedir animated:YES];
            }
            else {
                
                // Actualizamos tipo de pedido
                [globalVar.OC_order setTOT_type:TOT_pedido_a_domicilio];
                
                // Creamos DireccionesViewController
                _DVC_direccion = [[DireccionesViewController alloc] initWithNibName:@"DireccionesView" bundle:[NSBundle mainBundle]];
                
                // Nos posicionamos en el primer View Controller
                [self.navigationController pushViewController:_DVC_direccion animated:YES];
                
                // Asignamos delegado
                [_DVC_direccion setDelegate:self];
            }
            
            break;
        }
        case 4:
        {
            // Comprobamos si estamos en un pedido a domicilio
            if (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) {
                
                // Creamos PedidoViewController
                _PVC_pedir = [[PedidoViewController alloc] initWithNibName:@"PedidoView" bundle:[NSBundle mainBundle]];
                
                // Nos posicionamos en el primer View Controller
                [self.navigationController pushViewController:_PVC_pedir animated:YES];
            }
            else {
                
                // Actualizamos tipo de pedido
                [globalVar.OC_order setTOT_type:TOT_pedido_para_recoger];
                
                // Indicamos al delegado que se ha pulsado sobre la celda
                if (_delegate != nil) [_delegate UIB_recoger_comida_Touched];
            }
            
            break;
        }
        case 5:
        {
            // Comprobamos si estamos en una reserva
            if (globalVar.OC_order.TOT_type == TOT_reserva) {
                
                // Creamos ReservarViewController
                _RVC_reservar = [[ReservarViewController alloc] initWithNibName:@"ReservarView" bundle:[NSBundle mainBundle]];
                
                // Asignamos delegado
                [_RVC_reservar setDelegate:self];
                
                // Nos posicionamos en el primer View Controller
                [self.navigationController pushViewController:_RVC_reservar animated:YES];
            }
            else {
                
                // Actualizamos tipo de pedido
                [globalVar.OC_order setTOT_type:TOT_reserva];
                
                // Indicamos al delegado que se ha pulsado sobre la celda
                if (_delegate != nil) [_delegate UIB_reservar_mesa_Touched];
            }
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_map_TouchUpInside
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_map_TouchUpInside:(id)sender {
    
    NSMutableArray *NSMA_annotations = [[NSMutableArray alloc] init];
    
    // Construimos el Map ViewController
    _RAIGMVC_map = [[RestauranteAllInfoGooleMapsViewController alloc] initWithNibName:@"RestauranteAllInfoGooleMapsView" bundle:[NSBundle mainBundle]];
    
    // Creamos las coordenadas
    CLLocationCoordinate2D CLLC_location;
    CLLC_location.latitude  = _RC_restaurant.CGF_latitude;
    CLLC_location.longitude = _RC_restaurant.CGF_longitude;
    
    // Construmos el texto Title de la Anotación
    NSString *NSS_title = [NSString stringWithFormat:@"%@", _RC_restaurant.NSS_name];
    
    // Construimos el texto Subtitle de la anotación
    NSString *NSS_subtitle = [NSString stringWithFormat:@"%@", _RC_restaurant.NSS_address1];
    
    // Recogemos el valor de la Row selected
    AnnotationClass *AC_anotacion = [[AnnotationClass alloc] initWithCoordinate:CLLC_location 
                                                                          title:NSS_title 
                                                                       subtitle:NSS_subtitle];
    
    // Actualizamos la información del ViewController
    [NSMA_annotations addObject:AC_anotacion];
    
    // Asignamos NSMArray al Map ViewController
    [_RAIGMVC_map setNSMA_annotation:NSMA_annotations];
    
    // Cambiamos al nuevo ViewController
    [self.navigationController pushViewController:_RAIGMVC_map animated:YES];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_pre_pedir_Touched
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) Tabbar_pre_pedir_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_pre_pedir_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: Tabbar_mi_cuenta_Touched
//#	Fecha Creación	: 13/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) Tabbar_mi_cuenta_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_domicilio_Touched
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_pedir_domicilio_Touched {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate UIB_pedir_domicilio_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: cargar_historial
//#	Fecha Creación	: 12/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) cargar_historial {
    
}


@end
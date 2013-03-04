//
//  AppDelegate.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"
#import "FBConnect.h"

#import "PrincipalViewController.h"
#import "HelpViewController.h"
#import "MiSacoContenedorViewController.h"
#import "DomicilioHistorialViewController.h"
#import "MiPedidoViewController.h"
#import "RestauranteShortInfoViewController.h"
#import "DomicilioDireccionViewController.h"
#import "MiCuentaEditarCuentaViewController.h"
#import "MiCuentaRegistroLoginViewController.h"
#import "RestaurantePedirContenedorViewController.h"
#import "OpcionesViewController.h"
#import "AntesLlegarDatosContenedorViewController.h"
#import "PedidoViewController.h"
#import "RestauranteEnCocinaContenedorViewController.h"
#import "ReservarViewController.h"

#import "TabbarPrincipalViewController.h"
#import "TabbarDomicilioViewController.h"
#import "TabbarRestauranteViewController.h"
#import "TabbarAntesLlegarViewController.h"


@class MiActividadContenedorViewController, MiCuentaContenedorViewController, RestaurantePagarContenedorViewController, MiCuentaEditarCuentaViewController, MiCuentaRegistroLoginViewController;


@interface AppDelegate : NSObject <UIApplicationDelegate, TabbarPrincipalViewControllerDelegate, TabbarDomicilioViewControllerDelegate, TabbarRestauranteViewControllerDelegate, TabbarAntesLlegarViewControllerDelegate, PrincipalViewControllerDelegate, HelpViewControllerDelegate, MiSacoContenedorViewControllerDelegate, DomicilioHistorialViewControllerDelegate, MiPedidoViewControllerDelegate, RestauranteShortInfoViewControllerDelegate, DomicilioDireccionViewControllerDelegate, MiCuentaEditarCuentaViewControllerDelegate, MiCuentaRegistroLoginViewControllerDelegate, RestaurantePedirContenedorViewControllerDelegate, OpcionesViewControllerDelegate, AntesLlegarDatosContenedorViewControllerDelegate, PedidoViewControllerDelegate, RestauranteEnCocinaContenedorViewControllerDelegate, ReservarViewControllerDelegate> {
    
    NSTimer *_NST_timer_chec_new_orders;
    
    Facebook *facebook;
    NSMutableDictionary *userPermissions;
    
    NSInteger _NSI_active_index;
    BOOL _B_principal_page;
    BOOL _B_resetButtonState;
    
    BOOL _B_show_Tabbar_Principal;
    BOOL _B_show_Tabbar_Domicilio;
    BOOL _B_show_Tabbar_Restaurante;
    BOOL _B_show_Tabbar_AntesLlegar;
    
    IBOutlet UIView *UIV_tabbars;
    
    IBOutlet UINavigationController *UINC_principal_mi_actividad;
    IBOutlet UINavigationController *UINC_principal_mi_saco;
    IBOutlet UINavigationController *UINC_principal_mi_cuenta;
    IBOutlet UINavigationController *UINC_principal_help;
    IBOutlet UINavigationController *UINC_principal_opciones;
    IBOutlet UINavigationController *UINC_principal_reservas;
    
    IBOutlet UINavigationController *UINC_domicilio_buscar;
    IBOutlet UINavigationController *UINC_domicilio_mi_pedido;
    IBOutlet UINavigationController *UINC_domicilio_historial;
    
    IBOutlet UINavigationController *UINC_restaurante_pedir;
    IBOutlet UINavigationController *UINC_restaurante_en_cocina;
    IBOutlet UINavigationController *UINC_restaurante_pagar;
    
    IBOutlet UINavigationController *UINC_antes_llegar_datos;
    IBOutlet UINavigationController *UINC_antes_llegar_pedir;
    IBOutlet UINavigationController *UINC_antes_llegar_mi_pedido;
    
    MiActividadContenedorViewController *_MACVC_mi_actividad;
    MiSacoContenedorViewController      *_MSCVC_mi_saco;
    MiCuentaContenedorViewController    *_MCCVC_mi_cuenta;
    
    HelpViewController *_HVC_help;
    OpcionesViewController *_OVC_opciones;
    
    RestauranteShortInfoViewController *_RSIC_restaurante;
    ReservarViewController *_RVC_reservar;
    
    DomicilioDireccionViewController *_DDVC_buscar;
    DomicilioHistorialViewController *_DHVC_historial;

    MiPedidoViewController *_MPVC_mi_pedido;
    PedidoViewController *_PVC_pedido;
    
    RestaurantePedirContenedorViewController    *_RPCVC_pedir;
    RestauranteEnCocinaContenedorViewController *_RECCVC_en_cocina;
    RestaurantePagarContenedorViewController    *_RPCVC_pagar;
    
    AntesLlegarDatosContenedorViewController *_ALDCVC_datos;
    
    MiCuentaEditarCuentaViewController  *_MCECVC_editar_cuenta;
    MiCuentaRegistroLoginViewController *_MCRLVC_registro_login;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) NSTimer *NST_timer_chec_new_orders;

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;

@property (nonatomic, readwrite) NSInteger NSI_active_index;
@property (nonatomic, readwrite) BOOL B_principal_page;
@property (nonatomic, readwrite) BOOL B_resetButtonState;

@property (nonatomic, readwrite) BOOL B_show_Tabbar_Principal;
@property (nonatomic, readwrite) BOOL B_show_Tabbar_Domicilio;
@property (nonatomic, readwrite) BOOL B_show_Tabbar_Restaurante;
@property (nonatomic, readwrite) BOOL B_show_Tabbar_AntesLlegar;
@property (nonatomic, readwrite) BOOL B_show_Tabbar_Recoger;

@property (nonatomic, retain) UIView *UIV_tabbars;

@property (nonatomic, retain) UINavigationController *UINC_principal_mi_actividad;
@property (nonatomic, retain) UINavigationController *UINC_principal_mi_saco;
@property (nonatomic, retain) UINavigationController *UINC_principal_mi_cuenta;
@property (nonatomic, retain) UINavigationController *UINC_principal_help;
@property (nonatomic, retain) UINavigationController *UINC_principal_opciones;

@property (nonatomic, retain) UINavigationController *UINC_domicilio_buscar;
@property (nonatomic, retain) UINavigationController *UINC_domicilio_mi_pedido;
@property (nonatomic, retain) UINavigationController *UINC_domicilio_historial;

@property (nonatomic, retain) UINavigationController *UINC_restaurante_pedir;
@property (nonatomic, retain) UINavigationController *UINC_restaurante_en_cocina;
@property (nonatomic, retain) UINavigationController *UINC_restaurante_pagar;

@property (nonatomic, retain) UINavigationController *UINC_antes_llegar_datos;
@property (nonatomic, retain) UINavigationController *UINC_antes_llegar_pedir;
@property (nonatomic, retain) UINavigationController *UINC_antes_llegar_mi_pedido;

@property (nonatomic, retain) MiActividadContenedorViewController *MACVC_mi_actividad;
@property (nonatomic, retain) MiSacoContenedorViewController      *MSCVC_mi_saco;
@property (nonatomic, retain) MiCuentaContenedorViewController    *MCCVC_mi_cuenta;

@property (nonatomic, retain) HelpViewController     *HVC_help;
@property (nonatomic, retain) OpcionesViewController *OVC_opciones;

@property (nonatomic, retain) RestauranteShortInfoViewController *RSIC_restaurante;
@property (nonatomic, retain) ReservarViewController *RVC_reservar;

@property (nonatomic, retain) DomicilioDireccionViewController *DDVC_buscar;
@property (nonatomic, retain) DomicilioHistorialViewController *DHVC_historial;

@property (nonatomic, retain) MiPedidoViewController *MPVC_mi_pedido;
@property (nonatomic, retain) PedidoViewController *PVC_pedido;

@property (nonatomic, retain) RestaurantePedirContenedorViewController    *RPCVC_pedir;
@property (nonatomic, retain) RestauranteEnCocinaContenedorViewController *RECCVC_en_cocina;
@property (nonatomic, retain) RestaurantePagarContenedorViewController    *RPCVC_pagar;

@property (nonatomic, retain) AntesLlegarDatosContenedorViewController *ALDCVC_datos;

@property (nonatomic, retain) IBOutlet UIWindow *window;


-(void) updateNavigationControllerToIndex:(NSInteger)NSI_index popRoot:(BOOL)B_popRoot;


@end
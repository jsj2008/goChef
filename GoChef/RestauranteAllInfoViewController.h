//
//  RestauranteAllInfoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "AntesLlegarDatosContenedorViewController.h"
#import "DireccionesViewController.h"
#import "ReservarViewController.h"
#import "AsynchronousImageView.h"


@protocol RestauranteAllInfoViewControllerDelegate

-(void) Tabbar_pre_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;

-(void) UIB_pedir_restaurante_Touched;
-(void) UIB_pedir_antes_llegar_Touched;
-(void) UIB_pedir_domicilio_Touched;
-(void) UIB_recoger_comida_Touched;
-(void) UIB_reservar_mesa_Touched;

@end


@class RestaurantClass, RestauranteMiEstadoViewController, RestauranteFotosViewController, RestauranteInformacionViewController, PedidoViewController, RestauranteAllInfoGooleMapsViewController, ImageClass;

@interface RestauranteAllInfoViewController : UIViewController <AntesLlegarDatosContenedorViewControllerDelegate, DireccionesViewControllerDelegate, ReservarViewControllerDelegate> {
    
    IBOutlet UILabel *UIL_nombre_restaurante;
    IBOutlet UILabel *UIL_direccion_restaurante;
    IBOutlet UILabel *UIL_cp_provincia;
    
    IBOutlet UIButton *UIB_en_restaurante;
    IBOutlet UIButton *UIB_antes_llegar;
    IBOutlet UIButton *UIB_a_domicilio;
    IBOutlet UIButton *UIB_recoger;
    IBOutlet UIButton *UIB_reservar;
    IBOutlet UIButton *UIB_mis_ofertas;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIView *UIV_menu;
    
    IBOutlet UIImageView *UIIV_close;
    IBOutlet AsynchronousImageView *UIIV_restaurant;
    IBOutlet UIImageView *UIIV_mis_ofertas_background;
    
    IBOutlet UIScrollView *UISV_scroll;
    
    RestaurantClass *_RC_restaurant;
    
    RestauranteMiEstadoViewController         *_RMEVC_mi_estado;
    RestauranteFotosViewController            *_RFVC_fotos;
    RestauranteInformacionViewController      *_RIVC_informaicon;
    RestauranteAllInfoGooleMapsViewController *_RAIGMVC_map;
    
    AntesLlegarDatosContenedorViewController *_ALDCVC_datos;
    
    DireccionesViewController *_DVC_direccion;
    
    PedidoViewController *_PVC_pedir;
    ReservarViewController *_RVC_reservar;
    
    __unsafe_unretained id<RestauranteAllInfoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<RestauranteAllInfoViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurante;
@property (nonatomic, retain) UILabel *UIL_direccion_restaurante;
@property (nonatomic, retain) UILabel *UIL_cp_provincia;

@property (nonatomic, retain) UIButton *UIB_en_restaurante;
@property (nonatomic, retain) UIButton *UIB_antes_llegar;
@property (nonatomic, retain) UIButton *UIB_a_domicilio;
@property (nonatomic, retain) UIButton *UIB_recoger;
@property (nonatomic, retain) UIButton *UIB_reservar;
@property (nonatomic, retain) UIButton *UIB_mis_ofertas;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIView *UIV_menu;

@property (nonatomic, retain) UIImageView *UIIV_close;
@property (nonatomic, retain) UIImageView *UIIV_restaurant;
@property (nonatomic, retain) UIImageView *UIIV_mis_ofertas_background;

@property (nonatomic, retain) UIScrollView *UISV_scroll;

@property (nonatomic, retain) RestaurantClass *RC_restaurant;

@property (nonatomic, retain) RestauranteMiEstadoViewController         *RMEVC_mi_estado;
@property (nonatomic, retain) RestauranteFotosViewController            *RFVC_fotos;
@property (nonatomic, retain) RestauranteInformacionViewController      *RIVC_informaicon;
@property (nonatomic, retain) RestauranteAllInfoGooleMapsViewController *RAIGMVC_map;

@property (nonatomic, retain) AntesLlegarDatosContenedorViewController *ALDCVC_datos;

@property (nonatomic, retain) DireccionesViewController *DVC_direccion;

@property (nonatomic, retain) PedidoViewController *PVC_pedir;
@property (nonatomic, retain) ReservarViewController *RVC_reservar;


-(void) initNavigationBar;
-(void) setContentWith:(RestaurantClass *)newRC_restaurant; 


-(IBAction) UIB_mi_estado_TouchUpInside  :(id)sender;
-(IBAction) UIB_fotos_TouchUpInside      :(id)sender;
-(IBAction) UIB_informacion_TouchUpInside:(id)sender;
-(IBAction) UIB_accion_TouchUpInside     :(id)sender;
-(IBAction) UIB_map_TouchUpInside        :(id)sender;


@end
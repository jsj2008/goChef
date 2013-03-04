//
//  OpcionesViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "MiCuentaRegistroLoginViewController.h"

@protocol OpcionesViewControllerDelegate

-(void) UIB_settings_Touched;

@end

@class OpcionesAtencionClienteViewController, HelpViewController, OpcionesMiHistorialViewController, MiCuentaEditarCuentaViewController, TarjetasAdministrarViewController, OpcionesTerminosDeUsoViewController, OpcionesSugerenciaViewController;

@interface OpcionesViewController : UIViewController <UIAlertViewDelegate, MiCuentaRegistroLoginViewControllerDelegate> {
    
    IBOutlet UILabel *UIL_total_spending;
    IBOutlet UILabel *UIL_total_saving;
    IBOutlet UILabel *UIL_restaurants_visits;
    IBOutlet UILabel *UIL_version;
    
    IBOutlet UIImageView *UIIV_bakcground;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIScrollView *UISV_scroll;
    
    OpcionesAtencionClienteViewController   *_MCPVC_problemas;
    HelpViewController                      *_HVC_ayuda;
    OpcionesMiHistorialViewController       *_MCMHVC_historial;
    MiCuentaEditarCuentaViewController      *_MCECVC_editar_cuenta;
    TarjetasAdministrarViewController       *_TAVC_admin_tarjetas;
    MiCuentaRegistroLoginViewController     *_MCRLVC_registro_login;
    OpcionesTerminosDeUsoViewController     *_MCTUVC_terminos;
    OpcionesSugerenciaViewController        *_MCSVC_sugerir;
    
    __unsafe_unretained id<OpcionesViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<OpcionesViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_total_spending;
@property (nonatomic, retain) UILabel *UIL_total_saving;
@property (nonatomic, retain) UILabel *UIL_restaurants_visits;
@property (nonatomic, retain) UILabel *UIL_version;

@property (nonatomic, retain) UIImageView *UIIV_bakcground;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIScrollView *UISV_scroll;

@property (nonatomic, retain) OpcionesAtencionClienteViewController *MCPVC_problemas;
@property (nonatomic, retain) HelpViewController                    *HVC_ayuda;
@property (nonatomic, retain) OpcionesMiHistorialViewController     *MCMHVC_historial;
@property (nonatomic, retain) MiCuentaEditarCuentaViewController    *MCECVC_editar_cuenta;
@property (nonatomic, retain) TarjetasAdministrarViewController     *TAVC_admin_tarjetas;
@property (nonatomic, retain) MiCuentaRegistroLoginViewController   *MCRLVC_registro_login;
@property (nonatomic, retain) OpcionesTerminosDeUsoViewController   *MCTUVC_terminos;
@property (nonatomic, retain) OpcionesSugerenciaViewController      *MCSVC_sugerir;

-(IBAction) UIB_problemas_TouchUpInside         :(id)sender;
-(IBAction) UIB_como_funciona_TouchUpInside     :(id)sender;
-(IBAction) UIB_gasto_total_TouchUpInside       :(id)sender;
-(IBAction) UIB_total_ahorro_TouchUpInside      :(id)sender;
-(IBAction) UIB_sitios_visitados_TouchUpInside  :(id)sender;
-(IBAction) UIB_editar_cuenta_TouchUpInside     :(id)sender;
-(IBAction) UIB_admin_tarjetas_TouchUpInside    :(id)sender;
-(IBAction) UIB_logout_TouchUpInside            :(id)sender;
-(IBAction) UIB_terminos_de_uso_TouchUpInside   :(id)sender;
-(IBAction) UIB_facebook_TouchUpInside          :(id)sender;
-(IBAction) UIB_puntua_app_TouchUpInside        :(id)sender;
-(IBAction) UIB_sugerencias_TouchUpInside       :(id)sender;


-(void) initNavigationBar;


@end
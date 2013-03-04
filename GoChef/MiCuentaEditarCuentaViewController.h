//
//  MiCuentaEditarCuentaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectSexoViewController.h"
#import "SelectFechaViewController.h"

@protocol MiCuentaEditarCuentaViewControllerDelegate

-(void) Tabbar_dom_mi_pedido_Touched;
-(void) Tabbar_rst_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;
-(void) Tabbar_reserva_Touched;
-(void) Tabbar_pre_datos_Touched;

@end


@interface MiCuentaEditarCuentaViewController : UIViewController <UITextFieldDelegate, SelectSexoViewControllerDelegate, SelectFechaViewControllerDelegate, UIAlertViewDelegate> {
    
    NSDate *_NSD_fecha_nacimiento;
    typeSexoType _TST_sexo;
    
    BOOL _B_teclado_visible;
    
    IBOutlet UITextField *UITF_nombre;
    IBOutlet UITextField *UITF_apellidos;
    IBOutlet UITextField *UITF_correo;
    IBOutlet UITextField *UITF_ciudad;
    IBOutlet UITextField *UITF_telefono;
    IBOutlet UITextField *UITF_password01;
    IBOutlet UITextField *UITF_password02;
    
    IBOutlet UILabel *UIL_sexo;
    IBOutlet UILabel *UIL_fecha_nacimiento;
    
    IBOutlet UIView *UIV_contenido;
    IBOutlet UIScrollView *UISV_scroll;
    
    SelectSexoViewController  *_SSVC_sexo;
    SelectFechaViewController *_SFVC_fecha_nacimiento;
    
    __unsafe_unretained id<MiCuentaEditarCuentaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<MiCuentaEditarCuentaViewControllerDelegate> delegate;

@property (nonatomic, retain) NSDate *NSD_fecha_nacimiento;
@property (nonatomic, readwrite) typeSexoType TST_sexo;

@property (nonatomic, readwrite) BOOL B_teclado_visible;

@property (nonatomic, retain) UITextField *UITF_nombre;
@property (nonatomic, retain) UITextField *UITF_apellidos;
@property (nonatomic, retain) UITextField *UITF_correo;
@property (nonatomic, retain) UITextField *UITF_ciudad;
@property (nonatomic, retain) UITextField *UITF_telefono;
@property (nonatomic, retain) UITextField *UITF_password01;
@property (nonatomic, retain) UITextField *UITF_password02;

@property (nonatomic, retain) UILabel *UIL_sexo;
@property (nonatomic, retain) UILabel *UIL_fecha_nacimiento;

@property (nonatomic, retain) UIView *UIV_contenido;
@property (nonatomic, retain) UIScrollView *UISV_scroll;

@property (nonatomic, retain) SelectSexoViewController  *SSVC_sexo;
@property (nonatomic, retain) SelectFechaViewController *SFVC_fecha_nacimiento;


-(IBAction) UIB_sexo_TouchUpInside             :(id)sender;
-(IBAction) UIB_fecha_nacimiento_TouchUpInside :(id)sender;
-(IBAction) UIB_registro_TouchUpInside         :(id)sender;
-(IBAction) UIB_bajar_TouchUpInside            :(id)sender;


-(void) initNavigationBar;


@end
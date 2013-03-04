//
//  TarjetasAltaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectTipoTarjetaViewController.h"
#import "SelectMonthYearViewController.h"

@interface TarjetasAltaViewController : UIViewController <SelectTipoTarjetaViewControllerDelegate, SelectMonthYearViewControllerDelegate> {
    
    NSDate *_NSD_fecha_caducidad;
    
    IBOutlet UITextField *UITF_nombre;
    IBOutlet UITextField *UITF_numero;
    IBOutlet UITextField *UITF_fecha_caducidad;
    IBOutlet UITextField *UITF_cvv;

    IBOutlet UILabel *UIL_tipo_tarjeta;
    
    IBOutlet UIView *UIV_formulairo;
    
    SelectTipoTarjetaViewController *_STTVC_tipo_tarjeta;
    SelectMonthYearViewController *_SFVC_fecha_caducidad;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) NSDate *NSD_fecha_caducidad;

@property (nonatomic, retain) UITextField *UITF_nombre;
@property (nonatomic, retain) UITextField *UITF_numero;
@property (nonatomic, retain) UITextField *UITF_fecha_caducidad;
@property (nonatomic, retain) UITextField *UITF_cvv;

@property (nonatomic, retain) UILabel *UIL_tipo_tarjeta;

@property (nonatomic, retain) UIView *UIV_formulairo;

@property (nonatomic, retain) SelectTipoTarjetaViewController *STTVC_tipo_tarjeta;
@property (nonatomic, retain) SelectMonthYearViewController *SFVC_fecha_caducidad;


-(void) initNavigationBar;

-(IBAction) UIB_guardar_tarjeta_TouchUpInside       :(id)sender;
-(IBAction) UIB_select_tipo_tarjeta_TouchUpInside   :(id)sender;
-(IBAction) UIB_select_fecha_caducidad_TouchUpInside:(id)sender;


@end
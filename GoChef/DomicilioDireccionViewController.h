//
//  DomicilioDireccionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectTipoCocinaViewController.h"
#import "SelectDireccionViewController.h"
#import "RestauranteShortInfoViewController.h"

@class DomicilioDireccionFormViewController;

@protocol DomicilioDireccionViewControllerDelegate

-(void) Tabbar_mi_saco_Touched:(BOOL)B_resetTabbarButton;

@end


@interface DomicilioDireccionViewController : UIViewController <UIAlertViewDelegate, SelectTipoCocinaViewControllerDelegate, SelectDireccionViewControllerDelegate, RestauranteShortInfoViewControllerDelegate> {
    
    IBOutlet UILabel *UIL_direccion;
    IBOutlet UILabel *UIL_tipo_comida;
    
    IBOutlet UILabel *UIL_direccion_01;
    IBOutlet UILabel *UIL_direccion_02;
    IBOutlet UILabel *UIL_direccion_03;
    
    IBOutlet UIButton *UIB_a_domicilio;
    IBOutlet UIButton *UIB_recoger;
    
    IBOutlet UIView *UIV_direccion;
    IBOutlet UIView *UIV_tipo_cocina;
    
    DomicilioDireccionFormViewController *_DDFVC_direccion;
    RestauranteShortInfoViewController   *_RSIVC_restaurantes;
    
    SelectTipoCocinaViewController *_STCVC_tipo_comida;
    SelectDireccionViewController  *_SDVC_direccion;
    
    __unsafe_unretained id<DomicilioDireccionViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<DomicilioDireccionViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_direccion;
@property (nonatomic, retain) UILabel *UIL_tipo_comida;

@property (nonatomic, retain) UILabel *UIL_direccion_01;
@property (nonatomic, retain) UILabel *UIL_direccion_02;
@property (nonatomic, retain) UILabel *UIL_direccion_03;

@property (nonatomic, retain) UIButton *UIB_a_domicilio;
@property (nonatomic, retain) UIButton *UIB_recoger;

@property (nonatomic, retain) UIView *UIV_direccion;
@property (nonatomic, retain) UIView *UIV_tipo_cocina;

@property (nonatomic, retain) DomicilioDireccionFormViewController *DDFVC_direccion;
@property (nonatomic, retain) RestauranteShortInfoViewController   *RSIVC_restaurantes;

@property (nonatomic, retain) SelectTipoCocinaViewController *STCVC_tipo_comida;
@property (nonatomic, retain) SelectDireccionViewController  *SDVC_direccion;



-(IBAction) UIB_form_direccion_TouchUpInside     :(id)sender;
-(IBAction) UIB_buscar_restaurante_TouchUpInside :(id)sender;
-(IBAction) UIB_select_tipo_comida_TouchUpInside :(id)sender;
-(IBAction) UIB_select_direccion_TouchUpInside   :(id)sender;
-(IBAction) UIB_filtro_domicilio_TouchUpInside   :(id)sender;
-(IBAction) UIB_filtro_recoger_TouchUpInside     :(id)sender;
-(IBAction) UIB_edit_direccion_TouchUpInside     :(id)sender;
-(IBAction) UIB_remove_direccion_TouchUpInside   :(id)sender;

-(void) initNavigationBar;


@end
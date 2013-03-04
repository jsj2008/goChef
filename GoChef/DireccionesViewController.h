//
//  DireccionesViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectDireccionViewController.h"

@class DomicilioDireccionFormViewController;

@protocol DireccionesViewControllerDelegate

-(void) UIB_pedir_domicilio_Touched;
-(void) cargar_historial;

@end


@interface DireccionesViewController : UIViewController <UIAlertViewDelegate, SelectDireccionViewControllerDelegate> {
    
    IBOutlet UILabel *UIL_direccion;  
    IBOutlet UILabel *UIL_direccion_01;
    IBOutlet UILabel *UIL_direccion_02;
    IBOutlet UILabel *UIL_direccion_03;
    
    DomicilioDireccionFormViewController *_DDFVC_direccion;
    SelectDireccionViewController *_SDVC_direccion;
    
    __unsafe_unretained id<DireccionesViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<DireccionesViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_direccion;
@property (nonatomic, retain) UILabel *UIL_direccion_01;
@property (nonatomic, retain) UILabel *UIL_direccion_02;
@property (nonatomic, retain) UILabel *UIL_direccion_03;

@property (nonatomic, retain) DomicilioDireccionFormViewController *DDFVC_direccion;
@property (nonatomic, retain) SelectDireccionViewController *SDVC_direccion;



-(IBAction) UIB_add_new_direccion_TouchUpInside   :(id)sender;
-(IBAction) UIB_comprobar_direccion_TouchUpInside :(id)sender;
-(IBAction) UIB_select_direccion_TouchUpInside    :(id)sender;
-(IBAction) UIB_edit_direccion_TouchUpInside      :(id)sender;
-(IBAction) UIB_remove_direccion_TouchUpInside    :(id)sender;

-(void) initNavigationBar;


@end
//
//  DomicilioDireccionFormViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class DireccionClass;

@interface DomicilioDireccionFormViewController : UIViewController {
    
    BOOL _B_new_address;
    
    DireccionClass *_DC_direccion;
    
    IBOutlet UITextField *UITF_telefono;
    IBOutlet UITextField *UITF_direccion;
    IBOutlet UITextField *UITF_numero;
    IBOutlet UITextField *UITF_piso;
    IBOutlet UITextField *UITF_letra;
    IBOutlet UITextField *UITF_portal;
    IBOutlet UITextField *UITF_escalera;
    IBOutlet UITextField *UITF_cp;
    IBOutlet UITextField *UITF_ciudad;
    IBOutlet UITextField *UITF_etiqueta;
    
    IBOutlet UIView *UIV_formulairo;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_new_address;

@property (nonatomic, retain) DireccionClass *DC_direccion;

@property (nonatomic, retain) UITextField *UITF_telefono;
@property (nonatomic, retain) UITextField *UITF_direccion;
@property (nonatomic, retain) UITextField *UITF_numero;
@property (nonatomic, retain) UITextField *UITF_piso;
@property (nonatomic, retain) UITextField *UITF_letra;
@property (nonatomic, retain) UITextField *UITF_portal;
@property (nonatomic, retain) UITextField *UITF_escalera;
@property (nonatomic, retain) UITextField *UITF_cp;
@property (nonatomic, retain) UITextField *UITF_ciudad;
@property (nonatomic, retain) UITextField *UITF_etiqueta;

@property (nonatomic, retain) UIView *UIV_formulairo;

-(void) initNavigationBar;

-(IBAction) UIB_guardar_direccion_TouchUpInside:(id)sender;


@end
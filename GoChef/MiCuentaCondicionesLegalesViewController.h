//
//  MiCuentaCondicionesLegalesViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol MiCuentaCondicionesLegalesViewControllerDelegate

-(void) Tabbar_mi_cuenta_Touched;
-(void) UIB_settings_Touched;

@end

@interface MiCuentaCondicionesLegalesViewController : UIViewController {
    
    BOOL _B_checked;
    
    IBOutlet UIButton *UIB_check_condiciones_legales;    
    
    __unsafe_unretained id<MiCuentaCondicionesLegalesViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<MiCuentaCondicionesLegalesViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_checked;

@property (nonatomic, retain) UIButton *UIB_check_condiciones_legales;


-(IBAction) UIB_check_TouchUpInside     :(id)sender;
-(IBAction) UIB_registrar_TouchUpInside :(id)sender;


@end
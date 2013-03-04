//
//  MiCuentaLoginViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@protocol MiCuentaLoginViewControllerDelegate

-(void) Tabbar_dom_mi_pedido_Touched;
-(void) Tabbar_rst_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;
-(void) Tabbar_reserva_Touched;

@end


@interface MiCuentaLoginViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UITextField *UITF_correo_login;
    IBOutlet UITextField *UITF_correo_recordar;
    IBOutlet UITextField *UITF_password;
    
    IBOutlet UIView *UIV_login;
    IBOutlet UIView *UIV_recordar;
    
    __unsafe_unretained id<MiCuentaLoginViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<MiCuentaLoginViewControllerDelegate> delegate;

@property (nonatomic, retain) UITextField *UITF_correo_login;
@property (nonatomic, retain) UITextField *UITF_correo_recordar;
@property (nonatomic, retain) UITextField *UITF_password;

@property (nonatomic, retain) UIView *UIV_login;
@property (nonatomic, retain) UIView *UIV_recordar;


-(IBAction) UIB_login_TouchUpInside        :(id)sender;
-(IBAction) UIB_show_recordar_TouchUpInside:(id)sender;
-(IBAction) UIB_recordar_TouchUpInside     :(id)sender;


-(void) initNavigationBar;


@end
//
//  PrincipalViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@protocol PrincipalViewControllerDelegate

-(void) UIB_pedir_restaurante_Touched;
-(void) UIB_pedir_antes_llegar_Touched;
-(void) UIB_pedir_domicilio_Touched;
-(void) UIB_recoger_comida_Touched;
-(void) UIB_reservar_mesa_Touched;
-(void) UIB_help_Touched;
-(void) UIB_settings_Touched;

@end

@interface PrincipalViewController : UIViewController {
    
    UIImageView *UIIV_logo;

    IBOutlet UIImageView *UIIV_menus;
    IBOutlet UIButton *UIB_en_mesa;
    IBOutlet UIScrollView *UISV_scroll;
    
    __unsafe_unretained id<PrincipalViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<PrincipalViewControllerDelegate> delegate;

@property (nonatomic, retain) UIImageView *UIIV_logo;

@property (nonatomic, retain) UIImageView *UIIV_menus;
@property (nonatomic, retain) UIButton *UIB_en_mesa;
@property (nonatomic, retain) UIScrollView *UISV_scroll;


-(IBAction) UIB_pedir_restaurante_TouchUpInside  :(id)sender;
-(IBAction) UIB_pedir_antes_llegar_TouchUpInside :(id)sender;
-(IBAction) UIB_pedir_domicilio_TouchUpInside    :(id)sender;
-(IBAction) UIB_recoger_comida_TouchUpInside     :(id)sender;
-(IBAction) UIB_reservar_mesa_TouchUpInside      :(id)sender;


@end
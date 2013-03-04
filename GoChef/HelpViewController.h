//
//  HelpViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol HelpViewControllerDelegate

-(void) UIB_pedir_restaurante_withoutDelay_Touched;
-(void) UIB_pedir_antes_llegar_withoutDelay_Touched;
-(void) UIB_pedir_domicilio_withoutDelay_Touched;

@end

@interface HelpViewController : UIViewController {
    
    IBOutlet UIButton *UIB_domicilio;
    IBOutlet UIButton *UIB_restaurante;
    IBOutlet UIButton *UIB_antes_llegar;
    
    IBOutlet UIButton *UIB_accion;
    
    IBOutlet UIImageView *UIIV_text;
    
    __unsafe_unretained id<HelpViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<HelpViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_domicilio;
@property (nonatomic, retain) UIButton *UIB_restaurante;
@property (nonatomic, retain) UIButton *UIB_antes_llegar;

@property (nonatomic, retain) UIButton *UIB_accion;

@property (nonatomic, retain) UIImageView *UIIV_text;


-(IBAction) UIB_domicilio_TouchUpInside    :(id)sender;
-(IBAction) UIB_restaurante_TouchUpInside  :(id)sender;
-(IBAction) UIB_antes_llegar_TouchUpInside :(id)sender;
-(IBAction) UIB_accion_TouchUpInside       :(id)sender;


-(void) initNavigationBar;


@end
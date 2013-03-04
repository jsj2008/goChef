//
//  PedidoInstructionsViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@protocol PedidoInstructionsViewControllerDelegate

-(void) guardar_instructions_Touched:(NSString *)NSS_instructions;

@end


@interface PedidoInstructionsViewController : UIViewController {
    
    BOOL _B_readonly;
    
    IBOutlet UIButton *UIB_guardar;
    IBOutlet UITextView *UITV_instructions;
    IBOutlet UIView *UIV_formulario;
    
    __unsafe_unretained id<PedidoInstructionsViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<PedidoInstructionsViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_readonly;

@property (nonatomic, retain) UIButton *UIB_guardar;
@property (nonatomic, retain) UITextView *UITV_instructions;
@property (nonatomic, retain) UIView *UIV_formulario;

-(void) initNavigationBar;

-(IBAction) UIB_guardar_instructions_TouchUpInside:(id)sender;


@end
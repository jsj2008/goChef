//
//  OpcionesAtencionClienteViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface OpcionesAtencionClienteViewController : UIViewController <UITextViewDelegate> {
    
    BOOL _B_enviar;
    
    IBOutlet UITextView *UITV_text;
    IBOutlet UIView *UIV_contenido;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_enviar;

@property (nonatomic, retain) UITextView *UITV_text;
@property (nonatomic, retain) UIView *UIV_contenido;


-(IBAction) UIB_enviar_TouchUpInside:(id)sender;


-(void) initNavigationBar;


@end
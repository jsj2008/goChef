//
//  MiActividadConfirmarViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface MiActividadConfirmarViewController : UIViewController {
    
    NSInteger _NSI_starts;
    BOOL _B_favorite;
    
    IBOutlet UILabel *UIL_facebook_text;
    
    IBOutlet UITextView *UITV_text;
    
    IBOutlet UIButton *UIB_star_01;
    IBOutlet UIButton *UIB_star_02;
    IBOutlet UIButton *UIB_star_03;
    IBOutlet UIButton *UIB_star_04;
    IBOutlet UIButton *UIB_star_05;
    
    IBOutlet UIImageView *UIIV_facebook;
    
    IBOutlet UIButton *UIB_favorites;
    IBOutlet UIButton *UIB_eviar_mail;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_starts;
@property (nonatomic, readwrite) BOOL B_favorite;

@property (nonatomic, retain) UILabel *UIL_facebook_text;

@property (nonatomic, retain) UITextView *UITV_text;

@property (nonatomic, retain) UIButton *UIB_star_01;
@property (nonatomic, retain) UIButton *UIB_star_02;
@property (nonatomic, retain) UIButton *UIB_star_03;
@property (nonatomic, retain) UIButton *UIB_star_04;
@property (nonatomic, retain) UIButton *UIB_star_05;

@property (nonatomic, retain) UIImageView *UIIV_facebook;

@property (nonatomic, retain) UIButton *UIB_favorites;
@property (nonatomic, retain) UIButton *UIB_eviar_mail;


-(IBAction) UIB_favorites_TouchUpInside :(id)sender;
-(IBAction) UIB_faceboock_TouchUpInside :(id)sender;
-(IBAction) UIB_enviar_ticket_TouchUpInside :(id)sender;
-(IBAction) UIB_star_01_TouchUpInside :(id)sender;
-(IBAction) UIB_star_02_TouchUpInside :(id)sender;
-(IBAction) UIB_star_03_TouchUpInside :(id)sender;
-(IBAction) UIB_star_04_TouchUpInside :(id)sender;
-(IBAction) UIB_star_05_TouchUpInside :(id)sender;

-(void) initNavigationBar;


@end
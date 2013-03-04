//
//  AntesLlegarDatosContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectHoraViewController.h"
#import "SelectPersonasViewController.h"


@protocol AntesLlegarDatosContenedorViewControllerDelegate

-(void) Tabbar_pre_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;

@end

@interface AntesLlegarDatosContenedorViewController : UIViewController <UIAlertViewDelegate, SelectHoraViewControllerDelegate, SelectPersonasViewControllerDelegate> {
    
    BOOL _B_favorite;
    
    IBOutlet UILabel *UIL_hora;
    IBOutlet UILabel *UIL_personas;
    IBOutlet UILabel *UIL_facebook_text;
    
    IBOutlet UIImageView *UIIV_facebook;
    
    IBOutlet UIButton *UIB_favorites;
    
    SelectHoraViewController *_SHVC_hora;
    SelectPersonasViewController  *_SPVC_personas;
    
    __unsafe_unretained id<AntesLlegarDatosContenedorViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<AntesLlegarDatosContenedorViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_favorite;

@property (nonatomic, retain) UILabel *UIL_hora;
@property (nonatomic, retain) UILabel *UIL_personas;
@property (nonatomic, retain) UILabel *UIL_facebook_text;

@property (nonatomic, retain) UIImageView *UIIV_facebook;

@property (nonatomic, retain) UIButton *UIB_favorites;

@property (nonatomic, retain) SelectHoraViewController *SHVC_hora;
@property (nonatomic, retain) SelectPersonasViewController  *SPVC_personas;

@property (nonatomic, retain) NSArray *hoursArray;



-(IBAction) UIB_favorites_TouchUpInside       :(id)sender;
-(IBAction) UIB_faceboock_TouchUpInside       :(id)sender;
-(IBAction) UIB_select_hora_TouchUpInside     :(id)sender;
-(IBAction) UIB_select_personas_TouchUpInside :(id)sender;
-(IBAction) UIB_go_pedir_TouchUpInside        :(id)sender;


-(void) initNavigationBar;


@end
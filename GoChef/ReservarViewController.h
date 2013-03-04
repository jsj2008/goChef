//
//  ReservarViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "SelectFechaViewController.h"
#import "SelectHoraViewController.h"
#import "SelectPersonasViewController.h"
#import "SelectOfertaViewController.h"


@protocol ReservarViewControllerDelegate

-(void) Tabbar_mi_cuenta_Touched;

@end

@interface ReservarViewController : UIViewController <SelectHoraViewControllerDelegate, SelectFechaViewControllerDelegate, SelectPersonasViewControllerDelegate, SelectOfertaViewControllerDelegate> {
    
    BOOL _B_favorite;
    
    IBOutlet UILabel *UIL_fecha_hora;
    IBOutlet UILabel *UIL_personas;
    IBOutlet UILabel *UIL_facebook_text;
    IBOutlet UILabel *UIL_recoger_oferta;
    IBOutlet UIImageView *UIIV_facebook;
    IBOutlet UIButton *UIB_favorites;
    
    __unsafe_unretained id<ReservarViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<ReservarViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_favorite;

@property (nonatomic, retain) UILabel *UIL_fecha_hora;
@property (nonatomic, retain) IBOutlet UILabel *UIL_hora;

@property (nonatomic, retain) UILabel *UIL_personas;
@property (nonatomic, retain) UILabel *UIL_facebook_text;
@property (nonatomic, retain) UILabel *UIL_recoger_oferta;

@property (nonatomic, retain) UIImageView *UIIV_facebook;

@property (nonatomic, retain) UIButton *UIB_favorites;

@property (nonatomic, retain) SelectHoraViewController *SFHVC_fechaHora;
@property (nonatomic, retain) SelectHoraViewController *S_hora;
@property (nonatomic, retain) SelectPersonasViewController  *SPVC_personas;
@property (nonatomic, retain) SelectOfertaViewController    *SOVC_oferta;

@property (nonatomic, retain) NSArray *datesArray;
@property (nonatomic, retain) NSArray *hoursArray;


-(IBAction) UIB_favorites_TouchUpInside         :(id)sender;
-(IBAction) UIB_faceboock_TouchUpInside         :(id)sender;
-(IBAction) UIB_select_fecha_hora_TouchUpInside :(id)sender;
-(IBAction) UIB_select_hora_TouchUpInside :(id)sender;
-(IBAction) UIB_select_personas_TouchUpInside   :(id)sender;
-(IBAction) UIB_reservar_mesa_TouchUpInside     :(id)sender;
-(IBAction) UIB_select_oferta_TouchUpInside     :(id)sender;

-(void) initNavigationBar;


@end
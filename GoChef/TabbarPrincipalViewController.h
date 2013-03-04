//
//  TabbarPrincipalViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol TabbarPrincipalViewControllerDelegate

-(void) Tabbar_mi_activida_Touched;
-(void) Tabbar_mi_saco_Touched:(BOOL)B_resetTabbarButton;
-(void) Tabbar_mi_cuenta_Touched;

@end

@interface TabbarPrincipalViewController : UIViewController {
    
    IBOutlet UIButton *UIB_mi_saco;
    IBOutlet UIButton *UIB_mi_actividad;
    IBOutlet UIButton *UIB_mi_cuenta;
    
    IBOutlet UILabel *UIL_globo;
    IBOutlet UIView  *UIV_globo;
    
    IBOutlet UILabel *UIL_globo_animacion;
    IBOutlet UIView  *UIV_globo_animacion;
    
    __unsafe_unretained id<TabbarPrincipalViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<TabbarPrincipalViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_mi_saco;
@property (nonatomic, retain) UIButton *UIB_mi_actividad;
@property (nonatomic, retain) UIButton *UIB_mi_cuenta;

@property (nonatomic, retain) UILabel *UIL_globo;
@property (nonatomic, retain) UIView *UIV_globo;

@property (nonatomic, retain) UILabel *UIL_globo_animacion;
@property (nonatomic, retain) UIView *UIV_globo_animacion;


-(IBAction) UIB_mi_activida_TouchUpInside :(id)sender;
-(IBAction) UIB_mi_saco_TouchUpInside     :(id)sender;
-(IBAction) UIB_mi_cuenta_TouchUpInside   :(id)sender;


-(void) initTabbarButtonsStatus;
-(void) updateTabBarforIndex:(NSInteger)NSI_index;

-(void) updateGlobo;


@end
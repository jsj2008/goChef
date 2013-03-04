//
//  TabbarRestauranteViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol TabbarRestauranteViewControllerDelegate

-(void) Tabbar_rst_pedir_Touched;
-(void) Tabbar_rst_en_cocina_Touched;
-(void) Tabbar_rst_pagar_Touched;

@end

@interface TabbarRestauranteViewController : UIViewController {
    
    IBOutlet UIButton *UIB_pedir;
    IBOutlet UIButton *UIB_en_cocina;
    IBOutlet UIButton *UIB_pagar;
    
    IBOutlet UILabel *UIL_pedir_globo;
    IBOutlet UIView  *UIV_pedir_globo;
    IBOutlet UILabel *UIL_pedir_globo_animacion;
    IBOutlet UIView  *UIV_pedir_globo_animacion;
    
    IBOutlet UILabel *UIL_en_cocina_globo;
    IBOutlet UIView  *UIV_en_cocina_globo;
    IBOutlet UILabel *UIL_en_cocina_globo_animacion;
    IBOutlet UIView  *UIV_en_cocina_globo_animacion;
    
    IBOutlet UIView *UIV_accion;
    IBOutlet UIView *UIV_tabbar;
    
    IBOutlet UIButton *UIB_accion;
    
    __unsafe_unretained id<TabbarRestauranteViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<TabbarRestauranteViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_pedir;
@property (nonatomic, retain) UIButton *UIB_en_cocina;
@property (nonatomic, retain) UIButton *UIB_pagar;

@property (nonatomic, retain) UILabel *UIL_pedir_globo;
@property (nonatomic, retain) UIView  *UIV_pedir_globo;
@property (nonatomic, retain) UILabel *UIL_pedir_globo_animacion;
@property (nonatomic, retain) UIView  *UIV_pedir_globo_animacion;

@property (nonatomic, retain) UILabel *UIL_en_cocina_globo;
@property (nonatomic, retain) UIView  *UIV_en_cocina_globo;
@property (nonatomic, retain) UILabel *UIL_en_cocina_globo_animacion;
@property (nonatomic, retain) UIView  *UIV_en_cocina_globo_animacion;

@property (nonatomic, retain) UIView *UIV_accion;
@property (nonatomic, retain) UIView *UIV_tabbar;

@property (nonatomic, retain) UIButton *UIB_accion;


-(IBAction) UIB_pedir_TouchUpInside             :(id)sender;
-(IBAction) UIB_en_cocina_TouchUpInside         :(id)sender;
-(IBAction) UIB_pagar_TouchUpInside             :(id)sender;
-(IBAction) UIB_enviar_a_cocina_TouchUpInside   :(id)sender;

-(void) initTabbarButtonsStatus;
-(void) updateTabBarforIndex:(NSInteger)NSI_index;

-(void) pedir_globo_init:(NSInteger)NSI_number;
-(void) pedir_globo_reset;
-(void) pedir_globo_hide;
-(void) pedir_globo_addValue:(NSInteger)NSI_number;
-(void) pedir_globo_redoValue:(NSInteger)NSI_number;

-(void) en_cocina_globo_init:(NSInteger)NSI_number;
-(void) en_cocina_globo_reset;
-(void) en_cocina_globo_hide;
-(void) en_cocina_globo_addValue:(NSInteger)NSI_number;
-(void) en_cocina_globo_redoValue:(NSInteger)NSI_number;


@end
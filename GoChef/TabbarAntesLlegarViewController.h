//
//  TabbarAntesLlegarViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol TabbarAntesLlegarViewControllerDelegate

-(void) Tabbar_pre_datos_Touched;
-(void) Tabbar_pre_pedir_Touched;
-(void) Tabbar_pre_mi_pedido_Touched;

@end

@interface TabbarAntesLlegarViewController : UIViewController {
    
    IBOutlet UIButton *UIB_datos;
    IBOutlet UIButton *UIB_pedir;
    IBOutlet UIButton *UIB_mi_pedido;
    
    IBOutlet UILabel *UIL_globo;
    IBOutlet UIView  *UIV_globo;
    
    IBOutlet UILabel *UIL_globo_animacion;
    IBOutlet UIView  *UIV_globo_animacion;
    
    __unsafe_unretained id<TabbarAntesLlegarViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<TabbarAntesLlegarViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_datos;
@property (nonatomic, retain) UIButton *UIB_pedir;
@property (nonatomic, retain) UIButton *UIB_mi_pedido;

@property (nonatomic, retain) UILabel *UIL_globo;
@property (nonatomic, retain) UIView *UIV_globo;

@property (nonatomic, retain) UILabel *UIL_globo_animacion;
@property (nonatomic, retain) UIView *UIV_globo_animacion;


-(IBAction) UIB_datos_TouchUpInside     :(id)sender;
-(IBAction) UIB_pedir_TouchUpInside     :(id)sender;
-(IBAction) UIB_mi_pedido_TouchUpInside :(id)sender;


-(void) initTabbarButtonsStatus;
-(void) updateTabBarforIndex:(NSInteger)NSI_index;

-(void) initGlobo:(NSInteger)NSI_number;
-(void) resetGlobo;
-(void) hideGlobo;
-(void) addValueGlobo:(NSInteger)NSI_number;
-(void) redoValueGlobo:(NSInteger)NSI_number;


@end
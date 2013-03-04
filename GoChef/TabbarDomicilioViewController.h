//
//  TabbarDomicilioViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol TabbarDomicilioViewControllerDelegate

-(void) Tabbar_dom_buscar_Touched;
-(void) Tabbar_dom_mi_pedido_Touched;
-(void) Tabbar_dom_historial_Touched;

@end

@interface TabbarDomicilioViewController : UIViewController {
    
    IBOutlet UIButton *UIB_buscar;
    IBOutlet UIButton *UIB_mi_pedido;
    IBOutlet UIButton *UIB_historial;
    
    IBOutlet UILabel *UIL_globo;
    IBOutlet UIView  *UIV_globo;
    
    IBOutlet UILabel *UIL_globo_animacion;
    IBOutlet UIView  *UIV_globo_animacion;
    
    __unsafe_unretained id<TabbarDomicilioViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<TabbarDomicilioViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_buscar;
@property (nonatomic, retain) UIButton *UIB_mi_pedido;
@property (nonatomic, retain) UIButton *UIB_historial;

@property (nonatomic, retain) UILabel *UIL_globo;
@property (nonatomic, retain) UIView *UIV_globo;

@property (nonatomic, retain) UILabel *UIL_globo_animacion;
@property (nonatomic, retain) UIView *UIV_globo_animacion;


-(IBAction) UIB_buscar_TouchUpInside    :(id)sender;
-(IBAction) UIB_mi_pedido_TouchUpInside :(id)sender;
-(IBAction) UIB_historial_TouchUpInside  :(id)sender;


-(void) initTabbarButtonsStatus;
-(void) updateTabBarforIndex:(NSInteger)NSI_index;

-(void) initGlobo:(NSInteger)NSI_number;
-(void) resetGlobo;
-(void) hideGlobo;
-(void) addValueGlobo:(NSInteger)NSI_number;
-(void) redoValueGlobo:(NSInteger)NSI_number;


@end
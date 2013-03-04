//
//  CustomUITableViewCellMiSacoHeaderViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol CustomUITableViewCellMiSacoHeaderViewControllerDelegate

-(void) ordenar_ultimos_Touched;
-(void) ordenar_cercania_Touched;
-(void) ordenar_favoritos_Touched;
-(void) ordenar_hoy_Touched;

@end

@interface CustomUITableViewCellMiSacoHeaderViewController : UIViewController {
    
    IBOutlet UIButton *UIB_ultimos;
    IBOutlet UIButton *UIB_cercania;
    IBOutlet UIButton *UIB_favoritos;
    IBOutlet UIButton *UIB_hoy;
    
    __unsafe_unretained id<CustomUITableViewCellMiSacoHeaderViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiSacoHeaderViewControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *UIB_ultimos;
@property (nonatomic, retain) UIButton *UIB_cercania;
@property (nonatomic, retain) UIButton *UIB_favoritos;
@property (nonatomic, retain) UIButton *UIB_hoy;


-(IBAction) UIB_ultimos_TouchUpInside   :(id)sender;
-(IBAction) UIB_cercania_TouchUpInside  :(id)sender;
-(IBAction) UIB_favoritos_TouchUpInside :(id)sender;
-(IBAction) UIB_hoy_TouchUpInside       :(id)sender;


@end
//
//  CustomUITableViewCellPedidoConfirmacionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderFoodClass;

@protocol CustomUITableViewCellPedidoConfirmacionViewControllerDelegate

-(void) cellTouched:(OrderFoodClass *)OFC_food;

@end

@interface CustomUITableViewCellPedidoConfirmacionViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_plato;
    IBOutlet UILabel *UIL_cantidad;
    IBOutlet UILabel *UIL_caraceristicas;
    IBOutlet UILabel *UIL_precio;
    
    IBOutlet UIImageView *UIIV_precio_background;
    
    OrderFoodClass *_OFC_food;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_plato;
@property (nonatomic, retain) UILabel *UIL_cantidad;
@property (nonatomic, retain) UILabel *UIL_caraceristicas;
@property (nonatomic, retain) UILabel *UIL_precio;

@property (nonatomic, retain) UIImageView *UIIV_precio_background;

@property (nonatomic, retain) OrderFoodClass *OFC_food;


-(void) setContentWith:(OrderFoodClass *)newOFC_food;

-(IBAction) UIB_cell_TouchUpInside:(id)sender;


@end
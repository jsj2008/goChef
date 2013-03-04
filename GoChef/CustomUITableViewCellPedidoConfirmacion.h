//
//  CustomUITableViewCellPedidoConfirmacion.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoConfirmacionViewController.h"


@class OrderFoodClass;

@protocol CustomUITableViewCellPedidoConfirmacionDelegate

-(void) cellTouched:(OrderFoodClass *)OFC_food;

@end

@interface CustomUITableViewCellPedidoConfirmacion : UITableViewCell <CustomUITableViewCellPedidoConfirmacionViewControllerDelegate> {
    
    OrderFoodClass *_OFC_food;
    
    CustomUITableViewCellPedidoConfirmacionViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionDelegate> delegate;

@property (nonatomic, retain) OrderFoodClass *OFC_food;

@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderFoodClass *)newOFC_food;


@end

//
//  CustomUITableViewCellPedido.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoViewController.h"


@class OrderFoodClass;

@protocol CustomUITableViewCellPedidoDelegate

-(void) cellTouched:(OrderFoodClass *)OFC_food;

@end

@interface CustomUITableViewCellPedido : UITableViewCell <CustomUITableViewCellPedidoViewControllerDelegate> {
    
    OrderFoodClass *_OFC_food;
    
    CustomUITableViewCellPedidoViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoDelegate> delegate;

@property (nonatomic, retain) OrderFoodClass *OFC_food;

@property (nonatomic, retain) CustomUITableViewCellPedidoViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderFoodClass *)newOFC_food;


@end

//
//  CustomUITableViewCellPedirHistorial.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedirHistorialViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellPedirHistorialDelegate

-(void) cellTouched:(OrderClass *)OC_order;

@end

@interface CustomUITableViewCellPedirHistorial : UITableViewCell <CustomUITableViewCellPedirHistorialViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellPedirHistorialViewController *_CUITVCMAVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedirHistorialDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedirHistorialDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellPedirHistorialViewController *CUITVCMAVC_cell;

-(void) setContentWith:(OrderClass *)newOC_order;


@end

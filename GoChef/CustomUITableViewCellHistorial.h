//
//  CustomUITableViewCellHistorial.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellHistorialViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellHistorialDelegate

-(void) cellTouched:(OrderClass *)OC_order;

@end

@interface CustomUITableViewCellHistorial : UITableViewCell <CustomUITableViewCellHistorialViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellHistorialViewController *_CUITVCMAVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellHistorialDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellHistorialDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellHistorialViewController *CUITVCMAVC_cell;

-(void) setContentWith:(OrderClass *)newOC_order;


@end

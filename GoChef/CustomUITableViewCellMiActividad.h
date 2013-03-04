//
//  CustomUITableViewCellMyWallet.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiActividadViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellMiActividadDelegate

-(void) cellTouched:(OrderClass *)OC_order;

@end

@interface CustomUITableViewCellMiActividad : UITableViewCell <CustomUITableViewCellMiActividadViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellMiActividadViewController *_CUITVCMAVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellMiActividadDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiActividadDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellMiActividadViewController *CUITVCMAVC_cell;

-(void) setContentWith:(OrderClass *)newOC_order;


@end

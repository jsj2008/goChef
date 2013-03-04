//
//  CustomUITableViewCellMiActividadPie.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiActividadPieViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellMiActividadPieDelegate

-(void) show_instructions_Touched;
-(void) status_Touched;

@end

@interface CustomUITableViewCellMiActividadPie : UITableViewCell <CustomUITableViewCellMiActividadPieViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellMiActividadPieViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellMiActividadPieDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiActividadPieDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellMiActividadPieViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderClass *)newOC_order;


@end

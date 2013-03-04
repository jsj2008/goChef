//
//  CustomUITableViewCellEnCocinaPie.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellEnCocinaPieViewController.h"


@protocol CustomUITableViewCellEnCocinaPieDelegate

-(void) pedir_mas_comida_touched;
-(void) pagar_touched;

@end

@class OrderClass;

@interface CustomUITableViewCellEnCocinaPie : UITableViewCell <CustomUITableViewCellEnCocinaPieViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellEnCocinaPieViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellEnCocinaPieDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellEnCocinaPieDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellEnCocinaPieViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderClass *)newOC_order;


@end

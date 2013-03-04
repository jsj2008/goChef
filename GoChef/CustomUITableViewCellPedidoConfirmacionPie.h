//
//  CustomUITableViewCellPedidoConfirmacionPie.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoConfirmacionPieViewController.h"

@class OrderClass;

@protocol CustomUITableViewCellPedidoConfirmacionPieDelegate

-(void) show_instructions_Touched;
-(void) status_Touched;

@end


@interface CustomUITableViewCellPedidoConfirmacionPie : UITableViewCell <CustomUITableViewCellPedidoConfirmacionPieViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellPedidoConfirmacionPieViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionPieDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionPieDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionPieViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderClass *)newOC_order;


@end

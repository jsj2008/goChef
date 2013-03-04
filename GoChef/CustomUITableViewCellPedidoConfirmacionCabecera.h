//
//  CustomUITableViewCellPedidoConfirmacionCabecera.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoConfirmacionCabeceraViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellPedidoConfirmacionCabeceraDelegate
@end

@interface CustomUITableViewCellPedidoConfirmacionCabecera : UITableViewCell <CustomUITableViewCellPedidoConfirmacionCabeceraViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellPedidoConfirmacionCabeceraViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionCabeceraDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionCabeceraDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionCabeceraViewController *CUITVCPVC_cell;

-(void) setContentWith:(OrderClass *)newOC_order;


@end

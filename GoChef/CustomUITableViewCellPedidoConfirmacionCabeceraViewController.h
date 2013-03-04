//
//  CustomUITableViewCellPedidoConfirmacionCabeceraViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellPedidoConfirmacionCabeceraViewControllerDelegate
@end

@interface CustomUITableViewCellPedidoConfirmacionCabeceraViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_restaurantes;
    IBOutlet UILabel *UIL_detalle_pedido;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionCabeceraViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionCabeceraViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurantes;
@property (nonatomic, retain) UILabel *UIL_detalle_pedido;

@property (nonatomic, retain) OrderClass *OC_order;


-(void) setContentWith:(OrderClass *)newOC_order;


@end
//
//  CustomUITableViewCellPedidoPie.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoPieViewController.h"


@class OrderClass;

@protocol CustomUITableViewCellPedidoPieDelegate

-(void) pedir_mas_comida_Touched;
-(void) select_oferta_Touched;
-(void) enviar_pedido_Touched;
-(void) cancelar_pedido_Touched;

@end

@interface CustomUITableViewCellPedidoPie : UITableViewCell <CustomUITableViewCellPedidoPieViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    CustomUITableViewCellPedidoPieViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoPieDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoPieDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) CustomUITableViewCellPedidoPieViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderClass *)newOC_order;


@end

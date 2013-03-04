//
//  RestauranteConfirmacionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoConfirmacionPie.h"
#import "PedidoInstructionsViewController.h"


@class CustomUITableViewCellPedidoConfirmacion, CustomUITableViewCellPedidoConfirmacionCabecera;

@interface RestauranteConfirmacionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellPedidoConfirmacionPieDelegate, PedidoInstructionsViewControllerDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellPedidoConfirmacion         *_CUITVCP_cell; 
    CustomUITableViewCellPedidoConfirmacionCabecera *_CUITVCP_cabecera;
    CustomUITableViewCellPedidoConfirmacionPie      *_CUITVCP_pie;
    
    PedidoInstructionsViewController *_PIVC_instruction;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacion         *CUITVCP_cell; 
@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionCabecera *CUITVCP_cabecera;
@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionPie      *CUITVCP_pie;

@property (nonatomic, retain) PedidoInstructionsViewController *PIVC_instruction;


-(void) initNavigationBar;


@end
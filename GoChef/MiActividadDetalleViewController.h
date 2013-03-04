//
//  MiActividadDetalleViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiActividadPie.h"
#import "PedidoInstructionsViewController.h"


@class CustomUITableViewCellPedidoConfirmacion, CustomUITableViewCellPedidoConfirmacionCabecera, MiActividadConfirmarViewController;

@interface MiActividadDetalleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellMiActividadPieDelegate, PedidoInstructionsViewControllerDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellPedidoConfirmacion *_CUITVCP_cell; 
    CustomUITableViewCellPedidoConfirmacionCabecera *_CUITVCP_cabecera;
    CustomUITableViewCellMiActividadPie *_CUITVCP_pie;
    
    PedidoInstructionsViewController *_PIVC_instruction;
    MiActividadConfirmarViewController *_MACVC_confirmar;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacion *CUITVCP_cell; 
@property (nonatomic, retain) CustomUITableViewCellPedidoConfirmacionCabecera *CUITVCP_cabecera;
@property (nonatomic, retain) CustomUITableViewCellMiActividadPie *CUITVCP_pie;

@property (nonatomic, retain) PedidoInstructionsViewController *PIVC_instruction;
@property (nonatomic, retain) MiActividadConfirmarViewController *MACVC_confirmar;


-(void) initNavigationBar;


@end
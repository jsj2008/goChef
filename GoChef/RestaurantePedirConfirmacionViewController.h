//
//  RestaurantePedirConfirmacionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedido.h"
#import "CustomUITableViewCellPedidoPie.h"
#import "CustomUITableViewCellPedidoCabecera.h"
#import "SelectOfertaViewController.h"

@class EnviarPedidoViewController, PedidoPlatoViewController;

@interface RestaurantePedirConfirmacionViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, SelectOfertaViewControllerDelegate, CustomUITableViewCellPedidoDelegate, CustomUITableViewCellPedidoPieDelegate, CustomUITableViewCellPedidoCabeceraDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellPedido         *_CUITVCP_cell; 
    CustomUITableViewCellPedidoCabecera *_CUITVCP_cabecera;
    CustomUITableViewCellPedidoPie      *_CUITVCP_pie;
    
    EnviarPedidoViewController *_EPVC_enviar;  
    PedidoPlatoViewController  *_PPVC_plato;
    
    SelectOfertaViewController *_SOVC_oferta;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellPedido         *CUITVCP_cell; 
@property (nonatomic, retain) CustomUITableViewCellPedidoCabecera *CUITVCP_cabecera;
@property (nonatomic, retain) CustomUITableViewCellPedidoPie      *CUITVCP_pie;

@property (nonatomic, retain) EnviarPedidoViewController *EPVC_enviar;
@property (nonatomic, retain) PedidoPlatoViewController  *PPVC_plato;

@property (nonatomic, retain) SelectOfertaViewController *SOVC_oferta;


-(void) initNavigationBar;


@end
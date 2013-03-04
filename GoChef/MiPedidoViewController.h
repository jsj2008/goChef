//
//  MiPedidoViewController.h
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


@protocol MiPedidoViewControllerDelegate

-(void) Tabbar_dom_buscar_Touched;
-(void) Tabbar_pre_datos_Touched;
-(void) Tabbar_pre_pedir_Touched;

@end

@class PedidoPlatoViewController, EnviarPedidoViewController;

@interface MiPedidoViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, SelectOfertaViewControllerDelegate, CustomUITableViewCellPedidoDelegate, CustomUITableViewCellPedidoPieDelegate, CustomUITableViewCellPedidoCabeceraDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellPedido         *_CUITVCP_cell; 
    CustomUITableViewCellPedidoCabecera *_CUITVCP_cabecera;
    CustomUITableViewCellPedidoPie      *_CUITVCP_pie;
    
    EnviarPedidoViewController *_EPVC_enviar;  
    PedidoPlatoViewController  *_PPVC_plato;
    
    SelectOfertaViewController *_SOVC_oferta;
    
    __unsafe_unretained id<MiPedidoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<MiPedidoViewControllerDelegate> delegate;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellPedido         *CUITVCP_cell; 
@property (nonatomic, retain) CustomUITableViewCellPedidoCabecera *CUITVCP_cabecera;
@property (nonatomic, retain) CustomUITableViewCellPedidoPie      *CUITVCP_pie;

@property (nonatomic, retain) EnviarPedidoViewController *EPVC_enviar;
@property (nonatomic, retain) PedidoPlatoViewController  *PPVC_plato;

@property (nonatomic, retain) SelectOfertaViewController *SOVC_oferta;


-(void) initNavigationBar;


@end
//
//  RestauranteEnCocinaContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellEnCocinaPie.h"


@protocol RestauranteEnCocinaContenedorViewControllerDelegate

-(void) Tabbar_rst_pedir_Touched;
-(void) Tabbar_rst_pagar_Touched;

@end

@class EnviarPedidoViewController, PedidoPlatoViewController, CustomUITableViewCellEnCocina;

@interface RestauranteEnCocinaContenedorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellEnCocinaPieDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellEnCocina    *_CUITVCP_cell; 
    CustomUITableViewCellEnCocinaPie *_CUITVCP_pie;
    
    EnviarPedidoViewController *_EPVC_enviar;  
    PedidoPlatoViewController  *_PPVC_plato;
    
    __unsafe_unretained id<RestauranteEnCocinaContenedorViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<RestauranteEnCocinaContenedorViewControllerDelegate> delegate;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellEnCocina    *CUITVCP_cell; 
@property (nonatomic, retain) CustomUITableViewCellEnCocinaPie *CUITVCP_pie;

@property (nonatomic, retain) EnviarPedidoViewController *EPVC_enviar;
@property (nonatomic, retain) PedidoPlatoViewController  *PPVC_plato;


-(void) initNavigationBar;


@end
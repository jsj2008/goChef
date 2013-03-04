//
//  BuscarRestauranteContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "RestauranteAllInfoViewController.h"

#import "CustomUITableViewCellBuscarRestaurante.h"
#import "CustomUITableViewCellBuscarRestauranteHeader.h"

#import "SelectTipoCocinaViewController.h"
#import "SelectRestauranteViewController.h"


@protocol RestauranteShortInfoViewControllerDelegate

-(void) Tabbar_mi_saco_Touched:(BOOL)B_resetTabbarButton;
-(void) Tabbar_pre_pedir_Touched;
-(void) Tabbar_mi_cuenta_Touched;

@end

@class CustomUITableViewCellMore;

@interface RestauranteShortInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellBuscarRestauranteDelegate, CustomUITableViewCellBuscarRestauranteHeaderDelegate, SelectTipoCocinaViewControllerDelegate, SelectRestauranteViewControllerDelegate, RestauranteAllInfoViewControllerDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellBuscarRestaurante *_CUITVCBR_cell; 
    CustomUITableViewCellBuscarRestauranteHeader *_CUITVCBR_header;
    CustomUITableViewCellMore *_CUITVCM_more;
    
    RestauranteAllInfoViewController *_RAIVC_restaurante;
    
    SelectTipoCocinaViewController *_STCVC_tipo_cocina;
    SelectRestauranteViewController *_SRVC_restaurante;
    
    __unsafe_unretained id<RestauranteShortInfoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<RestauranteShortInfoViewControllerDelegate> delegate;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellBuscarRestaurante *CUITVCBR_cell;
@property (nonatomic, retain) CustomUITableViewCellBuscarRestauranteHeader *CUITVCBR_header;
@property (nonatomic, retain) CustomUITableViewCellMore *CUITVCM_more;

@property (nonatomic, retain) RestauranteAllInfoViewController *RAIVC_restaurante;

@property (nonatomic, retain) SelectTipoCocinaViewController *STCVC_tipo_cocina;
@property (nonatomic, retain) SelectRestauranteViewController *SRVC_restaurante;


-(void) initNavigationBar;


@end
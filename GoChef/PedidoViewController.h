//
//  PedidoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"
#import "UIScrollViewWithTouchEvent.h"

#import "CustomUITableViewCellPlatos.h"
#import "CustomUITableViewCellCarta.h"

#import "SelectTipoCartaViewController.h"
#import "SelectPrecioViewController.h"


@protocol PedidoViewControllerDelegate

-(void) Tabbar_pre_datos_Touched;

@end


@class CustomUITableViewHeaderSectionPlatosViewController, PedidoPlatoViewController;

@interface PedidoViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellPlatosDelegate, CustomUITableViewCellCartaDelegate, SelectTipoCartaViewControllerDelegate, SelectPrecioViewControllerDelegate> {
    
    NSMutableArray *_NSMA_max_number;
    NSMutableArray *_NSMA_categoria_number;
    
    NSInteger _NSI_idmenu_selected;
    
    IBOutlet UILabel *UIL_number;
    IBOutlet UILabel *UIL_tipo_carta;
    IBOutlet UILabel *UIL_tipo_menu;
    IBOutlet UILabel *UIL_precio;
    
    IBOutlet UITableView *UITV_listado_carta;
    IBOutlet UITableView *UITV_listado_menus;
    
    IBOutlet UIScrollViewWithTouchEvent *UISV_contenido;
    IBOutlet UIView *UIV_carta;
    IBOutlet UIView *UIV_menus;
    
    CustomUITableViewCellPlatos *_CUITVCP_cell;
    CustomUITableViewCellCarta *_CUITVCC_cell;
    
    CustomUITableViewHeaderSectionPlatosViewController *_CUITVCP_header;
    
    PedidoPlatoViewController *_PPVC_plato;
    
    SelectTipoCartaViewController *_STCVC_tipo_carta;
    SelectPrecioViewController *_SPVC_precio;
    
    __unsafe_unretained id<PedidoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<PedidoViewControllerDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *NSMA_max_number;
@property (nonatomic, retain) NSMutableArray *NSMA_categoria_number;

@property (nonatomic, readwrite) NSInteger NSI_idmenu_selected;

@property (nonatomic, retain) UILabel *UIL_number;
@property (nonatomic, retain) UILabel *UIL_tipo_carta;
@property (nonatomic, retain) UILabel *UIL_tipo_menu;
@property (nonatomic, retain) UILabel *UIL_precio;

@property (nonatomic, retain) UITableView *UITV_listado_carta;
@property (nonatomic, retain) UITableView *UITV_listado_menus;

@property (nonatomic, retain) UIScrollViewWithTouchEvent *UISV_contenido;
@property (nonatomic, retain) UIView *UIV_carta;
@property (nonatomic, retain) UIView *UIV_menus;

@property (nonatomic, retain) CustomUITableViewCellPlatos *CUITVCP_cell;
@property (nonatomic, retain) CustomUITableViewCellCarta *CUITVCC_cell;

@property (nonatomic, retain) CustomUITableViewHeaderSectionPlatosViewController *CUITVCP_header;

@property (nonatomic, retain) PedidoPlatoViewController *PPVC_plato;

@property (nonatomic, retain) SelectTipoCartaViewController *STCVC_tipo_carta;
@property (nonatomic, retain) SelectPrecioViewController *SPVC_precio;


-(IBAction) UIB_add_number_TouchUpInside        :(id)sender;
-(IBAction) UIB_redo_number_TouchUpInside       :(id)sender;
-(IBAction) UIB_select_tipo_carta_TouchUpInside :(id)sender;
-(IBAction) UIB_select_precio_TouchUpInside     :(id)sender;


-(void) initNavigationBar;


@end
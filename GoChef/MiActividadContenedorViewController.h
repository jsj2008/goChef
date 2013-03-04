//
//  MiActividadContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiActividad.h"

@class MiActividadDetalleViewController, CustomUITableViewCellMore;

@interface MiActividadContenedorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellMiActividadDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellMiActividad *_CUITVCMA_cell;
    CustomUITableViewCellMore *_CUITVCM_more;
    
    MiActividadDetalleViewController *_MADVC_detalle;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellMiActividad *CUITVCMA_cell;
@property (nonatomic, retain) CustomUITableViewCellMore *CUITVCM_more;

@property (nonatomic, retain) MiActividadDetalleViewController *MADVC_detalle;


-(void) initNavigationBar;


@end
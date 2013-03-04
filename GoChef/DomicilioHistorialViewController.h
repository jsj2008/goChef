//
//  DomicilioHistorialViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedirHistorial.h"
#import "DireccionesViewController.h"

@protocol DomicilioHistorialViewControllerDelegate

-(void) UIB_pedir_domicilio_Touched;

@end

@class OrderClass, CustomUITableViewCellMore;

@interface DomicilioHistorialViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellPedirHistorialDelegate, DireccionesViewControllerDelegate> {
    
    OrderClass *_OC_order;
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellPedirHistorial *_CUITVCMA_cell;
    CustomUITableViewCellMore *_CUITVCM_more;
    
    DireccionesViewController *_DVC_direccion;
    
    __unsafe_unretained id<DomicilioHistorialViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<DomicilioHistorialViewControllerDelegate> delegate;

@property (nonatomic, retain) OrderClass *OC_order;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellPedirHistorial *CUITVCMA_cell;
@property (nonatomic, retain) CustomUITableViewCellMore *CUITVCM_more;

@property (nonatomic, retain) DireccionesViewController *DVC_direccion;


-(void) initNavigationBar;


@end
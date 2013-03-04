//
//  OpcionesMiHistorialViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellHistorial.h"

@class MiActividadConfirmarViewController, CustomUITableViewCellMore;

@interface OpcionesMiHistorialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellHistorialDelegate> {
    
    IBOutlet UILabel *UIL_total_spending;
    IBOutlet UILabel *UIL_total_saving;
    IBOutlet UILabel *UIL_restaurants_visits;
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellHistorial *_CUITVCMA_cell;
    CustomUITableViewCellMore *_CUITVCM_more;
    
    MiActividadConfirmarViewController *_MACVC_ticket;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UILabel *UIL_total_spending;
@property (nonatomic, retain) UILabel *UIL_total_saving;
@property (nonatomic, retain) UILabel *UIL_restaurants_visits;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellHistorial *CUITVCMA_cell;
@property (nonatomic, retain) CustomUITableViewCellMore *CUITVCM_more;

@property (nonatomic, retain) MiActividadConfirmarViewController *MACVC_ticket;


-(void) initNavigationBar;


@end
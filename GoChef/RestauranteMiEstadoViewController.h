//
//  RestauranteMiEstadoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiEstado.h"

@protocol RestauranteMiEstadoViewControllerDelegate
@end

@interface RestauranteMiEstadoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellMiEstadoDelegate> {
    
    IBOutlet UILabel *UIL_discount;
    IBOutlet UILabel *UIL_description;
    
    IBOutlet UIImageView *UIIV_name;
    IBOutlet UIImageView *UIIV_price;
    IBOutlet UIImageView *UIIV_accumulated;
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellMiEstado *_CUITVCMS_cell; 
    
    __unsafe_unretained id<RestauranteMiEstadoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<RestauranteMiEstadoViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_discount;
@property (nonatomic, retain) UILabel *UIL_description;

@property (nonatomic, retain) UIImageView *UIIV_name;
@property (nonatomic, retain) UIImageView *UIIV_price;
@property (nonatomic, retain) UIImageView *UIIV_accumulated;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellMiEstado *CUITVCMS_cell;


-(void) initNavigationBar;


@end
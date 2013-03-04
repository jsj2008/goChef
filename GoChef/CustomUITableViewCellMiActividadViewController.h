//
//  CustomUITableViewCellMyWalletViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellMiActividadViewControllerDelegate

-(void) cellTouched:(OrderClass *)OC_order;

@end


@interface CustomUITableViewCellMiActividadViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_restaurante;
    IBOutlet UILabel *UIL_tipo_pedido;
    IBOutlet UILabel *UIL_fecha;
    IBOutlet UILabel *UIL_estado;
    IBOutlet UILabel *UIL_precio;
    
    IBOutlet UIImageView *UIIV_confirmado;
    IBOutlet UIImageView *UIIV_pagado;
    IBOutlet UIImageView *UIIV_background;
    IBOutlet UIImageView *UIIV_new;
    
    IBOutlet UIButton *UIB_cell;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellMiActividadViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiActividadViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurante;
@property (nonatomic, retain) UILabel *UIL_tipo_pedido;
@property (nonatomic, retain) UILabel *UIL_fecha;
@property (nonatomic, retain) UILabel *UIL_estado;
@property (nonatomic, retain) UILabel *UIL_precio;

@property (nonatomic, retain) UIImageView *UIIV_confirmado;
@property (nonatomic, retain) UIImageView *UIIV_pagado;
@property (nonatomic, retain) UIImageView *UIIV_background;
@property (nonatomic, retain) UIImageView *UIIV_new;

@property (nonatomic, retain) UIButton *UIB_cell;

@property (nonatomic, retain) OrderClass *OC_order;

-(void) setContentWith:(OrderClass *)newOC_order; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;


@end
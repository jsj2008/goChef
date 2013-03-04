//
//  CustomUITableViewCellHistorialViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellHistorialViewControllerDelegate

-(void) cellTouched:(OrderClass *)OC_order;

@end


@interface CustomUITableViewCellHistorialViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_restaurante;
    IBOutlet UILabel *UIL_gasto;
    IBOutlet UILabel *UIL_ahorro;
    IBOutlet UILabel *UIL_fecha;
    
    IBOutlet UIImageView *UIIV_imagen;
    
    IBOutlet UIButton *UIB_cell;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellHistorialViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellHistorialViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurante;
@property (nonatomic, retain) UILabel *UIL_gasto;
@property (nonatomic, retain) UILabel *UIL_ahorro;
@property (nonatomic, retain) UILabel *UIL_fecha;

@property (nonatomic, retain) UIImageView *UIIV_imagen;

@property (nonatomic, retain) UIButton *UIB_cell;

@property (nonatomic, retain) OrderClass *OC_order;

-(void) setContentWith:(OrderClass *)newOC_order; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;


@end
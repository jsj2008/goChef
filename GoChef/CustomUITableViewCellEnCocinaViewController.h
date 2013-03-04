//
//  CustomUITableViewCellEnCocinaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderFoodClass;

@interface CustomUITableViewCellEnCocinaViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_plato;
    IBOutlet UILabel *UIL_cantidad;
    IBOutlet UILabel *UIL_caraceristicas;
    IBOutlet UILabel *UIL_precio;
    
    IBOutlet UIImageView *UIIV_precio_background;
    
    OrderFoodClass *_OFC_food;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UILabel *UIL_nombre_plato;
@property (nonatomic, retain) UILabel *UIL_cantidad;
@property (nonatomic, retain) UILabel *UIL_caraceristicas;
@property (nonatomic, retain) UILabel *UIL_precio;

@property (nonatomic, retain) UIImageView *UIIV_precio_background;

@property (nonatomic, retain) OrderFoodClass *OFC_food;


-(void) setContentWith:(OrderFoodClass *)newOFC_food;


@end
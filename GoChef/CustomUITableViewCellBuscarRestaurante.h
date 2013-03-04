//
//  CustomUITableViewCellBuscarRestaurante.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellBuscarRestauranteViewController.h"


@class RestaurantClass;

@protocol CustomUITableViewCellBuscarRestauranteDelegate

-(void) cellTouched:(RestaurantClass *)RC_restaurant;
-(void) Tabbar_mi_saco_Touched;

@end


@interface CustomUITableViewCellBuscarRestaurante : UITableViewCell <CustomUITableViewCellBuscarRestauranteViewControllerDelegate> {
    
    RestaurantClass *_RC_restaurant;
    
    CustomUITableViewCellBuscarRestauranteViewController *_CUITVCBRVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellBuscarRestauranteDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellBuscarRestauranteDelegate> delegate;

@property (nonatomic, retain) RestaurantClass *RC_restaurant;

@property (nonatomic, retain) CustomUITableViewCellBuscarRestauranteViewController *CUITVCBRVC_cell;

-(void) setContentWith:(RestaurantClass *)newRC_restaurant;


@end

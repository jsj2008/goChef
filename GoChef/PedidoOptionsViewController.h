//
//  PedidoOptionsViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellIngrediente.h"

@class FoodClass;

@interface PedidoOptionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellIngredienteDelegate> {
    
    FoodClass *_FC_food;
    
    IBOutlet UITableView *UITV_listado;
    
    CustomUITableViewCellIngrediente *_CUITVCBR_cell; 
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) FoodClass *FC_food;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) CustomUITableViewCellIngrediente *CUITVCBR_cell;


-(void) initNavigationBar;

-(IBAction) UIB_guardar_seleccion_TouchUpInside:(id)sender;


@end
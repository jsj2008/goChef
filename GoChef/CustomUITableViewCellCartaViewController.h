//
//  CustomUITableViewCellPlatosViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class FoodClass;

@protocol CustomUITableViewCellCartaViewControllerDelegate

-(void) cellTouched:(FoodClass *)FC_food;

@end

@interface CustomUITableViewCellCartaViewController : UIViewController {
    
    IBOutlet UILabel *UIL_precio;
    IBOutlet UILabel *UIL_plato;
    
    IBOutlet UIImageView *UIIV_precio_background;
    IBOutlet UIImageView *UIIV_flecha;

    BOOL _B_readonly;
    FoodClass *_FC_food;
    
    __unsafe_unretained id<CustomUITableViewCellCartaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellCartaViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_precio;
@property (nonatomic, retain) UILabel *UIL_plato;

@property (nonatomic, retain) UIImageView *UIIV_precio_background;
@property (nonatomic, retain) UIImageView *UIIV_flecha;

@property (nonatomic, readwrite) BOOL B_readonly;
@property (nonatomic, retain) FoodClass *FC_food;


-(void) setContentWith:(FoodClass *)newFC_food readOnlyMode:(BOOL)newB_readonly; 

-(IBAction) UIB_cell_TouchUpInside:(id)sender;



@end
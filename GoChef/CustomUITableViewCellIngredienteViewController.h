//
//  CustomUITableViewCellIngredienteViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class FoodOptionClass;

@protocol CustomUITableViewCellIngredienteViewControllerDelegate

-(void) cellTouched:(FoodOptionClass *)FOC_food_option options:(BOOL)B_options;

@end

@interface CustomUITableViewCellIngredienteViewController : UIViewController {
    
    BOOL _B_active;
    BOOL _B_options;
    BOOL _B_onlyCheck;
    
    IBOutlet UILabel *UIL_nombre;
    IBOutlet UILabel *UIL_precio;
    
    IBOutlet UIImageView *UIIV_precio_background;
    
    FoodOptionClass *_FOC_food_option;
    
    __unsafe_unretained id<CustomUITableViewCellIngredienteViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellIngredienteViewControllerDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_active;
@property (nonatomic, readwrite) BOOL B_options;
@property (nonatomic, readwrite) BOOL B_onlyCheck;

@property (nonatomic, retain) UILabel *UIL_nombre;
@property (nonatomic, retain) UILabel *UIL_precio;

@property (nonatomic, retain) UIImageView *UIIV_precio_background;

@property (nonatomic, retain) FoodOptionClass *FOC_food_option;


-(void) setContentWith:(FoodOptionClass *)newFOC_food_option active:(BOOL)B_active onlyCheck:(BOOL)B_onlyCheck; 
-(void) setContentWithText:(NSString *)NSS_text price:(CGFloat)CGF_price active:(BOOL)B_active; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;



@end
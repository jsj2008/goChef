//
//  CustomUITableViewCellIngrediente.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellIngredienteViewController.h"


@class FoodOptionClass;

@protocol CustomUITableViewCellIngredienteDelegate

-(void) cellTouched:(FoodOptionClass *)FOC_food_option options:(BOOL)B_options;

@end

@interface CustomUITableViewCellIngrediente : UITableViewCell <CustomUITableViewCellIngredienteViewControllerDelegate> {
    
    FoodOptionClass *_FOC_food_option;
    
    CustomUITableViewCellIngredienteViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellIngredienteDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellIngredienteDelegate> delegate;

@property (nonatomic, retain) FoodOptionClass *FOC_food_option;

@property (nonatomic, retain) CustomUITableViewCellIngredienteViewController *CUITVCPVC_cell;

-(void) setContentWith:(FoodOptionClass *)newFOC_food_option active:(BOOL)B_active onlyCheck:(BOOL)B_onlyCheck;
-(void) setContentWithText:(NSString *)NSS_text price:(CGFloat)CGF_price active:(BOOL)B_active;


@end

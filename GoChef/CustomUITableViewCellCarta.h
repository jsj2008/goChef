//
//  CustomUITableViewCellCarta.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellCartaViewController.h"


@class FoodClass;

@protocol CustomUITableViewCellCartaDelegate

-(void) cellTouched:(FoodClass *)FC_food;

@end

@interface CustomUITableViewCellCarta : UITableViewCell <CustomUITableViewCellCartaViewControllerDelegate> {
    
    BOOL _B_readonly;
    FoodClass *_FC_food;
    
    CustomUITableViewCellCartaViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellCartaDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellCartaDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_readonly;
@property (nonatomic, retain) FoodClass *FC_food;

@property (nonatomic, retain) CustomUITableViewCellCartaViewController *CUITVCPVC_cell;

-(void) setContentWith:(FoodClass *)newFC_food readOnlyMode:(BOOL)newB_readonly;



@end

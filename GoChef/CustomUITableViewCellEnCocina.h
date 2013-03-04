//
//  CustomUITableViewCellEnCocina.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderFoodClass, CustomUITableViewCellEnCocinaViewController;


@interface CustomUITableViewCellEnCocina : UITableViewCell  {
    
    OrderFoodClass *_OFC_food;
    
    CustomUITableViewCellEnCocinaViewController *_CUITVCPVC_cell;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) OrderFoodClass *OFC_food;

@property (nonatomic, retain) CustomUITableViewCellEnCocinaViewController *CUITVCPVC_cell;


-(void) setContentWith:(OrderFoodClass *)newOFC_food;


@end

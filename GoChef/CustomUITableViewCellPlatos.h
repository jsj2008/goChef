//
//  CustomUITableViewCellPlatos.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPlatosViewController.h"


@class DailymenufoodClass;

@protocol CustomUITableViewCellPlatosDelegate

-(void) add_numberTouched :(id)sender idCategoria:(NSInteger)NSI_id_categoria;
-(void) redo_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria;

@end

@interface CustomUITableViewCellPlatos : UITableViewCell <CustomUITableViewCellPlatosViewControllerDelegate> {
    
    BOOL _B_readonly;
    DailymenufoodClass *_MFC_food;
    
    CustomUITableViewCellPlatosViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPlatosDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPlatosDelegate> delegate;

@property (nonatomic, readwrite) BOOL B_readonly;
@property (nonatomic, retain) DailymenufoodClass *MFC_food;

@property (nonatomic, retain) CustomUITableViewCellPlatosViewController *CUITVCPVC_cell;

-(void) setContentWith:(DailymenufoodClass *)newMFC_food readOnlyMode:(BOOL)newB_readonly cantidad:(NSInteger)NSI_cantidad;


@end

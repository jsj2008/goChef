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


@class DailymenufoodClass;

@protocol CustomUITableViewCellPlatosViewControllerDelegate

-(void) add_numberTouched :(id)sender idCategoria:(NSInteger)NSI_id_categoria;
-(void) redo_numberTouched:(id)sender idCategoria:(NSInteger)NSI_id_categoria;

@end

@interface CustomUITableViewCellPlatosViewController : UIViewController {
       
    IBOutlet UILabel *UIL_number;
    IBOutlet UILabel *UIL_plato;
    
    IBOutlet UIButton *UIB_add_number;
    IBOutlet UIButton *UIB_redo_number;
    IBOutlet UIImageView *UIIV_number_background;

    BOOL _B_readonly;
    DailymenufoodClass *_MFC_food;
    
    __unsafe_unretained id<CustomUITableViewCellPlatosViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPlatosViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_number;
@property (nonatomic, retain) UILabel *UIL_plato;

@property (nonatomic, retain) UIButton *UIB_add_number;
@property (nonatomic, retain) UIButton *UIB_redo_number;
@property (nonatomic, retain) UIImageView *UIIV_number_background;

@property (nonatomic, readwrite) BOOL B_readonly;
@property (nonatomic, retain) DailymenufoodClass *MFC_food;


-(void) setContentWith:(DailymenufoodClass *)newMFC_food readOnlyMode:(BOOL)newB_readonly cantidad:(NSInteger)NSI_cantidad;


-(IBAction) UIB_cell_TouchUpInside          :(id)sender;
-(IBAction) UIB_add_number_TouchUpInside    :(id)sender;
-(IBAction) UIB_redo_number_TouchUpInside   :(id)sender;


@end
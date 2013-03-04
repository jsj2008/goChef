//
//  PedidoPlatoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "PedidoInstructionsViewController.h"
#import "CustomUITableViewCellIngrediente.h"
#import "AsynchronousImageView.h"

@class PedidoOptionsViewController, FoodClass, OrderFoodClass;

@interface PedidoPlatoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PedidoInstructionsViewControllerDelegate, CustomUITableViewCellIngredienteDelegate> {
    
    BOOL _B_update;
    BOOL _B_loading_finish;
    
    CGFloat _CGF_price;
    NSInteger _NSI_init_amount;
    
    FoodClass *_FC_food;
    
    IBOutlet UITextView *UIL_namefood;
    IBOutlet UILabel *UIL_amount;
    IBOutlet UILabel *UIL_price;
    
    IBOutlet UIView *UIV_options;
    IBOutlet UIView *UIV_options_obligatories;
    IBOutlet UIView *UIV_add_mi_pedido;
    
    IBOutlet AsynchronousImageView *UIIV_image;
    
    IBOutlet UIScrollView *UISV_scroll;
    
    IBOutlet UITableView *UITV_options;
    IBOutlet UITableView *UITV_options_obligatories;
    
    PedidoOptionsViewController *_POVC_options;
    PedidoInstructionsViewController *_PIVC_instruction;
    
    CustomUITableViewCellIngrediente *_CUITVCBR_cell;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_update;
@property (nonatomic, readwrite) BOOL B_loading_finish;

@property (nonatomic, readwrite) CGFloat CGF_price;
@property (nonatomic, readwrite) NSInteger NSI_init_amount;

@property (nonatomic, retain) FoodClass *FC_food;

@property (nonatomic, retain) UITextView *UIL_namefood;
@property (nonatomic, retain) UILabel *UIL_amount;
@property (nonatomic, retain) UILabel *UIL_price;

@property (nonatomic, retain) UIView *UIV_options;
@property (nonatomic, retain) UIView *UIV_options_obligatories;
@property (nonatomic, retain) UIView *UIV_add_mi_pedido;

@property (nonatomic, retain) UIImageView *UIIV_image;

@property (nonatomic, retain) UIScrollView *UISV_scroll;

@property (nonatomic, retain) UITableView *UITV_options;
@property (nonatomic, retain) UITableView *UITV_options_obligatories;

@property (nonatomic, retain) PedidoOptionsViewController *POVC_options;
@property (nonatomic, retain) PedidoInstructionsViewController *PIVC_instruction;

@property (nonatomic, retain) CustomUITableViewCellIngrediente *CUITVCBR_cell;


-(IBAction) UIB_add_mi_pedido_TouchUpInside :(id)sender;
-(IBAction) UIB_add_amount_TouchUpInside    :(id)sender;
-(IBAction) UIB_redo_amount_TouchUpInside   :(id)sender;
-(IBAction) UIB_instructions_TouchUpInside  :(id)sender;


-(void) initNavigationBar;


@end
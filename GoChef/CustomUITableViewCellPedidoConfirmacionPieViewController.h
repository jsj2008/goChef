//
//  CustomUITableViewCellPedidoConfirmacionPieViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellPedidoConfirmacionPieViewControllerDelegate

-(void) show_instructions_Touched;
-(void) status_Touched;

@end


@interface CustomUITableViewCellPedidoConfirmacionPieViewController : UIViewController {
    
    IBOutlet UILabel *UIL_total;
    IBOutlet UIButton *UIB_status;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoConfirmacionPieViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoConfirmacionPieViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_total;
@property (nonatomic, retain) UIButton *UIB_status;

@property (nonatomic, retain) OrderClass *OC_order;


-(IBAction) UIB_show_instructions_TouchUpInside:(id)sender;
-(IBAction) UIB_status_TouchUpInside:(id)sender;

-(void) setContentWith:(OrderClass *)newOC_order;


@end
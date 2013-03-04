//
//  CustomUITableViewCellMiActividadPieViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class OrderClass;

@protocol CustomUITableViewCellMiActividadPieViewControllerDelegate

-(void) show_instructions_Touched;
-(void) status_Touched;

@end


@interface CustomUITableViewCellMiActividadPieViewController : UIViewController {
    
    IBOutlet UILabel *UIL_subtotal;
    IBOutlet UILabel *UIL_descuento;
    IBOutlet UILabel *UIL_gastos_envio;
    IBOutlet UILabel *UIL_descuento_ofertas;
    IBOutlet UILabel *UIL_descuento_facebook;   
    IBOutlet UILabel *UIL_total;
    
    IBOutlet UIButton *UIB_status;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellMiActividadPieViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiActividadPieViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_subtotal;
@property (nonatomic, retain) UILabel *UIL_descuento;
@property (nonatomic, retain) UILabel *UIL_gastos_envio;
@property (nonatomic, retain) UILabel *UIL_descuento_ofertas;
@property (nonatomic, retain) UILabel *UIL_descuento_facebook;
@property (nonatomic, retain) UILabel *UIL_total;

@property (nonatomic, retain) UIButton *UIB_status;

@property (nonatomic, retain) OrderClass *OC_order;


-(void) setContentWith:(OrderClass *)newOC_order;


-(IBAction) UIB_show_instructions_TouchUpInside:(id)sender;
-(IBAction) UIB_status_TouchUpInside:(id)sender;


@end
//
//  CustomUITableViewCellEnCocinaPieViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol CustomUITableViewCellEnCocinaPieViewControllerDelegate

-(void) pedir_mas_comida_touched;
-(void) pagar_touched;

@end

@class OrderClass;

@interface CustomUITableViewCellEnCocinaPieViewController : UIViewController {
    
    IBOutlet UILabel *UIL_subtotal;
    IBOutlet UILabel *UIL_descuento;
    IBOutlet UILabel *UIL_descuento_ofertas;
    IBOutlet UILabel *UIL_total;
    
    IBOutlet UIImageView *UIIV_background;
    
    OrderClass *_OC_order;
    
    __unsafe_unretained id<CustomUITableViewCellEnCocinaPieViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellEnCocinaPieViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_subtotal;
@property (nonatomic, retain) UILabel *UIL_descuento;
@property (nonatomic, retain) UILabel *UIL_descuento_ofertas;
@property (nonatomic, retain) UILabel *UIL_total;

@property (nonatomic, retain) UIImageView *UIIV_background;

@property (nonatomic, retain) OrderClass *OC_order;


-(IBAction) UIB_pagar_TouchUpInside:(id)sender;
-(IBAction) UIB_pedir_mas_comida_TouchUpInside:(id)sender;


-(void) setContentWith:(OrderClass *)newOC_order;


@end
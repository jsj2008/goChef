//
//  CustomUITableViewCellCreditCardViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class TarjetaClass;

@protocol CustomUITableViewCellCreditCardViewControllerDelegate

-(void) cellTouched:(TarjetaClass *)TC_creditcard;
-(void) removeTouched:(TarjetaClass *)TC_creditcard;

@end

@interface CustomUITableViewCellCreditCardViewController : UIViewController {
    
    BOOL _B_edit_mode;
    
    IBOutlet UILabel *UIL_creditcard;

    IBOutlet UIButton *UIB_default;
    IBOutlet UIButton *UIB_remove;
    
    TarjetaClass *_TC_creditcard;
    
    __unsafe_unretained id<CustomUITableViewCellCreditCardViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_edit_mode;

@property (nonatomic, assign) id<CustomUITableViewCellCreditCardViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_creditcard;

@property (nonatomic, retain) UIButton *UIB_default;
@property (nonatomic, retain) UIButton *UIB_remove;

@property (nonatomic, retain) TarjetaClass *TC_creditcard;


-(IBAction) UIB_cell_TouchUpInside   :(id)sender;
-(IBAction) UIB_remove_TouchUpInside :(id)sender;


-(void) setContentWith :(TarjetaClass *)newTC_creditcard edit_mode:(BOOL)newB_edit_mode;
-(void) changeEditMode :(BOOL)newB_edit_mode;
-(void) setDefault     :(BOOL)B_default;

@end
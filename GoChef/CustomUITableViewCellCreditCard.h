//
//  CustomUITableViewCellCreditCard.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellCreditCardViewController.h"


@class TarjetaClass;

@protocol CustomUITableViewCellCreditCardDelegate

-(void) cellTouched:(TarjetaClass *)TC_creditcard;
-(void) removeTouched:(TarjetaClass *)TC_creditcard;

@end

@interface CustomUITableViewCellCreditCard : UITableViewCell <CustomUITableViewCellCreditCardViewControllerDelegate> {
    
    TarjetaClass *_TC_creditcard;
    
    CustomUITableViewCellCreditCardViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellCreditCardDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellCreditCardDelegate> delegate;

@property (nonatomic, retain) TarjetaClass *TC_creditcard;

@property (nonatomic, retain) CustomUITableViewCellCreditCardViewController *CUITVCPVC_cell;


-(void) setContentWith :(TarjetaClass *)newTC_creditcard edit_mode:(BOOL)newB_edit_mode;


@end

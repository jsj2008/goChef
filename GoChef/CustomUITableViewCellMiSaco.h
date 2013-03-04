//
//  CustomUITableViewCellMyWallet.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiSacoViewController.h"


@class UserOfferClass;

@protocol CustomUITableViewCellMiSacoDelegate

-(void) cellTouched:(UserOfferClass *)UOC_offer;

@end


@interface CustomUITableViewCellMiSaco : UITableViewCell <CustomUITableViewCellMiSacoViewControllerDelegate> {
    
    UserOfferClass *_UOC_offer;
    
    CustomUITableViewCellMiSacoViewController *_CUITVCMSVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellMiSacoDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiSacoDelegate> delegate;

@property (nonatomic, retain) UserOfferClass *UOC_offer;

@property (nonatomic, retain) CustomUITableViewCellMiSacoViewController *CUITVCMSVC_cell;

-(void) setContentWith:(UserOfferClass *)newUOC_offer;


@end

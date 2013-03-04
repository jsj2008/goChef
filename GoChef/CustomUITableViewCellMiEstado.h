//
//  CustomUITableViewCellMiEstado.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiEstadoViewController.h"


@class UserOfferClass;

@protocol CustomUITableViewCellMiEstadoDelegate

-(void) cellTouched:(UserOfferClass *)UOC_offer;

@end


@interface CustomUITableViewCellMiEstado : UITableViewCell <CustomUITableViewCellMiEstadoViewControllerDelegate> {
    
    UserOfferClass *_UOC_offer;
    
    CustomUITableViewCellMiEstadoViewController *_CUITVCMSVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellMiEstadoDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiEstadoDelegate> delegate;

@property (nonatomic, retain) UserOfferClass *UOC_offer;

@property (nonatomic, retain) CustomUITableViewCellMiEstadoViewController *CUITVCMSVC_cell;

-(void) setContentWith:(UserOfferClass *)newUOC_offer;


@end

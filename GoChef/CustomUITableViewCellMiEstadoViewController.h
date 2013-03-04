//
//  CustomUITableViewCellMiEstadoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class UserOfferClass;

@protocol CustomUITableViewCellMiEstadoViewControllerDelegate

-(void) cellTouched:(UserOfferClass *)UOC_offer;

@end


@interface CustomUITableViewCellMiEstadoViewController : UIViewController {
    
    IBOutlet UILabel *UIL_titulo;
    
    IBOutlet UIButton *UIB_cell;
    
    UserOfferClass *_UOC_offer;
    
    __unsafe_unretained id<CustomUITableViewCellMiEstadoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiEstadoViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_titulo;

@property (nonatomic, retain) UIButton *UIB_cell;

@property (nonatomic, retain) UserOfferClass *UOC_offer;

-(void) setContentWith:(UserOfferClass *)newUOC_offer; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;


@end
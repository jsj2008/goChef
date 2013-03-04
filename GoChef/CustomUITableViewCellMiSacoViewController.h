//
//  CustomUITableViewCellMiSacoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"
#import "AsynchronousImageView.h"


@class UserOfferClass;

@protocol CustomUITableViewCellMiSacoViewControllerDelegate

-(void) cellTouched:(UserOfferClass *)UOC_offer;

@end


@interface CustomUITableViewCellMiSacoViewController : UIViewController {
    
    IBOutlet UILabel *UIL_titulo;
    IBOutlet UILabel *UIL_nombre_restaurante;
    IBOutlet UILabel *UIL_direccion;
    IBOutlet UILabel *UIL_validez;
    
    IBOutlet AsynchronousImageView *UIIV_imagen;
    
    IBOutlet UIButton *UIB_cell;
    
    UserOfferClass *_UOC_offer;
    
    __unsafe_unretained id<CustomUITableViewCellMiSacoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiSacoViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_titulo;
@property (nonatomic, retain) UILabel *UIL_nombre_restaurante;
@property (nonatomic, retain) UILabel *UIL_direccion;
@property (nonatomic, retain) UILabel *UIL_validez;

@property (nonatomic, retain) UIImageView *UIIV_imagen;

@property (nonatomic, retain) UIButton *UIB_cell;

@property (nonatomic, retain) UserOfferClass *UOC_offer;

-(void) setContentWith:(UserOfferClass *)newUOC_offer; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;


@end
//
//  SelectOfertaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class UserOfferClass;

@protocol SelectOfertaViewControllerDelegate

-(void) select_oferta:(UserOfferClass *)UOC_offer;
-(void) close_select_oferta;

@end


@interface SelectOfertaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    UserOfferClass *_UOC_offer;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectOfertaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectOfertaViewControllerDelegate> delegate;

@property (nonatomic, retain) UserOfferClass *UOC_offer;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_oferta_TouchUpInside:(id)sender;

-(void) setContentWith:(UserOfferClass *)newUOC_offer;


@end
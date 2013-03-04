//
//  SelectPrecioViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class DailymenuClass;

@protocol SelectPrecioViewControllerDelegate

-(void) select_precio:(DailymenuClass *)DMC_menu;
-(void) close_select_precio;

@end


@interface SelectPrecioViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    DailymenuClass *_DMC_menu;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectPrecioViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectPrecioViewControllerDelegate> delegate;

@property (nonatomic, retain) DailymenuClass *DMC_menu;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_precio_TouchUpInside:(id)sender;

-(void) setContentWith:(DailymenuClass *)newDMC_menu;


@end
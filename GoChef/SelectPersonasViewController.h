//
//  SelectPersonasViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class TipoCocinaClass;

@protocol SelectPersonasViewControllerDelegate

-(void) select_personas:(NSInteger)NSI_personas;
-(void) close_select_personas;

@end


@interface SelectPersonasViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSInteger _NSI_personas;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectPersonasViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectPersonasViewControllerDelegate> delegate;

@property (nonatomic, readwrite) NSInteger NSI_personas;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_personas_TouchUpInside:(id)sender;

-(void) setContentWith:(NSInteger)newNSI_personas;


@end
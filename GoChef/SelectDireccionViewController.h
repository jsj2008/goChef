//
//  SelectDireccionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol SelectDireccionViewControllerDelegate

-(void) select_direccion:(NSString *)NSS_direccion;
-(void) close_select_direccion;

@end


@interface SelectDireccionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_NSS_direccion;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectDireccionViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectDireccionViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_direccion;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_direccion_TouchUpInside:(id)sender;

-(void) setContentWith:(NSString *)newNSS_direccion;


@end
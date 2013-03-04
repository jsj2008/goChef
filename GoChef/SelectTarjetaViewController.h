//
//  SelectTarjetaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class TarjetaClass;

@protocol SelectTarjetaViewControllerDelegate

-(void) select_tarjeta:(TarjetaClass *)TC_tarjeta;
-(void) close_select_tarjeta;

@end


@interface SelectTarjetaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_NSS_tarjeta;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectTarjetaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectTarjetaViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_tarjeta;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_tarjeta_TouchUpInside:(id)sender;

-(void) setContentWith:(NSString *)newNSS_tarjeta;


@end
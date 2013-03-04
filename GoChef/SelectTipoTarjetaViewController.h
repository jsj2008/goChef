//
//  SelectTipoTarjetaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol SelectTipoTarjetaViewControllerDelegate

-(void) select_tipo_tarjeta:(NSString *)NSS_tipo_tarjeta;
-(void) close_select_tipo_tarjeta;

@end


@interface SelectTipoTarjetaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_NSS_tipo_tarjeta;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectTipoTarjetaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectTipoTarjetaViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_tipo_tarjeta;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_tipo_tarjeta_TouchUpInside:(id)sender;

-(void) setContentWith:(NSString *)newNSS_tipo_tarjeta;


@end
//
//  SelectTipoCartaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol SelectTipoCartaViewControllerDelegate

-(void) select_tipo_carta:(NSString *)NSS_tipo_carta;
-(void) close_select_tipo_carta;

@end


@interface SelectTipoCartaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_NSS_tipo_carta;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectTipoCartaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectTipoCartaViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_tipo_carta;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_tipo_carta_TouchUpInside:(id)sender;

-(void) setContentWith:(NSString *)new_NSS_tipo_carta;


@end
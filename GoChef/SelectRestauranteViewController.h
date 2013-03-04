//
//  SelectRestauranteViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol SelectRestauranteViewControllerDelegate

-(void) select_restaurante:(NSString *)NSS_restaurante;
-(void) close_select_restaurante;

@end


@interface SelectRestauranteViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_NSS_restaurante;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectRestauranteViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectRestauranteViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_restaurante;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_restaurante_TouchUpInside:(id)sender;

-(void) setContentWith:(NSString *)new_NSS_restaurante;


@end
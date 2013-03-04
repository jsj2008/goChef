//
//  SelectSexoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class TipoCocinaClass;

@protocol SelectSexoViewControllerDelegate

-(void) select_sexo:(typeSexoType)TST_sexo;
-(void) close_select_sexo;

@end


@interface SelectSexoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    typeSexoType _TST_sexo;
    
    IBOutlet UIPickerView *UIPV_listado;
    
    __unsafe_unretained id<SelectSexoViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectSexoViewControllerDelegate> delegate;

@property (nonatomic, readwrite) typeSexoType TST_sexo;

@property (nonatomic, retain) UIPickerView *UIPV_listado;


-(IBAction) UIB_close_select_sexo_TouchUpInside:(id)sender;

-(void) setContentWith:(typeSexoType)newTST_sexo;


@end
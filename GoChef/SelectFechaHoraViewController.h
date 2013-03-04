//
//  SelectFechaHoraViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol SelectFechaHoraViewControllerDelegate

-(void) select_fecha:(NSDate *)NSD_fecha;

@end


@interface SelectFechaHoraViewController : UIViewController {
    
    NSDate *_NSD_fecha;
    
    IBOutlet UIDatePicker *UIDPV_date;
    
    __unsafe_unretained id<SelectFechaHoraViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectFechaHoraViewControllerDelegate> delegate;

@property (nonatomic, retain) NSDate *NSD_fecha;
@property (nonatomic, retain) NSString *NSS_maxHour;
@property (nonatomic, retain) NSString *NSS_minHour;

@property (nonatomic, retain) UIDatePicker *UIDPV_date;


-(IBAction) UIB_close_select_fecha_TouchUpInside:(id)sender;

-(void) setContentWith:(NSDate *)newNSD_fecha;


@end
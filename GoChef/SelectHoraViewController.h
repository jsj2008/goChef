//
//  SelectHoraViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OCCalendarViewController.h"
#import "SingletonGlobal.h"

@protocol SelectHoraViewControllerDelegate

-(void) select_hora:(NSString *)NSD_fecha andType:(NSString*)type withOffer:(BOOL)offer;

@end

@interface SelectHoraViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate, OCCalendarDelegate> {
    
    __unsafe_unretained id<SelectHoraViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectHoraViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIPickerView *UIDPV_date;
@property (nonatomic, retain) OCCalendarViewController *calVC;
@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSDate *previousDate;


-(IBAction) UIB_close_select_hora_TouchUpInside:(id)sender;

@end
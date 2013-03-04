//
//  SelectHoraViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectHoraViewController.h"
#import "OrderClass.h"


@implementation SelectHoraViewController

@synthesize UIDPV_date;
@synthesize delegate = _delegate;
@synthesize dataSourceArray = _dataSourceArray;
@synthesize type = _type;
@synthesize calVC = _calVC;
@synthesize previousDate = _previousDate;

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.type isEqualToString:@"date"]) {
        
        [UIDPV_date removeFromSuperview];
        UIDPV_date = nil;
        
        self.calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(167, 2) inView:self.view arrowPosition:OCArrowPositionNone];
        [self.calVC setDaysWithOffers:self.dataSourceArray];
        self.calVC.delegate = self;
        self.calVC.selectionMode = OCSelectionSingleDate;
        
        if (self.previousDate) {
            [self.calVC setStartDate:self.previousDate];
            [self.calVC setEndDate:self.previousDate];
        } else {
            [self.calVC setStartDate:[NSDate date]];
            [self.calVC setEndDate:[NSDate date]];
        }
    
        [[self.view viewWithTag:777] addSubview:self.calVC.view];

    }
}

#pragma mark - OCCalendarDelegate

- (void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    NSDateFormatter *dFormat = [[NSDateFormatter alloc] init];
    [dFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *day = [dFormat stringFromDate:startDate];
    NSLog(@"day :: %@",day);
    
    BOOL offer = FALSE;

    for (NSDictionary *dict in self.dataSourceArray ) {
        NSString *theKey = [[dict allKeys] objectAtIndex:0];
        
        if ([theKey isEqualToString:day] && [[dict valueForKey:theKey] isEqualToString:@"1"]) {
            offer = TRUE;
            break;
        }
    }
    
    if (_delegate != nil) [_delegate select_hora:day andType:self.type withOffer:offer];


}

-(void) completedWithNoSelection{

}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 11/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_hora_TouchUpInside:(id)sender {
    
    if ([self.type isEqualToString:@"date"]) {
        
        [self.calVC removeCalView];
        
    } else {
        
        NSUInteger selectedRow = [self.UIDPV_date selectedRowInComponent:0];
        // Indicamos al delegado que se ha pulsado sobre la celda
        NSDictionary *dict = [self.dataSourceArray objectAtIndex:selectedRow];
        NSString *theKey = [[dict allKeys] objectAtIndex:0];
        
        BOOL offer = FALSE;
        
        if ([[dict valueForKey:theKey] isEqualToString:@"1"]) {
            offer = TRUE;
        }
        
        if (_delegate != nil) [_delegate select_hora:[NSString stringWithFormat:@"%@",theKey] andType:self.type withOffer:offer];
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [self.dataSourceArray count];
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [@"" stringByAppendingFormat:@"%d",row];
    
    return title;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UIView *viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 30)];
    [viewCell setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *dict = [self.dataSourceArray objectAtIndex:row];
    NSArray *keys = [dict allKeys];
    
    NSString *theKey = [keys objectAtIndex:0];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:viewCell.frame];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [lb setBackgroundColor:[UIColor clearColor]];
    
    NSDateFormatter *frmt = [[NSDateFormatter alloc] init];
    [frmt setDateFormat:@"MM"];
    
    if ([self.type isEqualToString:@"date"]) {
        [lb setText:[@"" stringByAppendingFormat:@"%@/%@",theKey,[frmt stringFromDate:[NSDate date]]]];
    } else {
        [lb setText:[@"" stringByAppendingFormat:@"%@",theKey]];

    }
    [viewCell addSubview:lb];
    
    if ([[dict valueForKey:theKey] isEqualToString:@"1"]) {
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bag.png"]];
        [image setFrame:CGRectMake(50, 7, 15, 15)];
        [viewCell addSubview:image];
    }
    
    return viewCell;

}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}


@end
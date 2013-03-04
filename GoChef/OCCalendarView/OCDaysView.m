//
//  OCDaysView.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCDaysView.h"

@implementation OCDaysView

@synthesize offers = _offers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        startCellX = 3;
        startCellY = 0;
        endCellX = 3;
        endCellY = 0;
        
		hDiff = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 41 : 43;
        vDiff = 30;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    NSDateFormatter *fDate = [[NSDateFormatter alloc] init];
    [fDate setDateFormat:@"MM"];
    //int actualMonth = [[fDate stringFromDate:[NSDate date]] intValue];
    
    CGSize shadow2Offset = CGSizeMake(0, 0);
    CGFloat shadow2BlurRadius = 0;
    CGColorRef shadow2 = [UIColor clearColor].CGColor;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    int month = currentMonth;
    int year = currentYear;
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
	int weekdayOfFirst = [weekdayComponents weekday];
    
    if (weekdayOfFirst == 1) {
        weekdayOfFirst = 7;
    } else {
        weekdayOfFirst = weekdayOfFirst -1;
    }
    
    //NSLog(@"weekdayOfFirst:%d", weekdayOfFirst);

	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
                                       forDate:dateOnFirst].length;
    
    //NSLog(@"month:%d, numDaysInMonth:%d", currentMonth, numDaysInMonth);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    didAddExtraRow = NO;
    
    
    
    //Find number of days in previous month
    NSDateComponents *prevDateParts = [[NSDateComponents alloc] init];
	[prevDateParts setMonth:month-1];
	[prevDateParts setYear:year];
	[prevDateParts setDay:1];
    
    NSDate *prevDateOnFirst = [calendar dateFromComponents:prevDateParts];
        
    int numDaysInPrevMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
                                       forDate:prevDateOnFirst].length;
        
    //Draw the text for each of those days.
    for(int i = 0; i <= weekdayOfFirst-2; i++) {
        int day = numDaysInPrevMonth - weekdayOfFirst + 2 + i;
        
        NSString *str = [NSString stringWithFormat:@"%d", day];
        
        
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
        CGRect dayHeader2Frame = CGRectMake((i)*hDiff, 0, 21, 14);
        [[UIColor lightGrayColor] setFill];
        [str drawInRect: dayHeader2Frame withFont: [UIFont fontWithName: @"Helvetica" size: 14] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
        CGContextRestoreGState(context);
    }
    
    
    UIImage* image = [UIImage imageNamed:@"bag.png"];

    BOOL endedOnSat = NO;
	int finalRow = 0;
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int dayNumber = i * 7 + j;
			
			if(dayNumber >= (weekdayOfFirst-1) && day <= numDaysInMonth) {
                NSString *str = [NSString stringWithFormat:@"%02d", day];
                
                CGContextSaveGState(context);
                //CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
                CGRect dayHeader2Frame = CGRectMake(j*hDiff, i*vDiff, 21, 14);
 
                [[UIColor blackColor] setFill];

                [str drawInRect: dayHeader2Frame withFont: [UIFont fontWithName: @"Helvetica" size: 14] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                BOOL offer = FALSE;
                
                for (NSDictionary *dict in self.offers ) {
                    NSString *theKey = [[dict allKeys] objectAtIndex:0];
                    
                    if ([theKey isEqualToString:str] && [[dict valueForKey:theKey] isEqualToString:@"1"]) {
                        offer = TRUE;
                        break;
                    }
                }
                
                if (offer) {
                    [image drawAtPoint:CGPointMake((j*hDiff)+15, (i*vDiff)+10) blendMode:kCGBlendModeOverlay alpha:1.0];
                }
                
                CGContextRestoreGState(context);
                
                finalRow = i;
                
                if(day == numDaysInMonth && j == 6) {
                    endedOnSat = YES;
                }
                
                if(i == 5) {
                    didAddExtraRow = YES;
                }
				++day;
			}
		}
	}
    
    //Find number of days in previous month
    NSDateComponents *nextDateParts = [[NSDateComponents alloc] init];
	[nextDateParts setMonth:month+1];
	[nextDateParts setYear:year];
	[nextDateParts setDay:1];
    
    NSDate *nextDateOnFirst = [calendar dateFromComponents:nextDateParts];
        
    NSDateComponents *nextWeekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:nextDateOnFirst];
	int weekdayOfNextFirst = [nextWeekdayComponents weekday];
    
    if (weekdayOfNextFirst == 1) {
        weekdayOfNextFirst = 7;
    } else {
        weekdayOfNextFirst = weekdayOfNextFirst -1;
    }
    
    if(!endedOnSat) {
        //Draw the text for each of those days.
        for(int i = weekdayOfNextFirst - 1; i < 7; i++) {
            int day = i - weekdayOfNextFirst + 2;
            
            NSString *str = [NSString stringWithFormat:@"%d", day];
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
            CGRect dayHeader2Frame = CGRectMake((i)*hDiff, finalRow * vDiff, 21, 14);
            [[UIColor lightGrayColor] setFill];
            [str drawInRect: dayHeader2Frame withFont: [UIFont fontWithName: @"Helvetica" size: 14] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
            CGContextRestoreGState(context);
        }
    }
}

- (void)setMonth:(int)month {
    currentMonth = month;
    [self setNeedsDisplay];
}

- (void)setYear:(int)year {
    currentYear = year;
    [self setNeedsDisplay];
}

- (void)resetRows {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    int month = currentMonth;
    int year = currentYear;
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
	int weekdayOfFirst = [weekdayComponents weekday];
    
    if (weekdayOfFirst == 1) {
        weekdayOfFirst = 7;
    } else {
        weekdayOfFirst = weekdayOfFirst -1;
    }
    
	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
                                       forDate:dateOnFirst].length;
    didAddExtraRow = NO;
	
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int dayNumber = i * 7 + j;
			if(dayNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                if(i == 5) {
                    didAddExtraRow = YES;
                    //NSLog(@"didAddExtraRow");
                }
				++day;
			}
		}
	}
}

- (BOOL)addExtraRow {
    return didAddExtraRow;
}


@end

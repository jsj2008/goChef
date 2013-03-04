//
//  CustomUITableViewHeaderSectionPlatosViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface CustomUITableViewHeaderSectionPlatosViewController : UIViewController {

    NSString *_NSS_texto;
    
    IBOutlet UILabel *UIL_texto;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) NSString *NSS_texto;

@property (nonatomic, retain) UILabel *UIL_texto;

-(void) setContentWith:(NSString *)newNSS_texto; 


@end
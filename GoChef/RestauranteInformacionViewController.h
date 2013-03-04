//
//  RestauranteInformacionViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface RestauranteInformacionViewController : UIViewController {
    
    IBOutlet UITextView *UITV_description;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UITextView *UITV_description;


-(void) initNavigationBar;


@end
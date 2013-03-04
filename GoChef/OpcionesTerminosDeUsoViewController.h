//
//  OpcionesTerminosDeUsoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface OpcionesTerminosDeUsoViewController : UIViewController <UIScrollViewDelegate> {
    
    IBOutlet UIScrollView *UISV_scroll;
    IBOutlet UIImageView *UIIV_condiciones_legales;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UIScrollView *UISV_scroll;
@property (nonatomic, retain) UIImageView *UIIV_condiciones_legales;


-(void) initNavigationBar;


@end
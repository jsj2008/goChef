//
//  RestauranteFotosViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface RestauranteFotosViewController : UIViewController <UIScrollViewDelegate> {
    
    NSInteger _NSI_number_image;
    
    IBOutlet UIPageControl *UIPC_imagenes;
    IBOutlet UIScrollView  *UISV_scroll;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_number_image;

@property (nonatomic, retain) UIPageControl *UIPC_imagenes;
@property (nonatomic, retain) UIScrollView  *UISV_scroll;


-(void) initNavigationBar;


@end
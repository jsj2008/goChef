//
//  RestauranteAllInfoGooleMapsViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SingletonGlobal.h"


@interface RestauranteAllInfoGooleMapsViewController : UIViewController <MKMapViewDelegate> {
    
    NSMutableArray *_NSMA_annotation;
	MKMapView *MKMV_map;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) IBOutlet MKMapView *MKMV_map;
@property (nonatomic, retain) NSMutableArray *NSMA_annotation;

-(void) centerMapInCoodinate:(CLLocationCoordinate2D)coordinate;
-(void) initNavigationBar;


@end
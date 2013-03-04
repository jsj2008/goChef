//
//  CoreLocationClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface CoreLocationClass : NSObject <CLLocationManagerDelegate> {
    
	CLLocationManager *CLLM_manager;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) CLLocationManager *CLLM_manager;

-(NSString *) distanceFromActualPositionTo:(CLLocation *)CLL_posFinal;
-(CGFloat) CGFdistanceFromActualPositionTo:(CLLocation *)CLL_posFinal;

-(CLLocation *) positionWithLatitud:(float)fLatitud longitud:(float)flongitud;
-(void) showRouteFromActualTo:(CLLocationCoordinate2D)coordinate;


@end

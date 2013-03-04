//
//  AnnotationClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface AnnotationClass : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate;
    
	NSString *NSS_title;
	NSString *NSS_subtitle;
    
    double dLatitud;
	double dLongitud;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) NSString *NSS_title;
@property (nonatomic, retain) NSString *NSS_subtitle;

@property (nonatomic, readwrite) double dLatitud;
@property (nonatomic, readwrite) double dLongitud;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
				  title:(NSString *) t
			   subtitle:(NSString *) st;

-(void)moveAnnotation: (CLLocationCoordinate2D) newCoordinate;

-(NSString *)subtitle;
-(NSString *)title;
-(void) setSubtitle: (NSString *) st;
-(void) setTitle: (NSString *) t;

@end

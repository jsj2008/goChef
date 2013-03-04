//
//  CoreLocationClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CoreLocationClass.h"

@implementation CoreLocationClass

@synthesize CLLM_manager;

#pragma mark -
#pragma mark Propiedades

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: init
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
	
	// Iniciamos el Location Manager
	self.CLLM_manager = [[CLLocationManager alloc] init];
	
    // Asignamos el delegado
    [self.CLLM_manager setDelegate:self];
    
    // Obtenemos la localización actual
	if ([CLLocationManager locationServicesEnabled]) {
		
		self.CLLM_manager.delegate = self;
		self.CLLM_manager.desiredAccuracy = kCLLocationAccuracyKilometer;
		self.CLLM_manager.distanceFilter = 500;
		[self.CLLM_manager startUpdatingLocation];	 
	}
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: distanceFromActualPositionTo
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) distanceFromActualPositionTo:(CLLocation *)CLL_posFinal {
    
    // Recogemos la posición actual
    CLLocation *CLL_posActual = [[CLLocation alloc] initWithLatitude:self.CLLM_manager.location.coordinate.latitude 
                                                           longitude:self.CLLM_manager.location.coordinate.longitude];
    
    // Calculamos la distancia
    CLLocationDistance CLLD_metros = [CLL_posActual distanceFromLocation:CLL_posFinal];
    
    // Devolvemos la distancia
    return [globalVar formatDistanceWithMeters:CLLD_metros];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: CGFdistanceFromActualPositionTo
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) CGFdistanceFromActualPositionTo:(CLLocation *)CLL_posFinal {
    
    // Recogemos la posición actual
    CLLocation *CLL_posActual = [[CLLocation alloc] initWithLatitude:self.CLLM_manager.location.coordinate.latitude 
                                                           longitude:self.CLLM_manager.location.coordinate.longitude];
    
    // Devolvemos la distancia
    return [CLL_posActual distanceFromLocation:CLL_posFinal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: positionWithLatitud:longitud
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(CLLocation *) positionWithLatitud:(float)fLatitud longitud:(float)flongitud {
    
    return [[CLLocation alloc] initWithLatitude:fLatitud longitude:flongitud];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: showRouteFromActualTo:longitud
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) showRouteFromActualTo:(CLLocationCoordinate2D)coordinate {
    
    // Construimos los datos de la ruta
    float fLatitudActual  = globalVar.CLC_location.CLLM_manager.location.coordinate.latitude;
    float fLongitudActual = globalVar.CLC_location.CLLM_manager.location.coordinate.longitude;
    float fLatitudFinal   = coordinate.latitude;
    float fLongiudFinal   = coordinate.longitude;
    
    // Realizamos la llamada al Google Maps para que calcule la ruta
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%.7f,%.7f&daddr=%.7f,%.7f", fLatitudActual, fLongitudActual, fLatitudFinal, fLongiudFinal];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: urlString]];
}

#pragma mark -
#pragma mark CoreLocation Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: locationManager:didUpdateToLocation:fromLocation:
//#	Fecha Creación	: 29/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
}


@end
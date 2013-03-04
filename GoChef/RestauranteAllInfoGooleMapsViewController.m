//
//  RestauranteAllInfoGooleMapsViewController.m
//  eligemenu
//
//  Created by Pablo H. Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteAllInfoGooleMapsViewController.h"

#import "AnnotationClass.h"
#import "CoreLocationClass.h"
#import "RestaurantClass.h"


@implementation RestauranteAllInfoGooleMapsViewController

@synthesize MKMV_map;
@synthesize NSMA_annotation = _NSMA_annotation;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_annotation
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_annotation:(NSMutableArray *)NSMA_annotation {
    
    _NSMA_annotation = [NSMA_annotation copy];
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Asignamos delegado
    [MKMV_map setDelegate:self];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Mapa";
	
    /*
    // Creamos las coordenadas de la posición actual
    CLLocationCoordinate2D CLLC_location;
    CLLC_location.latitude  = globalVar.CLC_location.CLLM_manager.location.coordinate.latitude;
    CLLC_location.longitude = globalVar.CLC_location.CLLM_manager.location.coordinate.longitude;
    
    // Colocamos el mapa en la posición del punto de interes
    [self centerMapInCoodinate:CLLC_location];
    */
    
    // Mostramos la posición actual
    MKMV_map.showsUserLocation = YES;
    
    // Insertamos las Annotations
    [MKMV_map addAnnotations:_NSMA_annotation];
    
    // Recuperamos el primer resturante (y único)
    AnnotationClass *AC_annotacion = [_NSMA_annotation objectAtIndex:0];
    
    // Creamos las coordenadas de la posición del primer resturante
    CLLocationCoordinate2D CLLC_location;
    CLLC_location.latitude  = AC_annotacion.coordinate.latitude;
    CLLC_location.longitude = AC_annotacion.coordinate.longitude;
    
    // Colocamos el mapa en la posición del punto de interes
    [self centerMapInCoodinate:CLLC_location];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
    [UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_leftContainer addSubview:UIB_back];
    
    // Adaptamos tamaño de la UIView
    [UIV_leftContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 32.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_leftItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_leftContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.leftBarButtonItem = UIBBI_leftItems;
    [self.navigationItem hidesBackButton];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : centerMapInCoodinate
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) centerMapInCoodinate:(CLLocationCoordinate2D)coordinate {
    
    CGFloat CGF_kilometers = _MAP_STANDAR_ZOOM_IN_KM_;
    
    // Calculamos la Span
	MKCoordinateSpan MKCS_span;
	MKCS_span.latitudeDelta  = CGF_kilometers/111.0;
	MKCS_span.longitudeDelta = CGF_kilometers/111.0;
	
    // Actualizamos la región
	MKCoordinateRegion MKCR_region;
	MKCR_region.span = MKCS_span;
	MKCR_region.center = coordinate;
	
    // Centramos el mapa en la regisón definida
	[MKMV_map setRegion:MKCR_region animated:YES];
}

#pragma mark -
#pragma mark MKMapView Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mapView:viewForAnnotation
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // Comprobamos si es la posición actual
    if (annotation == mapView.userLocation) return nil;
    
    // Creamos el MKPinAnnotationView
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinIdentifier"];
    
    // Recogemos el valor del Annotation actual
    //AnnotationClass *AC_annotation = (AnnotationClass *)annView.annotation;
    
    // Cambaimos el color del Pin según el tipo de Restaurante: Vip o Normal
    annView.pinColor = MKPinAnnotationColorRed;
    
    /*
     // Asignamos Pin Image segun tipo de Restaurante: Vip o Normal
     UIImageView *imageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:_MAPS_ANNOTATION_NORMAL_PIN_FILE_NAME_]];
     [annView addSubview:imageView];
     [imageView setFrame:CGRectMake(-8.0f, -3.0f, 34.0f, 54.0f)];
     */
    
    // Iniciamos el resto de propiedades
    annView.animatesDrop   = YES;
    annView.draggable      = YES;
    annView.canShowCallout = YES;
    
    return annView;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : mapView:annotationView:calloutAccessoryControlTapped:
//#	Fecha Creación	: 23/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    // Recuperamos el Annotation pulsado
    //AnnotationClass *AC_annotation = (AnnotationClass *)view.annotation;
}


@end
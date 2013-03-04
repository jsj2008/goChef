//
//  RestauranteFotosViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "RestauranteFotosViewController.h"
#import "LoadingViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "AsynchronousImageView.h"


@implementation RestauranteFotosViewController

@synthesize UIPC_imagenes;
@synthesize UISV_scroll;

@synthesize NSI_number_image = _NSI_number_image;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNIS_number_image
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		:
//#
-(void) setNSI_number_image:(NSInteger)NSI_number_image {
    
    _NSI_number_image = NSI_number_image;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos el delegado
    [UISV_scroll setDelegate:self];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
	self.navigationItem.title = @"Fotos";
    
    // Comprobamos si no se han cargado las imágenes
    if ([globalVar.OC_order.RC_restaurant.NSMA_images count] == 0) {
        
        // Esperamos antes de ir al menú de la aplicación
        NSTimer *NST_timer;
        NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                     target:self
                                                   selector:@selector(downloadRestaurantImages)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    else {
        
        // Iniciamos el UIPageControl
        [UIPC_imagenes setNumberOfPages : globalVar.OC_order.RC_restaurant.NSI_imagesCount-1];
        [UIPC_imagenes setCurrentPage   :0];
        
        // Iniciamos variable que controla posición imagen
        float fPosX = 0.0f;
        
        // Recorremos el Array de Imagenes
        for (int i = 0; i < globalVar.OC_order.RC_restaurant.NSI_imagesCount-1; i++) {
            
            ImageClass *IC_image = (ImageClass*)[globalVar.OC_order.RC_restaurant.NSMA_images objectAtIndex:i];
            // Creamos UIImageView
            //UIImage *UII_image = [UIImage imageWithData:IC_image.NSD_image];
            AsynchronousImageView *UIIV_image = [[AsynchronousImageView alloc] init];
            [UIIV_image setContentMode:UIViewContentModeScaleAspectFit];
            
            // Insertamos UIImageView
            [UISV_scroll addSubview:UIIV_image];
            
            // Posicionamos el UIimageView
            [UIIV_image setFrame:CGRectMake(fPosX, 0.0f, 320.0f, 200.0f)];
            fPosX += UIIV_image.frame.size.width + 0.0f;
            [UIIV_image loadImageFromURLString:IC_image.NSS_imageUrl andActiveCache:TRUE];
        }
        
        // Actualizamos el ContentSize del UIScrollView
        [UISV_scroll setContentSize:CGSizeMake(fPosX, 290.0f)];
    }
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
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		:
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) downloadRestaurantImages {
    
    // Iniciamos el number Image
    [self setNSI_number_image:1];
    
    // Creamos ImageClass
    globalVar.IC_image = [[ImageClass alloc] init];
    [globalVar.IC_image setTIT_type:TIT_restaurants];
    [globalVar.IC_image setCGF_width :640.0f];
    [globalVar.IC_image setCGF_height:400.0f];
    [globalVar.IC_image setNSI_number:_NSI_number_image];
    [globalVar.OC_order.RC_restaurant.NSMA_images addObject:globalVar.IC_image];
    
    // Download Image
    [self getImage];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getImage
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		:
//#
-(void) getImage {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_IMAGE_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(getImageSuccessful:)
                                                 name: _NOTIFICATION_IMAGE_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_IMAGE_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_IMAGE_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading getImage];
}

#pragma mark -
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : getImageSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) getImageSuccessful:(NSNotification *)notification {
    
    BOOL B_mostrar_imagenes = FALSE;
    
    // Comprobamos si la imagen no se encontro
    if (globalVar.IC_image.NSS_imageUrl == nil) {
        
        // Sacamos Image del Array
        [globalVar.OC_order.RC_restaurant.NSMA_images removeObject:globalVar.IC_image];
        
        // Comprobamos si tiene imagenes
        if ([globalVar.OC_order.RC_restaurant.NSMA_images count] > 0) B_mostrar_imagenes = TRUE;
    }
    else {
        
        // Comprobamos si hay más imágenes que cargar
        if (_NSI_number_image < 10) {
            
            // Iniciamos el number Image
            [self setNSI_number_image:(_NSI_number_image+1)];
            
            // Creamos ImageClass
            globalVar.IC_image = [[ImageClass alloc] init];
            [globalVar.IC_image setTIT_type:TIT_restaurants];
            [globalVar.IC_image setCGF_width :640.0f];
            [globalVar.IC_image setCGF_height:400.0f];
            [globalVar.IC_image setNSI_number:_NSI_number_image];
            [globalVar.OC_order.RC_restaurant.NSMA_images addObject:globalVar.IC_image];
            
            // Download Image
            [self getImage];
        }
        else {
            
            // Comprobamos si tiene imagenes
            if ([globalVar.OC_order.RC_restaurant.NSMA_images count] > 0) B_mostrar_imagenes = TRUE;
        }
    }
    
    // comprobamos si ya se han cargado todas las imágenes
    if (B_mostrar_imagenes) {
        
        // Iniciamos el UIPageControl
        [UIPC_imagenes setNumberOfPages :globalVar.OC_order.RC_restaurant.NSI_imagesCount-1];
        [UIPC_imagenes setCurrentPage   :0];
        
        // Iniciamos variable que controla posición imagen
        float fPosX = 0.0f;
        
        // Recorremos el Array de Imagenes
        for (int i = 0; i < globalVar.OC_order.RC_restaurant.NSI_imagesCount-1; i++) {
            
            ImageClass *IC_image = (ImageClass*)[globalVar.OC_order.RC_restaurant.NSMA_images objectAtIndex:i];
            
            // Creamos UIImageView
            //UIImage *UII_image = [UIImage imageWithData:IC_image.NSD_image];
            AsynchronousImageView *UIIV_image = [[AsynchronousImageView alloc] init];
            
            [UIIV_image setContentMode:UIViewContentModeScaleAspectFit];
            
            // Insertamos UIImageView
            [UISV_scroll addSubview:UIIV_image];
            
            // Posicionamos el UIimageView
            [UIIV_image setFrame:CGRectMake(fPosX, 0.0f, 320.0f, 200.0f)];
            fPosX += UIIV_image.frame.size.width + 0.0f;
            [UIIV_image loadImageFromURLString:IC_image.NSS_imageUrl andActiveCache:TRUE];

        }
        
        // Actualizamos el ContentSize del UIScrollView
        [UISV_scroll setContentSize:CGSizeMake(fPosX, 290.0f)];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark UIScrollView delegate

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : scrollViewDidEndDecelerating
//#	Fecha Creación	: 13/10/2011  (pjoramas)
//#	Fecha Ult. Mod.	: 13/10/2011  (pjoramas)
//# Descripción		: 
//#
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Averiguamos que numero de imagen se esta mostrando
    float fObjectSize   = 320.0f;
    float fPosActual    = UISV_scroll.contentOffset.x;
    NSInteger NSI_image = round(fPosActual / fObjectSize);;
    
    // Actualizamos el UIPageControl
    [UIPC_imagenes setCurrentPage:NSI_image];
}


@end
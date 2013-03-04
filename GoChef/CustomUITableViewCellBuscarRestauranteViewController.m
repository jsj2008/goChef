//
//  CustomUITableViewCellBuscarRestauranteViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellBuscarRestauranteViewController.h"

#import "RestaurantClass.h"
#import "TipoCocinaClass.h"
#import "OrderClass.h"
#import "ImageClass.h"


@implementation CustomUITableViewCellBuscarRestauranteViewController


@synthesize UIL_nombre_restaurante;
@synthesize UIL_tipo_comida;
@synthesize UIL_direccion;
@synthesize UIL_precio;
@synthesize UIL_distancia;
@synthesize UIL_tipo_estado;

@synthesize UIIV_estrella_01;
@synthesize UIIV_estrella_02;
@synthesize UIIV_estrella_03;
@synthesize UIIV_estrella_04;
@synthesize UIIV_estrella_05;

@synthesize UIIV_close;

@synthesize UIIV_imagen_restaurante;
@synthesize UIIV_imagen_offer;
@synthesize UIIV_background_tipo_estado;

@synthesize UIB_cell;

@synthesize RC_restaurant = _RC_restaurant;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setRC_restaurant
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setRC_restaurant:(RestaurantClass *)RC_restaurant {
    
    _RC_restaurant = RC_restaurant;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(RestaurantClass *)newRC_restaurant {
    
    // Actualizamos propiedad
    [self setRC_restaurant:newRC_restaurant];
    
    // Actualizamos el UILabel 
    [UIL_nombre_restaurante setText:_RC_restaurant.NSS_name];
    [UIL_distancia setText:_RC_restaurant.NSS_distance];
    
    // Mostramos Dirección
    if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
        
        // Construimos el texto a mostrar
        NSString *NSS_text = [NSString stringWithFormat:@"Min: %.2f€ Entrega: %.2f€", _RC_restaurant.CGF_min_price_homedelivery, _RC_restaurant.CGF_price_homedelivery];
        
        // Actualizamos UILabel
        [UIL_direccion setText:NSS_text];
    }
    else {
        
        // Mostramos la dirección
        [UIL_direccion setText:_RC_restaurant.NSS_address1];
    }
    
    // Comprobamos si esta cerrado
    switch (globalVar.OC_order.TOT_type)
    {
        case TOT_pedido_a_domicilio:
        {
            // Comprobamos si está cerrado para ese tipo de pedido
            if (_RC_restaurant.TRS_service_adomicilio == TRS_no_activo) [UIIV_close setAlpha:1.0f];
            else [UIIV_close setAlpha:0.0f];
            
            break;
        }
        case TOT_pedido_en_el_restaurante:
        {
            // Comprobamos si está cerrado para ese tipo de pedido
            if (_RC_restaurant.TRS_service_enrestaurante == TRS_no_activo) [UIIV_close setAlpha:1.0f];
            else [UIIV_close setAlpha:0.0f];
            
            break;
        }
        case TOT_pedido_antes_de_ir_al_restaurante:
        {
            // Comprobamos si está cerrado para ese tipo de pedido
            if (_RC_restaurant.TRS_service_antesrestaurante == TRS_no_activo) [UIIV_close setAlpha:1.0f];
            else [UIIV_close setAlpha:0.0f];
            
            break;
        }
        case TOT_pedido_para_recoger:
        {
            // Comprobamos si está cerrado para ese tipo de pedido
            if (_RC_restaurant.TRS_service_arecoger == TRS_no_activo) [UIIV_close setAlpha:1.0f];
            else [UIIV_close setAlpha:0.0f];
            
            break;
        }
        case TOT_reserva:
        {
            // Comprobamos si está cerrado para ese tipo de pedido
            if (_RC_restaurant.TRS_service_reserva == TRS_no_activo) [UIIV_close setAlpha:1.0f];
            else [UIIV_close setAlpha:0.0f];
            
            break;
        }
    }
    
    // Actualizamos UILanel Resturanttype
    NSArray *catIds = [_RC_restaurant.NSI_idrestauranttype componentsSeparatedByString:@","];    
    NSString *catsName = @"";
    
    for (int i = 0; i <[catIds count]; i++) {
        int theId = [[catIds objectAtIndex:i] intValue];
        TipoCocinaClass *TCC_restauranttype = [globalVar getRestautanttypeWithId:[NSString stringWithFormat:@"%d",theId]];
        if (i == 0) {
            catsName = [catsName stringByAppendingString:TCC_restauranttype.NSS_name];
        } else {
            catsName = [catsName stringByAppendingFormat:@", %@",TCC_restauranttype.NSS_name];
        }
    }
    //TipoCocinaClass *TCC_restauranttype = [globalVar getRestautanttypeWithId:[NSString stringWithFormat:@"%d",[_RC_restaurant.NSI_idrestauranttype intValue]]];
    [UIL_tipo_comida setText:catsName];
    
    // Actualizamos UILabel del Precio
    NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
    [UIL_precio setText:[NSString stringWithFormat:@"Precio medio: %.2f%@", _RC_restaurant.CGF_price_average, NSS_symbol]];

    // Comprobamos el estado
    if ([_RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_ORO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_imagen_estado = [UIImage imageNamed:@"restaurante_cell_tipo_estado_oro.png"];
        [UIIV_background_tipo_estado setImage:UII_imagen_estado];
        
        // Actualizamos UILabel de Tipo Estado
        [UIL_tipo_estado setText:[NSString stringWithFormat:@"Estado: %@ %@ descuento", _RC_restaurant.NSS_namemembership, _RC_restaurant.NSS_discount]];
    }
    else if ([_RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATINO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_imagen_estado = [UIImage imageNamed:@"restaurante_cell_tipo_estado_platino.png"];
        [UIIV_background_tipo_estado setImage:UII_imagen_estado];
        
        // Actualizamos UILabel de Tipo Estado
        [UIL_tipo_estado setText:[NSString stringWithFormat:@"Estado: %@ %@ descuento", _RC_restaurant.NSS_namemembership, _RC_restaurant.NSS_discount]];
    }
    else if ([_RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATA_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_imagen_estado = [UIImage imageNamed:@"restaurante_cell_tipo_estado_platino.png"];
        [UIIV_background_tipo_estado setImage:UII_imagen_estado];
        
        // Actualizamos UILabel de Tipo Estado
        [UIL_tipo_estado setText:[NSString stringWithFormat:@"Estado: %@ %@ descuento", _RC_restaurant.NSS_namemembership, _RC_restaurant.NSS_discount]];
    }
    else {
        
        // Ocultamos UIImage estado
        [UIIV_background_tipo_estado setAlpha:0.0f];
        
        // Actualizamos UILabel de Tipo Estado
        [UIL_tipo_estado setText:@""];
    }
    
    // Actualizamos UIImage
    //UIImage *UII_image = [UIImage imageWithData:_RC_restaurant.IC_image_mini.NSD_image];
    //[UIIV_imagen_restaurante setImage:UII_image];
    [UIIV_imagen_restaurante loadImageFromURLString:_RC_restaurant.IC_image_mini.NSS_imageUrl andActiveCache:TRUE];
    
    // Comprobamos si tiene oferta
    if (_RC_restaurant.NSI_idoffer > 0) {
        
        // Actualizamos UIImage
        //UIImage *UII_image_offer = [UIImage imageWithData:_RC_restaurant.IC_image_offer.NSD_image];
        //[UIIV_imagen_offer setImage:UII_image_offer];
        [UIIV_imagen_offer loadImageFromURLString:_RC_restaurant.IC_image_offer.NSS_imageUrl andActiveCache:TRUE];
    }
    
    // Creamos las UIImage de las posibles estrallas
    UIImage *UII_0   = [UIImage imageNamed:_SHORT_INFO_VALORACION_0_IMG_FNAME_];
    UIImage *UII_50  = [UIImage imageNamed:_SHORT_INFO_VALORACION_50_IMG_FNAME_];
    UIImage *UII_100 = [UIImage imageNamed:_SHORT_INFO_VALORACION_100_IMG_FNAME_];
    
    // Actualizamos las UIImageView Estrellas valoración
    if      (_RC_restaurant.CGF_stars < 0.5f)  { [UIIV_estrella_01 setImage:UII_0];   }
    else if (_RC_restaurant.CGF_stars < 1.0f)  { [UIIV_estrella_01 setImage:UII_50];  }
    else if (_RC_restaurant.CGF_stars < 1.5f)  { [UIIV_estrella_01 setImage:UII_100]; }
    else if (_RC_restaurant.CGF_stars < 2.0f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_50];  }
    else if (_RC_restaurant.CGF_stars < 2.5f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; }
    else if (_RC_restaurant.CGF_stars < 3.0f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_50];  }
    else if (_RC_restaurant.CGF_stars < 3.5f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_100]; }
    else if (_RC_restaurant.CGF_stars < 4.0f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_100]; [UIIV_estrella_04 setImage:UII_50];  }
    else if (_RC_restaurant.CGF_stars < 4.5f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_100]; [UIIV_estrella_04 setImage:UII_100]; }
    else if (_RC_restaurant.CGF_stars < 5.0f)  { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_100]; [UIIV_estrella_04 setImage:UII_100]; [UIIV_estrella_05 setImage:UII_50];  }
    else if (_RC_restaurant.CGF_stars == 5.0f) { [UIIV_estrella_01 setImage:UII_100]; [UIIV_estrella_02 setImage:UII_100]; [UIIV_estrella_03 setImage:UII_100]; [UIIV_estrella_04 setImage:UII_100]; [UIIV_estrella_05 setImage:UII_100]; }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_RC_restaurant];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_misaco_TouchUpInside
//#	Fecha Creación	: 23/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_misaco_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate Tabbar_mi_saco_Touched];
}


@end
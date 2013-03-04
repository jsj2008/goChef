//
//  CustomUITableViewCellMiSacoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellMiSacoViewController.h"

#import "UserOfferClass.h"
#import "ImageClass.h"


@implementation CustomUITableViewCellMiSacoViewController

@synthesize UIL_titulo;
@synthesize UIL_nombre_restaurante;
@synthesize UIL_direccion;
@synthesize UIL_validez;
@synthesize UIIV_imagen;
@synthesize UIB_cell;

@synthesize UOC_offer = _UOC_offer;
@synthesize delegate  = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setMSC_saco
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUOC_offer:(UserOfferClass *)UOC_offer {
    
    _UOC_offer = UOC_offer;
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
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Fecha Ult. Mod.	: 16/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(UserOfferClass *)newUOC_offer {
    
    // Actualizamos propiedad
    [self setUOC_offer:newUOC_offer];
    
    // Actualizamos el UILabel Nombre Restaurante
    [UIL_titulo             setText:_UOC_offer.NSS_nameoffer];
    [UIL_nombre_restaurante setText:[NSString stringWithFormat:@"%@ %@", _UOC_offer.NSS_namerestaurant, _UOC_offer.NSS_distance]];
    [UIL_direccion          setText:_UOC_offer.NSS_descriptionoffer];
    
    // Actualizamos UILabel Fecha
    NSDateFormatter *NSDF_date = [[NSDateFormatter alloc] init];
    [NSDF_date setDateFormat:@"'Validez hasta el ' d 'de' MMMM 'de' yyyy"];
    NSString *NSS_date = [NSDF_date stringFromDate:_UOC_offer.NSD_date_end];
    [UIL_validez setText:NSS_date];
    
    // Actualizamos UIImage
    //UIImage *UII_image = [UIImage imageWithData:_UOC_offer.IC_imageoffer.NSD_image];
    //[UIIV_imagen setImage:UII_image];
    [UIIV_imagen loadImageFromURLString:_UOC_offer.IC_imageoffer.NSS_imageUrl andActiveCache:TRUE];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_UOC_offer];
}


@end
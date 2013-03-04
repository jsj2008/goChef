//
//  SelectOfertaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectOfertaViewController.h"

#import "UserClass.h"
#import "RestaurantClass.h"
#import "OrderClass.h"


@implementation SelectOfertaViewController

@synthesize UIPV_listado;

@synthesize UOC_offer = _UOC_offer;
@synthesize delegate = _delegate;

NSMutableArray *NSMA_values;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setUOC_offer
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setUOC_offer:(UserOfferClass *)UOC_offer {
    
    _UOC_offer = UOC_offer;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración de delegados
	UIPV_listado.delegate   = self;
	UIPV_listado.dataSource = self;
    
    // Iniciamos el Array de Ofertas
    NSMA_values = [[NSMutableArray alloc] init];
    
    // Buscamos las ofertas del resturante actual
    for (UserOfferClass *UOC_offer in globalVar.UC_user.NSMA_offers)
        if (UOC_offer.NSI_idrestaurant == globalVar.OC_order.RC_restaurant.NSI_idrestaurant)
            [NSMA_values addObject:UOC_offer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Comprobamos si se ha seleccionado alguno oferta
    if (_UOC_offer.NSI_idoffer == _ID_OFFER_NO_SELECTED_) return;
    
    // Buscamos La Offer seleccionada
    int iPos = 0;
    for (UserOfferClass *UOC_offer in NSMA_values) {
        
        if (UOC_offer.NSI_idoffer == _UOC_offer.NSI_idoffer)
            [UIPV_listado selectRow:(iPos+1) inComponent:0 animated:YES];
        
        iPos += 1;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(UserOfferClass *)newUOC_offer {
    
    // Actualizamos propiedad
    [self setUOC_offer:newUOC_offer];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tipo_cocina_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_oferta_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_oferta];
}

#pragma mark -
#pragma mark UIPickerView Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfComponentsInPickerView
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:didSelectRow:inComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // Comprobamos si estamos en la primera 
    if (row > 0) {
        
        // Recuperamos la oferta seleccionada
        UserOfferClass *UOC_offer = [NSMA_values objectAtIndex:(row-1)];
        
        // Actualizamos propiedad
        [self setUOC_offer:UOC_offer];
    }
    else {
        
        // Creamos UserOfferClass
        _UOC_offer = [[UserOfferClass alloc] init];
        
        // Indicamos que no se ha seleccionado ninguna
        [_UOC_offer setNSI_idoffer:_ID_OFFER_NO_SELECTED_];
        [_UOC_offer setNSS_nameoffer:@"--"];
    }
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_oferta:_UOC_offer];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return ([NSMA_values count]+1);
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/05/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    if (row == 0) return @"--";
    else {
        
        // Recuperamos la oferta seleccionada
        UserOfferClass *UOC_offer = [NSMA_values objectAtIndex:(row-1)];
        
        return UOC_offer.NSS_nameoffer;
    }
}

@end
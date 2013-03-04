//
//  SelectPrecioViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectPrecioViewController.h"

#import "DailymenuClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"


@implementation SelectPrecioViewController

@synthesize UIPV_listado;

@synthesize DMC_menu = _DMC_menu;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setDMC_menu
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDMC_menu:(DailymenuClass *)DMC_menu {
    
    _DMC_menu = DMC_menu;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
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
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    int iPos = 0;
    
    // Buscamos Menu seleccionado
    for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {

        // Comprobamos si es el DailyMenu que buscamos
        if (DMC_menu.NSI_iddailymenu == _DMC_menu.NSI_iddailymenu)
            [UIPV_listado selectRow:iPos inComponent:0 animated:YES];
        
        iPos += 1;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(DailymenuClass *)newDMC_menu {
    
    // Actualizamos propiedad
    [self setDMC_menu:newDMC_menu];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tipo_cocina_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_precio_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_precio];
}

#pragma mark -
#pragma mark UIPickerView Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfComponentsInPickerView
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:didSelectRow:inComponent:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // Recuperamos el DailyMenu
    DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:row];
    
    // Marcamos el DailyMenu seleccionado
    [self setDMC_menu:DMC_menu];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_precio:_DMC_menu];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [globalVar.OC_order.RC_restaurant.NSMA_dailymenus count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 18/09/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    // Recuperamos el DailyMenu
    DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%.@", DMC_menu.NSS_name];
}

@end
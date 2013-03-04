//
//  SelectTipoCartaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectTipoCartaViewController.h"


@implementation SelectTipoCartaViewController

@synthesize UIPV_listado;

@synthesize NSS_tipo_carta = _NSS_tipo_carta;

@synthesize delegate = _delegate;

NSMutableArray *NSMA_values;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_precio
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_tipo_carta:(NSString *)NSS_tipo_carta {
    
    _NSS_tipo_carta = [NSS_tipo_carta copy];
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Configuración de delegados
	UIPV_listado.delegate   = self;
	UIPV_listado.dataSource = self;
    
    // Iniciamos values
    NSMA_values = [[NSMutableArray alloc] init];
    [NSMA_values addObject:_COMBO_TIPO_CARTA_CARTA_];
    [NSMA_values addObject:_COMBO_TIPO_CARTA_MENU_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    int iPos = 0;
    // Buscamos Tpo de Cocina seleccionado
    for (NSString *NSS_tipo_carta in NSMA_values) {
        
        if ([NSS_tipo_carta isEqualToString:_NSS_tipo_carta])
            [UIPV_listado selectRow:iPos inComponent:0 animated:YES];
        
        iPos += 1;
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSString *)new_NSS_tipo_carta {
    
    [self setNSS_tipo_carta:new_NSS_tipo_carta];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tipo_cocina_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_tipo_carta_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_tipo_carta];
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
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *NSS_tipo_carta = [NSMA_values objectAtIndex:row];
    
    [self setNSS_tipo_carta:NSS_tipo_carta];
     
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_tipo_carta:_NSS_tipo_carta];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [NSMA_values count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    return [NSMA_values objectAtIndex:row];
}

@end
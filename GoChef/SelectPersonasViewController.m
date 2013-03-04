//
//  SelectPersonasViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectPersonasViewController.h"


@implementation SelectPersonasViewController

@synthesize UIPV_listado;

@synthesize NSI_personas = _NSI_personas;
@synthesize delegate = _delegate;

NSMutableArray *NSMA_values;


#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSI_personas
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_personas:(NSInteger)NSI_personas {
    
    _NSI_personas = NSI_personas;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/09/2012  (pjoramas)
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
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:0]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:1]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:2]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:3]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:4]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:5]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:6]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:7]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:8]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:9]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:10]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:11]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:12]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:13]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:14]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:15]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:16]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:17]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:18]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:19]];
    [NSMA_values addObject:(NSNumber *)[NSNumber numberWithInteger:20]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(NSInteger)newNSI_personas {
    
    // Actualizamos propiedad
    [self setNSI_personas:newNSI_personas];
    
    // Comprobamos cual debe estar seleccionado
    [UIPV_listado selectRow:_NSI_personas inComponent:0 animated:YES];
    
    // Actualizamos UILabel
    [_delegate select_personas:_NSI_personas];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_personas_TouchUpInside
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_personas_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate close_select_personas];
}

#pragma mark -
#pragma mark UIPickerView Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : numberOfComponentsInPickerView
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:didSelectRow:inComponent:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSNumber *NSN_personas = [NSMA_values objectAtIndex:row];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_personas:[NSN_personas integerValue]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:numberOfRowsInComponent:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [NSMA_values count];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : pickerView:titleForRow:forComponent:
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component; {
    
    NSNumber *NSN_personas = [NSMA_values objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%d", [NSN_personas integerValue]];
}

@end
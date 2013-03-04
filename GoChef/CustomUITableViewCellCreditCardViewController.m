//
//  CustomUITableViewCellCreditCardViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellCreditCardViewController.h"

#import "TarjetaClass.h"


@implementation CustomUITableViewCellCreditCardViewController

@synthesize UIL_creditcard;
@synthesize UIB_default;
@synthesize UIB_remove;

@synthesize TC_creditcard = _TC_creditcard;
@synthesize B_edit_mode = _B_edit_mode;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_edit_mode
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_edit_mode:(BOOL)B_edit_mode {
    
    _B_edit_mode = B_edit_mode;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setTC_creditcard
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTC_creditcard:(TarjetaClass *)TC_creditcard {
    
    _TC_creditcard = TC_creditcard;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamo propiedad
    [self setB_edit_mode:FALSE];
    
    // Inicimoa UIButton
    [UIB_default setAlpha:0.0f];
    [UIB_remove  setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(TarjetaClass *)newTC_creditcard edit_mode:(BOOL)newB_edit_mode {
    
    // Actualizamos propiedad
    [self setTC_creditcard:newTC_creditcard];
    [self setB_edit_mode:newB_edit_mode];
    
    // Actualizamos el UILabel
    [UIL_creditcard setText:[globalVar formatTarjetaNumber:_TC_creditcard]];
    
    // comprobamo si es la tarjeta por defecto
    if (_TC_creditcard.B_default) [UIB_default setAlpha:1.0f];
    else [UIB_default setAlpha:0.0f];
    
    // Comprobamos l estado
    if (_B_edit_mode) {
        
        // Desplazamos el UILabel
        [UIL_creditcard setFrame:CGRectMake(57.0f, UIL_creditcard.frame.origin.y, 208.0f, UIL_creditcard.frame.size.height)];
        
        // Mostramos el UIButton remove
        [UIB_remove setAlpha:1.0f];
    }
    else {
        
        // Desplazamos el UILabel
        [UIL_creditcard setFrame:CGRectMake(34.0f, UIL_creditcard.frame.origin.y, 231.0f, UIL_creditcard.frame.size.height)];
        
        // Mostramos el UIButton remove
        [UIB_remove setAlpha:0.0f];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : changeEditMode
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) changeEditMode:(BOOL)newB_edit_mode {
    
    // Actualizamos propiedad
    [self setB_edit_mode:newB_edit_mode];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_CREDITCARD_EDIT_MODE_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Comprobamos l estado
    if (_B_edit_mode) {
        
        // Desplazamos el UILabel
        [UIL_creditcard setFrame:CGRectMake(57.0f, UIL_creditcard.frame.origin.y, 208.0f, UIL_creditcard.frame.size.height)];
        
        // Mostramos el UIButton remove
        [UIB_remove setAlpha:1.0f];
    }
    else {
        
        // Desplazamos el UILabel
        [UIL_creditcard setFrame:CGRectMake(34.0f, UIL_creditcard.frame.origin.y, 231.0f, UIL_creditcard.frame.size.height)];
        
        // Mostramos el UIButton remove
        [UIB_remove setAlpha:0.0f];
    }
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setDefault
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDefault:(BOOL)B_default {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_CREDITCARD_EDIT_MODE_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Comprobamos el estado
    if (B_default) [UIB_default setAlpha:1.0f];
    else [UIB_default setAlpha:0.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_TC_creditcard];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_remove_TouchUpInside
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_remove_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate removeTouched:_TC_creditcard];
}


@end
//
//  TabbarPrincipalViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TabbarPrincipalViewController.h"


@implementation TabbarPrincipalViewController

@synthesize UIB_mi_saco;
@synthesize UIB_mi_actividad;
@synthesize UIB_mi_cuenta;
@synthesize UIL_globo;
@synthesize UIV_globo;
@synthesize UIL_globo_animacion;
@synthesize UIV_globo_animacion;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initWithNibName:bundle:
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: viewDidLoad
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos los UIButton
    [self updateTabBarforIndex:0];
    
    // Iniciamos el Globo
    [UIV_globo setAlpha:0.0f];
    [UIV_globo_animacion setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_mi_saco
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_mi_saco:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_general_mi_saco_select.png"] forState:UIControlStateNormal];
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_mi_saco_normal.png"] forState:UIControlStateHighlighted];
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_mi_saco_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_mi_saco_normal.png"] forState:UIControlStateNormal];
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_general_mi_saco_select.png"] forState:UIControlStateHighlighted];
        [UIB_mi_saco setImage:[UIImage imageNamed:@"tabbar_button_general_mi_saco_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_mi_actividad
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_mi_actividad:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_general_mi_actividad_select.png"] forState:UIControlStateNormal];
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_mi_actividad_normal.png"] forState:UIControlStateHighlighted];
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_mi_actividad_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_mi_actividad_normal.png"] forState:UIControlStateNormal];
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_general_mi_actividad_select.png"] forState:UIControlStateHighlighted];
        [UIB_mi_actividad setImage:[UIImage imageNamed:@"tabbar_button_general_mi_actividad_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_mi_cuenta
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_mi_cuenta:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_general_mi_cuenta_select.png"] forState:UIControlStateNormal];
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_mi_cuenta_normal.png"] forState:UIControlStateHighlighted];
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_mi_cuenta_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_mi_cuenta_normal.png"] forState:UIControlStateNormal];
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_general_mi_cuenta_select.png"] forState:UIControlStateHighlighted];
        [UIB_mi_cuenta setImage:[UIImage imageNamed:@"tabbar_button_general_mi_cuenta_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateTabBarforIndex
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateTabBarforIndex:(NSInteger)NSI_index {
    
    // Actualizasmo UIButton
    if (NSI_index == 0) {
        
        // Actualizamos status UIButton
        [self updateUIB_mi_actividad :TRUE];
        [self updateUIB_mi_saco      :FALSE];
        [self updateUIB_mi_cuenta    :FALSE];
    }
    else if (NSI_index == 1) {
        
        // Actualizamos status UIButton
        [self updateUIB_mi_actividad :FALSE];
        [self updateUIB_mi_saco      :TRUE];
        [self updateUIB_mi_cuenta    :FALSE];
    }
    else if (NSI_index == 2) {
        
        // Actualizamos status UIButton
        [self updateUIB_mi_actividad :FALSE];
        [self updateUIB_mi_saco      :FALSE];
        [self updateUIB_mi_cuenta    :TRUE];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabbarButtonsStatus
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabbarButtonsStatus {
    
    // Actualizamos status UIButton
    [self updateUIB_mi_actividad :FALSE];
    [self updateUIB_mi_saco      :FALSE];
    [self updateUIB_mi_cuenta    :FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: aniGloboWithValue
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) aniGloboWithValue:(NSInteger)NSI_value {
    
    // Iniciamos el Globo
    [UIV_globo_animacion setAlpha:1.0f];
    [UIV_globo_animacion setFrame:UIV_globo.frame];
    [UIL_globo_animacion setText:[NSString stringWithFormat:@"%d", NSI_value]];
    
    CGFloat CGF_scale = 3.0f;
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_ADD_PLATO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    [UIV_globo_animacion setAlpha:0.0f];
    [UIV_globo_animacion setFrame:CGRectMake((UIV_globo_animacion.frame.origin.x - (UIV_globo_animacion.frame.size.width*CGF_scale/3)),
                                             (UIV_globo_animacion.frame.origin.y - (UIV_globo_animacion.frame.size.height*CGF_scale/3)),
                                             (UIV_globo_animacion.frame.size.width * CGF_scale),
                                             (UIV_globo_animacion.frame.size.height * CGF_scale))];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateGlobo
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) updateGlobo {
    
    // Comprobamos si no hay New Orders
    if (globalVar.NSI_num_new_order == 0) {
        
        // Ocultamos el Globo
        [self hideGlobo];
    }
    else {
        
        // Actualizamos el Globo
        [self initGlobo:globalVar.NSI_num_new_order];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initGlobo
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) initGlobo:(NSInteger)NSI_number {
    
    // Comprobamos si es el mismo valor que ya tiene
    NSInteger NSI_actual_value = [UIL_globo.text integerValue];
    if (NSI_actual_value == NSI_number) return;
    
    // Actualizamos UILabel
    [UIL_globo setText:[NSString stringWithFormat:@"%d", NSI_number]];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_globo setAlpha:1.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Ejecutamos animación
    [self aniGloboWithValue:NSI_number];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideGlobo
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/09/2012  (pjoramas)
//# Descripción		:
//#
-(void) hideGlobo {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_globo setAlpha:0.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_activida_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_mi_activida_TouchUpInside:(id)sender {
    
    // Cambiamos de View
    [self updateTabBarforIndex:0];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_mi_activida_Touched];
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_saco_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_mi_saco_TouchUpInside:(id)sender {
    
    // Cambiamos de View
    [self updateTabBarforIndex:1];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_mi_saco_Touched:TRUE];
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_cuenta_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_mi_cuenta_TouchUpInside:(id)sender {
    
    // Cambiamos de View
    [self updateTabBarforIndex:2];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_mi_cuenta_Touched];
}


@end
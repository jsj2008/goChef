//
//  TabbarDomicilioViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TabbarDomicilioViewController.h"

#import "OrderClass.h"


@implementation TabbarDomicilioViewController

@synthesize UIB_buscar;
@synthesize UIB_mi_pedido;
@synthesize UIB_historial;
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
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
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
//#	Procedimiento	: updateUIB_buscar
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_buscar:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_select.png"] forState:UIControlStateNormal];
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_normal.png"] forState:UIControlStateHighlighted];
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_normal.png"] forState:UIControlStateNormal];
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_select.png"] forState:UIControlStateHighlighted];
        [UIB_buscar setImage:[UIImage imageNamed:@"tabbar_button_domicilio_buscar_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_mi_pedido
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_mi_pedido:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_select.png"] forState:UIControlStateNormal];
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_normal.png"] forState:UIControlStateHighlighted];
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_normal.png"] forState:UIControlStateNormal];
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_select.png"] forState:UIControlStateHighlighted];
        [UIB_mi_pedido setImage:[UIImage imageNamed:@"tabbar_button_domicilio_mi_pedido_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_historial
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_historial:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_select.png"] forState:UIControlStateNormal];
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_normal.png"] forState:UIControlStateHighlighted];
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_normal.png"] forState:UIControlStateNormal];
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_select.png"] forState:UIControlStateHighlighted];
        [UIB_historial setImage:[UIImage imageNamed:@"tabbar_button_domicilio_historial_select.png"] forState:UIControlStateSelected];
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
        [self updateUIB_buscar    :TRUE];
        [self updateUIB_mi_pedido :FALSE];
        [self updateUIB_historial :FALSE];
    }
    else if (NSI_index == 1) {
        
        // Actualizamos status UIButton
        [self updateUIB_buscar    :FALSE];
        [self updateUIB_mi_pedido :TRUE];
        [self updateUIB_historial :FALSE];
    }
    else if (NSI_index == 2) {
        
        // Actualizamos status UIButton
        [self updateUIB_buscar    :FALSE];
        [self updateUIB_mi_pedido :FALSE];
        [self updateUIB_historial :TRUE];
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
    [self updateUIB_buscar    :TRUE];
    [self updateUIB_mi_pedido :FALSE];
    [self updateUIB_historial :FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: aniGloboWithValue
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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
//#	Procedimiento	: initGlobo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initGlobo:(NSInteger)NSI_number {
    
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
    [self aniGloboWithValue:1];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: resetGlobo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) resetGlobo {
    
    // Actualizamos UILabel
    [UIL_globo setText:@"0"];
    
    // Ocultamos el Globo
    [self hideGlobo];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: hideGlobo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
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


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: addValueGlobo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) addValueGlobo:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_globo setText:[NSString stringWithFormat:@"%d", (NSI_value+NSI_number)]];
    
    // Ejecutamos animación
    [self aniGloboWithValue:(NSI_value+NSI_number)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: redoValueGlobo
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) redoValueGlobo:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_globo setText:[NSString stringWithFormat:@"%d", (NSI_value-NSI_number)]];
    
    // Si es cero -> ocultamos globo
    if ((NSI_value-NSI_number) == 0) [self hideGlobo];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_buscar_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_buscar_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (!globalVar.B_pedido_confirmado) {

        // Cambiamos de View
        [self updateTabBarforIndex:0];
        
        // Indicamos al delegado que se ha seleccionado el Menú
        if (_delegate != nil) [_delegate Tabbar_dom_buscar_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_pedido_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_mi_pedido_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (globalVar.B_pedido_confirmado) return;
    
    // Comprobamos si hay comida en el pedido
    if ([globalVar.OC_order.NSMA_orderfoods count] == 0) return;
    
    // Cambiamos de View
    [self updateTabBarforIndex:1];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_dom_mi_pedido_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_historial_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_historial_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (!globalVar.B_pedido_confirmado) {
        
        // Cambiamos de View
        [self updateTabBarforIndex:2];
        
        // Indicamos al delegado que se ha seleccionado el Menú
        if (_delegate != nil) [_delegate Tabbar_dom_historial_Touched];
    }
}


@end
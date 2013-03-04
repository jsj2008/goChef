//
//  TabbarRestauranteViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "TabbarRestauranteViewController.h"


@implementation TabbarRestauranteViewController

@synthesize UIB_pedir;
@synthesize UIB_en_cocina;
@synthesize UIB_pagar;

@synthesize UIL_pedir_globo;
@synthesize UIV_pedir_globo;
@synthesize UIL_pedir_globo_animacion;
@synthesize UIV_pedir_globo_animacion;

@synthesize UIL_en_cocina_globo;
@synthesize UIV_en_cocina_globo;
@synthesize UIL_en_cocina_globo_animacion;
@synthesize UIV_en_cocina_globo_animacion;

@synthesize UIV_accion;
@synthesize UIV_tabbar;

@synthesize UIB_accion;

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
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos los UIButton
    [self updateTabBarforIndex:0];
    
    // Iniciamos el Globo
    [UIV_pedir_globo                setAlpha:0.0f];
    [UIV_pedir_globo_animacion      setAlpha:0.0f];
    [UIV_en_cocina_globo            setAlpha:0.0f];
    [UIV_en_cocina_globo_animacion  setAlpha:0.0f];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_pedir
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_pedir:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_select.png"] forState:UIControlStateNormal];
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_normal.png"] forState:UIControlStateHighlighted];
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_normal.png"] forState:UIControlStateNormal];
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_select.png"] forState:UIControlStateHighlighted];
        [UIB_pedir setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pedir_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_en_cocina
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_en_cocina:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_select.png"] forState:UIControlStateNormal];
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_normal.png"] forState:UIControlStateHighlighted];
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_normal.png"] forState:UIControlStateNormal];
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_select.png"] forState:UIControlStateHighlighted];
        [UIB_en_cocina setImage:[UIImage imageNamed:@"tabbar_button_restaurante_en_cocina_select.png"] forState:UIControlStateSelected];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIB_pagar
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIB_pagar:(BOOL)B_select {
    
    // Comprobamos si ha de estar selecionado
    if (B_select) {
        
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_select.png"] forState:UIControlStateNormal];
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_normal.png"] forState:UIControlStateHighlighted];
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_normal.png"] forState:UIControlStateSelected];
    }
    else {
        
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_normal.png"] forState:UIControlStateNormal];
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_select.png"] forState:UIControlStateHighlighted];
        [UIB_pagar setImage:[UIImage imageNamed:@"tabbar_button_restaurante_pagar_select.png"] forState:UIControlStateSelected];
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
        [self updateUIB_pedir     :TRUE];
        [self updateUIB_en_cocina :FALSE];
        [self updateUIB_pagar     :FALSE];
    }
    else if (NSI_index == 1) {
        
        // Actualizamos status UIButton
        [self updateUIB_pedir     :FALSE];
        [self updateUIB_en_cocina :TRUE];
        [self updateUIB_pagar     :FALSE];
    }
    else if (NSI_index == 2) {
        
        // Actualizamos status UIButton
        [self updateUIB_pedir     :FALSE];
        [self updateUIB_en_cocina :FALSE];
        [self updateUIB_pagar     :TRUE];
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
    [self updateUIB_pedir     :TRUE];
    [self updateUIB_en_cocina :FALSE];
    [self updateUIB_pagar     :FALSE];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: aniGloboWithValue
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) aniGloboWithValue:(NSInteger)NSI_value 
                     view:(UIView *)UIV_globo 
            animationview:(UIView *)UIV_globo_animacion 
                    label:(UILabel *)UIL_globo 
{   
    // Iniciamos el Globo
    [UIV_globo_animacion setAlpha:1.0f];
    [UIV_globo_animacion setFrame:UIV_globo.frame];
    [UIL_globo setText:[NSString stringWithFormat:@"%d", NSI_value]];
    
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
//#	Procedimiento	: pedir_globo_init
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_globo_init:(NSInteger)NSI_number {
    
    // Actualizamos UILabel
    [UIL_pedir_globo setText:[NSString stringWithFormat:@"%d", NSI_number]];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_pedir_globo setAlpha:1.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Ejecutamos animación
    [self aniGloboWithValue:1 view:UIV_pedir_globo animationview:UIV_pedir_globo_animacion label:UIL_pedir_globo_animacion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pedir_globo_reset
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_globo_reset {
    
    // Actualizamos UILabel
    [UIL_pedir_globo setText:@"0"];
    
    // Ocultamos el Globo
    [self pedir_globo_hide];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pedir_globo_hide
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_globo_hide {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_pedir_globo setAlpha:0.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pedir_globo_addValue
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_globo_addValue:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_pedir_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_pedir_globo setText:[NSString stringWithFormat:@"%d", (NSI_value+NSI_number)]];
    
    // Ejecutamos animación
    [self aniGloboWithValue:(NSI_value+NSI_number) view:UIV_pedir_globo animationview:UIV_pedir_globo_animacion label:UIL_pedir_globo_animacion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: pedir_globo_redoValue
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) pedir_globo_redoValue:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_pedir_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_pedir_globo setText:[NSString stringWithFormat:@"%d", (NSI_value-NSI_number)]];
    
    // Si es cero -> ocultamos globo
    if ((NSI_value-NSI_number) == 0) [self pedir_globo_hide];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: en_cocina_globo_init
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) en_cocina_globo_init:(NSInteger)NSI_number {
    
    // Actualizamos UILabel
    [UIL_en_cocina_globo setText:[NSString stringWithFormat:@"%d", NSI_number]];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_en_cocina_globo setAlpha:1.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Ejecutamos animación
    [self aniGloboWithValue:1 view:UIV_en_cocina_globo animationview:UIV_en_cocina_globo_animacion label:UIL_en_cocina_globo_animacion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: en_cocina_globo_reset
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) en_cocina_globo_reset {
    
    // Actualizamos UILabel
    [UIL_en_cocina_globo setText:@"0"];
    
    // Ocultamos el Globo
    [self en_cocina_globo_hide];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: en_cocina_globo_hide
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) en_cocina_globo_hide {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_GLOBO_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [UIV_en_cocina_globo setAlpha:0.0f];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: en_cocina_globo_addValue
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) en_cocina_globo_addValue:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_en_cocina_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_en_cocina_globo setText:[NSString stringWithFormat:@"%d", (NSI_value+NSI_number)]];
    
    // Ejecutamos animación
    [self aniGloboWithValue:(NSI_value+NSI_number) view:UIV_en_cocina_globo animationview:UIV_en_cocina_globo_animacion label:UIL_en_cocina_globo_animacion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: en_cocina_globo_redoValue
//#	Fecha Creación	: 06/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) en_cocina_globo_redoValue:(NSInteger)NSI_number {
    
    // Recogemos valor actual
    NSInteger NSI_value = [UIL_en_cocina_globo.text intValue];
    
    // Actualizamos UILabel
    [UIL_en_cocina_globo setText:[NSString stringWithFormat:@"%d", (NSI_value-NSI_number)]];
    
    // Si es cero -> ocultamos globo
    if ((NSI_value-NSI_number) == 0) [self en_cocina_globo_hide];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_pedir_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (!globalVar.B_pedido_confirmado) {
        
        // Cambiamos de View
        [self updateTabBarforIndex:0];
        
        // Indicamos al delegado que se ha seleccionado el Menú
        if (_delegate != nil) [_delegate Tabbar_rst_pedir_Touched];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_en_cocina_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_en_cocina_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (globalVar.B_pedido_confirmado) return;
    
    // Comprobamos que ya este en cocina
    if (!globalVar.B_pedido_en_cocina) return;
    
    // Cambiamos de View
    [self updateTabBarforIndex:1];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_rst_en_cocina_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_cuenta_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 23/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pagar_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (globalVar.B_pedido_confirmado) return;
    
    // Comprobamos que ya este en cocina
    if (!globalVar.B_pedido_en_cocina) return;
        
    // Cambiamos de View
    [self updateTabBarforIndex:2];
    
    // Indicamos al delegado que se ha seleccionado el Menú
    if (_delegate != nil) [_delegate Tabbar_rst_pagar_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_enviar_a_cocina_TouchUpInside
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_enviar_a_cocina_TouchUpInside:(id)sender {
    
    // Comprobamos si estamos en la pantalla de pedido confirmado
    if (!globalVar.B_pedido_confirmado) {
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Mi Actividad
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_ENVIAR_COCINA_ 
                                                            object:self];
    }
}


@end
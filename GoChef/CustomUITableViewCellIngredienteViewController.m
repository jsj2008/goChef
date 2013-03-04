//
//  CustomUITableViewCellIngredienteViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellIngredienteViewController.h"

#import "FoodOptionClass.h"
#import "OrderClass.h"
#import "FoodClass.h"
#import "RestaurantClass.h"


@implementation CustomUITableViewCellIngredienteViewController

@synthesize UIL_precio;
@synthesize UIL_nombre;
@synthesize UIIV_precio_background;

@synthesize B_active    = _B_active;
@synthesize B_options   = _B_options;
@synthesize B_onlyCheck = _B_onlyCheck;

@synthesize FOC_food_option = _FOC_food_option;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_active
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_active:(BOOL)B_active {
    
    _B_active = B_active;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_options
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_options:(BOOL)B_options {
    
    _B_options = B_options;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_options
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_onlyCheck:(BOOL)B_onlyCheck {
    
    _B_onlyCheck = B_onlyCheck;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setPIC_ingrediente
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setFOC_food_option:(FoodOptionClass *)FOC_food_option {
    
    _FOC_food_option = FOC_food_option;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 03/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setFOC_food_option:nil];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(FoodOptionClass *)newFOC_food_option active:(BOOL)B_active onlyCheck:(BOOL)B_onlyCheck {
    
    // Actualizamos propiedad
    [self setFOC_food_option :newFOC_food_option];
    [self setB_active        :B_active];
    [self setB_options       :FALSE];
    [self setB_onlyCheck     :B_onlyCheck];
    
    // Actualizamos el UILabel
    [UIL_nombre setText:_FOC_food_option.NSS_namefoodoption];
    
    // Actualizamos UILabel del Precio
    NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
    [UIL_precio setText:[NSString stringWithFormat:@"%.2f%@", _FOC_food_option.CGF_priceplusfoodoption, NSS_symbol]];
    
    // Actualizamos UIImage de background precio
    UIImage *UII_image;
    
    // Comprobamo si está seleccionado
    if (!_B_active) {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_normal.png"];
    }
    else {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_select.png"];
    }
    
    // Actualizamos UIImageView
    [UIIV_precio_background setImage:UII_image];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWithText:price:active:
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWithText:(NSString *)NSS_text price:(CGFloat)CGF_price active:(BOOL)B_active {
    
    // Actualizamos propiedad
    [self setB_active   :B_active];
    [self setB_onlyCheck:FALSE];
    
    // Actualizamos el UILabel
    [UIL_nombre setText:NSS_text];
    
    // Comprobamos si es una Options
    _B_options = ([NSS_text isEqualToString:_PEDIDO_MAS_INGREDIENTES_TEXT_]);
    
    // Actualizamos UILabel del Precio
    NSString *NSS_symbol = [[NSLocale currentLocale] objectForKey: NSLocaleCurrencySymbol];
    [UIL_precio setText:[NSString stringWithFormat:@"%.2f%@", CGF_price, NSS_symbol]];
    
    // Actualizamos UIImage de background precio
    UIImage *UII_image;
    
    // Comprobamo si está seleccionado
    if (!_B_active) {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_normal.png"];
    }
    else {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_select.png"];
    }
    
    // Actualizamos UIImageView
    [UIIV_precio_background setImage:UII_image];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cell_TouchUpInside
//#	Fecha Creación	: 03/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cell_TouchUpInside:(id)sender {
    
    // Actualizamos propiedad
    [self setB_active:!_B_active];
    
    // Actualizamos UIImage de background precio
    UIImage *UII_image;
    
    // Comprobamo si está seleccionado
    if (!_B_active) {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_normal.png"];
        
        // Comprobamos que NO solo haya que checkear
        if (!_B_onlyCheck) {
            
            // Comprobamos que NO sea para Mas ingredicentes o Combo
            if (_FOC_food_option != nil) {
                
                // Volvemos a marcar celda -> options obligatories tiene que haber siempre una marcada
                UII_image = [UIImage imageNamed:@"pedir_precio_select.png"];
            }
            else if (!_B_options) {
                
                // Quitamos group
                [globalVar.OFC_order_food setNSI_idfoodgroup:_ID_FOOD_NO_GROUP_];
            }
        }
    }
    else {
        
        // Asignamos fichero Imagen
        UII_image = [UIImage imageNamed:@"pedir_precio_select.png"];
        
        // Comprobamos que NO solo haya que checkear
        if (!_B_onlyCheck) {
            
            // Comprobamos que NO sea para Mas ingredicentes o Combo
            if (_FOC_food_option != nil) {
                
                FoodOptionClass *FOC_option_remove;
                
                // Buscamos la Options obligatorio que esta seleccionada actualmente
                for (FoodOptionClass *FOC_option in globalVar.OFC_order_food.NSMA_options) {
                    
                    // Recorremos Array de Food
                    for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods) {
                        
                        // Comprobamos si es la Food de la OrderFood
                        if (FC_food.NSI_idfood == globalVar.OFC_order_food.NSI_idfood) {
                            
                            // Recorremos el Array de Options
                            for (FoodOptionClass *FOC_option_obligatorie in FC_food.NSMA_options_obligatories) {
                                
                                // Comprobamos si es un Options NO obligatorie
                                if (FOC_option_obligatorie.NSI_idfoodoption == FOC_option.NSI_idfoodoption) 
                                    FOC_option_remove = FOC_option;
                            }
                        }
                    }
                }
                
                // Eliminamos seleccion actial
                [globalVar.OFC_order_food.NSMA_options removeObject:FOC_option_remove];
                
                // Insertamos la Options
                //[globalVar.OFC_order_food.NSMA_options addObject:_FOC_food_option];
            }
            else if (!_B_options) {
                
                // Recorremos Array de Food
                for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods) {
                    
                    // Comprobamos si es la Food de la OrderFood
                    if (FC_food.NSI_idfood == globalVar.OFC_order_food.NSI_idfood) {
                        
                        // Añadimos group
                        [globalVar.OFC_order_food setNSI_idfoodgroup:FC_food.NSI_idfoodgroup];
                        break;
                    }
                }
            }
        }
    }
    
    // Actualizamos UIImageView
    [UIIV_precio_background setImage:UII_image];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate cellTouched:_FOC_food_option options:_B_options];
}


@end
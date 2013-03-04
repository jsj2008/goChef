//
//  CustomUITableViewCellEnCocinaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellEnCocinaViewController.h"

#import "OrderClass.h"
#import "OrderFoodClass.h"
#import "DailymenuClass.h"
#import "RestaurantClass.h"
#import "DailymenufoodClass.h"
#import "FoodOptionClass.h"


@implementation CustomUITableViewCellEnCocinaViewController

@synthesize UIL_nombre_plato;
@synthesize UIL_cantidad;
@synthesize UIL_caraceristicas;
@synthesize UIL_precio;
@synthesize UIIV_precio_background;

@synthesize OFC_food = _OFC_food;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOFC_food
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOFC_food:(OrderFoodClass *)OFC_food {
    
    _OFC_food = OFC_food;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setContentWith
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderFoodClass *)newOFC_food {
    
    // Actualizamos propiedad
    [self setOFC_food:newOFC_food];
    
    // Actualizamos el UILabel
    [UIL_nombre_plato   setText:_OFC_food.NSS_namefood];
    [UIL_caraceristicas setText:@""];
    
    // Comprobamos si es un menú o una carta
    if (_OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
        
        // ACtualizamos UILabel Cantidad
        [UIL_cantidad setText:[NSString stringWithFormat:@"%d", _OFC_food.NSI_amount]];
        
        // Buscamos el menu
        CGFloat CGF_price;
        BOOL B_encontrado = FALSE;
        for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
            if (B_encontrado) break; 
            for (DailymenufoodClass *DFC_food in DMC_menu.NSMA_dailymenufoods)
                if (DFC_food.NSI_idfood == _OFC_food.NSI_iddailymenu_food) {
                    CGF_price = DMC_menu.CGF_price;
                    B_encontrado = TRUE;
                    break;
                }
        }
        
        // Contruimos las características
        [UIL_caraceristicas setText:[NSString stringWithFormat:@"Menú de %.2f €", CGF_price]];
        
        // Actualizamos UILabel del Precio
        [UIL_precio setText:@""];
        
        // Ocultamos Precio background
        [UIIV_precio_background setAlpha:0.0f];
    }
    else {
        
        NSString *NSS_caraceristicas = @"";
        BOOL B_encontrado = FALSE;
        
        // Recorremos el Array de options
        for (FoodOptionClass *FOC_option in _OFC_food.NSMA_options) {
            if (B_encontrado) break; 
            for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods) {
                if (B_encontrado) break;
                if (FC_food.NSI_idfood == _OFC_food.NSI_idfood)
                    for (FoodOptionClass *FOC_option_obligatories in FC_food.NSMA_options_obligatories)
                        if (FOC_option_obligatories.NSI_idfoodoption == FOC_option.NSI_idfoodoption) {
                            NSS_caraceristicas = FOC_option.NSS_namefoodoption;
                            B_encontrado = TRUE;
                            break;
                        }
            }
        }
        
        // Contruimos las características
        [UIL_caraceristicas setText:[NSString stringWithFormat:@"%@", NSS_caraceristicas]];
        
        // Actualizamos UILabel cantidad
        [UIL_cantidad setText:[NSString stringWithFormat:@"%d", _OFC_food.NSI_amount]];
        
        // Actualizamos UILabel del Precio
        [UIL_precio setText:[NSString stringWithFormat:@"%.2f €", [_OFC_food CGF_total_price]]];
    }
}


@end
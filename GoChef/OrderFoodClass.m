//
//  OrderFoodClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "OrderFoodClass.h"
#import "FoodOptionClass.h"
#import "OrderClass.h"
#import "RestaurantClass.h"


@implementation OrderFoodClass

@synthesize NSI_idorder_food     = _NSI_idorder_food;
@synthesize NSI_idfood           = _NSI_idfood;
@synthesize NSI_iddailymenu_food = _NSI_iddailymenu_food;
@synthesize NSI_idfoodcategories = _NSI_idfoodcategories;
@synthesize NSI_idfoodgroup      = _NSI_idfoodgroup;
@synthesize NSI_amount           = _NSI_amount;
@synthesize NSI_menus            = _NSI_menus;

@synthesize NSS_namefood             = _NSS_namefood;
@synthesize NSS_descriptionfood      = _NSS_descriptionfood;
@synthesize NSS_namefoodcategories   = _NSS_namefoodcategories;
@synthesize NSS_namefoodgroup        = _NSS_namefoodgroup;
@synthesize NSS_descriptionfoodgroup = _NSS_descriptionfoodgroup;
@synthesize NSS_instructions         = _NSS_instructions;

@synthesize CGF_price              = _CGF_price;
@synthesize CGF_priceplusfoodgroup = _CGF_priceplusfoodgroup;

@synthesize B_is_offer = _B_is_offer;
@synthesize B_is_offer_facebook = _B_is_offer_facebook;
@synthesize B_is_price_offer = _B_is_price_offer;

@synthesize IC_imagefood = _IC_imagefood;

@synthesize NSMA_options = _NSMA_options;


#pragma mark -
#pragma mark Propiedades

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_is_offer_facebook
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_is_offer_facebook:(BOOL)B_is_offer_facebook {
    
    _B_is_offer_facebook = B_is_offer_facebook;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setB_is_price_offer
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 30/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_is_price_offer:(BOOL)B_is_price_offer {
    
    _B_is_price_offer = B_is_price_offer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_instructions
//#	Fecha Creación	: 22/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_is_offer:(BOOL)B_is_offer {
    
    _B_is_offer = B_is_offer;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_instructions
//#	Fecha Creación	: 31/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 31/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_instructions:(NSString *)NSS_instructions {
    
    _NSS_instructions = NSS_instructions;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_iddailymenu_food
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_iddailymenu_food:(NSInteger)NSI_iddailymenu_food {
    
    _NSI_iddailymenu_food = NSI_iddailymenu_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idorder_food
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idorder_food:(NSInteger)NSI_idorder_food {
    
    _NSI_idorder_food = NSI_idorder_food;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_amount
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_amount:(NSInteger)NSI_amount {
    
    _NSI_amount = NSI_amount;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfood
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfood:(NSInteger)NSI_idfood {
    
    _NSI_idfood = NSI_idfood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodcategories
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodcategories:(NSInteger)NSI_idfoodcategories {
    
    _NSI_idfoodcategories = NSI_idfoodcategories;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_idfoodgroup
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_idfoodgroup:(NSInteger)NSI_idfoodgroup {
    
    _NSI_idfoodgroup = NSI_idfoodgroup;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSI_menus
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSI_menus:(NSInteger)NSI_menus {
    
    _NSI_menus = NSI_menus;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefood
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefood:(NSString *)NSS_namefood {
    
    _NSS_namefood = [NSS_namefood copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionfood
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionfood:(NSString *)NSS_descriptionfood {
    
    _NSS_descriptionfood = [NSS_descriptionfood copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodcategories
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodcategories:(NSString *)NSS_namefoodcategories {
    
    _NSS_namefoodcategories = [NSS_namefoodcategories copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_namefoodgroup
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_namefoodgroup:(NSString *)NSS_namefoodgroup {
    
    _NSS_namefoodgroup = [NSS_namefoodgroup copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSS_descriptionfoodgroup
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSS_descriptionfoodgroup:(NSString *)NSS_descriptionfoodgroup {
    
    _NSS_descriptionfoodgroup = [NSS_descriptionfoodgroup copy];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_price
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_price:(CGFloat)CGF_price {
    
    _CGF_price = CGF_price;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setCGF_priceplusfoodgroup
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCGF_priceplusfoodgroup:(CGFloat)CGF_priceplusfoodgroup {
    
    _CGF_priceplusfoodgroup = CGF_priceplusfoodgroup;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setIC_imagefood
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 15/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setIC_imagefood:(ImageClass *)IC_imagefood {
    
    _IC_imagefood = IC_imagefood;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setNSMA_options
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setNSMA_options:(NSMutableArray *)NSMA_options {
    
    _NSMA_options = NSMA_options;
}

#pragma mark -
#pragma mark Funciones generales

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : init
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {
    
    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos propiedades
    [self setNSI_idfood           : _ID_FOOD_NO_SELECCIONADA_];
    [self setNSI_iddailymenu_food : _ID_FOOD_NO_SELECCIONADA_];
    [self setNSI_idfoodgroup      : _ID_FOOD_NO_GROUP_];
    [self setNSI_amount           : 1];
    [self setNSI_menus            : 0];
    [self setB_is_offer           : FALSE];
    [self setB_is_offer_facebook  : FALSE];
    [self setB_is_price_offer     : FALSE];
    
    // Iniciamos los Arrays
    _NSMA_options = [[NSMutableArray alloc] init];
    
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : CGF_total_price
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) CGF_total_price {
    
    // Comprobamos si es una offer
    if (_B_is_offer_facebook) return 0.0;
    
    CGFloat CGF_total = _CGF_price;

    // Añadimos las options
    for (FoodOptionClass *FOC_option in _NSMA_options) CGF_total += FOC_option.CGF_priceplusfoodoption;
    
    // Comprobamos si se ha seleccionado el grupo
    if (_NSI_idfoodgroup != _ID_FOOD_NO_GROUP_) CGF_total += _CGF_priceplusfoodgroup;
        
    // Multiplicamos por la cantidad
    CGF_total *= _NSI_amount;
    
    return CGF_total;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : CGF_options_price
//#	Fecha Creación	: 25/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(CGFloat) CGF_options_price {
    
    // Comprobamos si es una offer
    if (_B_is_offer_facebook) return 0.0;
    
    BOOL B_obligatotie = FALSE;
    CGFloat CGF_total = 0.0f;
    
    // Recorremos el Array de Options
    for (FoodOptionClass *FOC_option in _NSMA_options) {
        
        // Recorremos Array de Food
        for (FoodClass *FC_food in globalVar.OC_order.RC_restaurant.NSMA_foods) {
            
            // Comprobamos si es la Food de la OrderFood
            if (FC_food.NSI_idfood == _NSI_idfood) {
                
                // Recorremos el Array de Options
                for (FoodOptionClass *FOC_option_obligatorie in FC_food.NSMA_options_obligatories) {
                    
                     // Comprobamos si es un Options NO obligatorie
                    if (FOC_option_obligatorie.NSI_idfoodoption == FOC_option.NSI_idfoodoption) B_obligatotie = TRUE;
                }
            }
        }
        
        // Comprobamo si NO es obligaorie
        if (!B_obligatotie) CGF_total += FOC_option.CGF_priceplusfoodoption;
        else B_obligatotie = FALSE;
    }
    
    return CGF_total;
}


@end
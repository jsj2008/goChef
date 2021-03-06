//
//  CustomUITableViewCellEnCocinaPieViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellEnCocinaPieViewController.h"

#import "OrderClass.h"
#import "RestaurantClass.h"
#import "UserOfferClass.h"
#import "UserClass.h"


@implementation CustomUITableViewCellEnCocinaPieViewController

@synthesize UIL_subtotal;
@synthesize UIL_descuento;
@synthesize UIL_descuento_ofertas;
@synthesize UIL_total;
@synthesize UIIV_background;

@synthesize OC_order = _OC_order;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad       : setOC_order
//#	Fecha Creación	: 10/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/07/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setOC_order:(OrderClass *)OC_order {
    
    _OC_order = OC_order;
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
//#	Fecha Ult. Mod.	: 13/02/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(OrderClass *)newOC_order {
    
    // Actualizamos propiedad
    [self setOC_order:newOC_order];
    
    NSMutableArray *NSMA_menus = [[NSMutableArray alloc] init];
    
    // Iniciamos Cantidad Máxima
    for (DailymenuClass *DMC_menu in _OC_order.RC_restaurant.NSMA_dailymenus) {
        NSNumber *NSN_numer = [NSNumber numberWithInt:0];
        [NSMA_menus addObject:NSN_numer];
    }
    
    // Calculamos el subtotal
    CGFloat CGF_subtotal = 0.0f;
    for (OrderFoodClass *OFC_food in _OC_order.NSMA_orderfoods) {
        
        // Comprobamos si es un menu
        if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
            
            // Buscamos el idDailyMenu
            int iPos = 0;
            for (DailymenuClass *DMC_menu in _OC_order.RC_restaurant.NSMA_dailymenus) {
                
                BOOL B_encontrado = FALSE;
                for (DailymenufoodClass *DMFC_food in DMC_menu.NSMA_dailymenufoods)
                    if (DMFC_food.NSI_idfood == OFC_food.NSI_iddailymenu_food) {
                        B_encontrado = TRUE;
                        break;
                    }
                
                if (B_encontrado) break;
                else iPos += 1;
            }
            
            // Comprobamos si el menú ya fue contabilizado
            NSNumber *NSN_number = [NSMA_menus objectAtIndex:iPos];
            NSInteger NSI_number = [NSN_number integerValue];
            if (NSI_number < OFC_food.NSI_menus) [NSMA_menus replaceObjectAtIndex:iPos withObject:[NSNumber numberWithInt:OFC_food.NSI_menus]];
        }
        else {
            
            // Sumamos el coste del food
            CGF_subtotal += [OFC_food CGF_total_price];
        }
    }
    
    // Fijamos el subtotal sin los platos de los menus
    CGFloat CGF_subtotal_carta = CGF_subtotal;
    
    // Incrementamos subtotal con los menus
    int iPos = 0;
    for (NSNumber *NSN_number in NSMA_menus) {
        
        NSInteger NSI_number = [NSN_number integerValue];
        if (NSI_number > 0) {
            DailymenuClass *DMC_menu = [_OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:iPos];
            CGF_subtotal += (DMC_menu.CGF_price * NSI_number);
        }
        
        iPos += 1;
    }
    
    // Actualizamos el UILabel
    [UIL_subtotal setText:[NSString stringWithFormat:@"%.2f €", CGF_subtotal]];
    
    // Calculamos descuento por la oferta
    CGFloat CGF_offer = 0.0f;
    if (_OC_order.OC_offer.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Comprobamos tipo de descuento
        switch (_OC_order.OC_offer.TOT_typediscount)
        {
            case TOT_descuento_sobre_carta:
            {
                // Calculamos porcentaje
                CGF_offer = (CGF_subtotal_carta*_OC_order.OC_offer.NSI_discount/100);
                break;
            }
            case TOT_regalo_plato_categoria:
            {
                // Recuperamos valor descuento
                CGF_offer = _OC_order.CGF_offer_discount;
                break;
            }
            case TOT_regalo_plato:
            {
                // Recuperamos valor descuento
                CGF_offer = _OC_order.CGF_offer_discount;
                break;
            }
            case TOT_2x1_en_categoria:
            {
                // Recuperamos valor descuento
                CGF_offer = _OC_order.CGF_offer_discount;
                break;
            }
        }
    }
    
    // Calculamos descuento
    CGFloat CGF_discount;
    if ([_OC_order.RC_restaurant B_discount_efectivo]) CGF_discount = [_OC_order.RC_restaurant CGF_discount];
    else CGF_discount = ((CGF_subtotal-CGF_offer)*[_OC_order.RC_restaurant CGF_discount]/100);
    
    // Calculamos el Total
    CGFloat CGF_total = CGF_subtotal;
    if (_OC_order.TOT_type == TOT_pedido_a_domicilio) CGF_total += _OC_order.RC_restaurant.CGF_price_homedelivery;
    CGF_total -= CGF_discount;
    CGF_total -= CGF_offer;
    
    // Actualizamos los UILabel
    [UIL_descuento         setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_discount == 0)?@"":@"-", CGF_discount]];
    [UIL_descuento_ofertas setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_offer == 0)?@"":@"-", CGF_offer]];
    [UIL_total             setText:[NSString stringWithFormat:@"%.2f €", CGF_total]];
    
    // Actualizamos propiedades Order
    [_OC_order setCGF_subtotal             :CGF_subtotal];
    [_OC_order setCGF_membership_discount  :CGF_discount];
    [_OC_order setCGF_offer_discount       :CGF_offer];
    [_OC_order setCGF_price_homedelivery   :_OC_order.RC_restaurant.CGF_price_homedelivery];
    [_OC_order setCGF_total                :CGF_total];
    
    // Comprobamos Tipo descuento usuario
    if ([_OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_ORO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_oro.png"];
        [UIIV_background setImage:UII_recoger_background];  
    }
    else if ([_OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATINO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_platino.png"];
        [UIIV_background setImage:UII_recoger_background];
    }
    else if ([_OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATA_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_plata.png"];
        [UIIV_background setImage:UII_recoger_background];
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pagar_TouchUpInside
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pagar_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate pagar_touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_pagar_TouchUpInside
//#	Fecha Creación	: 16/07/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_pedir_mas_comida_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate pedir_mas_comida_touched];
}


@end
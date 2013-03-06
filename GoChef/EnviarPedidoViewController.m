//
//  EnviarPedidoViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "EnviarPedidoViewController.h"
#import "LoadingViewController.h"
#import "TarjetasAltaViewController.h"
#import "ConfirmacionViewController.h"

#import "TarjetaClass.h"
#import "DireccionClass.h"
#import "OrderClass.h"
#import "DailymenuClass.h"
#import "RestaurantClass.h"
#import "UserClass.h"
#import "JSONparseClass.h"

@interface  EnviarPedidoViewController (Private)

-(void) cuponValidationResultOk:(NSNotification*)note;
-(void) cuponValidationResultKo;

@end


@implementation EnviarPedidoViewController

@synthesize UITF_actual;

@synthesize UIL_direccion_00;
@synthesize UIL_direccion_01;
@synthesize UIL_direccion_02;
@synthesize UIL_tarjeta;
@synthesize UIB_en_efectivo;
@synthesize UIB_tarjeta;
@synthesize UITF_telefono;
@synthesize UITF_direccion_info;
@synthesize UIV_contenido;
@synthesize UIIV_tarjeta;
@synthesize UIV_recoger;
@synthesize UIV_domicilio;
@synthesize UIIV_domicilio_background;
@synthesize UIIV_recoger_background;
@synthesize UIL_domicilio_subtotal;
@synthesize UIL_domicilio_descuento;
@synthesize UIL_domicilio_gastos_envio;
@synthesize UIL_domicilio_descuento_ofertas;
@synthesize UIL_domicilio_total;
@synthesize UIL_recoger_subtotal;
@synthesize UIL_recoger_descuento;
@synthesize UIL_recoger_descuento_ofertas;
@synthesize UIL_recoger_total;
@synthesize UISV_scroll;

@synthesize B_keyboardIsShow  = _B_keyboardIsShow;
@synthesize TAVC_alta_tarjeta = _TAVC_alta_tarjeta;
@synthesize CVC_confirmar     = _CVC_confirmar;
@synthesize STVC_tarjeta      = _STVC_tarjeta;

@synthesize cupponTextField = _cupponTextField;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setB_keyboardIsShow
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setB_keyboardIsShow:(BOOL)B_keyboardIsShow {
    
    _B_keyboardIsShow = B_keyboardIsShow;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setCVC_confirmar
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setCVC_confirmar:(ConfirmacionViewController *)CVC_confirmar {
    
    _CVC_confirmar = CVC_confirmar;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setTAVC_alta_tarjeta
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTAVC_alta_tarjeta:(TarjetasAltaViewController *)TAVC_alta_tarjeta {
    
    _TAVC_alta_tarjeta = TAVC_alta_tarjeta;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setSTVC_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setSTVC_tarjeta:(SelectTarjetaViewController *)STVC_tarjeta {
    
    _STVC_tarjeta = STVC_tarjeta;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos UIScrollView
    [self.view setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    
    // Insertamos UIButton Topbar
    [self initNavigationBar];
    
    // Insertamos los UIView Contenido
    [UISV_scroll addSubview:UIV_contenido];

    // Registramos las notificaciones para el keyboard 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    // Iniciamos los UIButton filter
    [UIB_en_efectivo setSelected:FALSE];
    [UIB_tarjeta     setSelected:TRUE];
    
    // Iniciamos las Resumen UIView
    [self initResumenOrder];
    
    // Actualizamos la Adrress seleccionada y la almancenamos en el servidor
    [self initUserAddress];
    
    // Iniciamos las Creditscard del Usuario
    [self initUserCreaditCards];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initUserAddress
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initUserAddress {
    
    // Comprobamos el tipo de pedido
    if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) {
        
        // Recuperamos la dirección
        DireccionClass *DC_useraddress = globalVar.OC_order.DC_useraddress;
        
        // Mostramos la dirección seleccionada
        [UIL_direccion_00 setText:@"Dirección de envío:"];
        [UIL_direccion_01 setText:[NSString stringWithFormat:@"%@ %@", DC_useraddress.NSS_direccion, DC_useraddress.NSS_numero]];
        [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@ %@", DC_useraddress.NSS_cp, DC_useraddress.NSS_ciudad]];
        
        // Comprobamos si se ha introducio un telefono en la dirección
        if ([DC_useraddress.NSS_telefono length] > 0) {
            
            // Mostramos el teléfono asociado a la dirección
            [UITF_telefono setText:[NSString stringWithFormat:@"%@", DC_useraddress.NSS_telefono]];
        }
        
        // Actualizamos instrucciones
        [UITF_direccion_info setText:globalVar.OC_order.NSS_instructions];
        
        // Comprobamos si es una direccion nueva
        if (globalVar.OC_order.DC_useraddress.NSI_id == _ID_NEW_ADDRESS_) {
            
            // Esperamos antes de ir al menú de la aplicación
            NSTimer *NST_timer;
            NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                         target:self
                                                       selector:@selector(setDireccion)
                                                       userInfo:nil
                                                        repeats:NO];
        }
        else {
            
            // Esperamos antes de ir al menú de la aplicación
            NSTimer *NST_timer;
            NST_timer = [NSTimer scheduledTimerWithTimeInterval:_DELAY_INIT_JSON_PARSE_
                                                         target:self
                                                       selector:@selector(updateDireccion)
                                                       userInfo:nil
                                                        repeats:NO];
        }
    }
    else {
        
        // Comprobamos si se ha introducio un telefono en el usuario
        if (globalVar.UC_user.NSI_phone > 10000) {
            
            // Mostramos el teléfono asociado a la dirección
            [UITF_telefono setText:[NSString stringWithFormat:@"%d", globalVar.UC_user.NSI_phone]];
        }
        
        // Mostramos la dirección seleccionada
        [UIL_direccion_00 setText:[NSString stringWithFormat:@"%@", globalVar.OC_order.RC_restaurant.NSS_name]];
        [UIL_direccion_01 setText:[NSString stringWithFormat:@"%@", globalVar.OC_order.RC_restaurant.NSS_address1]];
        [UIL_direccion_02 setText:[NSString stringWithFormat:@"%@", globalVar.OC_order.RC_restaurant.NSS_distance]];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initUserCreaditCards
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initUserCreaditCards {
    
    // Iniciamos UIView Tarjeta Info View
    [self updateUIViewInfoTarjeta];
    
    // Actualizamso UILabel
    [UIL_tarjeta setText:@"--"];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initResumenOrder
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initResumenOrder {

    // Comprobamos que tipo de pedido es
    if ( (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) || (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) ) {
        
        // Insertamos View
        [UISV_scroll addSubview:UIV_recoger];
        
        // Posicionamos View
        [UIV_recoger setFrame:CGRectMake(0.0f, 370.0f, UIV_recoger.frame.size.width, UIV_recoger.frame.size.height)];
    }
    else {
        
        // Insertamos View
        [UISV_scroll addSubview:UIV_domicilio];
        
        // Posicionamos View
        [UIV_domicilio setFrame:CGRectMake(0.0f, 370.0f, UIV_domicilio.frame.size.width, UIV_domicilio.frame.size.height)];
    }
    
    NSMutableArray *NSMA_menus = [[NSMutableArray alloc] init];
    
    // Iniciamos Cantidad Máxima
    for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
        NSNumber *NSN_numer = [NSNumber numberWithInt:0];
        [NSMA_menus addObject:NSN_numer];
    }
    
    // Calculamos el subtotal
    CGFloat CGF_subtotal = 0.0f;
    for (OrderFoodClass *OFC_food in globalVar.OC_order.NSMA_orderfoods) {
        
        // Comprobamos si es un menu
        if (OFC_food.NSI_iddailymenu_food != _ID_FOOD_NO_SELECCIONADA_) {
            
            // Buscamos el idDailyMenu
            int iPos = 0;
            for (DailymenuClass *DMC_menu in globalVar.OC_order.RC_restaurant.NSMA_dailymenus) {
                
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
            DailymenuClass *DMC_menu = [globalVar.OC_order.RC_restaurant.NSMA_dailymenus objectAtIndex:iPos];
            CGF_subtotal += (DMC_menu.CGF_price * NSI_number);
        }
        
        iPos += 1;
    }
    
    // Actualizamos el UILabel
    [UIL_domicilio_subtotal setText:[NSString stringWithFormat:@"%.2f €", CGF_subtotal]];
    [UIL_recoger_subtotal   setText:[NSString stringWithFormat:@"%.2f €", CGF_subtotal]];
    
    // Calculamos descuento por la oferta
    CGFloat CGF_offer = 0.0f;
    if (globalVar.OC_order.OC_offer.NSI_idoffer != _ID_OFFER_NO_SELECTED_) {
        
        // Comprobamos tipo de descuento
        switch (globalVar.OC_order.OC_offer.TOT_typediscount)
        {
            case TOT_descuento_sobre_carta:
            {
                // Calculamos porcentaje
                CGF_offer = (CGF_subtotal_carta*globalVar.OC_order.OC_offer.NSI_discount/100);
                break;
            }
            case TOT_regalo_plato_categoria:
            {
                // Recuperamos valor descuento
                CGF_offer = globalVar.OC_order.CGF_offer_discount;
                break;
            }
            case TOT_regalo_plato:
            {
                // Recuperamos valor descuento
                CGF_offer = globalVar.OC_order.CGF_offer_discount;
                break;
            }
            case TOT_2x1_en_categoria:
            {
                // Recuperamos valor descuento
                CGF_offer = globalVar.OC_order.CGF_offer_discount;
                break;
            }
        }
    }
    
    // Calculamos descuento
    CGFloat CGF_discount;
    if ([globalVar.OC_order.RC_restaurant B_discount_efectivo]) CGF_discount = [globalVar.OC_order.RC_restaurant CGF_discount];
    else CGF_discount = ((CGF_subtotal-CGF_offer)*[globalVar.OC_order.RC_restaurant CGF_discount]/100);
    
    // Calculamos el Total
    CGFloat CGF_total = CGF_subtotal;
    if (globalVar.OC_order.TOT_type == TOT_pedido_a_domicilio) CGF_total += globalVar.OC_order.RC_restaurant.CGF_price_homedelivery;
    CGF_total -= CGF_discount;
    CGF_total -= CGF_offer;
    
    // Actualizamos los UILabel
    [UIL_domicilio_descuento         setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_discount == 0)?@"":@"-", CGF_discount]];
    [UIL_domicilio_gastos_envio      setText:[NSString stringWithFormat:@"%.2f €", globalVar.OC_order.RC_restaurant.CGF_price_homedelivery]];
    [UIL_domicilio_descuento_ofertas setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_offer == 0)?@"":@"-", CGF_offer]];
    [UIL_domicilio_total             setText:[NSString stringWithFormat:@"%.2f €", CGF_total]];
    [UIL_recoger_descuento           setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_discount == 0)?@"":@"-", CGF_discount]];
    [UIL_recoger_descuento_ofertas   setText:[NSString stringWithFormat:@"%@%.2f €", (CGF_offer == 0)?@"":@"-", CGF_offer]];
    [UIL_recoger_total               setText:[NSString stringWithFormat:@"%.2f €", CGF_total]];
    
    // Comprobamos Tipo descuento usuario
    if ([globalVar.OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_ORO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_domicilio_background = [UIImage imageNamed:@"mi_pedido_pie_domicilio_oro.png"];
        [UIIV_domicilio_background setImage:UII_domicilio_background];
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_oro.png"];
        [UIIV_recoger_background setImage:UII_recoger_background];  
    }
    else if ([globalVar.OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATINO_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_domicilio_background = [UIImage imageNamed:@"mi_pedido_pie_domicilio_platino.png"];
        [UIIV_domicilio_background setImage:UII_domicilio_background];
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_platino.png"];
        [UIIV_recoger_background setImage:UII_recoger_background];
    }
    else if ([globalVar.OC_order.RC_restaurant.NSS_namemembership isEqualToString:_ESTADO_PLATA_]) {
        
        // Actualizamos UIImage estado
        UIImage *UII_domicilio_background = [UIImage imageNamed:@"mi_pedido_pie_domicilio_plata.png"];
        [UIIV_domicilio_background setImage:UII_domicilio_background];
        
        // Actualizamos UIImage estado
        UIImage *UII_recoger_background = [UIImage imageNamed:@"mi_pedido_pie_recoger_plata.png"];
        [UIIV_recoger_background setImage:UII_recoger_background];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Insertamos el title de la NavigationBar
    self.navigationItem.title = @"Enviar Pedido";
    
    // Iniciamos variable que indica si el teclado está oculto o no
    [self setB_keyboardIsShow:FALSE];
    
    // Oultamos el teclado
    [UITF_actual resignFirstResponder];
    
    // Recolocamos UIScrollView
    [self initUIScrollView];
    
    // Comprobamos si existe una direccion seleccionada
    [UIL_tarjeta setText:[globalVar formatTarjetaNumber:globalVar.OC_order.TC_creditcard]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillDisappear
//#	Fecha Creación	: 07/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillDisappear:(BOOL)animated {
    
    // Eliminamos las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initUIScrollView {
    
    // Oultamos el teclado
    [UITF_actual resignFirstResponder];
    
    // Recuperamos la UIview resumen
    UIView *UIV_resumen;
    if (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) UIV_resumen = UIV_recoger;
    else UIV_resumen = UIV_domicilio;
    
    // Recalculamos el tamaño View
    [UISV_scroll   setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 400.0f)];
    [UIV_contenido setFrame:CGRectMake(0.0f, 0.0f, UIV_contenido.frame.size.width, UIV_contenido.frame.size.height)];
    [UISV_scroll   setContentSize:CGSizeMake(UIV_contenido.frame.size.width, (UIV_contenido.frame.size.height + UIV_resumen.frame.size.height))];
    [UISV_scroll   setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUIViewInfoTarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUIViewInfoTarjeta {
    
    // Recuperamos la UIview resumen
    UIView *UIV_resumen;
    if ( (globalVar.OC_order.TOT_type == TOT_pedido_para_recoger) || (globalVar.OC_order.TOT_type == TOT_pedido_antes_de_ir_al_restaurante) ) UIV_resumen = UIV_recoger;
    else UIV_resumen = UIV_domicilio;
    
    // Comprobamos si es es efectivo o tarjeta
    if (UIB_tarjeta.selected) {
        
        // Seleccionamos la Default CreditCard
        [self selectDefaultCreditCard];
    }
    else {
        
        // Indicamos que no hay tarjeta
        globalVar.OC_order.TC_creditcard = [[TarjetaClass alloc] init];
    }
    
    // Comprobamos si ya esta en el estado que debe
    if ( (UIB_tarjeta.selected) && (UIV_resumen.frame.origin.y == 370.0f) ) return;
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Comprobamos si debemos mostrar o ocultar la tarjeta info
    if (UIV_resumen.frame.origin.y == 370.0f) {

        // Reposicionamos los View
        [UIV_resumen setFrame:CGRectMake(0.0f, 257.0f, UIV_resumen.frame.size.width, UIV_resumen.frame.size.height)];
        
        // Ocultamos UIImage
        [UIIV_tarjeta setAlpha:0.0f];
    }
    else {
        
        // Reposicionamos los View
        [UIV_resumen setFrame:CGRectMake(0.0f, 370.0f, UIV_resumen.frame.size.width, UIV_resumen.frame.size.height)];
        
        // Ocultamos UIImage
        [UIIV_tarjeta setAlpha:1.0f];
    }
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initNavigationBar
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initNavigationBar {
    
    // Creamos contenedor de UIButtons
    UIView* UIV_leftContainer = [[UIView alloc] init];
    
    // Creamos UIButton de "Guardar User"
    UIButton *UIB_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_normal.png"] forState:UIControlStateNormal];
    [UIB_back setImage:[UIImage imageNamed:@"topbar_button_back_select.png"] forState:UIControlStateHighlighted];
    [UIB_back addTarget:self action:@selector(goBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [UIV_leftContainer addSubview:UIB_back];
    
    // Adaptamos tamaño de la UIView
    [UIV_leftContainer setFrame:CGRectMake(0.0f, 12.0f, 65.0f, 32.0f)];
    
    // Creamos el UIBarButtonItem
    UIBarButtonItem *UIBBI_leftItems = [[UIBarButtonItem alloc] initWithCustomView:UIV_leftContainer];
    
    // Insertamos BackButton en la NavigationBar
    self.navigationItem.leftBarButtonItem = UIBBI_leftItems;
    [self.navigationItem hidesBackButton];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: goBackTapped
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 13/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) goBackTapped:(id)sender  {
    
    // Volvemos Viewcontroller padre
    [self.navigationController popViewControllerAnimated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: selectDefaultCreditCard
//#	Fecha Creación	: 29/06/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) selectDefaultCreditCard {
    
    // Recorremos el array de tarjetas
    for (TarjetaClass *TC_tarjeta in globalVar.NSMA_tarjetas) {
        
        // Comprobamo si es la tarjeta por defecto
        if (TC_tarjeta.B_default) {
            
            // Marcamos como tarjeta seleccionada
            [globalVar.OC_order setTC_creditcard:TC_tarjeta];
            
            // Actualizamos UILabel
            [UIL_tarjeta setText:[globalVar formatTarjetaNumber:globalVar.OC_order.TC_creditcard]];
            
            break;
        }
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setDireccion
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDireccion {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ADDRESS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ADDRESS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_ADDRESS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(setDireccionSuccessful:) 
                                                 name: _NOTIFICATION_SET_ADDRESS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_ADDRESS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_ADDRESS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading setDireccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateDireccion
//#	Fecha Creación	: 21/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) updateDireccion {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_UPDATE_ADDRESS_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_UPDATE_ADDRESS_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_UPDATE_ADDRESS_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateDireccionSuccessful:)
                                                 name: _NOTIFICATION_UPDATE_ADDRESS_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noInternet:)
                                                 name: _NOTIFICATION_UPDATE_ADDRESS_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(noSuccessful:)
                                                 name: _NOTIFICATION_UPDATE_ADDRESS_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading updateDireccion];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : registrarUsuario
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) editarUsuario {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_SUCCESSFUL_    object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_NO_INTERNET_   object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_SET_USER_ERROR_         object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(editarUsuarioSuccessful:) 
                                                 name: _NOTIFICATION_SET_USER_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_SET_USER_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_SET_USER_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading updateUser];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : setDireccionSuccessful
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setDireccionSuccessful:(NSNotification *)notification {
    
    // Comprobamos si debemos actualizar el usuario
    if (globalVar.B_guardar_usuario) {
        
        // Actualizamos su teléfono con el de la dirección
        [globalVar.UC_user setNSI_phone:[globalVar.OC_order.DC_useraddress.NSS_telefono integerValue]];
        
        // Enviamos actualización al servidor
        [self editarUsuario];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : updateDireccionSuccessful
//#	Fecha Creación	: 21/11/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) updateDireccionSuccessful:(NSNotification *)notification {
    
    // Comprobamos si debemos actualizar el usuario
    if (globalVar.B_guardar_usuario) {
        
        // Actualizamos su teléfono con el de la dirección
        [globalVar.UC_user setNSI_phone:[globalVar.OC_order.DC_useraddress.NSS_telefono integerValue]];
        
        // Enviamos actualización al servidor
        [self editarUsuario];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : editarUsuarioSuccessful
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) editarUsuarioSuccessful:(NSNotification *)notification {
    
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 26/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark Keyboard Notifications Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidShow
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidShow:(NSNotification *) notification {
    
    NSLog(@"keyboardDidShow");
    
    if (_B_keyboardIsShow) return;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    NSDictionary* info = [notification userInfo];
    
    //---obtain the size of the keyboard---
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    //---resize the scroll view (with keyboard)---
    CGRect viewFrame = [UISV_scroll frame];
    viewFrame.size.height -= (keyboardSize.height - 36.0f);
    UISV_scroll.frame = viewFrame;
    
    [UIView commitAnimations];
    
    [self setB_keyboardIsShow:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: keyboardDidHide
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 24/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) keyboardDidHide:(NSNotification *) notification {
    
    [self setB_keyboardIsShow:NO];
    
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 394.0f)];
    [UISV_scroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:TRUE];
    
    [UITF_actual resignFirstResponder];
}

#pragma mark -
#pragma mark TextField Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: textFieldDidBeginEditing
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) textFieldDidBeginEditing:(UITextField *)textFieldView {  
    
    // Fijamos UITextView Actual
    [self setUITF_actual:textFieldView];
    
    // Calculamos posición Y 
    CGFloat CGF_offsetY = textFieldView.center.y - 80.0f;
    
    // Comprobamos que no sea inferior al inicio
    if (CGF_offsetY < 0) CGF_offsetY = 0.0f;
    
    // Actualizamos la posición del UIScroll
    [UISV_scroll setContentOffset:CGPointMake(0,CGF_offsetY) animated:YES];
} 

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: textFieldShouldReturn
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) textFieldShouldReturn:(UITextField *) textFieldView {  
    
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 392.0f)];
    [UISV_scroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:TRUE];
    
    [textFieldView resignFirstResponder];
    return NO;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: textFieldDidEndEditing
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) textFieldDidEndEditing:(UITextField *) textFieldView {  
    
    // Fijamos UITextView Actual
    [self setUITF_actual:nil];
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_alta_tarjeta_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_alta_tarjeta_TouchUpInside:(id)sender {
    
    // Creamos TarjetasAltaViewController
    _TAVC_alta_tarjeta = [[TarjetasAltaViewController alloc] initWithNibName:@"TarjetasAltaView" bundle:[NSBundle mainBundle]];
    
    // Actualizamos propiedad
    [globalVar setTC_creditcard:nil];
    
    // Nos posicionamos en el primer View Controller
    [self.navigationController pushViewController:_TAVC_alta_tarjeta animated:YES];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_enviar_pedido_TouchUpInside
//#	Fecha Creación	: 13/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/10/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_enviar_pedido_TouchUpInside:(id)sender {
    
    // Comprobamos que si se ha seleccionado pago con tarjeta
    if (UIB_tarjeta.selected) {

        // Quitamos los posibles espacios
        NSString *NSS_tarjeta = [UIL_tarjeta.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // Comprobamos si no se ha seleccionado una tarjeta
        if ([NSS_tarjeta isEqualToString:@"Ninguna seleccionada"]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe seleccionar una tarjeta"];
            return;
        }
        
        // Comprobamos si el restaurante acepta ese tipo de tarjeta
        if ((([globalVar.OC_order.TC_creditcard.NSS_type isEqualToString:_CREDITCARD_VISA_TEXT_]) && (!globalVar.OC_order.RC_restaurant.B_visa)) ||
            (([globalVar.OC_order.TC_creditcard.NSS_type isEqualToString:_CREDITCARD_MASTERCARD_TEXT_]) && (!globalVar.OC_order.RC_restaurant.B_mastercard)))
        {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"El restaurante no permite pagos con el tipo de tarjeta seleccionado."];
            return;
        }
        
        // Comprobamos si la tarjeta tiene el CVV
        if ([globalVar.OC_order.TC_creditcard.NSS_cvv isEqualToString:_CVV_CREDIT_CARD_NULL]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Los datos de la tarjeta seleccionada están incompletos. Complete la información pendiente y vuelva a intentarlo."];
            return;
        }
    }
    
    // Comprobamos si se ha introducido el teléfono de contacto
    if ([UITF_telefono.text length] == 0) {
        
        [globalVar showAlerMsgWith:@"Error"
                           message:@"Debe introducir un teléfono de contacto"];
        return;
    }
    
    // Comprobamos si se va a realizar un pago con tarjeta
    if (globalVar.OC_order.NSI_idcreditcard != _ID_CREDITCARD_NO_SELECTED_) {
        
    }
    
    // Actualizamos instrucciones
    [globalVar.OC_order setNSS_instructions:UITF_direccion_info.text];
    
    // Mostramos mensage de confirmación
    UIAlertView *UIAV_confirm = [[UIAlertView alloc] init];
    [UIAV_confirm setTitle:@"Confirmación"];
    [UIAV_confirm setMessage:@"¿Está seguro de que quiere enviar el pedido? No podrá realizar más modificaciones."];
    [UIAV_confirm setDelegate:self];
    [UIAV_confirm addButtonWithTitle:@"Si"];
    [UIAV_confirm addButtonWithTitle:@"No"];
    [UIAV_confirm show];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_select_tarjeta_TouchUpInside
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/06/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_select_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos si no hay tarjetas
    if ([globalVar.NSMA_tarjetas count] == 0) {
    
        [globalVar showAlerMsgWith:@"Error"
                           message:@"No hay tarjetas creadas."];
        
        return;
    }
    
    // Comprobamos si ya se está mostrando
    if (_STVC_tarjeta != nil) return;
    
    // Creamos SelectTarjetaViewController
    _STVC_tarjeta = [[SelectTarjetaViewController alloc] initWithNibName:@"SelectTarjetaView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_STVC_tarjeta setDelegate:self];
    
    // Iniciamos Propiedades
    [_STVC_tarjeta setNSS_tarjeta:UIL_tarjeta.text];
    
    // Insertamos SelectTipoCocinaViewController
    [self.view addSubview:_STVC_tarjeta.view];
    
    // Posicionamos SelectTipoCocinaViewController
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    
    // Reposicionamos los View
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, (self.view.frame.size.height - _STVC_tarjeta.view.frame.size.height), _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
    
    // Oultamos el teclado
    [UITF_actual resignFirstResponder];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_filtro_efectivo_TouchUpInside
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 28/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_filtro_efectivo_TouchUpInside:(id)sender {
    
    // Comprobamos si ya está seleccionado
    if (!UIB_en_efectivo.selected) {

        // Actualizamos los UIButton filter
        [UIB_en_efectivo setSelected:TRUE];
        [UIB_tarjeta     setSelected:FALSE];
        
        // Actualizamos UIView Info Tarjeta
        [self updateUIViewInfoTarjeta];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_filtro_tarjeta_TouchUpInside
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 28/05/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_filtro_tarjeta_TouchUpInside:(id)sender {
    
    // Comprobamos si ya está seleccionado
    if (!UIB_tarjeta.selected) {
        
        // Actualizamos los UIButton filter
        [UIB_en_efectivo setSelected:FALSE];
        [UIB_tarjeta     setSelected:TRUE];
        
        // Actualizamos UIView Info Tarjeta
        [self updateUIViewInfoTarjeta];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_hide_keyboard
//#	Fecha Creación	: 12/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
-(IBAction) UIB_hide_keyboard:(id)sender {
    
    // Comprobamos si el teclado ya esta oculto
    if (!_B_keyboardIsShow) return;
    
    // Recolocamos el UIScrollView
    [UISV_scroll setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 392.0f)];
    [UISV_scroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:TRUE];
    
    // Ocultamos el teclado
    [UITF_actual resignFirstResponder];
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: alertView:clickedButtonAtIndex:
//#	Fecha Creación	: 30/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 11/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Comprobamos si ha confirmado ir a la página de diccionarios.com
    if (buttonIndex == 0) {
     
        // Creamos ConfirmacionViewController
        _CVC_confirmar = [[ConfirmacionViewController alloc] initWithNibName:@"ConfirmacionView" bundle:[NSBundle mainBundle]];
        
        // Nos posicionamos en el primer View Controller
        [self.navigationController pushViewController:_CVC_confirmar animated:YES];
    }
}

#pragma mark -  
#pragma mark Delegates Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 25/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) select_tarjeta:(TarjetaClass *)TC_tarjeta {
    
    // Marcamos como tarjeta seleccionada
    [globalVar.OC_order setTC_creditcard:TC_tarjeta];
    
    // Actualizamos UILabel
    [UIL_tarjeta setText:[globalVar formatTarjetaNumber:globalVar.OC_order.TC_creditcard]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : close_select_tipo_tarjeta
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) close_select_tarjeta {
    
    // Iniciamos animacion
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:_ANIMATION_SHOW_TABBAR_DURATION_];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    // Reposicionamos los View
    [_STVC_tarjeta.view setFrame:CGRectMake(0.0f, self.view.frame.size.height, _STVC_tarjeta.view.frame.size.width, _STVC_tarjeta.view.frame.size.height)];
    
    // Ejecutamos animacion
    [UIView commitAnimations];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: animationDidStop:finished:context:
//#	Fecha Creación	: 16/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/04/2012  (pjoramas)
//# Descripción		: 
//#
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
    // Quitamos el View Select Tipo Cocina
    [_STVC_tarjeta.view removeFromSuperview];
    
    // Liberamos memoria
    _STVC_tarjeta = nil;
}


#pragma mark - IBActions

-(IBAction) validateDiscountCuppon:(id)sender{
    
    // Comprobamos que si se ha seleccionado pago con tarjeta
    if (UIB_tarjeta.selected) {
        
        // Quitamos los posibles espacios
        NSString *NSS_tarjeta = [UIL_tarjeta.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // Comprobamos si no se ha seleccionado una tarjeta
        if ([NSS_tarjeta isEqualToString:@"Ninguna seleccionada"]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe seleccionar una tarjeta"];
            return;
        }
        
        // Comprobamos si la tarjeta tiene el CVV
        if ([globalVar.OC_order.TC_creditcard.NSS_cvv isEqualToString:_CVV_CREDIT_CARD_NULL]) {
            
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Los datos de la tarjeta seleccionada están incompletos. Complete la información pendiente y vuelva a intentarlo."];
            return;
        }
        
        if ([self.cupponTextField.text isEqualToString:@""]) {
            // Mostramos el error
            [globalVar showAlerMsgWith:@"Error"
                               message:@"Debe indicar un código de cupón para que pueda ser validado antes de ser aplicacdo a este pedido."];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cuponValidationResultOk:) name:@"cuponValidationResultOk" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cuponValidationResultKo) name:@"cuponValidationResultKo" object:nil];
        [globalVar.JPC_json UMNI_setOrderCupon:globalVar.OC_order];
    }

}

#pragma mark - private methods

-(void) cuponValidationResultOk:(NSNotification*)note{
    
    NSDictionary *dict = (NSDictionary*)note.object;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cuponValidationResultOk"  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cuponValidationResultKo"  object:nil];
}
-(void) cuponValidationResultKo{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cuponValidationResultOk"  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cuponValidationResultKo"  object:nil];
    // Mostramos el error
    [globalVar showAlerMsgWith:@"Error"
                       message:@"Se ha producidoun error al validar su cupón, vuelva a intentarlo otra vez."];
    return;

}
@end
//
//  CustomUITableViewCellBuscarRestauranteHeaderViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUITableViewCellBuscarRestauranteHeaderViewController.h"

#import "TipoCocinaClass.h"
#import "SearchRestaurantClass.h"


@implementation CustomUITableViewCellBuscarRestauranteHeaderViewController

@synthesize UIL_tipo_comida;
@synthesize UIL_restaurantes;
@synthesize UIB_cercania;
@synthesize UIB_ofertas;
@synthesize UIB_descuentos;

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : initWithNibName:bundle:
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		:
//#
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos UIButton
    [UIB_cercania   setSelected:FALSE];
    [UIB_ofertas    setSelected:FALSE];
    [UIB_descuentos setSelected:FALSE];
    
    // Activamos el método ordenación que corresponda
    switch (globalVar.SRC_search.TRO_order)
    {
        case TRO_distancia : [UIB_cercania   setSelected:TRUE]; break;
        case TRO_ofertas   : [UIB_ofertas    setSelected:TRUE]; break;
        case TRO_descuentos: [UIB_descuentos setSelected:TRUE]; break;
    }
    
    // Iniciamos UILabel Restauranttype
    
    NSArray *cats = [globalVar.SRC_search.NSS_idrestauranttype componentsSeparatedByString:@","];
    if (!globalVar.SRC_search.B_restauranttype) [UIL_tipo_comida setText:_COMBO_TIPOS_COCINA_];
    else {
        
        if ([cats count] > 1) {
            [UIL_tipo_comida setText:@"Múltiples categorías"];
        } else {
            [UIL_tipo_comida setText:[(TipoCocinaClass *)[globalVar getRestautanttypeWithId:globalVar.SRC_search.NSS_idrestauranttype] NSS_name]];
        }
    }
    
    // Iniciamos UILabel Filtro resturantes
    if (!globalVar.SRC_search.B_filter) [UIL_restaurantes setText:_COMBO_FILTRO_RESTAURATES_];
    else {
        
        // Mostramos el texto que se corresponda ocn el filtro activo
        switch (globalVar.SRC_search.TFR_filter)
        {
            case TFR_todos    : [UIL_restaurantes setText:_COMBO_FILTRO_RESTAURATES_]; break;
            case TFR_favoritos: [UIL_restaurantes setText:_COMBO_FILTRO_RESTAURATES_FAVORITOS_]; break;
            case TFR_historico: [UIL_restaurantes setText:_COMBO_FILTRO_RESTAURATES_HISTORICO_]; break;
        }
    }
}

#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cercania_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_tipo_comida_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_tipo_cocina_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_restaurantes_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_restaurantes_TouchUpInside:(id)sender {
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate select_restaurantes_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_cercania_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_cercania_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    [UIB_cercania   setSelected:TRUE];
    [UIB_ofertas    setSelected:FALSE];
    [UIB_descuentos setSelected:FALSE];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_cercania_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_ofertas_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_ofertas_TouchUpInside:(id)sender {
    
    // Actualizamos Barra
    [UIB_cercania   setSelected:FALSE];
    [UIB_ofertas    setSelected:TRUE];
    [UIB_descuentos setSelected:FALSE];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_ofertas_Touched];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_descuentos_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_descuentos_TouchUpInside:(id)sender {
    
    // Comprobamos si es un usuario registrado
    if (!globalVar.B_usuario_registrado) {
        
        // Mostramos mensaje de error
        [globalVar showAlerMsgWith:_ALERT_TITLE_NO_REGISTRADO_ message:_ALERT_MSG_NO_REGISTRADO_];
        
        return;
    }
    
    // Actualizamos Barra
    [UIB_cercania   setSelected:FALSE];
    [UIB_ofertas    setSelected:FALSE];
    [UIB_descuentos setSelected:TRUE];
    
    // Indicamos al delegado que se ha pulsado sobre la celda
    if (_delegate != nil) [_delegate filtro_descuentos_Touched];
}


@end
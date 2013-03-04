//
//  SelectTipoCocinaViewController.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "SelectTipoCocinaViewController.h"
#import "LoadingViewController.h"

#import "TipoCocinaClass.h"
#import "JSONparseClass.h"
#import "SearchRestaurantClass.h"


@implementation SelectTipoCocinaViewController

@synthesize UITV_listado;

@synthesize TCC_tipo_cocina = _TCC_tipo_cocina;

@synthesize delegate = _delegate;

@synthesize selectTypes = _selectTypes;
@synthesize selCats = _selCats;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad   	: setNSS_tipo_cocina
//#	Fecha Creación	: 08/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 08/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTCC_tipo_cocina:(TipoCocinaClass *)TCC_tipo_cocina {
    
    _TCC_tipo_cocina = TCC_tipo_cocina;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewDidLoad
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewDidLoad {
    
    [super viewDidLoad];
	
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Comprobamos si debemos cargar los Tipos de cocina
    if ([globalVar.NSMA_tipos_cocina count] == 0) [self loadTiposCocina];
    
    self.selectTypes = [[NSMutableArray alloc] initWithCapacity:[globalVar.NSMA_tipos_cocina count]];
    for (int i = 0 ;i <=[globalVar.NSMA_tipos_cocina count];i++) {
        [self.selectTypes addObject:@"0"];
        
        
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 12/09/2012  (pjoramas)
//# Descripción		: 
//#
-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.selCats = @"";

   
    NSArray *selectedIds = [globalVar.SRC_search.NSS_idrestauranttype componentsSeparatedByString:@","];
    
    for (int i = 1; i<=[globalVar.NSMA_tipos_cocina count]; i++){
    
        TipoCocinaClass *TCC_tipo_cocina = [globalVar.NSMA_tipos_cocina objectAtIndex:(i-1)];
    
        for (NSString *val in selectedIds) {
            if ([val isEqualToString:[NSString stringWithFormat:@"%d",TCC_tipo_cocina.NSI_id]]) {
                [self.selectTypes replaceObjectAtIndex:i withObject:@"1"];
                if([self.selCats isEqualToString:@""]){
                    self.selCats = [NSString stringWithFormat:@"%d",TCC_tipo_cocina.NSI_id];
                } else {
                    self.selCats = [self.selCats stringByAppendingFormat:@",%d",TCC_tipo_cocina.NSI_id];
                }
            }
        }
    }

}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : viewWillAppear
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setContentWith:(TipoCocinaClass *)newTCC_tipo_cocina {
    
    [self setTCC_tipo_cocina:newTCC_tipo_cocina];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocina
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadTiposCocina {
    
    // Eliminamos los posible Observadores
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_NO_INTERNET_ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NOTIFICATION_TIPOS_COCINA_ERROR_       object:nil];
    
    // Creamos NSNotificationCenter de operación correcta
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(loadTiposCocinaSuccessful:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noInternet:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_NO_INTERNET_
                                               object: nil];
    
    // Creamos NSNotificationCenter de no Internet
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(noSuccessful:) 
                                                 name: _NOTIFICATION_TIPOS_COCINA_ERROR_
                                               object: nil];
    
    // Cargamos los datos
    [globalVar.LVC_loading loadTiposCocina];
}

#pragma mark -  
#pragma mark Notification Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : loadTiposCocinaSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) loadTiposCocinaSuccessful:(NSNotification *)notification {
    
    // Actualizsmos el listado de Tipos de cocina
    [UITV_listado reloadData];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noInternet
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noInternet:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_NO_CONNECTION_ message:_ALERT_MSG_NO_CONNECTION_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : noSuccessful
//#	Fecha Creación	: 17/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 17/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) noSuccessful:(NSNotification *)notification {
    
    [globalVar showAlerMsgWith:_ALERT_TITLE_UMNI_ERROR_ message:globalVar.NSS_msg_error];
    
    // Ocultamos mensaje de No Internet
    [globalVar.LVC_loading.view setAlpha:0.0f];
}
                                                   
#pragma mark -
#pragma mark IBAction Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento   : UIB_close_select_tipo_cocina_TouchUpInside
//#	Fecha Creación	: 07/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 07/04/2012  (pjoramas)
//# Descripción		: 
//#
-(IBAction) UIB_close_select_tipo_cocina_TouchUpInside:(id)sender {
    
    NSLog(@"sel cats %@",self.selCats);
    // Indicamos al delegado que se ha pulsado sobre la celda    
    if (_delegate != nil) [_delegate select_tipo_cocina:self.selCats];
    if (_delegate != nil) [_delegate close_select_tipo_cocina];

}

#pragma mark - UITableview Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ([globalVar.NSMA_tipos_cocina count] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupCell";
	id cell = nil;
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (indexPath.row == 0) {
        [cell setText:@"Tipos de Comida (Todas)"];
    } else {
        // Recuperamos el tipo de cocina
        TipoCocinaClass *TCC_tipo_cocina = [globalVar.NSMA_tipos_cocina objectAtIndex:(indexPath.row-1)];
        [cell setText:TCC_tipo_cocina.NSS_name];
    }

    if ([[self.selectTypes objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selCats = @"";
    
    UITableViewCell *cell = (UITableViewCell*)[self.UITV_listado cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 0) {
        
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.selectTypes setObject:@"1" atIndexedSubscript:indexPath.row];
        
        for (int i = 1; i<=[globalVar.NSMA_tipos_cocina count]; i++) {
            [self.selectTypes setObject:@"0" atIndexedSubscript:i];
        }
        
        for (int i = 1; i<=[globalVar.NSMA_tipos_cocina count]; i++) {
            
            NSIndexPath *idx = [NSIndexPath indexPathForItem:i inSection:0];
            UITableViewCell *cell = (UITableViewCell*)[self.UITV_listado cellForRowAtIndexPath:idx];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
    } else {
    
        NSIndexPath *idx = [NSIndexPath indexPathForItem:0 inSection:0];
        UITableViewCell *fCell = (UITableViewCell*)[self.UITV_listado cellForRowAtIndexPath:idx];
        [fCell setAccessoryType:UITableViewCellAccessoryNone];

        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [self.selectTypes setObject:@"0" atIndexedSubscript:indexPath.row];
            
        } else {
            
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [self.selectTypes setObject:@"1" atIndexedSubscript:indexPath.row];
            
        }
        
        for (int i = 1; i<=[globalVar.NSMA_tipos_cocina count]; i++) {
            if ([[self.selectTypes objectAtIndex:i] isEqualToString:@"1"]) {
                
                TipoCocinaClass *TCC_tipo_cocina = [globalVar.NSMA_tipos_cocina objectAtIndex:(i-1)];
                if([self.selCats isEqualToString:@""]){
                    self.selCats = [NSString stringWithFormat:@"%d",TCC_tipo_cocina.NSI_id];
                } else {
                    self.selCats = [self.selCats stringByAppendingFormat:@",%d",TCC_tipo_cocina.NSI_id];
                }
            }
        }
    
    }
}

     
@end
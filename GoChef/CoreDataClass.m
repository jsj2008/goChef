//
//  CoreDataClass.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CoreDataClass.h"
#import "UserEntity.h"
#import "UserClass.h"
#import "TarjetaClass.h"
#import "CreditCardEntity.h"
#import "AESCryptClass.h"
#import "NSFileManager+DoNotBackup.h"
#import "NSData+Base64.h"


@implementation CoreDataClass

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: init
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(id) init {

    self = [super init];
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos UserClass
    globalVar.UC_user = [[UserClass alloc] init];
    
    return self;
}

#pragma mark -
#pragma mark Core Data Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) getUser {
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    // comprobamos si el Context sea correcto
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Lanzamos la petición que hemos preparado	
        NSError *NSE_error = nil; 
        NSMutableArray *NSMA_results = [[NSMOC_context executeFetchRequest:NSFR_request error:&NSE_error] mutableCopy];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_results != nil) {
            
            // Comprobamos que la consulta no sea vacia
            if ([NSMA_results count] != 0) {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Cargando BD de Users...");
                
                // Recuperamos la ProfileEntity recogida
                UserEntity *UE_user = [NSMA_results objectAtIndex:0];
                
                // Recogemos los valores
                [globalVar.UC_user setNSI_id       : [[UE_user id] integerValue]];
                [globalVar.UC_user setNSS_email    : [UE_user sEmail]];
                [globalVar.UC_user setNSS_password : [UE_user sPassword]];
            } 
            else if ((BOOL)_SHOW_LOG_) NSLog(@"No hay Users en la BD.");
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error abriendo BD de Users.");
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getCreaditCards
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) getCreaditCardsWithUserId:(NSInteger)userId {
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    // comprobamos si el Context sea correcto
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"CreditCardEntity" inManagedObjectContext:NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Set the predicate
        NSPredicate *NSP_predicate = [NSPredicate predicateWithFormat:@"(userId = %d)", userId];
        [NSFR_request setPredicate:NSP_predicate];
        
        // Lanzamos la petición que hemos preparado
        NSError *NSE_error = nil;
        NSMutableArray *NSMA_results = [[NSMOC_context executeFetchRequest:NSFR_request error:&NSE_error] mutableCopy];
        
        // Iniciamos Array de CredistsCard
        globalVar.NSMA_tarjetas = [[NSMutableArray alloc] init];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_results != nil) {
            
            // Comprobamos que la consulta no sea vacia
            if ([NSMA_results count] != 0 && userId != -1) {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Cargando BD de Creditcards...");
                
                // Recuperamos la ProfileEntity recogida
                for (CreditCardEntity *CCE_creditcard in NSMA_results) {

                    // Creamos CreditCradClass
                    TarjetaClass *TC_credit_card = [[TarjetaClass alloc] init];

                    // Recuperamos el CVV
                    NSString *NSS_cvv    = [globalVar decrypEAS128:[CCE_creditcard sCVV]];
                    NSString *NSS_type   = [globalVar decrypEAS128:[CCE_creditcard sType]];
                    NSString *NSS_number = [globalVar decrypEAS128:[CCE_creditcard sNumber]];
                    NSString *NSS_name   = [globalVar decrypEAS128:[CCE_creditcard sName]];

                    // Recuperamos datoa BB.DD
                    [TC_credit_card setNSI_id     : [[CCE_creditcard id] integerValue]];
                    [TC_credit_card setNSS_type   : NSS_type];
                    [TC_credit_card setNSS_name   : NSS_name];
                    [TC_credit_card setNSS_number : NSS_number];
                    [TC_credit_card setB_default  : [[CCE_creditcard bDefault] boolValue]];
                    [TC_credit_card setNSS_cvv    : NSS_cvv];
                    [TC_credit_card setNSD_date_expiration : [CCE_creditcard dExpiration]];
                    
                    // Añadimos la CreditCard al Array
                    [globalVar.NSMA_tarjetas addObject:TC_credit_card];
                }
            }
            else if ((BOOL)_SHOW_LOG_) NSLog(@"No hay Creditcards en la BD.");
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error abriendo BD de Creditcards.");
    }
}


//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateUser
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateUser:(UserClass *)UC_user {
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Lanzamos la petición que hemos preparado	
        NSError *error = nil; 
        NSMutableArray *NSMA_results = [[NSMOC_context executeFetchRequest:NSFR_request error:&error] mutableCopy];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_results != nil) {
            
            UserEntity *UE_user;
            
            // Comprobamos si se ha encontrado el resgitro en la BB.DD o es un registro nuevo
            if ([NSMA_results count] != 0) {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Actualizando BD de Users...");
                
                // Recuperamos la MyWalletShortInfoEntity recogida
                UE_user = [NSMA_results objectAtIndex:0];
            }
            else {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Creando BD de Users...");
                
                // Insertamos el punto de interes en la Base de Datos
                UE_user = (UserEntity *) [NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:NSMOC_context];
            }
            
            // Iniciamos sus propiedades
            [UE_user setId       : [NSNumber numberWithInteger: UC_user.NSI_id]];
            [UE_user setSEmail   : UC_user.NSS_email];
            [UE_user setSPassword: UC_user.NSS_password];
            
            NSError *NSE_error;
            if (![NSMOC_context save:&NSE_error]) {
                NSLog(@"Error al actualizando en BD de Profile.");
            }
            
            // Actualizamos variable global que indica que existe un Profile
            if (UC_user.NSI_id == _ID_USER_NO_REGISTRADO_) [globalVar setB_usuario_registrado:FALSE];
            else  [globalVar setB_usuario_registrado:TRUE];
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error al consultar en la BD Profile.");
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateCreaditCard
//#	Fecha Creación	: 16/09/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/11/2012  (pjoramas)
//# Descripción		:
//#
-(void) updateCreaditCard:(TarjetaClass *)TC_credit_card {
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"CreditCardEntity" inManagedObjectContext:NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Set the predicate
        NSPredicate *NSP_predicate = [NSPredicate predicateWithFormat:@"(id = %d)", TC_credit_card.NSI_id];
        [NSFR_request setPredicate:NSP_predicate];
        
        // Lanzamos la petición que hemos preparado
        NSError *error = nil;
        NSMutableArray *NSMA_results = [[NSMOC_context executeFetchRequest:NSFR_request error:&error] mutableCopy];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_results != nil) {
            
            CreditCardEntity *CCE_creditcard;
            
            // Comprobamos si se ha encontrado el resgitro en la BB.DD o es un registro nuevo
            if ([NSMA_results count] != 0) {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Actualizando BD de Creditcard...");
                
                // Recuperamos la MyWalletShortInfoEntity recogida
                CCE_creditcard = [NSMA_results objectAtIndex:0];
            }
            else {
                
                if ((BOOL)_SHOW_LOG_) NSLog(@"Creando BD de Creditcard...");
                
                // Insertamos el punto de interes en la Base de Datos
                CCE_creditcard = (CreditCardEntity *) [NSEntityDescription insertNewObjectForEntityForName:@"CreditCardEntity" inManagedObjectContext:NSMOC_context];
            }
            
            // Recuperamos el CVV
            NSString *NSS_cvv_crypt    = [globalVar encrypEAS128:TC_credit_card.NSS_cvv];
            NSString *NSS_type_crypt   = [globalVar encrypEAS128:TC_credit_card.NSS_type];
            NSString *NSS_number_crypt = [globalVar encrypEAS128:TC_credit_card.NSS_number];
            NSString *NSS_name_crypt   = [globalVar encrypEAS128:TC_credit_card.NSS_name];

            // Iniciamos sus propiedades
            [CCE_creditcard setId          : [NSNumber numberWithInteger: TC_credit_card.NSI_id]];
            [CCE_creditcard setSType       : NSS_type_crypt];
            [CCE_creditcard setSName       : NSS_name_crypt];
            [CCE_creditcard setSNumber     : NSS_number_crypt];
            [CCE_creditcard setBDefault    : [NSNumber numberWithBool:TC_credit_card.B_default]];
            [CCE_creditcard setSCVV        : NSS_cvv_crypt];
            [CCE_creditcard setDExpiration : TC_credit_card.NSD_date_expiration];
            [CCE_creditcard setUserId      : [NSNumber numberWithInt:globalVar.UC_user.NSI_id]];
            
            NSError *NSE_error;
            if (![NSMOC_context save:&NSE_error]) {
                NSLog(@"Error al actualizando en BD de Creditcard.");
            }
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error al consultar en la BD Creditcard.");
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: removeCreaditCard
//#	Fecha Creación	: 20/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeCreaditCard:(TarjetaClass *)TC_credit_card {
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"CreditCardEntity" inManagedObjectContext: NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Set the predicate
        NSPredicate *NSP_predicate = [NSPredicate predicateWithFormat:@"(id = %d)", TC_credit_card.NSI_id];
        [NSFR_request setPredicate:NSP_predicate];
        
        // Lanzamos la petición que hemos preparado
        NSError *error = nil;
        NSMutableArray *NSMA_fetchResults = [[NSMOC_context executeFetchRequest:NSFR_request error:&error] mutableCopy];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_fetchResults != nil) {
            
            if ((BOOL)_SHOW_LOG_) NSLog(@"Eliminando registro en BD de Creditcard...");
            
            // Recorremos el Array resultado
            for (CreditCardEntity *CCE_creditcard in NSMA_fetchResults) {
                
                if ((BOOL)_SHOW_LOG_)  NSLog(@"Eliminado registro %d de la BD de Creditcard...", [CCE_creditcard.id intValue]);
                
                // Lo eliminamos de la BB.DD
                [NSMOC_context deleteObject:CCE_creditcard];
            }
            
            // Guardamos los cambios
            NSError *error;
            if (![NSMOC_context save:&error]) {
                NSLog(@"Error al borrar de la BD de Creditcard.");
            }
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error al consultar en la BD de Creditcard.");
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: removeAllCreaditCard
//#	Fecha Creación	: 26/10/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 26/10/2012  (pjoramas)
//# Descripción		:
//#
-(void) removeAllCreaditCard {
    
    [globalVar.NSMA_tarjetas removeAllObjects];
    
    NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    
    if (NSMOC_context != nil) {
        
        // Creamos la petición
        NSFetchRequest      *NSFR_request = [[NSFetchRequest alloc] init];
        NSEntityDescription *NSED_entity  = [NSEntityDescription entityForName:@"CreditCardEntity" inManagedObjectContext: NSMOC_context];
        [NSFR_request setEntity:NSED_entity];
        
        // Lanzamos la petición que hemos preparado
        NSError *error = nil;
        NSMutableArray *NSMA_fetchResults = [[NSMOC_context executeFetchRequest:NSFR_request error:&error] mutableCopy];
        
        // Comprobamos que la consulta no haya dado error
        if (NSMA_fetchResults != nil) {
            
            if ((BOOL)_SHOW_LOG_) NSLog(@"Eliminando registro en BD de Creditcard...");
            
            // Recorremos el Array resultado
            for (CreditCardEntity *CCE_creditcard in NSMA_fetchResults) {
                
                if ((BOOL)_SHOW_LOG_)  NSLog(@"Eliminado registro %d de la BD de Creditcard...", [CCE_creditcard.id intValue]);
                
                // Lo eliminamos de la BB.DD
                [NSMOC_context deleteObject:CCE_creditcard];
            }
            
            // Guardamos los cambios
            NSError *error;
            if (![NSMOC_context save:&error]) {
                NSLog(@"Error al borrar de la BD de Creditcard.");
            }
        }
        else if ((BOOL)_SHOW_LOG_) NSLog(@"Error al consultar en la BD de Creditcard.");
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: saveContext
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: 
//#
-(void) saveContext {
    
    NSError *NSE_error = nil;
	NSManagedObjectContext *NSMOC_context = self.NSMOC_context;
    if (NSMOC_context != nil) {
        
        // Volcamos los datos a la Base de datos
        if ([NSMOC_context hasChanges] && ![NSMOC_context save:&NSE_error]) {
            NSLog(@"Unresolved error %@, %@", NSE_error, [NSE_error userInfo]);
            abort();
        }
    }
}


#pragma mark - Tpv Methods

-(TpvOrderEntity*) getTpvWithPaymentId:(NSString*)paymentId{
    
    NSError *error;
    if (self.NSMOC_context) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TpvOrderEntity" inManagedObjectContext:self.NSMOC_context];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@" idPaymentOrder = \"%@\"",paymentId]]];
        NSMutableArray *mutableFetchResults = [[self.NSMOC_context executeFetchRequest:fetchRequest error:&error] mutableCopy];
        if (mutableFetchResults != nil){
            if ([mutableFetchResults count] == 1) {
                TpvOrderEntity *currentEntity = (TpvOrderEntity*)[mutableFetchResults objectAtIndex:0];
                return currentEntity;
            }
        }
    }
    return nil;
}
-(TpvOrderEntity*) getTpvWithOrdertId:(NSString*)orderId{
    
    NSError *error;
    if (self.NSMOC_context) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TpvOrderEntity" inManagedObjectContext:self.NSMOC_context];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@" idOrder = \"%@\"",orderId]]];
        NSMutableArray *mutableFetchResults = [[self.NSMOC_context executeFetchRequest:fetchRequest error:&error] mutableCopy];
        if (mutableFetchResults != nil){
            if ([mutableFetchResults count] == 1) {
                TpvOrderEntity *currentEntity = (TpvOrderEntity*)[mutableFetchResults objectAtIndex:0];
                return currentEntity;
            }
        }
    }
    return nil;
}

-(void) createTpvWithId:(NSString*)paymentId{
    
    if (self.NSMOC_context) {
        TpvOrderEntity *tpvOrder = [NSEntityDescription insertNewObjectForEntityForName:@"TpvOrderEntity" inManagedObjectContext:self.NSMOC_context];
        [tpvOrder setIdPaymentOrder:paymentId];
        NSError *error;
        [self.NSMOC_context save:&error];
    }
}

-(void) updateTpvWithId:(NSString*)paymentId setOrderId:(NSString *)orderId{

    NSError *error;
    if (self.NSMOC_context) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TpvOrderEntity" inManagedObjectContext:self.NSMOC_context];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@" idPaymentOrder = \"%@\"",paymentId]]];
        NSMutableArray *mutableFetchResults = [[self.NSMOC_context executeFetchRequest:fetchRequest error:&error] mutableCopy];
        if (mutableFetchResults != nil){
            if ([mutableFetchResults count] == 1) {
                TpvOrderEntity *currentEntity = (TpvOrderEntity*)[mutableFetchResults objectAtIndex:0];
                [currentEntity setIdOrder:orderId];
                [self.NSMOC_context save:&error];
            }
        }
    }
}

#pragma mark - Core Data stack

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: NSMOC_context
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: Returns the managed object context for the application.
//#                   If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
//#
-(NSManagedObjectContext *) NSMOC_context {
    
    // Comprobamos si ya existe
    if (_NSMOC_context != nil) {
        return _NSMOC_context;
    }
    
    // Si no existe -> lo creamos
    NSPersistentStoreCoordinator *NSPSC_coordinator = [self NSPSC_store];
    if (NSPSC_coordinator != nil) {
        _NSMOC_context = [[NSManagedObjectContext alloc] init];
        [_NSMOC_context setPersistentStoreCoordinator:NSPSC_coordinator];
    }
    
    return _NSMOC_context;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: NSMOM_model
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: Returns the managed object model for the application.
//#                   If the model doesn't already exist, it is created from the application's model.
//#
-(NSManagedObjectModel *) NSMOM_model {
    
    // Comprobamos si ya existe
    if (_NSMOM_model != nil) {
        return _NSMOM_model;
    }
    
    // Si no existe -> lo creamos
    NSURL *NSURL_model = [[NSBundle mainBundle] URLForResource:_DB_FILE_NAME_ withExtension:@"momd"];
    _NSMOM_model = [[NSManagedObjectModel alloc] initWithContentsOfURL:NSURL_model];
    
    return _NSMOM_model;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: NSPSC_store
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: Returns the persistent store coordinator for the application.
//#                   If the coordinator doesn't already exist, it is created and the application's store added to it.
//#
-(NSPersistentStoreCoordinator *) NSPSC_store {
    
    // Comprobamos si ya existe
    if (_NSPSC_store != nil) return _NSPSC_store;
    
    // Si no existe -> lo creamos
    NSURL *NSURL_store;
    NSURL_store = [[self applicationSupportDirectory] URLByAppendingPathComponent:_DB_FILE_NAME_FULL_];
    
    if ((BOOL)_SHOW_LOG_) NSLog(@"BD: %@", [NSURL_store path]);
    
    NSError *NSE_error = nil;
    _NSPSC_store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self NSMOM_model]];
    if (![_NSPSC_store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:NSURL_store options:nil error:&NSE_error]) {
        NSLog(@"Unresolved error %@, %@", NSE_error, [NSE_error userInfo]);
        abort();
    }
    
    // Marcamos fichero para que no se realice copa en el iCloud
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL success = [fileManager addSkipBackupAttributeToItemAtURL:NSURL_store];
    if (success) 
        NSLog(@"Marked %@", NSURL_store);
    else
        NSLog(@"Can't marked %@", NSURL_store);
    
    return _NSPSC_store;
}

#pragma mark -
#pragma mark Application's Documents directory

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationSupportDirectory
//#	Fecha Creación	: 21/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 21/05/2012  (pjoramas)
//# Descripción		: Returns the URL to the application's Documents directory.
//#
-(NSURL *) applicationSupportDirectory {
    
    // Recogemos el NSString path al directorio
    NSString *executableName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *userpath = [paths objectAtIndex:0];
    userpath = [userpath stringByAppendingPathComponent:executableName];
    
    // Comprobamo si el directorio existe
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:userpath] == NO) {
        
        // Creamos el directorio
        [fileManager createDirectoryAtPath:userpath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // Recogemos la URL del directorio
    NSURL *storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:executableName];
    
    return storeURL;
}


@end
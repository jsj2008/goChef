//
//  DireccionClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface DireccionClass : NSObject {
    
    NSInteger _NSI_id;
    
    NSString *_NSS_telefono;
    NSString *_NSS_movil;
    NSString *_NSS_direccion;
    NSString *_NSS_numero;
    NSString *_NSS_piso;
    NSString *_NSS_letra;
    NSString *_NSS_portal;
    NSString *_NSS_escalera;
    NSString *_NSS_cp;
    NSString *_NSS_ciudad;
    NSString *_NSS_etiqueta;
        
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_id;

@property (nonatomic, retain) NSString *NSS_telefono;
@property (nonatomic, retain) NSString *NSS_movil;
@property (nonatomic, retain) NSString *NSS_direccion;
@property (nonatomic, retain) NSString *NSS_numero;
@property (nonatomic, retain) NSString *NSS_piso;
@property (nonatomic, retain) NSString *NSS_letra;
@property (nonatomic, retain) NSString *NSS_portal;
@property (nonatomic, retain) NSString *NSS_escalera;
@property (nonatomic, retain) NSString *NSS_cp;
@property (nonatomic, retain) NSString *NSS_ciudad;
@property (nonatomic, retain) NSString *NSS_etiqueta;


@end
//
//  MiSacoClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface MiSacoClass : NSObject {

    NSInteger _NSI_id;
    
    NSString *_NSS_titulo;
    NSString *_NSS_nombre_restaurante;
    NSString *_NSS_direccion_restaurante;
    NSString *_NSS_cp_provincia;
    NSString *_NSS_imagen;
        
    NSDate *_NSD_fecha_final;
    
    CGFloat _CGF_distancia;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_id;

@property (nonatomic, retain) NSString *NSS_titulo;
@property (nonatomic, retain) NSString *NSS_nombre_restaurante;
@property (nonatomic, retain) NSString *NSS_direccion_restaurante;
@property (nonatomic, retain) NSString *NSS_cp_provincia;
@property (nonatomic, retain) NSString *NSS_imagen;

@property (nonatomic, retain) NSDate *NSD_fecha_final;

@property (nonatomic, readwrite) CGFloat CGF_distancia;


@end
//
//  MensajeClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface MensajeClass : NSObject {
    
    NSString *_NSS_description;
    typeMensajeType _TMT_type;
}

@property (nonatomic, readwrite) typeMensajeType TMT_type;

@property (nonatomic, retain) NSString *NSS_description;


@end
//
//  AESCryptClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@interface AESCryptClass : NSObject {
    
    SingletonGlobal *globalVar;
}
    
unsigned char strToChar (char a, char b);

-(NSData *)  AES128EncryptWithKey  :(NSString *)key data:(NSData *)NSD_in;
-(NSData *)  AES128DecryptWithKey  :(NSString *)key data:(NSData *)NSD_in;
-(NSString*) stringWithHexBytes    :(NSData *)NSD_in;
-(NSData *)  decodeFromHexidecimal :(NSString *)NSS_in;
-(unsigned char *) decodeFromHexidecimal_:(NSString *)NSS_in;
-(NSString *)hexadecimalString:(NSData *)NSD_in;

@end
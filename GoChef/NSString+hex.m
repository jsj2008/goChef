//
//  NSString+hex.m
//  QPoints
//
//  Created by Pablo Javier Hernandez Oramas on 16/01/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "NSString+hex.h"

@implementation NSString (hex)

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: stringFromHex
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
+ (NSString *) stringFromHex:(NSString *)str 
{   
    NSMutableData *stringData = [[[NSMutableData alloc] init] autorelease];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1]; 
    }
    
    return [[[NSString alloc] initWithData:stringData encoding:NSASCIIStringEncoding] autorelease];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: stringToHex
//#	Fecha Creación	: 01/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 01/03/2012  (pjoramas)
//# Descripción		: 
//#
+ (NSString *) stringToHex:(NSString *)str
{   
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    
    return [hexString autorelease];
}

@end
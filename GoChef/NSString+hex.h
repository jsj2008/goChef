//
//  NSString+hex.h
//  QPoints
//
//  Created by Pablo Javier Hernandez Oramas on 16/01/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

@interface NSString (hex) 

+ (NSString *) stringFromHex:(NSString *)str;
+ (NSString *) stringToHex:(NSString *)str;

@end
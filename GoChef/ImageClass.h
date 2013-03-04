//
//  ImageClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@interface ImageClass : NSObject {
    
    NSInteger _NSI_number;
    
    typeImageType _TIT_type;
    
    CGFloat _CGF_width;
    CGFloat _CGF_height;
    
    NSData *_NSD_image;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) NSInteger NSI_number;

@property (nonatomic, readwrite) typeImageType TIT_type;

@property (nonatomic, readwrite) CGFloat CGF_width;
@property (nonatomic, readwrite) CGFloat CGF_height;

@property (nonatomic, retain) NSData *NSD_image;
@property (nonatomic, retain) NSString *NSS_imageUrl;


@end
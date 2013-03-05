//
//  FacebookClass.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "SingletonGlobal.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookClass : NSObject  {
    
    NSArray *permissions;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) NSArray *permissions;

-(void) getFacebookProfileData;
-(void) loginFacebook;
-(void) logoutFacebook;
-(void) postInUserWallMessage:(NSString *)NSS_message
                         name:(NSString *)NSS_name
                      caption:(NSString *)NSS_caption 
                  description:(NSString *)NSS_description 
                         link:(NSString *)NSS_link 
                      picture:(NSString *)NSS_picture;
@end
//
//  FacebookClass.m
//  QPoints
//
//  Created by Pablo Javier Hernandez Oramas on 16/01/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "FacebookClass.h"
#import "AppDelegate.h"
#import "UserClass.h"

@implementation FacebookClass
@synthesize permissions;

#pragma mark - General Methods

-(void) getFacebookProfileData {
    
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            if (!error) {
                [self request:nil didLoad:user];
            } else {
                NSLog(@"error facebook");
            }
        }];
        
    } else {
                
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:TRUE completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            switch (status) {
                case FBSessionStateOpen:
                    if (!error) {
                        // We have a valid session
                        [FBSession setActiveSession:session];
                        [[FBRequest requestForMe]
                         startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error){
                            if (!error) {
                                [self request:nil didLoad:user];
                            } else {
                                NSLog(@"error facebook");
                            }
                        }];
                    }
                    break;
                case FBSessionStateClosed:
                case FBSessionStateClosedLoginFailed:
                    [FBSession.activeSession closeAndClearTokenInformation];
                    break;
                default:
                    break;
            }
            
        }];
    }
    
}

-(void) loginFacebook {
    // Recuperamos los datos del usuario de su Profile de Facebook
    [self getFacebookProfileData];
}

-(void) logoutFacebook {
    
    // Borramos del registro que el uauario a consedido autorización de acceso a asu profile
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [[FBSession activeSession] closeAndClearTokenInformation];
}

-(void) postInUserWallMessage:(NSString *)NSS_message
                         name:(NSString *)NSS_name
                      caption:(NSString *)NSS_caption 
                  description:(NSString *)NSS_description 
                         link:(NSString *)NSS_link 
                      picture:(NSString *)NSS_picture{
            
    NSMutableDictionary *facebookParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           NSS_link, @"link",
                                           NSS_picture, @"picture",
                                           NSS_name, @"name",
                                           NSS_caption, @"caption",
                                           NSS_description, @"description",
                                           NSS_message,      @"message",
                                           nil];
    
    if (FBSession.activeSession.isOpen) {
        [FBRequestConnection startWithGraphPath:@"me/feed" parameters:facebookParams HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FACEBOOK_WALL_OK_ object:self];
        }];
    } else {
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObjects:@"publish_actions", nil] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:TRUE completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [FBSession setActiveSession:session];
            [FBRequestConnection startWithGraphPath:@"me/feed" parameters:facebookParams HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FACEBOOK_WALL_OK_ object:self];
            }];
        }];
    }
}

-(void) storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    
    // Guardamos en el sistema que el usuario ha consedido permiso de acceso a su profile de Facebook
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt   forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark - FBRequestDelegate Methods

-(void) request:(FBRequest *)request didLoad:(id)result {

    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Recuperamos los datos deseados
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    // Comprobamos si se han devuelto los datos solicitados y si se está realizando un registro de facebook
    if (([result objectForKey:@"name"]) && (globalVar.B_registro_facebook)) {
        
        // Recuperamos locaiton
        NSDictionary *NSD_location = [result objectForKey:@"hometown"];
        NSString *NSS_address = (NSString *)[NSD_location objectForKey:@"name"];
        
        // Recuperamo sexo
        NSString *NSS_sexo = [result objectForKey:@"gender"];
        typeSexoType TST_sexo;
        if ([NSS_sexo isEqualToString:@"male"]) TST_sexo = TST_hombre;
        else TST_sexo = TST_mujer;
        
        // Creamos UserClass
        globalVar.UC_user = [[UserClass alloc] init];
        
        // Actualizamos propiedad global
        [globalVar.UC_user setNSS_password  : _USER_FACEBOOK_PASSWORD_];
        [globalVar.UC_user setNSS_name      : [result objectForKey:@"first_name"]];
        [globalVar.UC_user setNSS_lastname  : [result objectForKey:@"middle_name"]];
        [globalVar.UC_user setNSS_email     : [result objectForKey:@"email"]];
        [globalVar.UC_user setNSS_location  : NSS_address];
        [globalVar.UC_user setTST_genre     : TST_sexo];
        
        // Recuperamos el numero de amigos
        [globalVar.UC_user setNSI_num_facebook_friends: [(NSString *)[result objectForKey:@"friend_count"] intValue]];
        [self storeAuthData:[FBSession activeSession].accessToken expiresAt:[FBSession activeSession].expirationDate];
        
        // Generamos la notificación que indica que los datos se han cargado correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_ 
                                                            object:self];
        
    }
    else {
        
        // Processing permissions information
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}
@end
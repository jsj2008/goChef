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

#pragma mark -
#pragma mark Properties


#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: getFacebookProfileData
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: Make a Graph API Call to get information about the current logged in user.
//#
-(void) getFacebookProfileData {
    
    // Contruimos la consulta con los datos del profile que nos interesa
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, email, birthday, current_location, first_name, last_name, name, sex, pic, friend_count FROM user WHERE uid=me()", @"query",
                                   nil];
    
    // Realizamos la consulta
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: permissions_accepted
//#	Fecha Creación	: 29/05/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 16/07/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) permissions_accepted {
    
    // Indicamos que queremos permiso para poder acceder al correo del usuario
    permissions = [[NSArray alloc] initWithObjects:
                   @"email", 
                   @"user_birthday", 
                   @"user_location", 
                   @"publish_stream", 
                   @"offline_access", 
                   @"user_online_presence",
                   @"read_friendlists",
                   @"user_hometown",
                   nil];
    
    // Comprobamos si el usuario ya ha dado permisos para acceder a su PRofile de Facebook
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        
        // Iniciamos solicitud de permisos
        [[delegate facebook] authorize:permissions];
        
        return FALSE;
    }
    else return TRUE;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: loginFacebook
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 29/05/2012  (pjoramas)
//# Descripción		: Show the authorization dialog.
//#
-(void) loginFacebook {

    // Comprobamos si se tiene ya los permisos necesarios
    if ([self permissions_accepted]) {
        
        // Recuperamos los datos del usuario de su Profile de Facebook
        [self getFacebookProfileData];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: logoutFacebook
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Invalidate the access token and clear the cookie.
//#
-(void) logoutFacebook {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: postInUserWall
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 22/06/2012  (pjoramas)
//# Descripción		: 
//#
-(void) postInUserWallMessage:(NSString *)NSS_message
                         name:(NSString *)NSS_name
                      caption:(NSString *)NSS_caption 
                  description:(NSString *)NSS_description 
                         link:(NSString *)NSS_link 
                      picture:(NSString *)NSS_picture
{
    // Comprobamos si se tiene ya los permisos necesarios
    if ([self permissions_accepted]) {
        
        // Recuperamos los datos del usaurio de su Profile de Facebook
        SBJSON *jsonWriter = [SBJSON new];
        
        // The action links to be shown with the post in the feed
        NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:NSS_name,@"name",NSS_link,@"link", nil], nil];
        NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
        
        // Dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       NSS_message,         @"message",
                                       NSS_name,            @"name",
                                       NSS_caption,         @"caption",
                                       NSS_description,     @"description",
                                       NSS_link,            @"link",
                                       NSS_picture,         @"picture",
                                       actionLinksStr,      @"actions",
                                       nil];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [[delegate facebook] requestWithGraphPath:@"feed" 
                                        andParams:params 
                                    andHttpMethod:@"POST" 
                                      andDelegate:self];
        
        
        // Generamos la notificación que indica que se ha de ir a la Navigation Principal
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FACEBOOK_WALL_OK_ 
                                                            object:self];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: storeAuthData
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    
    // Guardamos en el sistema que el usuario ha consedido permiso de acceso a su profile de Facebook
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt   forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark -
#pragma mark FBSessionDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: fbDidLogin
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		:  Called when the user has logged in successfully.
//#
-(void) fbDidLogin {
    
    // Recuperamos los datos del Profile
    [self getFacebookProfileData];
    
    // Guardamos en el resgitro que el usuairo ha dado permisos de acceso a su Profile
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[delegate facebook] accessToken] expiresAt:[[delegate facebook] expirationDate]];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: fbDidLogin
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: 
//#
-(void) fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: fbDidLogin
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Called when the user canceled the authorization dialog.
//#
-(void)fbDidNotLogin:(BOOL)cancelled {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: fbDidLogin
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Called when the request logout has succeeded.
//#
-(void) fbDidLogout {
    
    // Borramos del registro que el uauario a consedido autorización de acceso a asu profile
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: fbDidLogin
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Called when the session has expired.
//#
-(void) fbSessionInvalidated {
    
    // Construimos el AlertView
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Auth Exception"
                                                        message:@"Your session has expired."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil,
                              nil];
    
    // Mostramos el AlertView y realizamos un logout
    [alertView show];
    [self fbDidLogout];
}

#pragma mark -
#pragma mark FBRequestDelegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: request:didReceiveResponse:
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Called when the Facebook API request has returned a response. This callback
//#                   gives you access to the raw response. It's called before
//#                   (void)request:(FBRequest *)request didLoad:(id)result,
//#                   which is passed the parsed response object.
//#
-(void) request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: request:didLoad:
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 20/10/2012  (pjoramas)
//# Descripción		: Called when a request returns and its response has been parsed into
//#                   an object. The resulting object may be a dictionary, an array, a string,
//#                   or a number, depending on the format of the API response. If you need access
//#                   to the raw response, use:
//#
//#                   (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
//#
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
        NSDictionary *NSD_location = [result objectForKey:@"current_location"];
        NSString *NSS_address = (NSString *)[NSD_location objectForKey:@"city"];
        
        // Recuperamo sexo
        NSString *NSS_sexo = [result objectForKey:@"sex"];
        typeSexoType TST_sexo;
        if ([NSS_sexo isEqualToString:@"male"]) TST_sexo = TST_hombre;
        else TST_sexo = TST_mujer;
        
        // Creamos UserClass
        globalVar.UC_user = [[UserClass alloc] init];
        
        // Actualizamos propiedad global
        [globalVar.UC_user setNSS_password  : _USER_FACEBOOK_PASSWORD_];
        [globalVar.UC_user setNSS_name      : [result objectForKey:@"first_name"]];
        [globalVar.UC_user setNSS_lastname  : [result objectForKey:@"last_name"]];
        [globalVar.UC_user setNSS_email     : [result objectForKey:@"email"]];
        [globalVar.UC_user setNSS_location  : NSS_address];
        [globalVar.UC_user setTST_genre     : TST_sexo];
        
        // Recuperamos el numero de amigos
        [globalVar.UC_user setNSI_num_facebook_friends: [(NSString *)[result objectForKey:@"friend_count"] intValue]];
        
        // Generamos la notificación que indica que los datos se han cargado correctamente
        [[NSNotificationCenter defaultCenter] postNotificationName:_NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_ 
                                                            object:self];
        
        // Mostramos los datos del Profile
        NSLog(@"uid          : %@", [result objectForKey:@"uid"]);
        NSLog(@"email        : %@", [result objectForKey:@"email"]);
        NSLog(@"first_name   : %@", [result objectForKey:@"first_name"]);
        NSLog(@"last_name    : %@", [result objectForKey:@"last_name"]);
        NSLog(@"name         : %@", [result objectForKey:@"name"]);
        NSLog(@"sex          : %@", [result objectForKey:@"sex"]);
        NSLog(@"pic          : %@", [result objectForKey:@"pic"]);
        NSLog(@"birthday     : %@", [result objectForKey:@"birthday"]);
        NSLog(@"location     : %@", [result objectForKey:@"current_location"]);
        NSLog(@"friend_count : %@", [result objectForKey:@"friend_count"]);
    }
    else {
        
        // Processing permissions information
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: request:didFailWithError:
//#	Fecha Creación	: 10/03/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 10/03/2012  (pjoramas)
//# Descripción		: Called when an error prevents the Facebook API request from completing
//#                   successfully.
//#
-(void) request:(FBRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}


@end

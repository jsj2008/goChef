//
//  AppDelegate.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"

@implementation AppDelegate

@synthesize UINC_principal_mi_actividad;
@synthesize UINC_principal_mi_saco;
@synthesize UINC_principal_mi_cuenta;

@synthesize window = _window;

@synthesize TPVC_principal = _TPVC_principal;

#pragma mark -
#pragma mark Properties

//# ------------------------------------------------------------------------------------------------------------
//#	Propiedad    	: setTPVC_principal
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) setTPVC_principal:(TabbarPrincipalViewController *)TPVC_principal {
    
    _TPVC_principal = TPVC_principal;
}

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: application:didFinishLaunchingWithOptions:
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Variables de configuración
    globalVar = [SingletonGlobal sharedGlobal];
    
    // Iniciamos array NavigationController
    globalVar.NSMA_tabbar_viewcontroller = [[NSMutableArray alloc] init];
    
    // Insertamos NavigationController
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_actividad];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_saco];
    [globalVar.NSMA_tabbar_viewcontroller addObject:UINC_principal_mi_cuenta];
    
    // Iniciamos el LoadingViewController
    [self initLoadingViewController];
    
    // Iniciamos el LoadingViewController
    [self initTabBarViewController];

    // Iniciamos el NavigationController que debe activarse
    [self updateNavigationControllerToIndex:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
    
    // Iniciamos los componentes de la Windows
    [self.window makeKeyAndVisible];
    
    return YES;
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: updateNabvigationControllerToIndex
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) updateNavigationControllerToIndex:(NSInteger)NSI_index {
    
    // Colocamos el NavigationController que corresponda
    self.window.rootViewController = [globalVar.NSMA_tabbar_viewcontroller objectAtIndex:NSI_index];
    
    // Insertamos Tabbar Principal
    [self.window.rootViewController.view addSubview:_TPVC_principal.view];
    
    // Insertamos LoadingView Controller
    [self.window.rootViewController.view addSubview:globalVar.LVC_loading.view];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initTabBarPrincipal
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initTabBarViewController {
    
    // Iniciamos View Controller
    _TPVC_principal = [[TabbarPrincipalViewController alloc] initWithNibName:@"TabbarPrincipalView" bundle:[NSBundle mainBundle]];
    
    // Asignamos Delegado
    [_TPVC_principal setDelegate:self];
    
    // Posicionamos View Controller
    [_TPVC_principal.view setFrame:CGRectMake(0.0f, (self.window.frame.size.height-_TPVC_principal.view.frame.size.height),
                                              _TPVC_principal.view.frame.size.width, _TPVC_principal.view.frame.size.height)];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: initLoadingViewcontroller
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) initLoadingViewController {
    
    // Insertamos el LoadingViewController
    globalVar.LVC_loading = [[LoadingViewController alloc] initWithNibName:@"LoadingView" bundle:[NSBundle mainBundle]];
    
    // Posicionamos el LoadingViewController
    [globalVar.LVC_loading.view setFrame:CGRectMake(((self.window.frame.size.width/2)-(110.0f/2)), ((self.window.frame.size.height/2)-(110.0f/2)), 110.0f, 110.0f)];
    [globalVar.LVC_loading.view setAlpha:0.0f];
}

#pragma mark -
#pragma mark Delegate Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_activida_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_mi_activida_Touched {
    
    // Iniciamos el NavigationController que debe activarse
    [self updateNavigationControllerToIndex:_TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_saco_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_mi_saco_Touched {
    
    // Iniciamos el NavigationController que debe activarse
    [self updateNavigationControllerToIndex:_TABBAR_INDEX_PRINCIPAL_MI_SACO_];
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: UIB_mi_cuenta_Touched
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void) UIB_mi_cuenta_Touched {
    
    // Iniciamos el NavigationController que debe activarse
    [self updateNavigationControllerToIndex:_TABBAR_INDEX_PRINCIPAL_MI_CUENTA_];
}

#pragma mark -
#pragma mark Backround Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Sent when the application is about to move from active to inactive state. This can occur for certain types 
//#                   of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application 
//#                   and it begins the transition to the background state. Use this method to pause ongoing tasks, disable timers, 
//#                   and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//#
-(void) applicationWillResignActive:(UIApplication *)application {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Use this method to release shared resources, save user data, invalidate timers, and store enough application 
//#                   state information to restore your application to its current state in case it is terminated later. If your 
//#                   application supports background execution, this method is called instead of applicationWillTerminate: when the 
//#                   user quits.
//#
-(void) applicationDidEnterBackground:(UIApplication *)application {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Called as part of the transition from the background to the inactive state; here you can undo many of the changes 
//#                   made on entering the background.
//#
-(void) applicationWillEnterForeground:(UIApplication *)application {
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Restart any tasks that were paused (or not yet started) while the application was inactive. If the application 
//#                   was previously in the background, optionally refresh the user interface.
//#
-(void) applicationDidBecomeActive:(UIApplication *)application {
    
    // Although the SDK attempts to refresh its access tokens when it makes API calls,
    // it's a good practice to refresh the access token also when the app becomes active.
    // This gives apps that seldom make api calls a higher chance of having a non expired
    // access token.
}

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: applicationWillResignActive
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: Called when the application is about to terminate.
//#                   Save data if appropriate. 
//#                   See also applicationDidEnterBackground:.
//#
-(void) applicationWillTerminate:(UIApplication *)application {
}


@end
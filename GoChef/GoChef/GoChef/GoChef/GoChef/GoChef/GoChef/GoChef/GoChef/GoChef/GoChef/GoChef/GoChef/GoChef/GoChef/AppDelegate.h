//
//  AppDelegate.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "TabbarPrincipalViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, TabbarPrincipalViewControllerDelegate> {
    
    IBOutlet UINavigationController *UINC_principal_mi_actividad;
    IBOutlet UINavigationController *UINC_principal_mi_saco;
    IBOutlet UINavigationController *UINC_principal_mi_cuenta;
    
    TabbarPrincipalViewController *_TPVC_principal;

    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UINavigationController *UINC_principal_mi_actividad;
@property (nonatomic, retain) UINavigationController *UINC_principal_mi_saco;
@property (nonatomic, retain) UINavigationController *UINC_principal_mi_cuenta;

@property (nonatomic, retain) TabbarPrincipalViewController *TPVC_principal;

@property (nonatomic, retain) IBOutlet UIWindow *window;



@end
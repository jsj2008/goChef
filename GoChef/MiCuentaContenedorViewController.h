//
//  MiCuentaContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class MiCuentaEditarCuentaViewController, MiCuentaRegistroLoginViewController;

@interface MiCuentaContenedorViewController : UIViewController <UIAlertViewDelegate> {
    
    IBOutlet UIScrollView *UISV_scroll;
    
    MiCuentaEditarCuentaViewController  *_MCECVC_editar_cuenta;
    MiCuentaRegistroLoginViewController *_MCRLVC_registro_login;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) UIScrollView *UISV_scroll;

@property (nonatomic, retain) MiCuentaEditarCuentaViewController  *MCECVC_editar_cuenta;
@property (nonatomic, retain) MiCuentaRegistroLoginViewController *MCRLVC_registro_login;


-(void) initNavigationBar;


@end
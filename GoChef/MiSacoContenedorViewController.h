//
//  MiSacoContenedorViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiSaco.h"
#import "CustomUITableViewCellMiSacoHeader.h"
#import "RestauranteAllInfoViewController.h"

@protocol MiSacoContenedorViewControllerDelegate

-(void) back_pedir_domicilio_Touched;

-(void) UIB_pedir_restaurante_Touched;
-(void) UIB_pedir_antes_llegar_Touched;
-(void) UIB_pedir_domicilio_Touched;
-(void) UIB_recoger_comida_Touched;
-(void) UIB_reservar_mesa_Touched;

@end

@class CustomUITableViewCellMore;

@interface MiSacoContenedorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CustomUITableViewCellMiSacoDelegate, CustomUITableViewCellMiSacoHeaderDelegate, RestauranteAllInfoViewControllerDelegate> {
    
    IBOutlet UITableView *UITV_listado;
    
    RestauranteAllInfoViewController *_RAIVC_restaurante;
    
    CustomUITableViewCellMiSaco *_CUITVCMS_cell; 
    CustomUITableViewCellMiSacoHeader *_CUITVCMS_header;
    CustomUITableViewCellMore *_CUITVCM_more;
    
    __unsafe_unretained id<MiSacoContenedorViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) int filterSel;

@property (nonatomic, assign) id<MiSacoContenedorViewControllerDelegate> delegate;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) RestauranteAllInfoViewController *RAIVC_restaurante;

@property (nonatomic, retain) CustomUITableViewCellMiSaco *CUITVCMS_cell;
@property (nonatomic, retain) CustomUITableViewCellMiSacoHeader *CUITVCMS_header;
@property (nonatomic, retain) CustomUITableViewCellMore *CUITVCM_more;


-(void) initNavigationBar;


@end
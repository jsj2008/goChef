//
//  CustomUITableViewCellMiSacoViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"
#import "AsynchronousImageView.h"


@class RestaurantClass;

@protocol CustomUITableViewCellBuscarRestauranteViewControllerDelegate

-(void) cellTouched:(RestaurantClass *)RC_restaurant;
-(void) Tabbar_mi_saco_Touched;

@end


@interface CustomUITableViewCellBuscarRestauranteViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_restaurante;
    IBOutlet UILabel *UIL_tipo_comida;
    IBOutlet UILabel *UIL_direccion;
    IBOutlet UILabel *UIL_precio;
    IBOutlet UILabel *UIL_distancia;
    IBOutlet UILabel *UIL_tipo_estado;
    
    IBOutlet UIImageView *UIIV_estrella_01;
    IBOutlet UIImageView *UIIV_estrella_02;
    IBOutlet UIImageView *UIIV_estrella_03;
    IBOutlet UIImageView *UIIV_estrella_04;
    IBOutlet UIImageView *UIIV_estrella_05;
    
    IBOutlet UIImageView *UIIV_close;
    
    IBOutlet AsynchronousImageView *UIIV_imagen_restaurante;
    IBOutlet AsynchronousImageView *UIIV_imagen_offer;
    IBOutlet UIImageView *UIIV_background_tipo_estado;
    
    IBOutlet UIButton *UIB_cell;
    
    RestaurantClass *_RC_restaurant;
    
    __unsafe_unretained id<CustomUITableViewCellBuscarRestauranteViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellBuscarRestauranteViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurante;
@property (nonatomic, retain) UILabel *UIL_tipo_comida;
@property (nonatomic, retain) UILabel *UIL_direccion;
@property (nonatomic, retain) UILabel *UIL_precio;
@property (nonatomic, retain) UILabel *UIL_distancia;
@property (nonatomic, retain) UILabel *UIL_tipo_estado;

@property (nonatomic, retain) UIImageView *UIIV_estrella_01;
@property (nonatomic, retain) UIImageView *UIIV_estrella_02;
@property (nonatomic, retain) UIImageView *UIIV_estrella_03;
@property (nonatomic, retain) UIImageView *UIIV_estrella_04;
@property (nonatomic, retain) UIImageView *UIIV_estrella_05;

@property (nonatomic, retain) UIImageView *UIIV_close;

@property (nonatomic, retain) UIImageView *UIIV_imagen_restaurante;
@property (nonatomic, retain) UIImageView *UIIV_imagen_offer;
@property (nonatomic, retain) UIImageView *UIIV_background_tipo_estado;

@property (nonatomic, retain) UIButton *UIB_cell;

@property (nonatomic, retain) RestaurantClass *RC_restaurant;

-(void) setContentWith:(RestaurantClass *)newRC_restaurant; 


-(IBAction) UIB_cell_TouchUpInside:(id)sender;
-(IBAction) UIB_misaco_TouchUpInside:(id)sender;


@end
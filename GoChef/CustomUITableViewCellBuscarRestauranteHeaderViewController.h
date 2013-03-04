//
//  CustomUITableViewCellBuscarRestauranteHeaderViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol CustomUITableViewCellBuscarRestauranteHeaderViewControllerDelegate

-(void) filtro_cercania_Touched;
-(void) filtro_ofertas_Touched;
-(void) filtro_descuentos_Touched;
-(void) select_tipo_cocina_Touched;
-(void) select_restaurantes_Touched;

@end

@interface CustomUITableViewCellBuscarRestauranteHeaderViewController : UIViewController {
    
    IBOutlet UILabel *UIL_tipo_comida;
    IBOutlet UILabel *UIL_restaurantes;
    
    IBOutlet UIButton *UIB_cercania;
    IBOutlet UIButton *UIB_ofertas;
    IBOutlet UIButton *UIB_descuentos;
    
    __unsafe_unretained id<CustomUITableViewCellBuscarRestauranteHeaderViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellBuscarRestauranteHeaderViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_tipo_comida;
@property (nonatomic, retain) UILabel *UIL_restaurantes;

@property (nonatomic, retain) UIButton *UIB_cercania;
@property (nonatomic, retain) UIButton *UIB_ofertas;
@property (nonatomic, retain) UIButton *UIB_descuentos;


-(IBAction) UIB_descuentos_TouchUpInside :(id)sender;

-(IBAction) UIB_tipo_comida_TouchUpInside  :(id)sender;
-(IBAction) UIB_restaurantes_TouchUpInside :(id)sender;
-(IBAction) UIB_ofertas_TouchUpInside      :(id)sender;
-(IBAction) UIB_descuentos_TouchUpInside   :(id)sender;


@end
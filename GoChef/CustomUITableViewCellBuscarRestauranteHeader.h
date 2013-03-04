//
//  CustomUITableViewCellBuscarRestauranteHeader.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellBuscarRestauranteHeaderViewController.h"


@protocol CustomUITableViewCellBuscarRestauranteHeaderDelegate

-(void) filtro_cercania_Touched;
-(void) filtro_ofertas_Touched;
-(void) filtro_descuentos_Touched;
-(void) select_tipo_cocina_Touched;
-(void) select_restaurantes_Touched;

@end

@interface CustomUITableViewCellBuscarRestauranteHeader : UITableViewCell <CustomUITableViewCellBuscarRestauranteHeaderViewControllerDelegate> {
    
    CustomUITableViewCellBuscarRestauranteHeaderViewController *_CUITVCMSH_cell;
    
    __unsafe_unretained id<CustomUITableViewCellBuscarRestauranteHeaderDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellBuscarRestauranteHeaderDelegate> delegate;

@property (nonatomic, retain) CustomUITableViewCellBuscarRestauranteHeaderViewController *CUITVCMSH_cell;


@end

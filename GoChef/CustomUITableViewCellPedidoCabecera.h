//
//  CustomUITableViewCellPedidoCabecera.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellPedidoCabeceraViewController.h"


@protocol CustomUITableViewCellPedidoCabeceraDelegate

-(void) recomiendo_en_facebook;

@end

@interface CustomUITableViewCellPedidoCabecera : UITableViewCell <CustomUITableViewCellPedidoCabeceraViewControllerDelegate> {
    
    NSString *_NSS_nombre_restaurante;
    
    CustomUITableViewCellPedidoCabeceraViewController *_CUITVCPVC_cell;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoCabeceraDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoCabeceraDelegate> delegate;

@property (nonatomic, retain) NSString *NSS_nombre_restaurante;

@property (nonatomic, retain) CustomUITableViewCellPedidoCabeceraViewController *CUITVCPVC_cell;

-(void) setContentWith:(NSString *)newNSS_nombre_restaurante;


@end

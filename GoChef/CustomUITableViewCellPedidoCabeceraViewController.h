//
//  CustomUITableViewCellPedidoCabeceraViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@protocol CustomUITableViewCellPedidoCabeceraViewControllerDelegate

-(void) recomiendo_en_facebook;

@end

@interface CustomUITableViewCellPedidoCabeceraViewController : UIViewController {
    
    IBOutlet UILabel *UIL_nombre_restaurantes;
    IBOutlet UILabel *UIL_facebook_text;
    
    IBOutlet UIButton *UIB_recomendar;
    
    IBOutlet UIImageView *UIIV_facebook;
    
    NSString *_NSS_nombre_restaurante;
    
    __unsafe_unretained id<CustomUITableViewCellPedidoCabeceraViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellPedidoCabeceraViewControllerDelegate> delegate;

@property (nonatomic, retain) UILabel *UIL_nombre_restaurantes;
@property (nonatomic, retain) UILabel *UIL_facebook_text;

@property (nonatomic, retain) UIButton *UIB_recomendar;

@property (nonatomic, retain) UIImageView *UIIV_facebook;

@property (nonatomic, retain) NSString *NSS_nombre_restaurante;

-(IBAction) UIB_recomiendo_en_facebook_TouchUpInside:(id)sender;


-(void) setContentWith:(NSString *)newNSS_nombre_restaurante;


@end
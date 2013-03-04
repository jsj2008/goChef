//
//  TarjetasAdministrarViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellCreditCard.h"

@class TarjetasAltaViewController;

@interface TarjetasAdministrarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, CustomUITableViewCellCreditCardDelegate> {
    
    BOOL _B_edit_mode;
    
    IBOutlet UITableView *UITV_listado;
    
    TarjetasAltaViewController *_TAVC_alta_tarjeta;
    
    CustomUITableViewCellCreditCard *_CUITVCBR_cell;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, readwrite) BOOL B_edit_mode;

@property (nonatomic, retain) UITableView *UITV_listado;

@property (nonatomic, retain) TarjetasAltaViewController *TAVC_alta_tarjeta;

@property (nonatomic, retain) CustomUITableViewCellCreditCard *CUITVCBR_cell;


-(void) initNavigationBar;

-(IBAction) UIB_add_creditcard_TouchUpInside:(id)sender;


@end
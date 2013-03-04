//
//  SelectTipoCocinaViewController.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

@class TipoCocinaClass;

@protocol SelectTipoCocinaViewControllerDelegate

-(void) select_tipo_cocina:(NSString *)TCC_tipo_cocina_ids;
-(void) close_select_tipo_cocina;

@end

@interface SelectTipoCocinaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    TipoCocinaClass *_TCC_tipo_cocina;
        
    __unsafe_unretained id<SelectTipoCocinaViewControllerDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<SelectTipoCocinaViewControllerDelegate> delegate;
@property (nonatomic, retain) TipoCocinaClass *TCC_tipo_cocina;
@property (nonatomic, retain) IBOutlet UITableView *UITV_listado;
@property (nonatomic, retain) NSMutableArray *selectTypes;
@property (nonatomic, retain) NSString *selCats;


-(IBAction) UIB_close_select_tipo_cocina_TouchUpInside:(id)sender;
-(void) setContentWith:(TipoCocinaClass *)newTCC_tipo_cocina;

@end
//
//  CustomUITableViewCellMiSacoHeader.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"

#import "CustomUITableViewCellMiSacoHeaderViewController.h"


@protocol CustomUITableViewCellMiSacoHeaderDelegate

-(void) ordenar_ultimos_Touched;
-(void) ordenar_cercania_Touched;
-(void) ordenar_favoritos_Touched;
-(void) ordenar_hoy_Touched;

@end

@interface CustomUITableViewCellMiSacoHeader : UITableViewCell <CustomUITableViewCellMiSacoHeaderViewControllerDelegate> {
    
    CustomUITableViewCellMiSacoHeaderViewController *_CUITVCMSH_cell;
    
    __unsafe_unretained id<CustomUITableViewCellMiSacoHeaderDelegate> _delegate;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, assign) id<CustomUITableViewCellMiSacoHeaderDelegate> delegate;

@property (nonatomic, retain) CustomUITableViewCellMiSacoHeaderViewController *CUITVCMSH_cell;


@end

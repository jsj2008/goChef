//
//  CustomUITableViewCellMore.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SingletonGlobal.h"


@class CustomUITableViewCellMoreViewController;

@interface CustomUITableViewCellMore : UITableViewCell  {
    
    CustomUITableViewCellMoreViewController *_CUITVCMAVC_cell;
    
    SingletonGlobal *globalVar;
}

@property (nonatomic, retain) CustomUITableViewCellMoreViewController *CUITVCMAVC_cell;


@end

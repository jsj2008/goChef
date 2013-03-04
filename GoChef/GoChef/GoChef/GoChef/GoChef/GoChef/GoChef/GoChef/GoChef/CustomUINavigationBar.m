//
//  CustomUINavigationBar.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "CustomUINavigationBar.h"

@implementation CustomUINavigationBar

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark General Methods

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: drawRect
//#	Fecha Creación	: 06/04/2012  (pjoramas)
//#	Fecha Ult. Mod.	: 06/04/2012  (pjoramas)
//# Descripción		: 
//#
-(void)drawRect:(CGRect)rect {
 
    UIImage *image = [UIImage imageNamed:@"topbar.png"];
    [image drawInRect:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
}

@end
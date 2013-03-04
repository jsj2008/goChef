//
//  UIScrollViewWithTouchEvent.m
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import "UIScrollViewWithTouchEvent.h"


@implementation UIScrollViewWithTouchEvent

//# ------------------------------------------------------------------------------------------------------------
//#	Procedimiento	: touchesEnded:withEvent:
//#	Fecha Creación	: 22/08/2011  (pjoramas)
//#	Fecha Ult. Mod.	: 22/08/2011  (pjoramas)
//# Descripción		: 
//#
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (!self.dragging) {
		[self.nextResponder touchesEnded: touches withEvent:event]; 
	}		
	[super touchesEnded: touches withEvent: event];
}

@end

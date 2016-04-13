//
//  DMDraggableView+DragEndBehaviorUtils.h
//  Demo
//
//  Created by David Martinez Lebron on 4/12/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "DMDraggableView.h"

@interface DMDraggableView (DragEndBehaviorUtils)

-(void) manageDragEndBehaviorKeep:(CGRect) lastValidFrame;
-(void) manageDragEndBehaviorReset:(CGRect) defaultFrame;
-(void) manageDragEndBehaviorBordersWithLastValidFrame:(CGRect) lastValidFrame shouldReset:(BOOL) shouldReset;

@end

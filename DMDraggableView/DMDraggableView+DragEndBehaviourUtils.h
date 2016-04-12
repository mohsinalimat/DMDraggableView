//
//  DMDraggableView+DragEndBehaviourUtils.h
//  Demo
//
//  Created by David Martinez Lebron on 4/12/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "DMDraggableView.h"

@interface DMDraggableView (DragEndBehaviourUtils)

-(void) manageDragEndBehaviourKeep:(CGRect) lastValidFrame;
-(void) manageDragEndBehaviourReset:(CGRect) defaultFrame;

@end

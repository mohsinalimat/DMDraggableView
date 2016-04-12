//
//  DMDraggableView+DragEndBehaviourUtils.m
//  Demo
//
//  Created by David Martinez Lebron on 4/12/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "DMDraggableView+DragEndBehaviorUtils.h"

struct FrameQuadrant {
    
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;

};

@implementation DMDraggableView (DragEndBehaviorUtils)

-(void) manageDragEndBehaviorKeep:(CGRect) lastValidFrame {
    [UIView animateWithDuration:0.2f animations:^{
        self.frame = lastValidFrame;
        
    } completion: ^(BOOL finished) {
        if (finished)
            self.userInteractionEnabled = true;
        self.alpha = 1.0f;
    }];
}

-(void) manageDragEndBehaviorReset:(CGRect) defaultFrame {
    
    
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = defaultFrame;
    } completion:^(BOOL finished) {
        if (finished)
            self.userInteractionEnabled = true;
        self.alpha = 1.0f;
    }];
    
//    [UIView animateWithDuration:0.2f animations:^{
//        
//        
//    } completion: ^(BOOL finished) {
//
//    }];
}

-(void) manageDragEndBehaviorBorders {
    
    CGRect superViewFrame = [self.superview frame];
    
    CGFloat superViewWidth = CGRectGetWidth(superViewFrame);
    CGFloat superViewHeight = CGRectGetHeight(superViewFrame);
    
    CGFloat quadrantHeight = superViewHeight/2;
    CGFloat quadrantWidth = superViewWidth/2;
    
//    struct FrameQuadrant topQuadrant;
//    
//    topQuadrant.x = 0;
//    topQuadrant.y = 0;
    
    CGRect topQuadrant = CGRectMake(0, 0, superViewWidth, quadrantHeight);
    CGRect leftQuadrant = CGRectMake(0, 0, superViewWidth/2, superViewHeight);
    CGRect bottomQuadrant = CGRectMake(0, 0, superViewWidth, superViewHeight);
    CGRect rightQuadrant = CGRectMake(superViewHeight - (superViewHeight/2), 0, superViewWidth, superViewHeight/2);
}

@end









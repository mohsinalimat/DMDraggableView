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
    
    [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = lastValidFrame;
    } completion:^(BOOL finished) {
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

}

-(void) manageDragEndBehaviorBordersWithLastValidFrame:(CGRect) lastValidFrame shouldReset:(BOOL) shouldReset {
    
    if (shouldReset) {
        [self manageDragEndBehaviorKeep:lastValidFrame];
        return;
    }
    
    
    CGRect superViewFrame = [self.superview frame];
    
    CGFloat superViewWidth = CGRectGetWidth(superViewFrame);
    CGFloat superViewHeight = CGRectGetHeight(superViewFrame);
    
    CGFloat quadrantHeight = superViewHeight/4;
    CGFloat quadrantWidth = superViewWidth/2;

    CGFloat sideQuadrantHeight = superViewHeight/2;
    
    CGFloat bottomQuadrantOriginY = superViewHeight - quadrantHeight;
    CGFloat rightQuadrantOriginX = superViewWidth - quadrantWidth;
    
    CGRect topQuadrant = CGRectMake(0, 0, superViewWidth, quadrantHeight);
    CGRect leftQuadrant = CGRectMake(0, quadrantHeight, quadrantWidth, sideQuadrantHeight);
    CGRect bottomQuadrant = CGRectMake(0, bottomQuadrantOriginY, superViewWidth, quadrantHeight);
    CGRect rightQuadrant = CGRectMake(rightQuadrantOriginX, quadrantHeight, quadrantWidth, sideQuadrantHeight);
    
    
    /*******************
    
     // TO CALCULATE ANGLE BASED ON OVERLAPPED CORNERS
     
     CGFloat quadrantHeight = superViewHeight/4;
     CGFloat quadrantWidth = superViewWidth/2;
     
     CGFloat topBottomQuadrantOriginX = superViewWidth/4;
     
     CGRect topQuadrant = CGRectMake(topBottomQuadrantOriginX, 0, quadrantWidth, quadrantHeight);
     CGRect leftQuadrant = CGRectMake(0, quadrantHeight, quadrantWidth, superViewHeight/2);
     CGRect bottomQuadrant = CGRectMake(topBottomQuadrantOriginX, superViewHeight - (quadrantHeight), quadrantWidth, quadrantHeight);
     CGRect rightQuadrant = CGRectMake(superViewWidth - (quadrantWidth), quadrantHeight, quadrantWidth, superViewHeight/2);
    
    *********************/
    
    
    if (CGRectContainsPoint(topQuadrant, self.frame.origin)) {
        
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, 10, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        } completion:^(BOOL finished) {
            if (finished)
                self.userInteractionEnabled = true;
        }];
    }
    
    else if (CGRectContainsPoint(leftQuadrant, self.frame.origin)) {
        
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setFrame:CGRectMake(10, self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        } completion:^(BOOL finished) {
            if (finished)
                self.userInteractionEnabled = true;
        }];
    }
    
    else if (CGRectContainsPoint(bottomQuadrant, self.frame.origin)) {
        
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setFrame:CGRectMake(self.frame.origin.x, superViewHeight - (CGRectGetHeight(self.frame) + 10), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        } completion:^(BOOL finished) {
            if (finished)
                self.userInteractionEnabled = true;
        }];
    }
    
    else if (CGRectContainsPoint(rightQuadrant, self.frame.origin)) {
        
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setFrame:CGRectMake(superViewWidth -(CGRectGetWidth(self.frame) + 10), self.frame.origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        } completion:^(BOOL finished) {
            if (finished)
                self.userInteractionEnabled = true;
        }];
    }
    
//    UIView *t1 = [[UIView alloc] initWithFrame:topQuadrant];
//    [t1 setBackgroundColor:[UIColor redColor]];
//    [t1 setAlpha:0.5];
//    
//    UIView *t2 = [[UIView alloc] initWithFrame:leftQuadrant];
//    [t2 setBackgroundColor:[UIColor yellowColor]];
//    [t2 setAlpha:0.5];
//    
//    UIView *t3 = [[UIView alloc] initWithFrame:bottomQuadrant];
//    [t3 setBackgroundColor:[UIColor greenColor]];
//    [t3 setAlpha:0.5];
//    
//    UIView *t4 = [[UIView alloc] initWithFrame:rightQuadrant];
//    [t4 setBackgroundColor:[UIColor blueColor]];
//    [t4 setAlpha:0.5];
//    
//    [self.superview addSubview:t1];
//    [self.superview addSubview:t2];
//    [self.superview addSubview:t3];
//    [self.superview addSubview:t4];
    
}

@end









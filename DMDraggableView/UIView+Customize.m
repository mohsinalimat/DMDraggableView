//
//  UIView+Customize.m
//  Demo
//
//  Created by David Martinez Lebron on 4/12/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "UIView+Customize.h"

@implementation UIView (Customize)

-(void) circular {
    
    CGFloat minimumSize = CGRectGetWidth(self.frame) < CGRectGetHeight(self.frame) ? CGRectGetWidth(self.frame) : CGRectGetHeight(self.frame);
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, minimumSize, minimumSize)];
    
    [self.layer setCornerRadius:minimumSize/2];
}

@end

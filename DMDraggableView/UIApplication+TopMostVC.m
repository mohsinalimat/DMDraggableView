//
//  UIApplication+TopMostVC.m
//  Demo
//
//  Created by David Martinez Lebron on 4/13/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "UIApplication+TopMostVC.h"

@implementation UIApplication (TopMostVC)

+ (UIViewController*) topMostVC
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end

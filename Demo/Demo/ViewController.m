//
//  ViewController.m
//  Demo
//
//  Created by David Martinez Lebron on 4/12/16.
//  Copyright © 2016 Davaur. All rights reserved.
//

#import "ViewController.h"
#import "DMDraggableView.h"

@interface ViewController () <DMDraggableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DMDraggableView *dragView = [[DMDraggableView alloc] initWithDelegate:self withFrame:CGRectMake(100, 100, 50, 50) inView:self.view withDragEndBehaviour:DragEndBehaviorReset];
    
    [self.view addSubview:dragView];
}


@end

//
//  DMDraggableView.h
//  TimeEffortTracker
//
//  Created by David Martinez Lebron on 3/13/16.
//  Copyright © 2016 davaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "UIView+Customize.h"


typedef enum {
    
    ValueUnitSeconds,
    ValueUnitMinutes,
    ValueUnitHours
    
} ValueUnit;

static const CGFloat kNavigationBarHeight = 64.0f;

typedef enum {
    
    DragEndBehaviorReset, /* Default: Reset view to origin */
    DragEndBehaviorKeep, /* Keep view where drag ended */
    DragEndBehaviorBounds /* Keep view close to borders */
    
} DragEndBehavior;

@protocol DMDraggableViewDelegate;

@interface DMDraggableView : UIView

@property (nonatomic) CGFloat value; /* Value, in this case is seconds */
@property (nonatomic) BOOL selected;
@property (nonatomic) UIColor *titleColor;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) UIImage *image;
@property (nonatomic, strong) UIColor *highlightedColor; /* View Border Color when Selected/Highlighted State */
@property (nonatomic, strong) UIColor *normalColor; /* View Border Color Normal State */
@property (nonatomic) UIView *targetView; /* Location on which the item is considered to be "inside" */
@property (nonatomic) id<DMDraggableViewDelegate> delegate;

//TODO: Add circular property

-(id) initWithDelegate:(id<DMDraggableViewDelegate>) delegate withFrame: (CGRect) frame inView:(UIView *) superView withDragEndBehaviour:(DragEndBehavior) dragEndBehavior;

//-(void) manageDragEndBehavior;



@end

@protocol DMDraggableViewDelegate <NSObject>

@optional
-(void) didStartDraggingView:(DMDraggableView *) view;
-(void) didTapView:(DMDraggableView *) view;
-(void) didEndDragginItem:(DMDraggableView *) view;
-(void) didDropOnTarget:(DMDraggableView *) view;
-(void) didEnterTarget:(DMDraggableView *) view;
-(void) didLeaveTarget:(DMDraggableView *) view;

@end






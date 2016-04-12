//
//  DMDraggableView.h
//  TimeEffortTracker
//
//  Created by David Martinez Lebron on 3/13/16.
//  Copyright © 2016 davaur. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    
    ValueUnitSeconds,
    ValueUnitMinutes,
    ValueUnitHours
    
} ValueUnit;

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
@property (nonatomic) BOOL shouldStickToBorders; /* Frame will always be close to the borders */

//TODO: Add circular property

-(id) initWithDelegate:(id<DMDraggableViewDelegate>) delegate withFrame: (CGRect) frame inView:(UIView *) superView;

-(void) resetItemLocation;



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






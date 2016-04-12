//
//  DMDraggableView.m
//  TimeEffortTracker
//
//  Created by David Martinez Lebron on 3/13/16.
//  Copyright © 2016 davaur. All rights reserved.
//

#import "DMDraggableView.h"
#import "DMDraggableView+DragEndBehaviorUtils.h"
//#import "UIView+Animations.h"
//#import "UIView+Shadow.h"
//#import "Colours.h"

@interface DMDraggableView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) CGFloat size;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGPoint originalCenter;
@property (nonatomic) UIView *superView;
@property BOOL isOnTarget;
@property (nonatomic) CGRect lastValidFrame; // will retain the last valid frame. Invalid = outside superview
@property (nonatomic) CGRect  defaultFrame; // view default frame
@property (nonatomic) UIView *highlightedEffectView;
@property BOOL shouldResetViewOrigin;
@property (nonatomic) DragEndBehavior dragEndBehavior;

@end

@implementation DMDraggableView

-(id) initWithDelegate:(id<DMDraggableViewDelegate>) delegate withFrame: (CGRect) frame inView:(UIView *) superView withDragEndBehaviour:(DragEndBehavior) dragEndBehavior {
    self = [super initWithFrame:frame];
    
    if (self) {
        _delegate = delegate;
        _superView = superView;
        _selected = false;
        _originalCenter = self.center;
        _size = CGRectGetHeight(self.frame);
        _lastValidFrame = frame;
        _defaultFrame = frame;
        _dragEndBehavior = dragEndBehavior;
        [self prepareUI];
    }
    
    return self;
}

//TODO: Add method `presentInView`
#pragma mark- Setters
-(void) setHighlightedColor:(UIColor *) highlightedColor {
    _highlightedColor = highlightedColor;
}

-(void) setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    
    self.backgroundColor = _normalColor;
    
    if (self.targetView != nil) {
        if (!self.selected)
            self.targetView.backgroundColor = _normalColor;
    }
}

-(void) setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

-(void) setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.titleLabel setTextColor:_titleColor];
}

-(void) setTargetView:(UIView *)targetView {
    _targetView = targetView;
    self.normalColor = _targetView.backgroundColor;
}

-(void) setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
    [self addSubview:self.imageView];
}

-(void) setSelected:(BOOL)selected {
    _selected = selected;
    
    if (_selected == true) {
        
        //        [UIView animateWithDuration:0.1 animations:^{
        //            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.size + 10, self.size + 10)];
        //            [self circularShape];
        //        }];
        
        self.layer.borderColor = self.highlightedColor ? self.highlightedColor.CGColor : [UIColor redColor].CGColor;
    }
    
    else {
        //        [UIView animateWithDuration:0.1 animations:^{
        //            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.size, self.size)];
        //            [self circularShape];
        //        }];
        
        self.layer.borderColor = self.normalColor ? self.normalColor.CGColor : [UIColor lightGrayColor].CGColor;
    }
}

//-(void) setDragEndBehaviour:(DragEndBehaviour)dragEndBehaviour {
//    _dragEndBehaviour = dragEndBehaviour;
//}


#pragma mark- Initializer
-(UIPanGestureRecognizer *) panGestureRecognizer {
    if (_panGestureRecognizer)
        return _panGestureRecognizer;
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    return _panGestureRecognizer;
}

-(UITapGestureRecognizer *) tapGestureRecognizer {
    if (_tapGestureRecognizer)
        return _tapGestureRecognizer;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    return _tapGestureRecognizer;
}

-(UIImageView *) imageView {
    if (_imageView)
        return _imageView;
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    return _imageView;
}

#pragma mark- Tap Gesture
-(void) tap:(UITapGestureRecognizer *) recognizer {
    
    if ([self.delegate respondsToSelector:@selector(didTapView:)])
        [self.delegate didTapView:self];
}


#pragma mark- Gesture State Helpers
-(void) dragging:(UIPanGestureRecognizer *) recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self beginGestureState:recognizer];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self changedGestureState:recognizer];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self endGestureState:recognizer];
            break;
            
        default:
            break;
    }
}

-(void) beginGestureState:(UIPanGestureRecognizer *) recognizer  {
    
    if ([self.delegate respondsToSelector:@selector(didStartDraggingView:)])
        [self.delegate didStartDraggingView:self];
    
    // add shadow to target
//    [UIView animateWithDuration:1.2f animations:^{
//        [self.targetView addShadow];
//    }];
    
    UIView *dragView = recognizer.view;
    self.originalCenter = dragView.center;
    
    dragView.alpha = 0.7f;
}

-(void) changedGestureState:(UIPanGestureRecognizer *) recognizer {
    
    // call delegate method
    
    if ([self.delegate respondsToSelector:@selector(didStartDraggingView:)])
        [self.delegate didStartDraggingView:self];
    
    UIView *dragView = recognizer.view;
    UIView *superView = [self.superView superview];
    
    CGPoint translation = [recognizer locationInView:self.superView];
    
    CGPoint realPoint = [recognizer locationInView:superView];
    
    
//    CGPoint gestureTranslation = [recognizer translationInView:self];
//    CGPoint gestureVelocity = [recognizer velocityInView:self];
    
    // standardize frame
    [dragView setCenter:CGPointMake(translation.x, translation.y)];
    
    
    [self manageView:dragView forValidLocationInSuperView:superView];
    
    
    if (self.targetView != nil) {
        self.isOnTarget = [self isOrigin:realPoint onTarget:self.targetView];
    }
}

// manages drag view valid locations, If view is outside superview frame, frame must be reset to last valid location
-(void) manageView:(UIView *) dragView forValidLocationInSuperView:(UIView *) superView {
    
    if (([dragView frame].origin.x < 0 || [dragView frame].origin.x + CGRectGetWidth([dragView frame]) > CGRectGetWidth([superView frame])) || ([dragView frame].origin.y < 0 || [dragView frame].origin.y + CGRectGetHeight([dragView frame]) > CGRectGetHeight([superView frame]))) {
        self.shouldResetViewOrigin = true;
    }
    
    else {
        self.lastValidFrame = [dragView frame];
        self.shouldResetViewOrigin = false;
    }
    
}

-(void) endGestureState:(UIPanGestureRecognizer *) recognizer {
    
    if ([self.delegate respondsToSelector:@selector(didEndDragginItem:)])
        [self.delegate didEndDragginItem:self];
    
    
    if (self.targetView != nil) {
        if (self.isOnTarget) {
            
            if ([self.delegate respondsToSelector:@selector(didDropOnTarget:)])
                [self.delegate didDropOnTarget:self];
            
            return;
        }
    }
    
    [self manageDragEndBehaviour];
}


-(BOOL) isOrigin:(CGPoint) point onTarget:(UIView *) target {
    if (CGRectContainsPoint(self.targetView.frame, point)) {
        
        if (!self.isOnTarget) {
            
            if ([self.delegate respondsToSelector:@selector(didEnterTarget:)])
                [self.delegate didEnterTarget:self];
            
            [UIView animateWithDuration:0.2f animations:^{
                self.targetView.backgroundColor = self.highlightedColor != nil ? self.highlightedColor : [UIColor redColor];
            }];
            
        }
        return true;
    }
    
    else {
        
        if (self.isOnTarget) {
            
            [UIView animateWithDuration:0.2f animations:^{
                self.targetView.backgroundColor = self.normalColor;
            }];
            
            if ([self.delegate respondsToSelector:@selector(didLeaveTarget:)])
                [self.delegate didLeaveTarget:self];
        }
        
        return false;
    }
}

#pragma mark- UI
-(UILabel  *) titleLabel {
    
    if (_titleLabel) {
        return _titleLabel;
    }
    
    CGRect labelFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    
    [_titleLabel setText:self.title];
    
    [_titleLabel setTextColor:[UIColor redColor]];
    
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    
    [_titleLabel setNumberOfLines:2];
    
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    return _titleLabel;
}

-(void) prepareUI {
    
    [self addGestureRecognizer:self.panGestureRecognizer];
    [self addGestureRecognizer:self.tapGestureRecognizer];
    [self addSubview:self.titleLabel];
    [self.superView addSubview:self];
    self.layer.borderWidth = 1.0;
    self.backgroundColor = self.normalColor ? self.normalColor : [UIColor lightGrayColor];
    [self circular];
}



#pragma mark- Methods
-(void) manageDragEndBehaviour {
    
    switch (self.dragEndBehavior) {
        case DragEndBehaviorKeep:
            
            [self manageDragEndBehaviorKeep:self.lastValidFrame];
            
            break;
            
        case DragEndBehaviorReset:
            
            [self manageDragEndBehaviorReset:self.defaultFrame];
            
            break;
            
        case DragEndBehaviorBorders:
            
            break;
            
        default:
            break;
    }
    
    self.userInteractionEnabled = false;
}


-(void)dealloc {
    //TODO: Clean memory
}

@end











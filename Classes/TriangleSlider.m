//
//  TriangleSlider.m
//  Control
//
//  Created by Александр on 25.09.17.
//  Copyright © 2017 Александр. All rights reserved.
//

#import "TriangleSlider.h"

@interface TriangleSlider ()

@property (strong, nonatomic) NSMutableArray * segmentViews;

@end

@implementation TriangleSlider

@synthesize valueControl = _valueControl;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}


- (void)baseInit {
    
    _segmentViews = [[NSMutableArray alloc] init];
}


- (void)drawRect:(CGRect)rect {
    
    [self createSegments];
}


- (void)prepareForInterfaceBuilder {
    
    [self createSegments];
}


- (void)createSegments {
    
    // Remove old views
    for(int i = 0; i < self.segmentViews.count; ++i) {
        
        UIView *segmentView = (UIView *) [self.segmentViews objectAtIndex:i];
        
        [segmentView removeFromSuperview];
    }
    [self.segmentViews removeAllObjects];
    
    // Add new views
    for(int i = 0; i < self.segments; ++i) {
        
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width/self.segments)*i, 0, (self.bounds.size.width/self.segments)-self.distanceSegments, self.bounds.size.height)];
        
        segmentView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.segmentViews addObject:segmentView];
        
        [self addSubview:segmentView];
        
        segmentView.backgroundColor = self.notActiveColor;
    }
    [self createMask];
    
    [self refresh];
}


- (void)refresh {
    
    for(int i = 0; i < self.segmentViews.count; ++i) {
        
        UIView *segmentView = [self.segmentViews objectAtIndex:i];
        
        if (self.valueControl >= i+1) {
            
            segmentView.backgroundColor = self.activeColor;
    
        } else {
            
            segmentView.backgroundColor = self.notActiveColor;
        }
    }
}


- (void)setValueControl:(int)valueControl {
    
    _valueControl = valueControl;
    
    [self refresh];
}


- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    
    int valueControl = 0;
    
    for (int i = (int)(self.segmentViews.count - 1); i >= 0; i--) {
        
        UIView *segmentView = [self.segmentViews objectAtIndex:i];
        
        if (touchLocation.x > segmentView.frame.origin.x) {
            
            valueControl = i+1;
            
            break;
        }
    }
    self.valueControl = valueControl;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    [self handleTouchAtLocation:touchLocation];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    [self handleTouchAtLocation:touchLocation];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)createMask {
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y+ self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y)];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y)];
    [path closePath];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 1;
    [self.layer addSublayer:fillLayer];
}


@end

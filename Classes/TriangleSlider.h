//
//  TriangleSlider.h
//  Control
//
//  Created by Александр on 25.09.17.
//  Copyright © 2017 Александр. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE


@interface TriangleSlider : UIControl

@property (nonatomic) IBInspectable int segments;
@property (nonatomic) IBInspectable UIColor *activeColor;
@property (nonatomic) IBInspectable UIColor *notActiveColor;
@property (nonatomic) IBInspectable double distanceSegments;

@property (assign, nonatomic) int valueControl;

- (void)createSegments;


@end

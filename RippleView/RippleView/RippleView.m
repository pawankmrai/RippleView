//
//  RippleView.m
//  RippleView
//
//  Created by eag ers on 21/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import "RippleView.h"
#import <QuartzCore/QuartzCore.h>

@interface RippleView ()

//Private variable
@property(strong, nonatomic) UIColor *borderColor;
@property(strong, nonatomic) UIColor *fillColor;
@property(strong, nonatomic) CALayer *targetLayer;
@property(assign, nonatomic) CGFloat borderWidth;
@property(assign, nonatomic) CGFloat radious;
@property(assign, nonatomic) CFTimeInterval duration;
@property(assign, nonatomic) CGFloat scale;
@property(assign, nonatomic) BOOL isRunSuperView;

//Private function
-(void)rippleStop;
@end
@implementation RippleView

-(void)awakeFromNib {
    _borderWidth    = 5.0f;
    _radious        = 30.0f;
    _duration       = 0.4;
    _borderColor    = [UIColor redColor];
    _fillColor      = [UIColor blueColor];
    _scale          = 3.0f;
    _isRunSuperView = YES;
}

-(void)rippleView:(CGPoint)location withColor:(UIColor *)color {
    [self border:location withColor:color];
}
-(void)border:(CGPoint)location withColor:(UIColor *)color {
    self.borderColor = color;
    [self prePerform:location locationInView:YES withColor:color];
}
-(void)prePerform:(CGPoint)point locationInView:(BOOL)isLocationInView withColor:(UIColor *)color {
    
    CGPoint p = isLocationInView ? CGPointMake(point.x + self.frame.origin.x, point.y + self.frame.origin.y) : point;
    [self perform:p];
}

-(void)perform:(CGPoint)point {
    
    //
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.borderWidth, self.borderWidth, self.radious * 2, self.radious * 2) cornerRadius:self.radious];
    [self.fillColor setFill];
    [path fill];
    [self.borderColor setStroke];
    path.lineWidth = self.borderWidth;
    [path stroke];
    
    //
    UIGraphicsBeginImageContextWithOptions(CGSizeMake((self.radious + self.borderWidth) * 2, (self.radious + self.borderWidth) *2), false, 3.0);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //
    CABasicAnimation *opcity = [CABasicAnimation animation];
    opcity.keyPath = @"opacity";
    opcity.autoreverses = NO;
    opcity.fillMode = kCAFillModeForwards;
    opcity.removedOnCompletion = NO;
    opcity.duration = self.duration;
    opcity.fromValue = @1.0;
    opcity.toValue = @0.0;
    
    //
    CABasicAnimation *transform = [CABasicAnimation animation];
    transform.autoreverses = NO;
    transform.fillMode = kCAFillModeForwards;
    transform.removedOnCompletion = NO;
    transform.duration = self.duration;
    transform.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0/self.scale, 1.0 / self.scale, 1.0)];
    transform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(self.scale, self.scale, 1.0)];
    
    //
    CALayer *rippleLayer = self.targetLayer;
    if (!rippleLayer) {
        rippleLayer = [CALayer layer];
        [self.layer addSublayer:rippleLayer];
        self.targetLayer = rippleLayer;
    }
    
    CALayer *target = self.targetLayer;
    RippleView *weakSelf = self;
    
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        CALayer *layer = [CALayer layer];
        layer.contents = (__bridge id _Nullable)(img.CGImage);
        layer.frame = CGRectMake(point.x - weakSelf.radious, point.y, weakSelf.radious * 2, weakSelf.radious * 1);
        [target addSublayer:layer];
        
        //
        [CATransaction begin];
        [CATransaction setAnimationDuration:weakSelf.duration];
        [CATransaction setCompletionBlock:^{
            layer.contents = nil;
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }];
        
        //
        [layer addAnimation:opcity forKey:nil];
        [layer addAnimation:transform forKey:nil];
        [CATransaction commit];
    });
    
}

-(void)rippleStop {
    [[self.targetLayer sublayers]
                                makeObjectsPerformSelector:@selector(removeAllAnimations)];
}
@end

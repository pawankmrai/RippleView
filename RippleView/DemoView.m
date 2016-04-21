//
//  DemoView.m
//  RippleView
//
//  Created by eag ers on 21/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self];
        [self rippleView:point withColor:[UIColor whiteColor]];
    }
}

@end

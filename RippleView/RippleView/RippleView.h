//
//  RippleView.h
//  RippleView
//
//  Created by eag ers on 21/04/16.
//  Copyright © 2016 eag ers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RippleView : UIView
-(void)rippleView:(CGPoint)location withColor:(UIColor *)color;
-(void)rippleStop;
@end

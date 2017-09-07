//
//  BladeLengthStyleKit.m
//  ProjectName
//
//  Created by Max von Hippel on 8/27/16.
//  Copyright (c) 2016 Linked & Loaded. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "BladeLengthStyleKit.h"


@implementation BladeLengthStyleKit

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawCanvas1WithBlade_length: (CGFloat)blade_length
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();


    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: UIColor.blackColor];
    [shadow setShadowOffset: CGSizeMake(2.1, 1.1)];
    [shadow setShadowBlurRadius: 5];
    NSShadow* shadow2 = [[NSShadow alloc] init];
    [shadow2 setShadowColor: UIColor.whiteColor];
    [shadow2 setShadowOffset: CGSizeMake(2.1, 3.1)];
    [shadow2 setShadowBlurRadius: 5];

    //// Bezier Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, blade_length, 0.5);

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(3, 4)];
    [bezierPath addLineToPoint: CGPointMake(0, 54)];
    [bezierPath addLineToPoint: CGPointMake(114, 54)];
    [bezierPath addLineToPoint: CGPointMake(117, 47)];
    [bezierPath addLineToPoint: CGPointMake(121, 54)];
    [bezierPath addLineToPoint: CGPointMake(124, 47)];
    [bezierPath addLineToPoint: CGPointMake(128, 54)];
    [bezierPath addLineToPoint: CGPointMake(131, 47)];
    [bezierPath addLineToPoint: CGPointMake(134, 54)];
    [bezierPath addLineToPoint: CGPointMake(137, 47)];
    [bezierPath addLineToPoint: CGPointMake(140, 54)];
    [bezierPath addLineToPoint: CGPointMake(167, 54)];
    [bezierPath addLineToPoint: CGPointMake(200, 0)];
    [bezierPath addLineToPoint: CGPointMake(3, 4)];
    [bezierPath addLineToPoint: CGPointMake(3, 4)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [UIColor.lightGrayColor setFill];
    [bezierPath fill];

    ////// Bezier Inner Shadow
    CGContextSaveGState(context);
    UIRectClip(bezierPath.bounds);
    CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);

    CGContextSetAlpha(context, CGColorGetAlpha([shadow2.shadowColor CGColor]));
    CGContextBeginTransparencyLayer(context, NULL);
    {
        UIColor* opaqueShadow = [shadow2.shadowColor colorWithAlphaComponent: 1];
        CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, [opaqueShadow CGColor]);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        CGContextBeginTransparencyLayer(context, NULL);

        [opaqueShadow setFill];
        [bezierPath fill];

        CGContextEndTransparencyLayer(context);
    }
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    CGContextRestoreGState(context);

    [UIColor.darkGrayColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];

    CGContextRestoreGState(context);
}

@end

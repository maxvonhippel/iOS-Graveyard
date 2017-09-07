//
//  SwitchBladeView.m
//  cutlery
//
//  Created by Max von Hippel on 8/19/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "SwitchBladeView.h"

@implementation SwitchBladeView
@synthesize backgroundColor, curKnife;


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [self clearGraphics];
    
    // -------------------------------------------------- blade ------------------------------------------------------
    // then, set blade color by blade material
    NSArray* bladeMaterialArray = [[NSArray alloc] initWithObjects:@"carbon steel", @"stainless steel", @"tool steel", @"alloy steel", @"steel", @"cobalt alloy", @"titanium alloy", @"carbon fiber", @"obsidian", @"ceramic", @"glass", @"plastic", @"copper", @"damascus", @"damasteel", nil];
    NSArray* bladeColorArray = [[NSArray alloc] initWithObjects:
                                [UIColor colorWithRed:0.71 green:0.73 blue:0.76 alpha:1.0], // carbon steel
                                [UIColor colorWithRed:0.88 green:0.90 blue:0.92 alpha:1.0], // stainless steel
                                [UIColor colorWithRed:0.37 green:0.39 blue:0.42 alpha:1.0], // tool steel
                                [UIColor colorWithRed:0.44 green:0.45 blue:0.47 alpha:1.0], // alloy steel
                                [UIColor colorWithRed:0.68 green:0.70 blue:0.72 alpha:1.0], // steel
                                [UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.0], // cobalt alloy
                                [UIColor colorWithRed:0.75 green:0.78 blue:0.77 alpha:1.0], // titaniumm alloy
                                [UIColor colorWithRed:0.12 green:0.07 blue:0.16 alpha:1.0], // carbon fiber
                                [UIColor colorWithRed:0.00 green:0.00 blue:0.01 alpha:1.0], // obsidian
                                [UIColor colorWithRed:0.50 green:0.46 blue:0.55 alpha:1.0], // ceramic
                                [UIColor colorWithRed:0.04 green:0.39 blue:0.74 alpha:1.0], // glass
                                [UIColor colorWithRed:0.90 green:0.51 blue:0.46 alpha:1.0], // plastic
                                [UIColor colorWithRed:0.90 green:0.84 blue:0.25 alpha:1.0], // copper
                                [UIColor colorWithRed:0.02 green:0.16 blue:0.16 alpha:1.0], // damascus
                                [UIColor colorWithRed:0.19 green:0.20 blue:0.20 alpha:1.0], // famasteel
                                nil];
    UIColor* bladeColor;
    if ([bladeMaterialArray containsObject:curKnife.bladeMaterial] && [bladeMaterialArray indexOfObject:curKnife.bladeMaterial] <= [bladeColorArray count] - 1) {
        bladeColor = [bladeColorArray objectAtIndex:[bladeMaterialArray indexOfObject:curKnife.bladeMaterial]];
    } else bladeColor = [UIColor grayColor];
    
    // Drawing code
    if ([curKnife.blade isEqualToString:@"sheep foot"]) {
        
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(68.13, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(83.9, 4.22)];
        [bezierPath addLineToPoint: CGPointMake(92.62, 9.42)];
        [bezierPath addLineToPoint: CGPointMake(97.6, 17.6)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(15.02, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(4.23, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(4.23, 25.04)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 25.04)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];


    } else if ([curKnife.blade isEqualToString:@"gut-hook"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(28.4, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(59.3, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(79.47, 2.4)];
        [bezierPath addLineToPoint: CGPointMake(90.2, 5.25)];
        [bezierPath addLineToPoint: CGPointMake(92.77, 5.25)];
        [bezierPath addLineToPoint: CGPointMake(92.77, 2.4)];
        [bezierPath addLineToPoint: CGPointMake(86.34, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(94.49, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(97.92, 5.25)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 17.14)];
        [bezierPath addLineToPoint: CGPointMake(97.92, 19.52)];
        [bezierPath addLineToPoint: CGPointMake(90.2, 22.84)];
        [bezierPath addLineToPoint: CGPointMake(74.75, 27.12)];
        [bezierPath addLineToPoint: CGPointMake(59.3, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(41.7, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(21.53, 27.12)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 22.84)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

        
    } else if ([curKnife.blade isEqualToString:@"cleaver"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, -0.5)];
        [bezierPath addLineToPoint: CGPointMake(54.35, 1.41)];
        [bezierPath addLineToPoint: CGPointMake(99.5, -0.5)];
        [bezierPath addLineToPoint: CGPointMake(99.5, 53.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 53.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, -0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(88.5, 3.5, 7, 7)];
        [UIColor.whiteColor setFill];
        [ovalPath fill];
        [UIColor.blackColor setStroke];
        ovalPath.lineWidth = 1;
        [ovalPath stroke];


    
    } else if ([curKnife.blade isEqualToString:@"combat"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(56.33, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 3.17)];
        [bezierPath addLineToPoint: CGPointMake(85.08, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(51.75, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(33.83, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(32.17, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(30.5, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(28.83, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(27.58, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(25.92, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(24.25, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(22.58, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(20.92, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(19.25, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(17.58, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(15.92, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(14.25, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(12.58, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(10.92, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(9.25, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(7.58, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 20.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];


        
    } else if ([curKnife.blade isEqualToString:@"throwing"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 2.58)];
        [bezierPath addLineToPoint: CGPointMake(46.33, 2.58)];
        [bezierPath addLineToPoint: CGPointMake(68.83, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 12.58)];
        [bezierPath addLineToPoint: CGPointMake(68.83, 25.5)];
        [bezierPath addLineToPoint: CGPointMake(46.33, 22.58)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 22.58)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 2.58)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];


        
    } else if ([curKnife.blade isEqualToString:@"chef"]) {
        
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(98.41, 5.78)];
        [bezierPath addLineToPoint: CGPointMake(95.06, 10.01)];
        [bezierPath addLineToPoint: CGPointMake(88.37, 14.76)];
        [bezierPath addLineToPoint: CGPointMake(71.63, 24.27)];
        [bezierPath addLineToPoint: CGPointMake(55.31, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(39.41, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(16.4, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(8.45, 25.86)];
        [bezierPath addLineToPoint: CGPointMake(4.68, 24.27)];
        [bezierPath addLineToPoint: CGPointMake(4.68, 14.76)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 14.76)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

        
    } else if ([curKnife.blade isEqualToString:@"fillet"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(96.75, 4.28)];
        [bezierPath addLineToPoint: CGPointMake(90.92, 7.52)];
        [bezierPath addLineToPoint: CGPointMake(81.75, 10.76)];
        [bezierPath addLineToPoint: CGPointMake(3.42, 10.76)];
        [bezierPath addLineToPoint: CGPointMake(3.42, 19.94)];
        [bezierPath addLineToPoint: CGPointMake(6.33, 24.26)];
        [bezierPath addLineToPoint: CGPointMake(3.42, 27.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 24.26)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

        
    } else if ([curKnife.blade isEqualToString:@"needle-point"]) {
        
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(3.33, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(72.97, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 4.5)];
        [bezierPath addLineToPoint: CGPointMake(72.97, 9.17)];
        [bezierPath addLineToPoint: CGPointMake(3.33, 9.17)];
        [bezierPath addLineToPoint: CGPointMake(3.33, 17.83)];
        [bezierPath addLineToPoint: CGPointMake(5.76, 23.17)];
        [bezierPath addLineToPoint: CGPointMake(3.33, 26.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 23.17)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(3.33, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];


    } else if ([curKnife.blade isEqualToString:@"straight"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(97.15, 4.8)];
        [bezierPath addLineToPoint: CGPointMake(92.55, 9.57)];
        [bezierPath addLineToPoint: CGPointMake(83.35, 14.82)];
        [bezierPath addLineToPoint: CGPointMake(70.37, 18.64)];
        [bezierPath addLineToPoint: CGPointMake(39.83, 21.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 21.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

        
    } else if ([curKnife.blade isEqualToString:@"khukri"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(27.7, 3.35)];
        [bezierPath addLineToPoint: CGPointMake(64.52, 7.16)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 17.14)];
        [bezierPath addLineToPoint: CGPointMake(92.55, 20.94)];
        [bezierPath addLineToPoint: CGPointMake(77.49, 26.17)];
        [bezierPath addLineToPoint: CGPointMake(64.52, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(53.22, 29.5)];
        [bezierPath addLineToPoint: CGPointMake(43.6, 26.17)];
        [bezierPath addLineToPoint: CGPointMake(32.72, 17.14)];
        [bezierPath addLineToPoint: CGPointMake(24.77, 13.81)];
        [bezierPath addLineToPoint: CGPointMake(17.24, 10.96)];
        [bezierPath addLineToPoint: CGPointMake(9.71, 10.96)];
        [bezierPath addLineToPoint: CGPointMake(3.85, 13.81)];
        [bezierPath addLineToPoint: CGPointMake(3.85, 17.14)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 17.14)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(27.7, 3.35)];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];


        
    } else if ([curKnife.blade isEqualToString:@"tanto"]) {
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(92.97, 16.4)];
        [bezierPath addLineToPoint: CGPointMake(85.86, 23.53)];
        [bezierPath addLineToPoint: CGPointMake(10.12, 23.53)];
        [bezierPath addLineToPoint: CGPointMake(10.12, 16.4)];
        [bezierPath addLineToPoint: CGPointMake(2.59, 16.4)];
        [bezierPath addLineToPoint: CGPointMake(2.59, 23.53)];
        [bezierPath addLineToPoint: CGPointMake(5.94, 28.47)];
        [bezierPath addLineToPoint: CGPointMake(5.94, 34.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 34.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

    
    } else if ([curKnife.blade isEqualToString:@"talon"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(12.26, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(12.26, 2.79)];
        [bezierPath addLineToPoint: CGPointMake(15.43, 2.79)];
        [bezierPath addLineToPoint: CGPointMake(17.24, 4.61)];
        [bezierPath addLineToPoint: CGPointMake(19.5, 5.99)];
        [bezierPath addLineToPoint: CGPointMake(21.77, 5.99)];
        [bezierPath addLineToPoint: CGPointMake(25.84, 4.61)];
        [bezierPath addLineToPoint: CGPointMake(29.01, 2.79)];
        [bezierPath addLineToPoint: CGPointMake(36.7, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(70.64, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(78.33, 2.79)];
        [bezierPath addLineToPoint: CGPointMake(89.64, 8.73)];
        [bezierPath addLineToPoint: CGPointMake(93.71, 13.3)];
        [bezierPath addLineToPoint: CGPointMake(97.33, 20.16)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 28.84)];
        [bezierPath addLineToPoint: CGPointMake(89.64, 23.36)];
        [bezierPath addLineToPoint: CGPointMake(76.52, 20.16)];
        [bezierPath addLineToPoint: CGPointMake(64.75, 18.33)];
        [bezierPath addLineToPoint: CGPointMake(54.35, 20.16)];
        [bezierPath addLineToPoint: CGPointMake(36.7, 26.56)];
        [bezierPath addLineToPoint: CGPointMake(23.12, 30.67)];
        [bezierPath addLineToPoint: CGPointMake(12.26, 32.5)];
        [bezierPath addLineToPoint: CGPointMake(5.48, 30.67)];
        [bezierPath addLineToPoint: CGPointMake(5.48, 28.84)];
        [bezierPath addLineToPoint: CGPointMake(3.21, 30.67)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 30.67)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"pen"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(3.53, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(80.3, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 5.17)];
        [bezierPath addLineToPoint: CGPointMake(95.57, 11)];
        [bezierPath addLineToPoint: CGPointMake(90.65, 16.25)];
        [bezierPath addLineToPoint: CGPointMake(80.3, 21.5)];
        [bezierPath addLineToPoint: CGPointMake(10.35, 21.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 16.25)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 5.17)];
        [bezierPath addLineToPoint: CGPointMake(3.46, 0.5)];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

        
    } else if ([curKnife.blade isEqualToString:@"punch"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, -0.5)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 2)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 4)];
        [bezierPath addLineToPoint: CGPointMake(7.58, 4)];
        [bezierPath addLineToPoint: CGPointMake(7.58, 2)];
        [bezierPath addLineToPoint: CGPointMake(33, -0.5)];
        [bezierPath addLineToPoint: CGPointMake(65.5, 2)];
        [bezierPath addLineToPoint: CGPointMake(92.17, 11.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 17.5)];
        [bezierPath addLineToPoint: CGPointMake(83, 38.5)];
        [bezierPath addLineToPoint: CGPointMake(60.5, 50.5)];
        [bezierPath addLineToPoint: CGPointMake(22.17, 50.5)];
        [bezierPath addLineToPoint: CGPointMake(9.67, 44)];
        [bezierPath addLineToPoint: CGPointMake(7.58, 44)];
        [bezierPath addLineToPoint: CGPointMake(7.58, 38.5)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 38.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 44)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 28)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 28)];
        [bezierPath addLineToPoint: CGPointMake(22.17, 23)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 17.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 17.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 2)];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"multitool"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(41.92, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(87.53, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 16.53)];
        [bezierPath addLineToPoint: CGPointMake(77.07, 16.53)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(67.45, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(67.45, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(64.94, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(64.94, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(62.42, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(62.42, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(59.5, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(59.5, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(56.99, 8.52)];
        [bezierPath addLineToPoint: CGPointMake(56.99, 12.53)];
        [bezierPath addLineToPoint: CGPointMake(48.2, 16.53)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 16.53)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 20.99)];
        [bezierPath addLineToPoint: CGPointMake(5.52, 20.99)];
        [bezierPath addLineToPoint: CGPointMake(8.03, 25)];
        [bezierPath addLineToPoint: CGPointMake(8.03, 28.11)];
        [bezierPath addLineToPoint: CGPointMake(5.52, 31.23)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 31.23)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 36.13)];
        [bezierPath addLineToPoint: CGPointMake(48.2, 36.13)];
        [bezierPath addLineToPoint: CGPointMake(56.99, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(56.99, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(59.5, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(59.5, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(62.42, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(62.42, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(64.94, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(64.94, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(67.45, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(67.45, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 40.14)];
        [bezierPath addLineToPoint: CGPointMake(77.07, 36.13)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 36.13)];
        [bezierPath addLineToPoint: CGPointMake(87.53, 47.26)];
        [bezierPath addLineToPoint: CGPointMake(69.96, 53.5)];
        [bezierPath addLineToPoint: CGPointMake(41.92, 53.5)];
        [bezierPath addLineToPoint: CGPointMake(31.46, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 44.59)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 8.52)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"saw"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(99.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(99.5, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(94.55, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(92.08, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(87.95, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(84.65, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(80.94, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(77.64, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(74.34, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(71.45, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(68.15, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(64.85, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(61.14, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(57.84, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(55.36, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(52.06, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(47.94, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(44.64, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(41.34, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(38.04, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(33.91, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(31.02, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(27.31, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(24.01, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(20.71, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(17.41, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(14.94, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(10.81, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(7.51, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(4.21, 58.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 46.69)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"machete"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(1.74, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(91.41, 10.38)];
        [bezierPath addLineToPoint: CGPointMake(81.49, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(61.24, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(20.33, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(20.33, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(17.03, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(17.03, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(13.72, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(13.72, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(10.83, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(10.83, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(7.52, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(7.52, 20.78)];
        [bezierPath addLineToPoint: CGPointMake(4.22, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(4.22, 35.86)];
        [bezierPath addLineToPoint: CGPointMake(5.46, 35.86)];
        [bezierPath addLineToPoint: CGPointMake(5.46, 39.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 39.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 35.86)];
        [bezierPath addLineToPoint: CGPointMake(1.74, 35.86)];
        [bezierPath addLineToPoint: CGPointMake(1.74, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 27.54)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(1.74, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"bowie"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(67.86, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(72.47, 2.71)];
        [bezierPath addLineToPoint: CGPointMake(78.32, 4.93)];
        [bezierPath addLineToPoint: CGPointMake(85.02, 6.26)];
        [bezierPath addLineToPoint: CGPointMake(92.55, 6.26)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 4.93)];
        [bezierPath addLineToPoint: CGPointMake(99.24, 7.59)];
        [bezierPath addLineToPoint: CGPointMake(94.22, 12.46)];
        [bezierPath addLineToPoint: CGPointMake(87.11, 19.1)];
        [bezierPath addLineToPoint: CGPointMake(75.4, 26.19)];
        [bezierPath addLineToPoint: CGPointMake(59.5, 31.5)];
        [bezierPath addLineToPoint: CGPointMake(4.27, 31.5)];
        [bezierPath addLineToPoint: CGPointMake(2.59, 27.51)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 26.19)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

    } else if ([curKnife.blade isEqualToString:@"drop-point"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(60.33, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 4.01)];
        [bezierPath addLineToPoint: CGPointMake(95.9, 12.19)];
        [bezierPath addLineToPoint: CGPointMake(89.62, 20.96)];
        [bezierPath addLineToPoint: CGPointMake(79.16, 27.39)];
        [bezierPath addLineToPoint: CGPointMake(60.33, 32.65)];
        [bezierPath addLineToPoint: CGPointMake(9.71, 38.5)];
        [bezierPath addLineToPoint: CGPointMake(5.52, 32.65)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 32.65)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

    } else if ([curKnife.blade isEqualToString:@"muskrat"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 3.83)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 3.83)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 3.83)];
        [bezierPath addLineToPoint: CGPointMake(27.81, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 3.83)];
        [bezierPath addLineToPoint: CGPointMake(89.16, 15.17)];
        [bezierPath addLineToPoint: CGPointMake(71.51, 21.83)];
        [bezierPath addLineToPoint: CGPointMake(11.42, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 21.83)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 32.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 3.83)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 3.83)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
    } else if ([curKnife.blade isEqualToString:@"spear-point"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(62.58, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(89.25, 4.58)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 4.58)];
        [bezierPath addLineToPoint: CGPointMake(97.17, 10.3)];
        [bezierPath addLineToPoint: CGPointMake(85.92, 22.54)];
        [bezierPath addLineToPoint: CGPointMake(70.92, 29.89)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 29.89)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 22.54)];
        [bezierPath addLineToPoint: CGPointMake(2.58, 22.54)];
        [bezierPath addLineToPoint: CGPointMake(2.58, 36.42)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 40.5)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

    } else if ([curKnife.blade isEqualToString:@"razor"]) {
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color2 = [UIColor colorWithRed: 0.947 green: 0.934 blue: 0.934 alpha: 1];
        UIColor* shadowColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* color11 = [UIColor colorWithRed: 0.884 green: 0.864 blue: 0.864 alpha: 0.287];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: shadowColor];
        [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
        [shadow setShadowBlurRadius: 5];
        NSShadow* shadow2 = [[NSShadow alloc] init];
        [shadow2 setShadowColor: [color2 colorWithAlphaComponent: CGColorGetAlpha(color2.CGColor) * 0.61]];
        [shadow2 setShadowOffset: CGSizeMake(8.1, 13.1)];
        [shadow2 setShadowBlurRadius: 17];
        
        //// Group
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(0.5, -0.5)];
            [bezierPath addLineToPoint: CGPointMake(100.5, -0.5)];
            [bezierPath addLineToPoint: CGPointMake(100.5, 8.42)];
            [bezierPath addLineToPoint: CGPointMake(95.08, 8.42)];
            [bezierPath addLineToPoint: CGPointMake(92.58, 13.38)];
            [bezierPath addLineToPoint: CGPointMake(92.58, 15.86)];
            [bezierPath addLineToPoint: CGPointMake(100.5, 15.86)];
            [bezierPath addLineToPoint: CGPointMake(100.5, 57.5)];
            [bezierPath addLineToPoint: CGPointMake(58.83, 57.5)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 57.5)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 15.86)];
            [bezierPath addLineToPoint: CGPointMake(9.67, 15.86)];
            [bezierPath addLineToPoint: CGPointMake(9.67, 13.38)];
            [bezierPath addLineToPoint: CGPointMake(6.33, 8.42)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 8.42)];
            [bladeColor setFill];
            [bezierPath fill];
            [UIColor.blackColor setStroke];
            bezierPath.lineWidth = 1;
            [bezierPath stroke];
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(48.5, 17.5, 4, 16)];
            [UIColor.whiteColor setFill];
            [ovalPath fill];
            [UIColor.blackColor setStroke];
            ovalPath.lineWidth = 1;
            [ovalPath stroke];
            
            
            //// Rectangle Drawing
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.5, -0.5, 100, 10)];
            [UIColor.blackColor setFill];
            [rectanglePath fill];
            [UIColor.blackColor setStroke];
            rectanglePath.lineWidth = 1;
            [rectanglePath stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(1.33, 34.7)];
            [bezier2Path addLineToPoint: CGPointMake(1.33, 55.02)];
            [bezier2Path addLineToPoint: CGPointMake(88.42, 55.02)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [bladeColor setFill];
            [bezier2Path fill];
            
            ////// Bezier 2 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier2Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow2.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow2.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier2Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
            
            [color11 setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
        }

    } else if ([curKnife.blade isEqualToString:@"utility"]) {
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color2 = [UIColor colorWithRed: 0.947 green: 0.934 blue: 0.934 alpha: 1];
        UIColor* shadowColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* color9 = [UIColor colorWithRed: 0.958 green: 0.958 blue: 0.958 alpha: 1];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: shadowColor];
        [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
        [shadow setShadowBlurRadius: 5];
        NSShadow* shadow2 = [[NSShadow alloc] init];
        [shadow2 setShadowColor: [color2 colorWithAlphaComponent: CGColorGetAlpha(color2.CGColor) * 0.61]];
        [shadow2 setShadowOffset: CGSizeMake(8.1, 13.1)];
        [shadow2 setShadowBlurRadius: 17];
        
        //// Group
        {
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(1.33, 46.98)];
            [bezier5Path addLineToPoint: CGPointMake(5.92, 56.27)];
            [bezier5Path addLineToPoint: CGPointMake(20.5, 56.27)];
            [bezier5Path addLineToPoint: CGPointMake(31.33, 35.99)];
            [bezier5Path addLineToPoint: CGPointMake(1.33, 35.99)];
            [bezier5Path addLineToPoint: CGPointMake(1.33, 46.98)];
            [bezier5Path addLineToPoint: CGPointMake(1.33, 46.98)];
            [bezier5Path closePath];
            [bladeColor setFill];
            [bezier5Path fill];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(60.08, 0.5)];
            [bezier2Path addLineToPoint: CGPointMake(73.42, 0.5)];
            [bezier2Path addLineToPoint: CGPointMake(100.5, 47.82)];
            [bezier2Path addLineToPoint: CGPointMake(5.92, 47.82)];
            [bezier2Path addLineToPoint: CGPointMake(13, 22.47)];
            [bezier2Path addLineToPoint: CGPointMake(18.42, 0.5)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.lightGrayColor setFill];
            [bezier2Path fill];
            
            ////// Bezier 2 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier2Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow2.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow2.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier2Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(0.5, 1.35)];
            [bezierPath addLineToPoint: CGPointMake(59.67, 1.35)];
            [bezierPath addLineToPoint: CGPointMake(59.67, 9.8)];
            [bezierPath addLineToPoint: CGPointMake(54.25, 18.25)];
            [bezierPath addLineToPoint: CGPointMake(40.5, 29.23)];
            [bezierPath addLineToPoint: CGPointMake(22.58, 29.23)];
            [bezierPath addLineToPoint: CGPointMake(9.25, 18.25)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 9.8)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 1.35)];
            [bezierPath closePath];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.grayColor setFill];
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
            
            [UIColor.blackColor setStroke];
            bezierPath.lineWidth = 1;
            [bezierPath stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(7.17, 46.98)];
            [bezier6Path addLineToPoint: CGPointMake(2.17, 46.98)];
            [bezier6Path addLineToPoint: CGPointMake(2.17, 54.58)];
            [bezier6Path addLineToPoint: CGPointMake(100.08, 54.58)];
            [bezier6Path addLineToPoint: CGPointMake(100.08, 46.98)];
            [bezier6Path addLineToPoint: CGPointMake(7.17, 46.98)];
            [bezier6Path closePath];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, [shadow2.shadowColor CGColor]);
            [color9 setFill];
            [bezier6Path fill];
            
            ////// Bezier 6 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier6Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier6Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow2.shadowOffset, shadow2.shadowBlurRadius, [shadow2.shadowColor CGColor]);
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            CGContextRestoreGState(context);
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(0.92, 8.95)];
            [bezier3Path addLineToPoint: CGPointMake(13, 22.47)];
            [bezier3Path addLineToPoint: CGPointMake(13, 36.84)];
            [bezier3Path addLineToPoint: CGPointMake(0.92, 60.5)];
            [bezier3Path addLineToPoint: CGPointMake(0.92, 8.95)];
            [bezier3Path closePath];
            [bladeColor setFill];
            [bezier3Path fill];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(23.83, 8.11)];
            [bezier4Path addLineToPoint: CGPointMake(36.75, 8.11)];
            [bezier4Path addLineToPoint: CGPointMake(33, 14.87)];
            [bezier4Path addLineToPoint: CGPointMake(23.83, 8.11)];
            [bezier4Path closePath];
            [bladeColor setFill];
            [bezier4Path fill];
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
        }

    } if ([curKnife.blade isEqualToString:@"pruner"]) {
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(49.25, 0.5)];
        [bezierPath addLineToPoint: CGPointMake(81.75, 8.93)];
        [bezierPath addLineToPoint: CGPointMake(97.17, 20.53)];
        [bezierPath addLineToPoint: CGPointMake(100.5, 39.5)];
        [bezierPath addLineToPoint: CGPointMake(81.75, 32.12)];
        [bezierPath addLineToPoint: CGPointMake(55.5, 25.8)];
        [bezierPath addLineToPoint: CGPointMake(13, 32.12)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 32.12)];
        [bezierPath addLineToPoint: CGPointMake(3.83, 25.8)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 32.12)];
        [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
        [bezierPath closePath];
        [bladeColor setFill];
        [bezierPath fill];
        [UIColor.blackColor setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];

   } else if ([curKnife.blade isEqualToString:@"skinner"]) {
       //// General Declarations
       CGContextRef context = UIGraphicsGetCurrentContext();
       
       //// Color Declarations
       UIColor* color2 = [UIColor colorWithRed: 0.947 green: 0.934 blue: 0.934 alpha: 1];
       UIColor* shadowColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
       UIColor* color10 = [UIColor colorWithRed: 0.65 green: 0.634 blue: 0.634 alpha: 0.273];
       
       //// Shadow Declarations
       NSShadow* shadow = [[NSShadow alloc] init];
       [shadow setShadowColor: shadowColor];
       [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
       [shadow setShadowBlurRadius: 5];
       NSShadow* shadow2 = [[NSShadow alloc] init];
       [shadow2 setShadowColor: [color2 colorWithAlphaComponent: CGColorGetAlpha(color2.CGColor) * 0.61]];
       [shadow2 setShadowOffset: CGSizeMake(8.1, 13.1)];
       [shadow2 setShadowBlurRadius: 17];
       
       //// Group
       {
           //// Bezier Drawing
           UIBezierPath* bezierPath = [UIBezierPath bezierPath];
           [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
           [bezierPath addLineToPoint: CGPointMake(44.25, 0.5)];
           [bezierPath addLineToPoint: CGPointMake(100.5, 4.3)];
           [bezierPath addLineToPoint: CGPointMake(97.58, 11.27)];
           [bezierPath addLineToPoint: CGPointMake(93, 17.6)];
           [bezierPath addLineToPoint: CGPointMake(86.75, 23.93)];
           [bezierPath addLineToPoint: CGPointMake(78.42, 30.27)];
           [bezierPath addLineToPoint: CGPointMake(63.42, 34.7)];
           [bezierPath addLineToPoint: CGPointMake(33.42, 34.7)];
           [bezierPath addLineToPoint: CGPointMake(13.83, 34.7)];
           [bezierPath addLineToPoint: CGPointMake(10.92, 30.27)];
           [bezierPath addLineToPoint: CGPointMake(8.42, 27.73)];
           [bezierPath addLineToPoint: CGPointMake(6.75, 27.73)];
           [bezierPath addLineToPoint: CGPointMake(4.25, 30.27)];
           [bezierPath addLineToPoint: CGPointMake(0.5, 34.7)];
           [bezierPath addLineToPoint: CGPointMake(0.5, 38.5)];
           [bezierPath addLineToPoint: CGPointMake(0.5, 0.5)];
           [bezierPath closePath];
           [bladeColor setFill];
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
           
           [UIColor.blackColor setStroke];
           bezierPath.lineWidth = 1;
           [bezierPath stroke];
           
           
           //// Bezier 2 Drawing
           UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
           [bezier2Path moveToPoint: CGPointMake(10.5, 27.1)];
           [bezier2Path addLineToPoint: CGPointMake(17.58, 16.97)];
           [bezier2Path addLineToPoint: CGPointMake(35.5, 8.73)];
           [bezier2Path addLineToPoint: CGPointMake(97.17, 8.73)];
           [bezier2Path addLineToPoint: CGPointMake(97.17, 8.73)];
           CGContextSaveGState(context);
           CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
           [color10 setStroke];
           bezier2Path.lineWidth = 1;
           [bezier2Path stroke];
           CGContextRestoreGState(context);
       }

        
    }
}

- (void) clearGraphics {
    
    if (!backgroundColor)
        return;
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 100, 60)];
    [backgroundColor setFill];
    [rectangle2Path fill];
    
}


@end

//
//  handle.m
//  cutlery
//
//  Created by Max von Hippel on 8/19/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "handle.h"

@implementation handle
@synthesize backgroundColor, curKnife;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // next, set handleImageView color
    NSArray* handleMaterialArray = [[NSArray alloc] initWithObjects:@"carbon fiber", @"exotic wood", @"wood", @"aluminum", @"copper", @"steel", @"nylon copolymer", @"elastomer", @"titanium", @"plastic", @"rubber", @"composite", @"paracord", @"dymondwood", @"bone", @"stag horn", @"buffalo horn", @"mother of pearl", @"damascus", @"antler", @"horn", @"mammoth", @"ivory", nil];
    // make an nsarray of colors
    // thank jesus for this website: http://www.briangrinstead.com/blog/ios-uicolor-picker
    // -------------------------- colors -------------------------------------------------------------
    NSArray* colorArray = [[NSArray alloc] initWithObjects:[UIColor blackColor],       // carbon fiber
                           [UIColor brownColor],                                       // exotic wood
                           [UIColor colorWithRed:0.75 green:0.55 blue:0.13 alpha:1.0], // wood
                           [UIColor colorWithRed:0.71 green:0.84 blue:0.77 alpha:1.0],                                                   // aluminum
                           [UIColor yellowColor],                                      // copper
                           [UIColor colorWithRed:0.78 green:0.78 blue:0.77 alpha:1.0], // steel
                           [UIColor colorWithRed:0.28 green:0.27 blue:0.26 alpha:1.0], // nylon copolymer
                           [UIColor colorWithRed:0.88 green:0.90 blue:0.34 alpha:1.0], // elastomer
                           [UIColor colorWithRed:0.83 green:1.00 blue:0.99 alpha:1.0], // titanium
                           [UIColor colorWithRed:0.17 green:0.45 blue:0.55 alpha:1.0], // plastic
                           [UIColor colorWithRed:0.02 green:0.14 blue:0.17 alpha:1.0], // rubber
                           [UIColor colorWithRed:0.24 green:0.11 blue:0.40 alpha:1.0], // composite
                           [UIColor colorWithRed:0.38 green:0.35 blue:0.14 alpha:1.0], // paracord
                           [UIColor colorWithRed:0.00 green:0.96 blue:0.71 alpha:1.0], // dymondwood
                           [UIColor colorWithRed:0.73 green:0.85 blue:0.82 alpha:1.0], // bone
                           [UIColor colorWithRed:0.80 green:0.85 blue:0.73 alpha:1.0], // stag horn
                           [UIColor colorWithRed:0.29 green:0.22 blue:0.36 alpha:1.0], // buffalo horn
                           [UIColor colorWithRed:0.95 green:0.91 blue:0.98 alpha:1.0], // mother of pearl
                           [UIColor colorWithRed:0.06 green:0.24 blue:0.44 alpha:1.0], // damascus
                           [UIColor colorWithRed:0.72 green:0.75 blue:0.71 alpha:1.0], // antler
                           [UIColor colorWithRed:0.91 green:0.89 blue:0.82 alpha:1.0], // horn
                           [UIColor colorWithRed:0.33 green:0.33 blue:0.32 alpha:1.0], // mammoth
                           [UIColor colorWithRed:0.89 green:0.89 blue:0.84 alpha:1.0], // ivory
                           nil];
    // then match material to color
    UIColor* handleColor;
    
    if ([handleMaterialArray containsObject:curKnife.handleMaterial] && [handleMaterialArray indexOfObject:curKnife.handleMaterial] < [colorArray count]) {
        handleColor = [colorArray objectAtIndex:[handleMaterialArray indexOfObject:curKnife.handleMaterial]];
    } else handleColor = [UIColor brownColor];
    
    // Drawing code
    [self clearGraphics];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(9.22, 6.2)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 6.2)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 36.6)];
    [bezierPath addLineToPoint: CGPointMake(2.99, 38.5)];
    [bezierPath addLineToPoint: CGPointMake(9.22, 38.5)];
    [bezierPath addLineToPoint: CGPointMake(12.33, 36.6)];
    [bezierPath addLineToPoint: CGPointMake(16.69, 32.17)];
    [bezierPath addLineToPoint: CGPointMake(18.56, 30.27)];
    [bezierPath addLineToPoint: CGPointMake(87.67, 25.83)];
    [bezierPath addLineToPoint: CGPointMake(92.65, 30.27)];
    [bezierPath addLineToPoint: CGPointMake(95.76, 32.17)];
    [bezierPath addLineToPoint: CGPointMake(99.5, 32.17)];
    [bezierPath addLineToPoint: CGPointMake(99.5, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(95.76, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(94.52, 1.13)];
    [bezierPath addLineToPoint: CGPointMake(92.65, 1.13)];
    [bezierPath addLineToPoint: CGPointMake(91.41, 1.77)];
    [bezierPath addLineToPoint: CGPointMake(87.67, 1.77)];
    [bezierPath addLineToPoint: CGPointMake(67.75, 1.77)];
    [bezierPath addLineToPoint: CGPointMake(31.63, 3.67)];
    [bezierPath addLineToPoint: CGPointMake(9.22, 6.2)];
    [bezierPath closePath];
    [handleColor setFill];
    [bezierPath fill];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(88, 15, 9, 9)];
    [UIColor.blackColor setFill];
    [ovalPath fill];


    
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

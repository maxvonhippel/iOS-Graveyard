//
//  BladeLengthView.m
//  cutlery
//
//  Created by Max von Hippel on 8/27/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "BladeLengthView.h"
#import "BladeLengthStyleKit.h"

@implementation BladeLengthView
@synthesize curKnife;


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat blade_length = -205 + (205 * curKnife.bladeLength / 30); // 0 to -205 from 0 to 30
    CGFloat follow_x = 197 * curKnife.bladeLength / 30;            // 0 to 197 from 0 to 30
    
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
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: UIColor.blackColor];
    [shadow setShadowOffset: CGSizeMake(2.1, 1.1)];
    [shadow setShadowBlurRadius: 5];
    NSShadow* shadow2 = [[NSShadow alloc] init];
    [shadow2 setShadowColor: UIColor.whiteColor];
    [shadow2 setShadowOffset: CGSizeMake(2.1, 3.1)];
    [shadow2 setShadowBlurRadius: 5];
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(0.5, -0.5)];
    [bezier2Path addLineToPoint: CGPointMake(0.5, 33.5)];
    [bezier2Path addLineToPoint: CGPointMake(197.5, 33.5)];
    [bezier2Path addLineToPoint: CGPointMake(200.5, 33.5)];
    [bezier2Path addLineToPoint: CGPointMake(200.5, -0.5)];
    [bezier2Path addLineToPoint: CGPointMake(0.5, -0.5)];
    [bezier2Path addLineToPoint: CGPointMake(0.5, -0.5)];
    [handleColor setFill];
    [bezier2Path fill];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 3.5;
    [bezier2Path stroke];
    
    
    //// Bezier 3 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, (follow_x + 1), 0.5);
    
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(0, 0)];
    [bezier3Path addLineToPoint: CGPointMake(0, 38)];
    [handleColor setFill];
    [bezier3Path fill];
    [color3 setStroke];
    bezier3Path.lineWidth = 4.5;
    [bezier3Path stroke];
    
    CGContextRestoreGState(context);
    
    
    //// Bezier Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, blade_length, 0.5);
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(2.96, 2.37)];
    [bezierPath addLineToPoint: CGPointMake(0, 32)];
    [bezierPath addLineToPoint: CGPointMake(112.58, 32)];
    [bezierPath addLineToPoint: CGPointMake(115.54, 27.85)];
    [bezierPath addLineToPoint: CGPointMake(119.49, 32)];
    [bezierPath addLineToPoint: CGPointMake(122.45, 27.85)];
    [bezierPath addLineToPoint: CGPointMake(126.4, 32)];
    [bezierPath addLineToPoint: CGPointMake(129.36, 27.85)];
    [bezierPath addLineToPoint: CGPointMake(132.33, 32)];
    [bezierPath addLineToPoint: CGPointMake(135.29, 27.85)];
    [bezierPath addLineToPoint: CGPointMake(138.25, 32)];
    [bezierPath addLineToPoint: CGPointMake(164.91, 32)];
    [bezierPath addLineToPoint: CGPointMake(197.5, 0)];
    [bezierPath addLineToPoint: CGPointMake(2.96, 2.37)];
    [bezierPath addLineToPoint: CGPointMake(2.96, 2.37)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
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
    
    CGContextRestoreGState(context);
    
    [UIColor.darkGrayColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    CGContextRestoreGState(context);
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(47, 35, 108, 21);
    {
        NSString* textContent = [NSString stringWithFormat:@"%.2ld in, %.f cm", (long)curKnife.bladeLength, curKnife.bladeLength * 2.54];
        NSMutableParagraphStyle* textStyle = [NSMutableParagraphStyle new];
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(2, 0)];
    [bezier4Path addLineToPoint: CGPointMake(2, 33)];
    [handleColor setFill];
    [bezier4Path fill];
    [UIColor.blackColor setStroke];
    bezier4Path.lineWidth = 5;
    [bezier4Path stroke];
}


@end

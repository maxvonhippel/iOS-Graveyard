//
//  Material.m
//  cutlery
//
//  Created by Max von Hippel on 8/26/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "MaterialView.h"
#import "MaterialStyleKit.h"

@implementation MaterialView
@synthesize material;

- (void)drawRect:(CGRect)rect {
    // what color is this material?
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
    
    NSArray* handleMaterialArray = [[NSArray alloc] initWithObjects:@"carbon fiber", @"exotic wood", @"wood", @"aluminum", @"copper", @"steel", @"nylon copolymer", @"elastomer", @"titanium", @"plastic", @"rubber", @"composite", @"paracord", @"dymondwood", @"bone", @"stag horn", @"buffalo horn", @"mother of pearl", @"damascus", @"antler", @"horn", @"mammoth", @"ivory", nil];
    // make an nsarray of colors
    // thank jesus for this website: http://www.briangrinstead.com/blog/ios-uicolor-picker
    // -------------------------- colors -------------------------------------------------------------
    NSArray* handleColorArray = [[NSArray alloc] initWithObjects:[UIColor blackColor],       // carbon fiber
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
    
    UIColor* materialColor;
    if ([bladeMaterialArray containsObject:material] && [bladeMaterialArray indexOfObject:material] < [bladeColorArray count]) {
        // blade material
        materialColor = [bladeColorArray objectAtIndex:[bladeMaterialArray indexOfObject:material]];
        
    } else if ([handleMaterialArray containsObject:material] && [handleMaterialArray indexOfObject:material] < [handleColorArray count]) {
        // handle material
        materialColor = [handleColorArray objectAtIndex:[handleMaterialArray indexOfObject:material]];
        
    } else materialColor = [UIColor lightGrayColor];
    
    // now we need to set the view shape / type for the material view
    NSArray* mineral = [[NSArray alloc] initWithObjects:@"carbon steel", @"stainless steel", @"tool steel", @"alloy steel", @"steel", @"cobalt alloy", @"titanium alloy", @"copper", @"damascus", @"damasteel", @"aluminum", @"titanium", nil];
    NSArray* synthetic = [[NSArray alloc] initWithObjects:@"carbon fiber", @"plastic", @"nylon copolymer", @"elastomer", @"rubber", @"composite", @"paracord", nil];
    NSArray* exotic = [[NSArray alloc] initWithObjects:@"obsidian", @"ceramic", @"glass", @"mother of pearl", nil];
    NSArray* organic = [[NSArray alloc] initWithObjects:@"exotic wood", @"wood", @"dymondwood", nil];
    NSArray* horn = [[NSArray alloc] initWithObjects:@"bone", @"buffalo horn", @"horn", @"mammoth", @"ivory", nil];
    NSArray* antler = [[NSArray alloc] initWithObjects:@"stag horn", @"antler", nil];
    
    if ([antler containsObject:material]) {
        
        // draw an antler **********************************************************************************
        
        //// Antler
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(13.5, 29.84)];
            [bezierPath addLineToPoint: CGPointMake(13.5, 25.71)];
            [bezierPath addLineToPoint: CGPointMake(13.5, 19.96)];
            [bezierPath addLineToPoint: CGPointMake(14.19, 17.43)];
            [bezierPath addLineToPoint: CGPointMake(14.88, 14.21)];
            [bezierPath addLineToPoint: CGPointMake(16.03, 10.99)];
            [bezierPath addLineToPoint: CGPointMake(17.19, 8.24)];
            [bezierPath addLineToPoint: CGPointMake(18.34, 6.86)];
            [bezierPath addLineToPoint: CGPointMake(18.34, 8.93)];
            [bezierPath addLineToPoint: CGPointMake(17.19, 13.29)];
            [bezierPath addLineToPoint: CGPointMake(16.03, 18.58)];
            [bezierPath addLineToPoint: CGPointMake(16.03, 25.71)];
            [bezierPath addLineToPoint: CGPointMake(16.03, 27.32)];
            [bezierPath addLineToPoint: CGPointMake(17.19, 26.63)];
            [bezierPath addLineToPoint: CGPointMake(17.19, 25.02)];
            [bezierPath addLineToPoint: CGPointMake(18.34, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(19.49, 17.43)];
            [bezierPath addLineToPoint: CGPointMake(21.56, 13.29)];
            [bezierPath addLineToPoint: CGPointMake(24.33, 8.24)];
            [bezierPath addLineToPoint: CGPointMake(27.55, 3.41)];
            [bezierPath addLineToPoint: CGPointMake(30.32, 0.65)];
            [bezierPath addLineToPoint: CGPointMake(32.16, -0.5)];
            [bezierPath addLineToPoint: CGPointMake(32.16, -0.04)];
            [bezierPath addLineToPoint: CGPointMake(30.32, 3.41)];
            [bezierPath addLineToPoint: CGPointMake(27.55, 7.55)];
            [bezierPath addLineToPoint: CGPointMake(24.33, 14.21)];
            [bezierPath addLineToPoint: CGPointMake(22.95, 18.58)];
            [bezierPath addLineToPoint: CGPointMake(22.25, 20.88)];
            [bezierPath addLineToPoint: CGPointMake(22.95, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(23.64, 22.49)];
            [bezierPath addLineToPoint: CGPointMake(25.02, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(28.47, 19.96)];
            [bezierPath addLineToPoint: CGPointMake(31.24, 16.74)];
            [bezierPath addLineToPoint: CGPointMake(34.92, 12.14)];
            [bezierPath addLineToPoint: CGPointMake(38.15, 8.24)];
            [bezierPath addLineToPoint: CGPointMake(40.68, 6.86)];
            [bezierPath addLineToPoint: CGPointMake(40.68, 7.55)];
            [bezierPath addLineToPoint: CGPointMake(38.15, 10.99)];
            [bezierPath addLineToPoint: CGPointMake(34.92, 14.9)];
            [bezierPath addLineToPoint: CGPointMake(33.08, 18.58)];
            [bezierPath addLineToPoint: CGPointMake(33.08, 19.96)];
            [bezierPath addLineToPoint: CGPointMake(33.08, 20.88)];
            [bezierPath addLineToPoint: CGPointMake(34.92, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(45.75, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(57.5, 19.96)];
            [bezierPath addLineToPoint: CGPointMake(57.5, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(54.97, 22.49)];
            [bezierPath addLineToPoint: CGPointMake(48.29, 24.1)];
            [bezierPath addLineToPoint: CGPointMake(42.53, 25.02)];
            [bezierPath addLineToPoint: CGPointMake(34.92, 25.71)];
            [bezierPath addLineToPoint: CGPointMake(27.55, 27.32)];
            [bezierPath addLineToPoint: CGPointMake(22.25, 28.7)];
            [bezierPath addLineToPoint: CGPointMake(18.34, 32.14)];
            [bezierPath addLineToPoint: CGPointMake(19.49, 35.13)];
            [bezierPath addLineToPoint: CGPointMake(20.41, 39.27)];
            [bezierPath addLineToPoint: CGPointMake(21.56, 41.8)];
            [bezierPath addLineToPoint: CGPointMake(23.64, 44.56)];
            [bezierPath addLineToPoint: CGPointMake(25.71, 40.88)];
            [bezierPath addLineToPoint: CGPointMake(28.47, 36.74)];
            [bezierPath addLineToPoint: CGPointMake(30.32, 36.74)];
            [bezierPath addLineToPoint: CGPointMake(28.47, 39.27)];
            [bezierPath addLineToPoint: CGPointMake(27.55, 43.18)];
            [bezierPath addLineToPoint: CGPointMake(25.71, 48.47)];
            [bezierPath addLineToPoint: CGPointMake(26.86, 50.3)];
            [bezierPath addLineToPoint: CGPointMake(28.47, 53.52)];
            [bezierPath addLineToPoint: CGPointMake(30.32, 54.9)];
            [bezierPath addLineToPoint: CGPointMake(31.24, 56.28)];
            [bezierPath addLineToPoint: CGPointMake(28.47, 57.89)];
            [bezierPath addLineToPoint: CGPointMake(26.86, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(24.33, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(25.02, 56.28)];
            [bezierPath addLineToPoint: CGPointMake(22.95, 53.52)];
            [bezierPath addLineToPoint: CGPointMake(20.41, 49.39)];
            [bezierPath addLineToPoint: CGPointMake(18.34, 44.56)];
            [bezierPath addLineToPoint: CGPointMake(14.88, 39.27)];
            [bezierPath addLineToPoint: CGPointMake(13.5, 32.14)];
            [bezierPath addLineToPoint: CGPointMake(13.5, 29.84)];
            [bezierPath closePath];
            [materialColor setFill];
            [bezierPath fill];
            [UIColor.blackColor setStroke];
            bezierPath.lineWidth = 1;
            [bezierPath stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(16.49, 30.99)];
            [bezier2Path addLineToPoint: CGPointMake(18.11, 27.78)];
            [bezier2Path addLineToPoint: CGPointMake(20.87, 25.02)];
            [bezier2Path addLineToPoint: CGPointMake(20.87, 20.65)];
            [bezier2Path addLineToPoint: CGPointMake(22.71, 14.21)];
            [UIColor.blackColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(14.42, 20.65)];
            [bezier3Path addLineToPoint: CGPointMake(15.11, 30.3)];
            [bezier3Path addLineToPoint: CGPointMake(16.26, 38.35)];
            [bezier3Path addLineToPoint: CGPointMake(21.33, 47.55)];
            [bezier3Path addLineToPoint: CGPointMake(28.01, 55.13)];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(22.02, 28.24)];
            [bezier4Path addLineToPoint: CGPointMake(27.78, 25.25)];
            [bezier4Path addLineToPoint: CGPointMake(33.08, 20.88)];
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(26.17, 54.9)];
            [bezier5Path addLineToPoint: CGPointMake(26.17, 56.51)];
            [bezier5Path addLineToPoint: CGPointMake(27.55, 58.35)];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(25.48, 57.66)];
            [bezier6Path addLineToPoint: CGPointMake(25.48, 59.5)];
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(27.09, 56.05)];
            [bezier7Path addLineToPoint: CGPointMake(27.78, 56.97)];
            [bezier7Path addLineToPoint: CGPointMake(29.86, 56.97)];
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
        }

        
    } else if ([horn containsObject:material]) {
        
        // draw a horn **********************************************************************************
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.whiteColor];
        [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
        [shadow setShadowBlurRadius: 5];
        
        //// Horn
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(1.5, 1.5)];
            [bezierPath addLineToPoint: CGPointMake(1.5, 9.96)];
            [bezierPath addLineToPoint: CGPointMake(5.35, 23.25)];
            [bezierPath addLineToPoint: CGPointMake(11.76, 42.58)];
            [bezierPath addLineToPoint: CGPointMake(29.72, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(45.11, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(52.8, 55.88)];
            [bezierPath addLineToPoint: CGPointMake(60.5, 45)];
            [bezierPath addLineToPoint: CGPointMake(56.65, 32.92)];
            [bezierPath addLineToPoint: CGPointMake(45.11, 23.25)];
            [bezierPath addLineToPoint: CGPointMake(27.15, 9.96)];
            [bezierPath addLineToPoint: CGPointMake(11.76, 1.5)];
            [bezierPath addLineToPoint: CGPointMake(7.91, 5.12)];
            [bezierPath addLineToPoint: CGPointMake(1.5, 1.5)];
            [bezierPath closePath];
            [materialColor setFill];
            [bezierPath fill];
            
            ////// Bezier Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezierPath.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
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
            [bezier2Path moveToPoint: CGPointMake(32.28, 58.29)];
            [bezier2Path addLineToPoint: CGPointMake(32.28, 51.04)];
            [bezier2Path addLineToPoint: CGPointMake(39.98, 45)];
            [bezier2Path addLineToPoint: CGPointMake(51.52, 34.12)];
            [bezier2Path addLineToPoint: CGPointMake(56.65, 34.12)];
            [bezier2Path addLineToPoint: CGPointMake(56.65, 45)];
            [bezier2Path addLineToPoint: CGPointMake(47.67, 54.67)];
            [bezier2Path addLineToPoint: CGPointMake(39.98, 58.29)];
            [bezier2Path addLineToPoint: CGPointMake(32.28, 58.29)];
            [bezier2Path addLineToPoint: CGPointMake(32.28, 58.29)];
            [bezier2Path closePath];
            [UIColor.darkGrayColor setFill];
            [bezier2Path fill];
            [UIColor.blackColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(33.57, 45)];
            [bezier3Path addLineToPoint: CGPointMake(39.98, 37.75)];
            [bezier3Path addLineToPoint: CGPointMake(42.54, 32.92)];
            [bezier3Path addLineToPoint: CGPointMake(51.52, 29.29)];
            [UIColor.darkGrayColor setFill];
            [bezier3Path fill];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(24.59, 41.38)];
            [bezier4Path addLineToPoint: CGPointMake(32.28, 34.12)];
            [bezier4Path addLineToPoint: CGPointMake(34.85, 29.29)];
            [bezier4Path addLineToPoint: CGPointMake(45.11, 23.25)];
            [UIColor.darkGrayColor setFill];
            [bezier4Path fill];
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(13.04, 40.17)];
            [bezier5Path addLineToPoint: CGPointMake(19.46, 36.54)];
            [bezier5Path addLineToPoint: CGPointMake(28.43, 28.08)];
            [UIColor.darkGrayColor setFill];
            [bezier5Path fill];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(25.87, 43.79)];
            [bezier6Path addLineToPoint: CGPointMake(25.87, 47.42)];
            [bezier6Path addLineToPoint: CGPointMake(28.43, 53.46)];
            [UIColor.darkGrayColor setFill];
            [bezier6Path fill];
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(9.2, 5.12)];
            [bezier7Path addLineToPoint: CGPointMake(14.33, 11.17)];
            [bezier7Path addLineToPoint: CGPointMake(14.33, 22.04)];
            [bezier7Path addLineToPoint: CGPointMake(14.33, 22.04)];
            [UIColor.darkGrayColor setFill];
            [bezier7Path fill];
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
            
            
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(22.02, 16)];
            [bezier8Path addLineToPoint: CGPointMake(28.43, 22.04)];
            [bezier8Path addLineToPoint: CGPointMake(36.13, 18.42)];
            [UIColor.darkGrayColor setFill];
            [bezier8Path fill];
            [UIColor.blackColor setStroke];
            bezier8Path.lineWidth = 1;
            [bezier8Path stroke];
        }
        
    } else if ([organic containsObject:material]) {
        
        // draw a log **********************************************************************************
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Group
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, -5, 26.5);
            CGContextRotateCTM(context, -27.37 * M_PI / 180);
            
            
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(7.28, 9.03)];
            [bezierPath addLineToPoint: CGPointMake(17.82, 9.03)];
            [bezierPath addLineToPoint: CGPointMake(27.36, 12.22)];
            [bezierPath addLineToPoint: CGPointMake(40.92, 9.03)];
            [bezierPath addLineToPoint: CGPointMake(40.92, 0)];
            [bezierPath addLineToPoint: CGPointMake(44.44, 3.19)];
            [bezierPath addLineToPoint: CGPointMake(44.44, 9.03)];
            [bezierPath addLineToPoint: CGPointMake(54.48, 6.91)];
            [bezierPath addLineToPoint: CGPointMake(57.99, 12.22)];
            [bezierPath addLineToPoint: CGPointMake(57.99, 14.34)];
            [bezierPath addLineToPoint: CGPointMake(59.5, 14.34)];
            [bezierPath addLineToPoint: CGPointMake(59.5, 19.12)];
            [bezierPath addLineToPoint: CGPointMake(57.99, 27.09)];
            [bezierPath addLineToPoint: CGPointMake(54.48, 27.09)];
            [bezierPath addLineToPoint: CGPointMake(57.99, 28.69)];
            [bezierPath addLineToPoint: CGPointMake(54.48, 30.81)];
            [bezierPath addLineToPoint: CGPointMake(38.91, 30.81)];
            [bezierPath addLineToPoint: CGPointMake(34.39, 32.41)];
            [bezierPath addLineToPoint: CGPointMake(17.82, 34)];
            [bezierPath addLineToPoint: CGPointMake(7.28, 32.41)];
            [bezierPath addLineToPoint: CGPointMake(7.28, 9.03)];
            [bezierPath closePath];
            [materialColor setFill];
            [bezierPath fill];
            [UIColor.blackColor setStroke];
            bezierPath.lineWidth = 1;
            [bezierPath stroke];
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 9.5, 13, 23)];
            [materialColor setFill];
            [ovalPath fill];
            [UIColor.blackColor setStroke];
            ovalPath.lineWidth = 1;
            [ovalPath stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(13.81, 16.47)];
            [bezier2Path addLineToPoint: CGPointMake(19.83, 16.47)];
            [bezier2Path addLineToPoint: CGPointMake(23.35, 18.06)];
            [bezier2Path addLineToPoint: CGPointMake(31.88, 20.19)];
            [bezier2Path addLineToPoint: CGPointMake(40.42, 16.47)];
            [bezier2Path addLineToPoint: CGPointMake(45.94, 16.47)];
            [UIColor.blackColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(12.3, 28.69)];
            [bezier3Path addLineToPoint: CGPointMake(17.82, 34)];
            [bezier3Path addLineToPoint: CGPointMake(30.38, 26.56)];
            [bezier3Path addLineToPoint: CGPointMake(40.42, 24.97)];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(42.43, 4.25)];
            [bezier5Path addLineToPoint: CGPointMake(43.93, 4.25)];
            [bezier5Path addLineToPoint: CGPointMake(43.93, 4.25)];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(58.5, 13.28)];
            [bezier6Path addLineToPoint: CGPointMake(45.94, 13.28)];
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(26.86, 11.69)];
            [bezier7Path addLineToPoint: CGPointMake(33.89, 14.34)];
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
            
            
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(6.28, 9.03)];
            [bezier8Path addLineToPoint: CGPointMake(8.79, 11.69)];
            [bezier8Path addLineToPoint: CGPointMake(11.3, 15.94)];
            [bezier8Path addLineToPoint: CGPointMake(11.3, 21.25)];
            [bezier8Path addLineToPoint: CGPointMake(11.3, 25.5)];
            [bezier8Path addLineToPoint: CGPointMake(8.79, 30.28)];
            [bezier8Path addLineToPoint: CGPointMake(6.28, 31.88)];
            [bezier8Path addLineToPoint: CGPointMake(2.26, 30.28)];
            [UIColor.blackColor setStroke];
            bezier8Path.lineWidth = 1;
            [bezier8Path stroke];
            
            
            
            CGContextRestoreGState(context);
        }

        
    } else if ([exotic containsObject:material]) {
        
        // draw a "exotic" icon thingy, like a pearl ************************************************************
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.whiteColor];
        [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
        [shadow setShadowBlurRadius: 5];
        NSShadow* shadow3 = [[NSShadow alloc] init];
        [shadow3 setShadowColor: UIColor.blackColor];
        [shadow3 setShadowOffset: CGSizeMake(5.1, 5.1)];
        [shadow3 setShadowBlurRadius: 5];
        
        //// Group
        {
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 60, 60)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius, [shadow3.shadowColor CGColor]);
            [materialColor setFill];
            [ovalPath fill];
            
            ////// Oval Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(ovalPath.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [ovalPath fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
            
        }

        
    } else if ([synthetic containsObject:material]) {
        
        // draw an Escher shape for synthetic stuff ************************************************************
        
        
        //// Group
        {
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(30.56, 29.56)];
            [bezier6Path addLineToPoint: CGPointMake(25.98, 37.39)];
            [bezier6Path addLineToPoint: CGPointMake(35.86, 37.39)];
            [bezier6Path addLineToPoint: CGPointMake(30.56, 29.56)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint: CGPointMake(36.04, 3.62)];
            [bezier6Path addLineToPoint: CGPointMake(60.5, 46.24)];
            [bezier6Path addLineToPoint: CGPointMake(57.61, 55.5)];
            [bezier6Path addLineToPoint: CGPointMake(6.52, 55.5)];
            [bezier6Path addLineToPoint: CGPointMake(0.5, 46.24)];
            [bezier6Path addCurveToPoint: CGPointMake(20.31, 11.88) controlPoint1: CGPointMake(0.5, 46.24) controlPoint2: CGPointMake(13.17, 24.27)];
            [bezier6Path addCurveToPoint: CGPointMake(25.08, 3.62) controlPoint1: CGPointMake(23.12, 7.01) controlPoint2: CGPointMake(25.08, 3.62)];
            [bezier6Path addLineToPoint: CGPointMake(36.04, 3.62)];
            [bezier6Path addLineToPoint: CGPointMake(36.04, 3.62)];
            [bezier6Path closePath];
            [materialColor setFill];
            [bezier6Path fill];
            [UIColor.whiteColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(35.8, 3.5)];
            [bezier2Path addLineToPoint: CGPointMake(15.92, 37.57)];
            [bezier2Path addLineToPoint: CGPointMake(35.8, 37.57)];
            [bezier2Path addLineToPoint: CGPointMake(35.8, 37.57)];
            [bezier2Path addLineToPoint: CGPointMake(35.8, 37.57)];
            [UIColor.whiteColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(25.92, 37.45)];
            [bezier3Path addLineToPoint: CGPointMake(35.68, 20.48)];
            [bezier3Path addLineToPoint: CGPointMake(57.61, 55.5)];
            [bezier3Path addLineToPoint: CGPointMake(55.68, 55.5)];
            [UIColor.whiteColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(30.62, 29.5)];
            [bezier4Path addLineToPoint: CGPointMake(42.43, 46.95)];
            [bezier4Path addLineToPoint: CGPointMake(1.83, 46.95)];
            [UIColor.whiteColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
        }

        
    } else { //if ([mineral containsObject:material]) {
        
        if (![mineral containsObject:material]) {
            // log that there is clearly some sort of issue at hand
            NSLog(@"material not found in list for material view: %@", material);
        }
        
        // draw a mineral / rock shape **************************************************************************
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.whiteColor];
        [shadow setShadowOffset: CGSizeMake(3.1, 3.1)];
        [shadow setShadowBlurRadius: 5];
        
        //// Group
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(12.72, 6.17)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 16.17)];
            [bezierPath addLineToPoint: CGPointMake(0.5, 30.61)];
            [bezierPath addLineToPoint: CGPointMake(7.17, 49.5)];
            [bezierPath addLineToPoint: CGPointMake(23.83, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(49.39, 59.5)];
            [bezierPath addLineToPoint: CGPointMake(60.5, 37.28)];
            [bezierPath addLineToPoint: CGPointMake(53.83, 2.83)];
            [bezierPath addLineToPoint: CGPointMake(30.5, -0.5)];
            [bezierPath addLineToPoint: CGPointMake(21.61, 6.17)];
            [bezierPath addLineToPoint: CGPointMake(12.72, 6.17)];
            [bezierPath closePath];
            [UIColor.grayColor setFill];
            [bezierPath fill];
            
            ////// Bezier Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezierPath.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
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
            [bezier2Path moveToPoint: CGPointMake(13.83, 6.17)];
            [bezier2Path addLineToPoint: CGPointMake(22.72, 17.28)];
            [bezier2Path addLineToPoint: CGPointMake(22.72, 27.28)];
            [bezier2Path addLineToPoint: CGPointMake(13.83, 33.94)];
            [bezier2Path addLineToPoint: CGPointMake(0.5, 30.61)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.grayColor setFill];
            [bezier2Path fill];
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(22.72, 17.28)];
            [bezier3Path addLineToPoint: CGPointMake(32.72, 18.39)];
            [bezier3Path addLineToPoint: CGPointMake(21.61, 6.17)];
            [bezier3Path addLineToPoint: CGPointMake(23.83, 6.17)];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(54.94, 2.83)];
            [bezier4Path addLineToPoint: CGPointMake(43.83, 21.72)];
            [bezier4Path addLineToPoint: CGPointMake(47.17, 41.72)];
            [bezier4Path addLineToPoint: CGPointMake(60.5, 37.28)];
            [UIColor.grayColor setFill];
            [bezier4Path fill];
            
            ////// Bezier 4 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier4Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier4Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(33.83, 17.28)];
            [bezier5Path addLineToPoint: CGPointMake(43.83, 21.72)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.grayColor setFill];
            [bezier5Path fill];
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(14.94, 32.83)];
            [bezier6Path addLineToPoint: CGPointMake(14.94, 40.61)];
            [bezier6Path addLineToPoint: CGPointMake(29.39, 43.94)];
            [bezier6Path addLineToPoint: CGPointMake(23.83, 59.5)];
            [UIColor.grayColor setFill];
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
            
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(30.5, 43.94)];
            [bezier7Path addLineToPoint: CGPointMake(38.28, 33.94)];
            [bezier7Path addLineToPoint: CGPointMake(22.72, 27.28)];
            [UIColor.grayColor setFill];
            [bezier7Path fill];
            
            ////// Bezier 7 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier7Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier7Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
            
            
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(39.39, 32.83)];
            [bezier8Path addLineToPoint: CGPointMake(39.39, 49.5)];
            [bezier8Path addLineToPoint: CGPointMake(49.39, 59.5)];
            [bezier8Path addLineToPoint: CGPointMake(49.39, 58.39)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [materialColor setFill];
            [bezier8Path fill];
            
            ////// Bezier 8 Inner Shadow
            CGContextSaveGState(context);
            UIRectClip(bezier8Path.bounds);
            CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
            
            CGContextSetAlpha(context, CGColorGetAlpha([shadow.shadowColor CGColor]));
            CGContextBeginTransparencyLayer(context, NULL);
            {
                UIColor* opaqueShadow = [shadow.shadowColor colorWithAlphaComponent: 1];
                CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [opaqueShadow CGColor]);
                CGContextSetBlendMode(context, kCGBlendModeSourceOut);
                CGContextBeginTransparencyLayer(context, NULL);
                
                [opaqueShadow setFill];
                [bezier8Path fill];
                
                CGContextEndTransparencyLayer(context);
            }
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
            
            [UIColor.blackColor setStroke];
            bezier8Path.lineWidth = 1;
            [bezier8Path stroke];
        }

    }
}

@end

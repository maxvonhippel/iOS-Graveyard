//
//  OwnWantView.m
//  cutlery
//
//  Created by Max von Hippel on 8/25/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "OwnWantView.h"
#import "OwnWantStyleKit.h"

@implementation OwnWantView
@synthesize curKnife, backgroundColor;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (!curKnife)
        return;
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 50, 50)];
    if (backgroundColor)
        [backgroundColor setFill];
    else [[UIColor clearColor] setFill];
    [rectanglePath fill];
    
    // Drawing code
    if (curKnife.ownIt) {
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.614 green: 0.384 blue: 0.098 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 0.536 green: 0.374 blue: 0.27 alpha: 1];
        UIColor* color3 = [UIColor colorWithRed: 0.496 green: 0.299 blue: 0.142 alpha: 1];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.blackColor];
        [shadow setShadowOffset: CGSizeMake(-2.1, -1.1)];
        [shadow setShadowBlurRadius: 2];
        
        //// Group 2
        {
            //// Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(14.63, 25.82)];
                [bezierPath addLineToPoint: CGPointMake(27.15, 19.5)];
                [bezierPath addLineToPoint: CGPointMake(47.5, 49.5)];
                [bezierPath addLineToPoint: CGPointMake(41.24, 49.5)];
                [bezierPath addLineToPoint: CGPointMake(34.98, 48.71)];
                [bezierPath addLineToPoint: CGPointMake(28.72, 45.55)];
                [bezierPath addLineToPoint: CGPointMake(18.54, 39.24)];
                [bezierPath addLineToPoint: CGPointMake(11.5, 27.39)];
                [bezierPath addLineToPoint: CGPointMake(14.63, 25.82)];
                [bezierPath closePath];
                [color setFill];
                [bezierPath fill];
                [UIColor.blackColor setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(27.15, 22.66)];
                [bezier2Path addLineToPoint: CGPointMake(44.37, 47.92)];
                [bezier2Path addLineToPoint: CGPointMake(38.11, 47.92)];
                [bezier2Path addLineToPoint: CGPointMake(31.85, 45.55)];
                [bezier2Path addLineToPoint: CGPointMake(20.11, 38.45)];
                [bezier2Path addLineToPoint: CGPointMake(13.85, 28.18)];
                [bezier2Path addLineToPoint: CGPointMake(13.85, 28.18)];
                bezier2Path.lineCapStyle = kCGLineCapRound;
                
                bezier2Path.lineJoinStyle = kCGLineJoinBevel;
                
                [color setFill];
                [bezier2Path fill];
                [UIColor.blackColor setStroke];
                bezier2Path.lineWidth = 1;
                [bezier2Path stroke];
            }
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(12.77, 26.17)];
            [bezier3Path addLineToPoint: CGPointMake(10.67, 21.92)];
            [bezier3Path addLineToPoint: CGPointMake(7.51, 18.74)];
            [bezier3Path addLineToPoint: CGPointMake(3.3, 16.62)];
            [bezier3Path addLineToPoint: CGPointMake(3.3, 12.38)];
            [bezier3Path addLineToPoint: CGPointMake(7.51, 7.08)];
            [bezier3Path addLineToPoint: CGPointMake(14.88, 7.08)];
            [bezier3Path addLineToPoint: CGPointMake(20.14, 10.26)];
            [bezier3Path addLineToPoint: CGPointMake(20.14, 13.44)];
            [bezier3Path addLineToPoint: CGPointMake(23.3, 17.68)];
            [bezier3Path addLineToPoint: CGPointMake(27.51, 19.8)];
            [bezier3Path addLineToPoint: CGPointMake(12.77, 26.17)];
            [bezier3Path closePath];
            [color2 setFill];
            [bezier3Path fill];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 9 Drawing
            UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
            [bezier9Path moveToPoint: CGPointMake(14.13, 25.86)];
            [bezier9Path addLineToPoint: CGPointMake(3.3, 9.5)];
            [bezier9Path addLineToPoint: CGPointMake(1.5, 8.59)];
            [bezier9Path addLineToPoint: CGPointMake(9.62, -0.5)];
            [bezier9Path addLineToPoint: CGPointMake(14.13, 1.32)];
            [bezier9Path addLineToPoint: CGPointMake(13.23, 4.95)];
            [bezier9Path addLineToPoint: CGPointMake(20.44, 17.68)];
            [bezier9Path addLineToPoint: CGPointMake(30.36, 15.86)];
            [bezier9Path addLineToPoint: CGPointMake(30.36, 17.68)];
            [bezier9Path addLineToPoint: CGPointMake(14.13, 25.86)];
            [bezier9Path closePath];
            
            // use handle color of actual knife ------------------------------------------------------
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
            
            [handleColor setFill];
            [bezier9Path fill];
            [UIColor.blackColor setStroke];
            bezier9Path.lineWidth = 1;
            [bezier9Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(6.46, 16.62)];
            [bezier5Path addLineToPoint: CGPointMake(9.62, 19.8)];
            [bezier5Path addLineToPoint: CGPointMake(18.04, 16.62)];
            [bezier5Path addLineToPoint: CGPointMake(18.04, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path closePath];
            [color3 setFill];
            [bezier5Path fill];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(9.62, 8.14)];
            [bezier4Path addLineToPoint: CGPointMake(6.46, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(9.62, 14.5)];
            [bezier4Path addLineToPoint: CGPointMake(12.77, 14.5)];
            [bezier4Path addLineToPoint: CGPointMake(16.98, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(19.09, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(19.09, 7.08)];
            [bezier4Path addLineToPoint: CGPointMake(12.77, 4.95)];
            [bezier4Path addLineToPoint: CGPointMake(9.62, 8.14)];
            [bezier4Path closePath];
            [color setFill];
            [bezier4Path fill];
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9.5, 9.5, 5, 4)];
            [UIColor.darkGrayColor setFill];
            [ovalPath fill];
            [UIColor.blackColor setStroke];
            ovalPath.lineWidth = 1;
            [ovalPath stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(19.09, 15.56)];
            [bezier6Path addLineToPoint: CGPointMake(21.19, 19.8)];
            [bezier6Path addLineToPoint: CGPointMake(21.19, 19.8)];
            [color3 setFill];
            [bezier6Path fill];
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(13.83, 18.74)];
            [bezier7Path addLineToPoint: CGPointMake(15.93, 21.92)];
            [color3 setFill];
            [bezier7Path fill];
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
            
            
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(14.88, 24.05)];
            [bezier8Path addLineToPoint: CGPointMake(24.35, 19.8)];
            [bezier8Path addLineToPoint: CGPointMake(24.35, 19.8)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.blackColor setStroke];
            bezier8Path.lineWidth = 1;
            [bezier8Path stroke];
            CGContextRestoreGState(context);
        }

    } else {
        
        //// General Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.614 green: 0.384 blue: 0.098 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 0.536 green: 0.374 blue: 0.27 alpha: 1];
        UIColor* color3 = [UIColor colorWithRed: 0.496 green: 0.299 blue: 0.142 alpha: 1];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: UIColor.blackColor];
        [shadow setShadowOffset: CGSizeMake(-2.1, -1.1)];
        [shadow setShadowBlurRadius: 2];
        
        //// Group 2
        {
            //// Group
            {
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(14.63, 25.82)];
                [bezierPath addLineToPoint: CGPointMake(27.15, 19.5)];
                [bezierPath addLineToPoint: CGPointMake(47.5, 49.5)];
                [bezierPath addLineToPoint: CGPointMake(41.24, 49.5)];
                [bezierPath addLineToPoint: CGPointMake(34.98, 48.71)];
                [bezierPath addLineToPoint: CGPointMake(28.72, 45.55)];
                [bezierPath addLineToPoint: CGPointMake(18.54, 39.24)];
                [bezierPath addLineToPoint: CGPointMake(11.5, 27.39)];
                [bezierPath addLineToPoint: CGPointMake(14.63, 25.82)];
                [bezierPath closePath];
                [color setFill];
                [bezierPath fill];
                [UIColor.blackColor setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(27.15, 22.66)];
                [bezier2Path addLineToPoint: CGPointMake(44.37, 47.92)];
                [bezier2Path addLineToPoint: CGPointMake(38.11, 47.92)];
                [bezier2Path addLineToPoint: CGPointMake(31.85, 45.55)];
                [bezier2Path addLineToPoint: CGPointMake(20.11, 38.45)];
                [bezier2Path addLineToPoint: CGPointMake(13.85, 28.18)];
                [bezier2Path addLineToPoint: CGPointMake(13.85, 28.18)];
                bezier2Path.lineCapStyle = kCGLineCapRound;
                
                bezier2Path.lineJoinStyle = kCGLineJoinBevel;
                
                [color setFill];
                [bezier2Path fill];
                [UIColor.blackColor setStroke];
                bezier2Path.lineWidth = 1;
                [bezier2Path stroke];
            }
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(12.77, 26.17)];
            [bezier3Path addLineToPoint: CGPointMake(10.67, 21.92)];
            [bezier3Path addLineToPoint: CGPointMake(7.51, 18.74)];
            [bezier3Path addLineToPoint: CGPointMake(3.3, 16.62)];
            [bezier3Path addLineToPoint: CGPointMake(3.3, 12.38)];
            [bezier3Path addLineToPoint: CGPointMake(7.51, 7.08)];
            [bezier3Path addLineToPoint: CGPointMake(14.88, 7.08)];
            [bezier3Path addLineToPoint: CGPointMake(20.14, 10.26)];
            [bezier3Path addLineToPoint: CGPointMake(20.14, 13.44)];
            [bezier3Path addLineToPoint: CGPointMake(23.3, 17.68)];
            [bezier3Path addLineToPoint: CGPointMake(27.51, 19.8)];
            [bezier3Path addLineToPoint: CGPointMake(12.77, 26.17)];
            [bezier3Path closePath];
            [color2 setFill];
            [bezier3Path fill];
            [UIColor.blackColor setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(6.46, 16.62)];
            [bezier5Path addLineToPoint: CGPointMake(9.62, 19.8)];
            [bezier5Path addLineToPoint: CGPointMake(18.04, 16.62)];
            [bezier5Path addLineToPoint: CGPointMake(18.04, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path addLineToPoint: CGPointMake(7.51, 11.32)];
            [bezier5Path closePath];
            [color3 setFill];
            [bezier5Path fill];
            [UIColor.blackColor setStroke];
            bezier5Path.lineWidth = 1;
            [bezier5Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(9.62, 8.14)];
            [bezier4Path addLineToPoint: CGPointMake(6.46, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(9.62, 14.5)];
            [bezier4Path addLineToPoint: CGPointMake(12.77, 14.5)];
            [bezier4Path addLineToPoint: CGPointMake(16.98, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(19.09, 11.32)];
            [bezier4Path addLineToPoint: CGPointMake(19.09, 7.08)];
            [bezier4Path addLineToPoint: CGPointMake(12.77, 4.95)];
            [bezier4Path addLineToPoint: CGPointMake(9.62, 8.14)];
            [bezier4Path closePath];
            [color setFill];
            [bezier4Path fill];
            [UIColor.blackColor setStroke];
            bezier4Path.lineWidth = 1;
            [bezier4Path stroke];
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9.5, 9.5, 5, 4)];
            [UIColor.darkGrayColor setFill];
            [ovalPath fill];
            [UIColor.blackColor setStroke];
            ovalPath.lineWidth = 1;
            [ovalPath stroke];
            
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(19.09, 15.56)];
            [bezier6Path addLineToPoint: CGPointMake(21.19, 19.8)];
            [bezier6Path addLineToPoint: CGPointMake(21.19, 19.8)];
            [color3 setFill];
            [bezier6Path fill];
            [UIColor.blackColor setStroke];
            bezier6Path.lineWidth = 1;
            [bezier6Path stroke];
            
            
            //// Bezier 7 Drawing
            UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
            [bezier7Path moveToPoint: CGPointMake(13.83, 18.74)];
            [bezier7Path addLineToPoint: CGPointMake(15.93, 21.92)];
            [color3 setFill];
            [bezier7Path fill];
            [UIColor.blackColor setStroke];
            bezier7Path.lineWidth = 1;
            [bezier7Path stroke];
            
            
            //// Bezier 8 Drawing
            UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
            [bezier8Path moveToPoint: CGPointMake(14.88, 24.05)];
            [bezier8Path addLineToPoint: CGPointMake(24.35, 19.8)];
            [bezier8Path addLineToPoint: CGPointMake(24.35, 19.8)];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            [UIColor.blackColor setStroke];
            bezier8Path.lineWidth = 1;
            [bezier8Path stroke];
            CGContextRestoreGState(context);
        }

    }
}


@end

//
//  ParticularCardView.m
//  Card Creator
//
//  Created by Max von Hippel on 7/17/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ParticularCardView.h"
#import "EthansStyleKit.h"

@implementation ParticularCardView
@synthesize curCard;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 7. Generate the card graphics and present them to the user
    // code written using PaintCode on OSX
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.146 green: 0.135 blue: 0.135 alpha: 1];
    
    //// Gradient Declarations
    CGFloat gradientBlueLocations[] = {0.11, 0.75, 0.92};
    CGGradientRef gradientBlue = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.blueColor.CGColor, (id)[UIColor.blueColor blendedColorWithFraction: 0.5 ofColor: UIColor.whiteColor].CGColor, (id)UIColor.whiteColor.CGColor], gradientBlueLocations);
    CGFloat gradientLocations[] = {0, 0.32, 0.88};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)UIColor.redColor.CGColor, (id)[UIColor.redColor blendedColorWithFraction: 0.5 ofColor: UIColor.whiteColor].CGColor, (id)UIColor.whiteColor.CGColor], gradientLocations);
    
    //// Image Declarations
    UIImage* image = curCard.picture;
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 640, 960) cornerRadius: 39];
    [color setFill];
    [rectanglePath fill];
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(109, 108, 423, 241) cornerRadius: 39];
    CGContextSaveGState(context);
    [rectangle2Path addClip];
    [image drawInRect: CGRectMake(109, 108, image.size.width, image.size.height)];
    CGContextRestoreGState(context);
    [UIColor.whiteColor setStroke];
    rectangle2Path.lineWidth = 1;
    [rectangle2Path stroke];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(29, 19, 583, 75);
    {
        NSString* textContent = curCard.name;
        NSMutableParagraphStyle* textStyle = [NSMutableParagraphStyle new];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 39], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(109, 361, 423, 246);
    NSMutableParagraphStyle* text2Style = [NSMutableParagraphStyle new];
    text2Style.alignment = NSTextAlignmentLeft;
    
    NSDictionary* text2FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: text2Style};
    
    [curCard.information drawInRect: text2Rect withAttributes: text2FontAttributes];
    
    
    //// Text 3 Drawing
    CGRect text3Rect = CGRectMake(109, 623, 423, 170);
    NSMutableParagraphStyle* text3Style = [NSMutableParagraphStyle new];
    text3Style.alignment = NSTextAlignmentLeft;
    
    NSDictionary* text3FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: text3Style};
    
    [curCard.quote drawInRect: text3Rect withAttributes: text3FontAttributes];
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(564, 829, 51, 51)];
    CGContextSaveGState(context);
    [ovalPath addClip];
    CGContextDrawLinearGradient(context, gradientBlue, CGPointMake(589.5, 829), CGPointMake(589.5, 880), 0);
    CGContextRestoreGState(context);
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(564, 894, 51, 51)];
    CGContextSaveGState(context);
    [oval2Path addClip];
    CGContextDrawRadialGradient(context, gradient,
                                CGPointMake(594.93, 914.07), 10.85,
                                CGPointMake(584.07, 924.93), 32.55,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    //// Text 4 Drawing
    CGRect text4Rect = CGRectMake(574, 835, 32, 39);
    {
        NSString* textContent = [NSString stringWithFormat:@"%ld", (long)curCard.attack_points];
        NSMutableParagraphStyle* text4Style = [NSMutableParagraphStyle new];
        text4Style.alignment = NSTextAlignmentLeft;
        
        NSDictionary* text4FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: text4Style};
        
        CGFloat text4TextHeight = [textContent boundingRectWithSize: CGSizeMake(text4Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text4FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text4Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text4Rect), CGRectGetMinY(text4Rect) + (CGRectGetHeight(text4Rect) - text4TextHeight) / 2, CGRectGetWidth(text4Rect), text4TextHeight) withAttributes: text4FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 5 Drawing
    CGRect text5Rect = CGRectMake(574, 900, 32, 39);
    {
        NSString* textContent = [NSString stringWithFormat:@"%ld", (long)curCard.health_points];
        NSMutableParagraphStyle* text5Style = [NSMutableParagraphStyle new];
        text5Style.alignment = NSTextAlignmentLeft;
        
        NSDictionary* text5FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: text5Style};
        
        CGFloat text5TextHeight = [textContent boundingRectWithSize: CGSizeMake(text5Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text5FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text5Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text5Rect), CGRectGetMinY(text5Rect) + (CGRectGetHeight(text5Rect) - text5TextHeight) / 2, CGRectGetWidth(text5Rect), text5TextHeight) withAttributes: text5FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 6 Drawing
    CGRect text6Rect = CGRectMake(14, 889, 202, 60);
    {
        NSString* textContent = @"Catastrophic Kingdoms™\nEthan McGowan";
        NSMutableParagraphStyle* text6Style = [NSMutableParagraphStyle new];
        text6Style.alignment = NSTextAlignmentLeft;
        
        NSDictionary* text6FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: text6Style};
        
        CGFloat text6TextHeight = [textContent boundingRectWithSize: CGSizeMake(text6Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text6FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text6Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text6Rect), CGRectGetMinY(text6Rect) + (CGRectGetHeight(text6Rect) - text6TextHeight) / 2, CGRectGetWidth(text6Rect), text6TextHeight) withAttributes: text6FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Cleanup
    CGGradientRelease(gradientBlue);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end

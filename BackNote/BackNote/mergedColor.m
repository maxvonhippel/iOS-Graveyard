//
//  mergedColor.m
//  BackNote
//
//  Created by Max von Hippel on 2/23/14.
//  Copyright (c) 2014 Max von Hippel. All rights reserved.
//

#import "mergedColor.h"

@implementation mergedColor
+(UIColor *)mergedColor {
    CGImageRef rawImageRef = [self CGImage];
    
    // scale image to an one pixel image
    
    uint8_t  bitmapData[4];
    int bitmapByteCount;
    int bitmapBytesPerRow;
    int width = 1;
    int height = 1;
    
    bitmapBytesPerRow = (width * 4);
    bitmapByteCount = (bitmapBytesPerRow * height);
    memset(bitmapData, 0, bitmapByteCount);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate (bitmapData,width,height,8,bitmapBytesPerRow,
                                                  colorspace,kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorspace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextSetInterpolationQuality(context, kCGInterpolationMedium);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), rawImageRef);
    CGContextRelease(context);
    return [UIColor colorWithRed:bitmapData[2] / 255.0f
                           green:bitmapData[1] / 255.0f
                            blue:bitmapData[0] / 255.0f
                           alpha:1];
}
@end

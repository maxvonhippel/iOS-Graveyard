//
//  handle.h
//  cutlery
//
//  Created by Max von Hippel on 8/19/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnifeStyleKit.h"
#import "Knife.h"

@interface handle : UIView

@property (nonatomic) Knife* curKnife;

@property (nonatomic) UIColor* backgroundColor;

- (void) clearGraphics;

@end

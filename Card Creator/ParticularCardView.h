//
//  ParticularCardView.h
//  Card Creator
//
//  Created by Max von Hippel on 7/17/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface ParticularCardView : UIView
// note that I can't call it newCard for this reason: http://pinkstone.co.uk/how-to-fix-propertys-synthesized-getter-follows-cocoa-naming-convention-for-returning-owned-objects/

@property (nonatomic, strong) Card *curCard;
- (void)drawRect:(CGRect)rect;
@end

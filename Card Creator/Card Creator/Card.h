//
//  Card.h
//  Card Creator
//
//  Created by Max von Hippel on 6/24/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Card : NSObject <NSCoding>

@property UIImage* picture;         // rounded edges, picture of the card's content
@property NSString* name;           // name of the card
@property NSString* information;    // information about the card, what it does, etc.
@property NSInteger attack_points; // how many attack points it has
@property NSInteger health_points; // how many health points it has
@property NSString* quote;          // a quote about the card from some warrior or something

@end

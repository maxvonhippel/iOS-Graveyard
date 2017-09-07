//
//  Card.m
//  Card Creator
//
//  Created by Max von Hippel on 6/24/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize picture, name, information, attack_points, health_points, quote;

// encode and decode code comes from example here:
// http://www.idev101.com/code/Objective-C/Saving_Data/NSCoding.html

// encode a card to memory
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:picture forKey:@"picture"];
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:information forKey:@"information"];
    [coder encodeInteger:attack_points forKey:@"attack_points"];
    [coder encodeInteger:health_points forKey:@"health_points"];
    [coder encodeObject:quote forKey:@"quote"];
}

// decode a card from memory
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.picture = [coder decodeObjectForKey:@"picture"];
    self.name = [coder decodeObjectForKey:@"name"];
    self.information = [coder decodeObjectForKey:@"information"];
    self.attack_points = [coder decodeIntegerForKey:@"attack_points"];
    self.health_points = [coder decodeIntegerForKey:@"health_points"];
    self.quote = [coder decodeObjectForKey:@"quote"];
    return self;
}

@end

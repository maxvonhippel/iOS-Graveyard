//
//  Knife.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "Knife.h"

@implementation Knife
@synthesize name, blade, bladeMaterial, handleMaterial, fullTang, price, brand, bladeLength, ownIt;//, knifeImage;

- (BOOL)isEqual:(id)object {
    Knife* other_knife = (Knife*)object;
    if ([other_knife.name isEqualToString:self.name]
        && [other_knife.blade isEqualToString:self.blade]
        && [other_knife.bladeMaterial isEqualToString:self.bladeMaterial]
        && [other_knife.handleMaterial isEqualToString:self.handleMaterial]
        && other_knife.fullTang == self.fullTang
        && other_knife.price == self.price
        && [other_knife.brand isEqualToString:self.brand]
        && other_knife.bladeLength == self.bladeLength
        && other_knife.ownIt == self.ownIt)
        return true;
    else return false;
}

// take care of memory stuff
// encode and decode code comes from example here:
// http://www.idev101.com/code/Objective-C/Saving_Data/NSCoding.html

// encode to memory
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:blade forKey:@"blade"];
    [coder encodeObject:bladeMaterial forKey:@"bladeMaterial"];
    [coder encodeObject:handleMaterial forKey:@"handleMaterial"];
    [coder encodeBool:fullTang forKey:@"fullTang"];
    [coder encodeInteger:price forKey:@"price"];
    [coder encodeObject:brand forKey:@"brand"];
    [coder encodeInteger:bladeLength forKey:@"bladeLength"];
    [coder encodeBool:ownIt forKey:@"ownIt"];
    // [coder encodeObject:@"knifeImage" forKey:@"knifeImage"];
}

// decode a card from memory
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.name = [coder decodeObjectForKey:@"name"];
    self.blade = [coder decodeObjectForKey:@"blade"];
    self.bladeMaterial = [coder decodeObjectForKey:@"bladeMaterial"];
    self.fullTang = [coder decodeBoolForKey:@"fulLTang"];
    self.price = [coder decodeIntegerForKey:@"price"];
    self.brand = [coder decodeObjectForKey:@"brand"];
    self.bladeLength = [coder decodeIntegerForKey:@"bladeLength"];
    self.handleMaterial = [coder decodeObjectForKey:@"handleMaterial"];
    self.ownIt = [coder decodeBoolForKey:@"ownIt"];
    // self.knifeImage = [coder decodeObjectForKey:@"knifeImage"];
    return self;
}

@end

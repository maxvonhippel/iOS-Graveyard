//
//  Aircraft.m
//  CAS Calculator
//
//  Created by Max von Hippel on 8/12/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "Aircraft.h"

@implementation Aircraft
@synthesize name, grossWeight, KCASVLDM, maxGrossWeight, minGrossWeight;//, specificRange;

// encode and decode code comes from example here:
// http://www.idev101.com/code/Objective-C/Saving_Data/NSCoding.html

// encode a card to memory
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:grossWeight forKey:@"grossWeight"];
    [coder encodeObject:KCASVLDM forKey:@"KCASVLDM"];
    [coder encodeObject:maxGrossWeight forKey:@"maxWeight"];
    [coder encodeObject:minGrossWeight forKey:@"minWeight"];
    // [coder encodeObject:specificRange forKey:@"specificRange"];
}

// decode a card from memory
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.name = [coder decodeObjectForKey:@"name"];
    self.grossWeight = [coder decodeObjectForKey:@"grossWeight"];
    self.maxGrossWeight = [coder decodeObjectForKey:@"maxWeight"];
    self.minGrossWeight = [coder decodeObjectForKey:@"minWeight"];
    self.KCASVLDM = [coder decodeObjectForKey:@"KCASVLDM"];
    // self.specificRange = [coder decodeObjectForKey:@"specificRange"];
    return self;
}

@end

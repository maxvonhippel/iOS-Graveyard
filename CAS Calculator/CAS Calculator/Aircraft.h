//
//  Aircraft.h
//  CAS Calculator
//
//  Created by Max von Hippel on 8/12/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Aircraft : NSObject <NSCoding>

@property NSString* name;           // name of aircraft
@property NSNumber* grossWeight;    // gross weight of aircraft at determination of below V(L/D)max
@property NSNumber* KCASVLDM;       // V(L/D)max at above gross weight determination
@property NSNumber* maxGrossWeight; // the max gross weight of the aircraft
@property NSNumber* minGrossWeight; // the min gross weight of the aircraft
// @property NSNumber* specificRange;  // the SR of the aircraft at the given gross weight

@end

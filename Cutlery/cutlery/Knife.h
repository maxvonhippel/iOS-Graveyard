//
//  Knife.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Knife : NSObject

@property (nonatomic, retain) NSString* name;               // the model name of the knife, eg, Gryptillian
@property (nonatomic, retain) NSString* blade;              // the blade style, e.g, bowie, machete, drop point
@property (nonatomic, retain) NSString* bladeMaterial;      // the blade material, e.g, carbon fiber
@property (nonatomic, retain) NSString* handleMaterial;     // the handle material, e.g, rubber
@property (assign, nonatomic) BOOL fullTang;                        // YES if full tang, NO if not full tang
@property (nonatomic) NSInteger price;                     // MSRP
@property (nonatomic, retain) NSString* brand;              // brand name, e.g, Benchmade
@property (nonatomic) NSInteger bladeLength;               // blade length
@property (assign, nonatomic) BOOL ownIt;                           // own it?  Or wishlist?
// @property (nonatomic, retain) IBOutlet UIImage* knifeImage; // image of the knife



@end

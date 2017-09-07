//
//  PodcastEpisode.h
//  pod box
//
//  Created by Max von Hippel on 1/18/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PodcastEpisode : NSObject

@property NSString* name;       // the name of the podcast episode
@property NSDate* date;         // the date at which the podcast episode was saved
@property NSString* text;       // the text description of the podcast episode
@property NSURL* url;           // the url which points to the podcast episode website
@property NSURL* rss;           // the url which points to the podcast rss
@property NSString* filePath;   // the internal filePath of the podcast episode
@property NSString* notes;      // any notes the user has written about the podcast episode

// encode
- (void)encodeWithCoder:(NSCoder*)encoder;
// decode
- (id)initWithCoder:(NSCoder*)decoder;

@end

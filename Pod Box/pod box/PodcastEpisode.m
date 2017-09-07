//
//  PodcastEpisode.m
//  pod box
//
//  Created by Max von Hippel on 1/18/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import "PodcastEpisode.h"

@implementation PodcastEpisode
@synthesize name, date, text, url, rss, filePath, notes;

// --------------------------- coding -----------------------------------------

// encode
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:date forKey:@"date"];
    [encoder encodeObject:text forKey:@"text"];
    [encoder encodeObject:url forKey:@"url"];
    [encoder encodeObject:rss forKey:@"rss"];
    [encoder encodeObject:filePath forKey:@"filePath"];
    [encoder encodeObject:notes forKey:@"nodes"];
}

// decode
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init]))
    {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.text = [decoder decodeObjectForKey:@"text"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.rss = [decoder decodeObjectForKey:@"rss"];
        self.filePath = [decoder decodeObjectForKey:@"filePath"];
        self.notes = [decoder decodeObjectForKey:@"notes"];
    }
    return self;
}

@end

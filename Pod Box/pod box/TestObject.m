//
//  TestObject.m
//  pod box
//
//  Created by Max von Hippel on 2/5/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

-(void)test
{
    // failure ---- nprOne does not work.
    // NSString* nprOne = @"#1: The Single Straight Guy Focus Group http://one.npr.org/i/503752900:503752902";
    // overcast works!
    // NSString* overcast = @"The Stack Overflow Podcast: Stack Overflow Podcast #98 - Scott Hanselman Is Better Than Us at Everything https://overcast.fm/+FFX3qo_pE";
    // cast works!
    // NSString* casts = @"http://pca.st/episode/a4e53ae0-be5b-0134-10a8-25324e2a541d";
    // failure ---- tuneIn does not work
    // NSString* tuneIn = @"Listen to Charlotte Hornets at Boston Celtics : today on TuneIn http://tun.in/ph9Hq";
    // rssRadio works!
    // NSString* rssRadio = @"Hi\n\nThought you might like this episode of This American Life, entitled #577: Something Only I Can See.\n\nThis message was sent from RSSRadio, available on the iTunes app store. http://itunes.apple.com/us/app/rssradio-mobile/id679025359\n\n\nhttp://rssr.link/PhW";
    // failure - doesn't work yet, will maybe once I get itunes search or an alternative to work?
    // NSString* podBean = @"I feel like Sam Adeyemi sounds pretty good, what do you think?\nhttp://www.podbean.com/media/share/pb-ji34v-666bf1";
    // downCast works!
    // NSString* downCast = @"Listening to Wait Wait... Don't Tell Me! (Tom Hanks with Not My Job guest Simone Biles)\n\nTom Hanks is our guest host this week. He talks to Olympic Gold Medalist Simone Biles, along with panelists Paula Poundstone, Luke Burbank, and Faith Salie.\n\nhttp://waitwait.npr.libsynfusion.com/tom-hanks-with-not-my-job-guest-simone-biles";
    // apple works!
    // NSString* apple = @"http://power1051.iheart.com/podcast/itunes/breakfastclub_interviews_itunes.xml";
    // [self addEpisode:apple];
}

@end

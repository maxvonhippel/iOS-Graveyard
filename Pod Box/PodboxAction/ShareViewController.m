//
//  ShareViewController.m
//  PodboxAction
//
//  Created by Max von Hippel on 3/30/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//
//  Using tutorial from: http://www.technetexperts.com/mobile/share-extension-in-ios-application-overview-with-example/

#import "ShareViewController.h"
#import "PodcastEpisode.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

@end

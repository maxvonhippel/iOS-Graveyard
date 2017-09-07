//
//  EpisodeViewController.m
//  pod box
//
//  Created by Max von Hippel on 2/5/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import "EpisodeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>  
#import <AVFoundation/AVFoundation.h>

// note: look at these resources for future work
// kit for filetype identification
// https://github.com/aidansteele/MagicKit
// apple audio/video docs
// https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW1

@interface EpisodeViewController ()

@end

@implementation EpisodeViewController
@synthesize navigationBar, thumbnailImageView, metadataTextView, episode, filepath_full;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (episode == NULL)
    {
        // log an error
        NSLog(@"error: episode view initialized but not episode passed");
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        ViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    // set up view
    [navigationBar setTitle:episode.name];
    // thumbnail
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesFolder = paths[0];
    filepath_full = [cachesFolder stringByAppendingPathComponent:episode.filePath];
    NSURL* videoUrl = [NSURL URLWithString:filepath_full];
    AVAsset* asset = [AVAsset assetWithURL:videoUrl];
    NSLog(@"filepath: %@", filepath_full);
    if (asset.playable)
    {
        // is it a video?  audio?
        NSString *fileExtension = [videoUrl pathExtension];
        NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExtension, NULL);
        NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
        NSLog(@"file extension: %@\n\nUTI: %@\n\ncontent type: %@\n\n", fileExtension, UTI, contentType);
        
    }
    else if ([[NSFileManager defaultManager] fileExistsAtPath:episode.filePath])
    {
        // Borrowed from http://stackoverflow.com/questions/5996797/determine-mime-type-of-nsdata-loaded-from-a-file
        // itself, derived from  http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
        CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[episode.filePath pathExtension], NULL);
        CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
        CFRelease(UTI);
        if (!mimeType)
        {
            NSLog(@"application/octet-stream");
        }
        else
        {
            NSLog(@"mimetype: %@", (__bridge NSString *)((__bridge CFTypeRef _Nullable)((__bridge NSString *)mimeType)));
        }
    }
    
    BOOL hasVideo = [asset tracksWithMediaType:AVMediaTypeVideo].count > 0;
    BOOL hasAudio = [asset tracksWithMediaType:AVMediaTypeAudio].count > 0;
    @try
    {
        
        if (hasVideo)
        {
            NSLog(@"finding thumbnail for video");
            // get thumbnail from video
            AVURLAsset* asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
            AVAssetImageGenerator* generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
            NSError* error = NULL;
            CMTime time = CMTimeMake(1, 1);
            CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
            NSLog(@"error==%@, Refimage==%@", error, refImg);
            UIImage *frameImage= [[UIImage alloc] initWithCGImage:refImg];
            [thumbnailImageView setImage:frameImage];
            [self resizeThumbnailImageView];
        }
        else if (hasAudio && episode.url)
        {
            NSLog(@"finding image from favicon online");
            NSString* faviUrlString = [NSString stringWithFormat:@"http://www.google.com/s2/favicons?domain=%@", [episode.url absoluteString]];
            NSLog(@"favicon string: %@", faviUrlString);
            NSURL* faviUrl = [NSURL URLWithString:faviUrlString];
            NSData* faviData = [NSData dataWithContentsOfURL:faviUrl];
            UIImage* faviconImage = [[UIImage alloc] initWithData:faviData];
            if (faviconImage)
                [thumbnailImageView setImage:faviconImage];
            [self resizeThumbnailImageView];
        }
        [thumbnailImageView setNeedsDisplay];
    }
    @catch (NSException *exception)
    {
        [thumbnailImageView removeFromSuperview];
    }
    @finally
    {
        NSMutableArray* metaArray = [[NSMutableArray alloc] init];
        if (episode.name)
            [metaArray addObject:[NSString stringWithFormat:@"Episode Title: %@", episode.name]];
        if (episode.date)
            [metaArray addObject:[NSString stringWithFormat:@"Date Saved: %@", episode.date]];
        if (episode.text)
            [metaArray addObject:[NSString stringWithFormat:@"Description: %@", episode.text]];
        if (episode.notes)
            [metaArray addObject:[NSString stringWithFormat:@"Notes: %@", episode.notes]];
        if (episode.rss)
            [metaArray addObject:[NSString stringWithFormat:@"RSS URL: %@", [episode.rss absoluteString]]];
        if (episode.url)
            [metaArray addObject:[NSString stringWithFormat:@"Downloaded From URL: %@", [episode.url absoluteString]]];
        NSString* metaString = [metaArray componentsJoinedByString:@"\n"];
        [metadataTextView setText:metaString];
    }
    
}

// resize the thumbnail view according to the size of the image found
- (void)resizeThumbnailImageView
{
    CGSize imageSize = thumbnailImageView.image.size;
    [thumbnailImageView sizeThatFits:imageSize];
    CGPoint imageViewCenter = thumbnailImageView.center;
    imageViewCenter.x = CGRectGetMidX(self.view.frame);
    [thumbnailImageView setCenter:imageViewCenter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)share:(id)sender
{
    UIDocumentInteractionController* documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filepath_full]];
    documentController.delegate = self;
    [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}

- (IBAction)edit:(id)sender
{
    //
}

- (IBAction)play:(id)sender {
}
@end

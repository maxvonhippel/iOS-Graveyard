//
//  EpisodeViewController.h
//  pod box
//
//  Created by Max von Hippel on 2/5/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import "ViewController.h"
#import "PodcastEpisode.h"
#import "ViewController.h"

@interface EpisodeViewController : ViewController <UIDocumentInteractionControllerDelegate>

// the episode to show
@property (strong, nonatomic) PodcastEpisode* episode;
// the filepath string
@property (strong, nonatomic) NSString* filepath_full;

// navigation bar on top, contains title of episode
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
// share - offer options to share this episode
- (IBAction)share:(id)sender;
// edit - allow user to change metadata properties or delete episode
- (IBAction)edit:(id)sender;
// play the file
- (IBAction)play:(id)sender;
// thumbnail image view - derived from metadata of file
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
// metadata text view - shows metadata of file
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

@end

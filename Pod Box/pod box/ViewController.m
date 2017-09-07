//
//  ViewController.m
//  pod box
//
//  Created by Max von Hippel on 12/3/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ViewController.h"
// podcast parser kit
#import <BNRSSFeedParser/BNRSSFeedParser.h>
#import <BNRSSFeedParser/BNRSSFeedItem.h>
#import <BNRSSFeedParser/BNPodcastFeedParser.h>
#import <BNRSSFeedParser/BNPodcastFeedItem.h>
#import <BNRSSFeedParser/BNRSSFeedItemEnclosure.h>
#import <BNRSSFeedParser/BNPodcastFeed.h>
// my internal podcast episode structure
#import "PodcastEpisode.h"
// individual podcast view
#import "EpisodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize podTable, updateProgressLabel;

// ----------------------------- basic initialization ------------------------------------

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    //
    [super viewDidLoad];
    podTable.delegate = self;
    podTable.dataSource = self;
    [updateProgressLabel setText:@""];
    [podTable reloadData];
    // NSString* apple = @"http://power1051.iheart.com/podcast/itunes/breakfastclub_interviews_itunes.xml";
    // [self addEpisode:apple];
}

- (void)didReceiveMemoryWarning
{
    [updateProgressLabel setText:@"... memory warning"];
    NSLog(@"didRecieveMemoryWarning");
    //
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ----------------------------- saving episodes to disk ------------------------------------

// save a podcast episode to the disk with a specific key <---- DONE
- (void)saveEpisode:(PodcastEpisode*)episode
{
    [updateProgressLabel setText:[NSString stringWithFormat:@"Saving episode %@", episode.name]];
    NSLog(@"Saving episode ----------------- \nname:%@\ndate:%@\nfilepath:%@\ntext:%@\nurl:%@\nrss:%@\nnotes:%@\n\n----------------------", episode.name, episode.date, episode.filePath, episode.text, episode.url.absoluteString, episode.rss.absoluteString, episode.notes);
    //
    NSArray* episodes_prior = [self settingsArrayWithKey:@"episodes"];
    NSMutableArray* episodes;
    if (episodes_prior != NULL)
        episodes = [NSMutableArray arrayWithArray:episodes_prior];
    else episodes = [[NSMutableArray alloc] init];
    [episodes addObject:episode];
    NSData* encodedObject = [NSKeyedArchiver archivedDataWithRootObject:[NSArray arrayWithArray:episodes]];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"episodes"];
    [defaults synchronize];
    // reload the table of episodes
    [updateProgressLabel setText:@""];
    [podTable reloadData];
}

// ----------------------------- loading episodes from disk ------------------------------------

// load an episode by its episode name <---- DONE
- (NSArray*)settingsArrayWithKey:(NSString*)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:key])
    {
        NSData* encodedObject = [defaults objectForKey:key];
        return (NSArray*)([NSKeyedUnarchiver unarchiveObjectWithData:encodedObject]);
    }
    return NULL;
}

// load an episode by its index <---- DONE
- (PodcastEpisode*)loadEpisodeAtIndex:(NSUInteger)index
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"episodes"])
    {
        NSData* encodedObject = [defaults objectForKey:@"episodes"];
        NSArray* episodes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        if ([episodes count] > index)
            return [episodes objectAtIndex:index];
    }
    return NULL;
}

// number of episodes in the app
- (NSUInteger)numberOfEpisodes
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"episodes"])
    {
        NSData* encodedObject = [defaults objectForKey:@"episodes"];
        NSArray* episodes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        return [episodes count];
    }
    return 0;
}

// ----------------------------- downloading an initialized episode ------------------------------------

// dealing with a BNPodcastFeedItem episode <---- DONE
- (void)downloadEpisode:(BNPodcastFeedItem*)_episode andEpisode:(PodcastEpisode*)episode
{
    [updateProgressLabel setText:@"Initializing download"];
    // NSLog(@"downloadEpisode: %@", episode.link);
    episode.name = _episode.title;
    episode.url = _episode.enclosure.url;
    episode.text = _episode.description;
    
    [self downloadEpisodeFromUrl:_episode.enclosure.url andEpisode:episode];
    //
    // download a standard rss format episode and save to app storage <3
    return;
}

// downloading an episode from download url <---- DONE
- (void)downloadEpisodeFromUrl:(NSURL*)url andEpisode:(PodcastEpisode*)episode
{
    [updateProgressLabel setText:[NSString stringWithFormat:@"downloading episode %@", episode.name]];
    NSLog(@"downloadEpisodeFromUrl: %@", url);
    //
    //download the file in a seperate thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSLog(@"Downloading file from url started");
        NSData* urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachesFolder = paths[0];
            episode.date = [NSDate date];
            NSString* nameString = [[url absoluteString] lastPathComponent];
            NSString *filePath = [cachesFolder stringByAppendingPathComponent:nameString];
            // deal with metadata
            if (!episode.name)
                episode.name = episode.filePath;
            episode.filePath = nameString;
            //saving is done on main thread
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [urlData writeToFile:filePath atomically:YES];
                NSLog(@"File Saved: %@", filePath);
                // and save
                [self saveEpisode:episode];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
        
    });
}

// ------------------------------------------- debugging -------------------------------------------
- (void)failure:(NSString*)sharetext
{
    [updateProgressLabel setText:@""];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"\n--------------------------------\n\nFAILURE!!!\n\n%@\n--------------------------------", sharetext);
    UIAlertController* logSheet = [UIAlertController alertControllerWithTitle:@"Sorry :/" message:@"Looks like something went wrong, and I couldn't find the episode." preferredStyle:UIAlertControllerStyleActionSheet];
    // add a default cancel action
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Oh well" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction* tellDev = [UIAlertAction actionWithTitle:@"Send error report" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setSubject:@"bug report from pod box"];
            [mailController setToRecipients:@[@"maxvonhippel1996@gmail.com"]];
            NSString* body = [NSString stringWithFormat:@"Version %@ text: %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"], sharetext];
            [mailController setMessageBody:body isHTML:NO];
            [self presentViewController:mailController animated:YES completion:nil];
        }
    }];
    [logSheet addAction:ok];
    [logSheet addAction:tellDev];
    [self presentViewController:logSheet animated:YES completion:nil];
}

// ------------------------ parsing requested podcast download ------------------------------------

// <---- DONE
// we have a list of possible items from RSS and some arbitrary information.  Figure out what to download
// and download it.
// prior assumption: this is only called with a bnfeed that is not empty.
- (void)parseBnfeedItems:(BNPodcastFeed*)bnfeed andText:(NSString*)sharetext andEpisode:(PodcastEpisode*)episode
{
    [updateProgressLabel setText:@"parsing rss feed items"];
    NSLog(@"parseBnfeedItems: %lu items, text: %@", (unsigned long)bnfeed.count, sharetext);
    //
    NSMutableArray* titles = [[NSMutableArray alloc] init];
    // search for the item which appears to match whatever text we are passed in the share thing
    for (BNPodcastFeedItem* item in bnfeed.items)
    {
        // if the sharetext has this item's title in it then this is the correct episode and we're done searching
        if ([sharetext rangeOfString:item.title].location != NSNotFound)
        {
            // we found the episode!  let's download it!
            [self downloadEpisode:item andEpisode:episode];
            return;
        }
        [titles addObject:item.title];
    }
    // ok, if we have more than one title, we can look at what we've got and choose one
    if ([titles count] > 1)
    {
        // if we make it this far, then we don't know which episode to return
        // so we can ask the user!
        UIAlertController* chooseDownloadSheet = [UIAlertController alertControllerWithTitle:@"I'm having trouble reading that url ..." message:@"Which episode do you want?" preferredStyle:UIAlertControllerStyleActionSheet];
        // add a default cancel action
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action)
        {
            [updateProgressLabel setText:@""];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [chooseDownloadSheet addAction:cancel];
        // add a possible download option for each episode
        for (NSString* title in titles)
        {
            UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive
                                                           handler: ^(UIAlertAction *action)
            {
                                                               // begin the download
                                                               [self downloadEpisode:[bnfeed.items objectAtIndex:[titles indexOfObject:title]] andEpisode:episode];
                                                           }];
            // add the action
            [chooseDownloadSheet addAction:action];
        }
        // show the sheet to choose the download
        [self presentViewController:chooseDownloadSheet animated:YES completion:nil];
    }
    // if we only have 1 item in titles, then that's it and we can download it
    else if ([titles count] == 1)
        [self downloadEpisode:bnfeed.items[0] andEpisode:episode];
    
}

// try looking for rss and parse whatever we find <--- DONE
- (void)tryRss:(NSString*)sharetext andFeed:(BNPodcastFeed*)bnfeed andEpisode:(PodcastEpisode*)episode andUrl:(NSURL*)url
{
    [updateProgressLabel setText:@"trying to parse rss"];
    NSLog(@"tryRss: shareText: %@ and feed items: %lu", sharetext, (unsigned long)bnfeed.count);
    //
    episode.rss = url;
    // find the specific episode we are looking for
    // what episode ARE we looking for?
    if ([bnfeed.items count] == 1)
    {
        // just download this one item from the rss
        [self downloadEpisode:bnfeed.items[0] andEpisode:episode];
    }
    else if ([bnfeed.items count] > 1)
    {
        // try to go through all the items to find the right one
        [self parseBnfeedItems:bnfeed andText:sharetext andEpisode:episode];
    }
    else
    {
        // handle case where we have less than 1 item in the feed or where it is null
        [self failure:sharetext];
    }
    
}

// ------------------------ helper functions for html parsing ------------------------------------

// find the urls in a string <---- DONE
- (NSArray*)urlsInString:(NSString*)string
{
    [updateProgressLabel setText:@"looking for urls"];
    NSLog(@"urlsInString:\n");
    //
    // create a detector to find urls in the html
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    // create an array to hold all the matches
    NSArray* matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    // create an array to hold the final list of urls
    NSMutableArray* urls = [[NSMutableArray alloc] init];
    // iterate over all the matches
    for (NSTextCheckingResult* match in matches)
    {
        // add each match in NSURL format to our array to return
        NSURL *url = [match URL];
        [urls addObject:url];
    }
    // return said array
    NSArray* urlsArray = [NSArray arrayWithArray:urls];
    NSLog(@"%@", urlsArray);
    return urlsArray;
    
}

// find the possible audio/video files from a list of urls <---- NOT DONE
- (NSArray*)possibleFiles:(NSArray*)urls
{
    [updateProgressLabel setText:@"looking for files"];
    // TODO
    NSLog(@"possibleFiles: number of urls passed: %lu", (unsigned long)urls.count);
    //
    NSMutableArray* possibleFiles = [[NSMutableArray alloc] init];
    // find any possible files
    for (NSURL* url in urls) {
        // are any of these audio files?
        // create the request for the web page
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"HEAD"];
        // get the response
        NSHTTPURLResponse *response;
        // send the request
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
        // if we can read the response, read it
        if ([response respondsToSelector:@selector(allHeaderFields)])
        {
            // get the headers
            NSDictionary* allFields = [response allHeaderFields];
            NSString* contentType;
            // iterate over each header
            for (NSString* key in allFields.allKeys)
            {
                // get the content-type of that header
                if ([key compare:@"content-type" options:NSCaseInsensitiveSearch] == NSOrderedSame)
                {
                    // This is it
                    contentType = allFields[key];
                    break;
                }
            }
            // is that header an audio file?
            if ([contentType rangeOfString:@"audio"].location != NSNotFound || [contentType rangeOfString:@"video"].location != NSNotFound)
            {
                // this is a possible file
                [possibleFiles addObject:url];
            }
        }
    }
    // return an array of all the possible files urls
    return [NSArray arrayWithArray:possibleFiles];
    
}

// ------------------------ principle web parsing function NOT DONE ------------------------------------
- (void)handleIfNoPossibleFiles:(NSString*)sharetext andURL:(NSURL*)url andEpisode:(PodcastEpisode*)episode
{
    [updateProgressLabel setText:@"no files found"];
    // if no items:
    NSLog(@"Found no titles to download.");
    // try searching iTunes
    NSString* searchString = (url == nil) ? sharetext : [sharetext stringByReplacingOccurrencesOfString:url.absoluteString withString:@""];
    NSString *trimmedString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* plusedString = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString* searchUrl = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&entity=podcast&attribute=keywordsTerm", plusedString];
    NSLog(@"Going to search itunes store using url: %@", searchUrl);
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:searchRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (!error)
         {
             // http://stackoverflow.com/a/25608051/1586231
             NSError* parseError;
             id parse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
             NSLog(@"iTunes store results: %@", parse);
             if (parse == nil)
             {
                 // NOPE
                 // TODO
                 [self failure:sharetext];
                 return;
             }
             else if ([parse isKindOfClass:[NSDictionary class]])
             {
                 NSDictionary* tabDict = parse;
                 // ... Do stuff with tabDict. Don't touch parse anymore.
                 if ([tabDict objectForKey:@"artistName"])
                 {
                     // handle it!
                     // TODO
                     NSLog(@"SUCCESS!\n---------------\n\n%@\n\n----------", tabDict);
                     return;
                 }
                 else
                 {
                     // NOPE
                     // TODO
                     [self failure:sharetext];
                     return;
                 }
             }
             else if ([parse isKindOfClass:[NSArray class]])
             {
                 NSArray* tabArray = parse;
                 // ... Do stuff with tabArray. Don't touch parse anymore.
                 if ([tabArray count] >= 1)
                 {
                     // handle it!
                     // TODO
                     NSLog(@"SUCCESS!\n---------------\n\n%@\n\n----------", tabArray);
                     return;
                 }
                 else
                 {
                     // NOPE
                     // TODO
                     [self failure:sharetext];
                     return;
                 }
             }
             else
             {
                 // NOPE
                 // TODO
                 [self failure:sharetext];
                 return;
             }
             // if there are results, deal with them
             // if not, for now at least, too bad.
         }
     }];
}

- (void)tryParseWebResources:(NSString*)sharetext andURL:(NSURL*)url andEpisode:(PodcastEpisode*)episode {
    [updateProgressLabel setText:@"searching web"];
    NSLog(@"tryParseWebResources: shareText: %@ andUrl: %@", sharetext, url.absoluteString);
    //
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    // this is not an rss feed.  We need to search the html for a download url.
    // let's download the html of the website
    NSError *err = nil;
    NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
    if (err)
    {
        
        // Handle the error
        // TODO
        [self failure:sharetext];
        
    }
    else
    {
        
        NSArray* urls = [self urlsInString:html];
        NSArray* possibleFiles = [self possibleFiles:urls];
        // ok so do we have anything in our possible files?
        NSUInteger l = [possibleFiles count];
        if (l == 0)
        {
            [self handleIfNoPossibleFiles:sharetext andURL:url andEpisode:episode];
        }
        else if (l == 1)
        {
            
            NSURL* _url = possibleFiles[0];
            NSLog(@"Found the following file to download: %@", _url.absoluteString);
            // ok so this must be our file
            // download the file
            
        }
        else
        {
            
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            for (NSURL* _url in possibleFiles)
                [titles addObject:_url.absoluteString];
            UIAlertController* chooseDownloadSheet = [UIAlertController alertControllerWithTitle:@"Sorry to make you do the dirty work, but ..." message:@"Which of these urls looks the most likely to you?  If you have no idea, just click one randomly." preferredStyle:UIAlertControllerStyleActionSheet];
            // add a default cancel action
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action)
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [updateProgressLabel setText:@""];
            }];
            [chooseDownloadSheet addAction:cancel];
            // add a possible download option for each episode
            for (NSString* title in titles)
            {
                UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive
                                                               handler: ^(UIAlertAction *action)
                {
                                                                   // begin the download
                                                                   [self downloadEpisodeFromUrl:[NSURL URLWithString:title] andEpisode:episode];
                                                               }];
                // add the action
                [chooseDownloadSheet addAction:action];
            }
            // show the sheet to choose the download
            [self presentViewController:chooseDownloadSheet animated:YES completion:nil];
            
            // ok, so if we have a bunch of files, do any of them regex match the episode name?
            // if so:
            // 1. if just one good match download it
            // 2. if multiple matches, download the largest one if possible
        }
        
    }
    
}

// ------------------------ begin the process - NOT DONE ------------------------------------

// start handling an episode download request (from a sharesheet, but note that I haven't added
// app extension functionality to this yet, so there's still a lot of work to be done on that front)
- (void)addEpisode:(NSString*)sharetext
{
    [updateProgressLabel setText:@"starting episode parsing"];
    NSLog(@"addEpisode: %@", sharetext);
    //
    PodcastEpisode* episode = [[PodcastEpisode alloc] init];
    // step 1: find the url in the text
    NSArray* urls = [self urlsInString:sharetext];
    // iterate over the matches and find the first good url
    
    for (NSURL* url in urls)
    {
        
        // is it an RSS feed?
        @try
        {
            
            // Display the network activity indicator
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            // Perform the request on a new thread so we don't block the UI
            BNPodcastFeedParser* feedparser = [[BNPodcastFeedParser alloc] init];
            [feedparser parseFeedURL:url withETag:NULL untilPubDate:NULL success:^(NSHTTPURLResponse *nsresp, BNPodcastFeed *bnfeed)
            {

                [self tryRss:sharetext andFeed:bnfeed andEpisode:episode andUrl:url];
                
            } failure:^(NSHTTPURLResponse *nsresp, NSError *nerr)
            {
                
                [self tryParseWebResources:sharetext andURL:url andEpisode:episode];
                
            }];
            
        }
        @catch (NSException* err)
        {
            NSLog(@"%@", err.name);
        }
    }
}

// ---------------------------- user interface stuff ---------------------------------

// NOT DONE
- (IBAction)buttonPressAddNewPodcast:(id)sender
{
    // TODO: add UI flow to add a new podcast manually
}

// return the number of sectins in the tableview - for now, only 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: return number of folders
    return 1;
}

// return the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO: return number of items in that folder
    return [self numberOfEpisodes];
}

// return the cell for a specific index in the uitableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        [podTable registerClass:[UITableViewCell self] forCellReuseIdentifier:cellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    PodcastEpisode* episode = [self loadEpisodeAtIndex:(NSUInteger)indexPath.row];
    cell.textLabel.text = episode.name;
    return cell;
}

// launch the viewcontroller for a specific episode <---- DONE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO
    PodcastEpisode* episode = [self loadEpisodeAtIndex:(NSUInteger)indexPath.row];
    if (episode != NULL)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        EpisodeViewController* epiViewController = [storyboard instantiateViewControllerWithIdentifier:@"EpisodeViewController"];
        epiViewController.episode = episode;
        [self presentViewController:epiViewController animated:YES completion:nil];
    }
    else
    {
        [self failure:[NSString stringWithFormat:@"failed to select item at indexPath: %@ text of cell: %@", indexPath, [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]]];
    }
}

@end

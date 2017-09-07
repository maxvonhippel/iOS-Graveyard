//
//  ViewController.h
//  pod box
//
//  Created by Max von Hippel on 12/3/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <UIActionSheetDelegate, UITableViewDelegate,UITableViewDataSource>

// the table to hold all our stored podcast episodes
@property (weak, nonatomic) IBOutlet UITableView *podTable;
@property (weak, nonatomic) IBOutlet UILabel *updateProgressLabel;

// a button to open a new UI in which to add a podcast episode manually
- (IBAction)buttonPressAddNewPodcast:(id)sender;

@end


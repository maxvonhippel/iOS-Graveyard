//
//  SavedKniveViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Knife.h"
#import "handle.h"
#import "SwitchBladeView.h"
#import "OwnWantView.h"
#import "MaterialView.h"
#import "BladeLengthView.h"

@interface SavedKniveViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *specsTable;
@property (nonatomic) Knife* curKnife;

@property (weak, nonatomic) IBOutlet UINavigationBar *titleNavigationBar;

@property (weak, nonatomic) IBOutlet UILabel *ownItLabel;
@property (weak, nonatomic) IBOutlet OwnWantView *ownItView;
@property (weak, nonatomic) IBOutlet UISwitch *ownItSwitch;
- (IBAction)ownItSwitchValueChanged:(id)sender;
- (IBAction)searchWebForKnife:(id)sender;
- (IBAction)revealPrice:(id)sender;

@end

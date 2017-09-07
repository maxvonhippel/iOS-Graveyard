//
//  ViewController.h
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *knifeTable;

- (IBAction)addKnife:(id)sender;

- (IBAction)reviewApp:(id)sender;

@end


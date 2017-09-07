//
//  ViewController.h
//  GDORK
//
//  Created by Max von Hippel on 8/17/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *allWordsSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *mostWordsSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *allURLSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *mostURLSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *allTitleSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *mostTitleSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *siteSearchBar;
@property (weak, nonatomic) IBOutlet UISearchBar *filetypeSearchBar;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

- (IBAction)search:(id)sender;

@end


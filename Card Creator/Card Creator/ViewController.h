//
//  ViewController.h
//  Card Creator
//
//  Created by Max von Hippel on 6/24/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
// make a new card
- (IBAction)NewCard:(id)sender;
-(Card*)readCardFromArrayWithCustomObjFromUserDefaults:(NSIndexPath*)indexPath;
-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray;
-(UIImage*)imageFromCard:(Card*)newCard;
- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url;

@property (weak, nonatomic) IBOutlet UIToolbar* toolBar;
@property (weak, nonatomic) IBOutlet UITableView* deckTable;

@end


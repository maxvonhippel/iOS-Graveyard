//
//  ViewController.h
//  CAS Calculator
//
//  Created by Max von Hippel on 7/26/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Aircraft.h"

@interface ViewController : UIViewController <UIDocumentInteractionControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aircraftTable;

- (IBAction)AddAircraft:(id)sender;
-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray;

@end


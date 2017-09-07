//
//  ViewController.m
//  CAS Calculator
//
//  Created by Max von Hippel on 7/26/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize aircraftTable;

// ------------------------------------------------ standard methods -------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    aircraftTable.dataSource = self;
    aircraftTable.delegate = self;
    self.aircraftTable.allowsMultipleSelectionDuringEditing = NO;
    [self.aircraftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [aircraftTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------------------------------------------------- tableview stuff -----------------------------------------------------

// How many items are in the hanger table view? Should be the amount in the hanger in memory
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1. Does the user have any saved cards? If not, show a message saying to make some!
    // check here: @property (weak, nonatomic) NSDictionary* savedData;
    // in large part code explained by http://stackoverflow.com/a/14970464/1586231
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] != nil) {
        // say you have an empty deck
        NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
        NSArray *hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        return [hanger count];
    }
    return 0;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] != nil) {
            // which aircraft are we deleting and from where
            NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
            NSArray *hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
            Aircraft* aircraft = [hanger objectAtIndex:indexPath.row];
            NSMutableArray* copyHanver = [NSMutableArray arrayWithArray:hanger];
            // delete it
            [copyHanver removeObject:aircraft];
            [self writeArrayWithCustomObjToUserDefaults:@"hanger" withArray:copyHanver];
            // reload data
            [aircraftTable reloadData];
        }
    }
}

// what aircraft should appear in cell X of the hanger table?  Should be that at index X in the hanger in memory
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // define the cell
    // code from http://stackoverflow.com/a/34250654/1586231
    // Also got crucial debugging advice from http://stackoverflow.com/a/12737966/1586231
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // get the text to go in the cell
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] != nil) {
        // say you have an empty deck
        NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
        NSArray *hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        Aircraft* aircraft = [hanger objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", aircraft.name];
    } else cell.textLabel.text = @"You have no cards.";
    return cell;
}

// what happens if the user clicks on a cell in our tableview?  We calculate output and show a view controller with options accordingly
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //////////// show a popupnin which they can search or export a TSV
    // max and min weight alert view

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Search or Export" message:@"Search for the V-Speeds at a specific gross weight, or export a .TSV file with results for all weights." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"Gross weight in lbs", @"Gross weight in lbs");
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction* searchAction = [UIAlertAction actionWithTitle:@"Search" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [alert dismissViewControllerAnimated:TRUE completion:nil];
        // search for that specific weight's results and present them
        // save the written weight to 'aircraft'
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber* weight = [f numberFromString:alert.textFields.firstObject.text];
        if (weight == nil || [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] == nil || [weight doubleValue] < 0) {
            // something is wrong, try again
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            // say you have an empty hanger
            NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
            NSArray* hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
            Aircraft* aircraft = [hanger objectAtIndex:indexPath.row];
            // find results for that weight
            NSString* outputString = [NSString stringWithFormat:@"weight: %.f lbs, V(L/D)max: %.f KCAS, V-Carson: %.f KCAS, V-BE: %.f KCAS",\
                                      [weight doubleValue],\
                                      [aircraft.KCASVLDM integerValue] * pow( ([weight doubleValue] / [aircraft.grossWeight integerValue]), 0.5),\
                                      [aircraft.KCASVLDM integerValue] * pow( ([weight doubleValue] / [aircraft.grossWeight integerValue]), 0.5) * 1.316,\
                                      [aircraft.KCASVLDM integerValue] * pow( ([weight doubleValue] / [aircraft.grossWeight integerValue]), 0.5) / 1.316];
            UIAlertController* queryResultAlert = [UIAlertController alertControllerWithTitle:@"V-Speeds for given gross weight" message:outputString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:nil];
            [queryResultAlert addAction:doneAction];
            [self presentViewController:queryResultAlert animated:YES completion:nil];
        }
        
     }];
    
    [alert addAction:searchAction];
    
    UIAlertAction* exportAction = [UIAlertAction actionWithTitle:@"Export .TSV" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [alert dismissViewControllerAnimated:TRUE completion:nil];
        //////////// if the user selects to export TSV
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] != nil) {
            // say you have an empty hanger
            NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
            NSArray* hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
            Aircraft* aircraft = [hanger objectAtIndex:indexPath.row];
            // next we show a share sheet with the data
            int iterations = (int)([aircraft.maxGrossWeight integerValue] - [aircraft.minGrossWeight integerValue]) / 100;
            NSMutableArray* output = [[NSMutableArray alloc] init];
            // NSNumber* namgalArray[iterations];
            // NSNumber* rangeArray[iterations];
            [output addObject:[NSString stringWithFormat:@"weight\tV(L/D)max\tV-Carson\tV-BE"]];
            int n = 0;
            for (double i = [aircraft.minGrossWeight doubleValue]; i < [aircraft.maxGrossWeight doubleValue]; i += 100) {
                if (n++ >= iterations)
                    break;
                // calculate vldmax - "by formula V2 = V1  X  square root of (W2/W1)"
                // calculate vcarson - "Carson = Vldmax * 1.316"
                // calculate vbe - "VBE = Vldmax / 1.316"
                // calculate SR2 = SR1 (W1/W2)
                // TODO: calculate the nam / gal
                // TODO: calculate the range
                [output addObject:[NSString stringWithFormat:@"%.f\t%.f\t%.f\t%.f",\
                                   i,\
                                   [aircraft.KCASVLDM integerValue] * pow( (i / [aircraft.grossWeight integerValue]), 0.5),\
                                   [aircraft.KCASVLDM integerValue] * pow( (i / [aircraft.grossWeight integerValue]), 0.5) * 1.316,\
                                   [aircraft.KCASVLDM integerValue] * pow( (i / [aircraft.grossWeight integerValue]), 0.5) / 1.316 ]];//,\
                                    [aircraft.specificRange doubleValue] * ( [aircraft.grossWeight doubleValue] / i)]];
            }
            //get the documents directory:
            NSArray *paths = NSSearchPathForDirectoriesInDomains
            (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            //make a file name to write the data to using the documents directory:
            NSString *fileName = [NSString stringWithFormat:@"%@/%@.tsv",
                                  documentsDirectory, aircraft.name];
            //create content - four lines of text
            NSString *content = [output componentsJoinedByString:@"\n"];
            //save content to the documents directory
            [content writeToFile:fileName
                      atomically:NO
                        encoding:NSStringEncodingConversionAllowLossy
                           error:nil];
            // make share sheet for the document
            NSURL *URL = [[NSURL alloc] initFileURLWithPath:fileName];
            
            // export the file at this URL
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:nil];
            
            // you can exclude certain types of activities. You can just display the AirDrop activity by excluding all other activities.
            NSArray *excludedActivities = @[UIActivityTypePostToWeibo, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo];
            activityViewController.excludedActivityTypes = excludedActivities;
            
            [self presentViewController:activityViewController animated:YES completion:nil];
        
            NSLog(@"%@", content);
        }
    }];
    
    [alert addAction:exportAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
        [alert dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// ------------------------------------------------- share sheet ----------------------------------------------------------

// this method is used to share content using the default iOS share sheet
// code from here: http://stackoverflow.com/a/13499204/1586231
- (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    
    [self presentViewController:activityController animated:YES completion:nil];
}


// ---------------------------------------------------------- methods -----------------------------------------------------

// this saves the information for the aircraft to the hanger for future reference
- (void)calculate:(Aircraft*)aircraft {
    if (aircraft == NULL || aircraft.name == NULL || aircraft.KCASVLDM == nil || aircraft.grossWeight == nil) {
        // show alert saying something went wrong
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Something went wrong :(" message:@"Something is wrong with one of the values you entered - maybe the name is empty, or the weight or KCAS is not a number over 0?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [alert dismissViewControllerAnimated:TRUE completion:nil];
                                                              }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // now that that's out of the way, add the aircraft to the list, and to memory
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"] != nil) {
        NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"hanger"];
        NSArray* hanger = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        NSMutableArray* newHanger = [NSMutableArray arrayWithArray:hanger];
        [newHanger addObject:aircraft];
        [self writeArrayWithCustomObjToUserDefaults:@"hanger" withArray:newHanger];
    } else {
        NSMutableArray* newHanger = [NSMutableArray arrayWithObjects:aircraft, nil];
        [self writeArrayWithCustomObjToUserDefaults:@"hanger" withArray:newHanger];
    }
    // then reload data
    [aircraftTable reloadData];
}

// this begins the process of adding an aicraft to the hanger
- (IBAction)AddAircraft:(id)sender {
    // the new aircraft
    Aircraft* aircraft = [Aircraft alloc];
    
    // max and min weight alert view
    UIAlertController* maxMinAlert = [UIAlertController alertControllerWithTitle:@"Max & Min Gross Weight" message:@"Enter below the maximum and minimum gross weight in lbs at which you might expect to fly this aircraft." preferredStyle:UIAlertControllerStyleAlert];
    
    [maxMinAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"Max gross weight, lbs", @"Max gross weight, lbs");
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [maxMinAlert addTextFieldWithConfigurationHandler:^(UITextField* textFieldTwo) {
        textFieldTwo.placeholder = NSLocalizedString(@"Min gross weight, lbs", @"Min gross weight, lbs");
        textFieldTwo.keyboardType = UIKeyboardTypeNumberPad;
    }];
    /*
    // specific range alert view
    UIAlertController* specificRangeAlert = [UIAlertController alertControllerWithTitle:@"SR at given weight" message:@"What is the specific range in Nam/g of the aircraft at the weight and V(L/D)max you just entered from the POH?" preferredStyle:UIAlertControllerStyleAlert];
    
    [specificRangeAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction* doneSRAction = [UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber* sr = [f numberFromString:specificRangeAlert.textFields.firstObject.text];
        
        [specificRangeAlert dismissViewControllerAnimated:YES completion:nil];
        if (sr == nil || [sr doubleValue] < 1) {
            [self presentViewController:specificRangeAlert animated:YES completion:nil];
        } else {
            aircraft.specificRange = sr;
            [self presentViewController:maxMinAlert animated:YES completion:nil];
        }
    }];
    
    [specificRangeAlert addAction:doneSRAction];
    */
    UIAlertAction* doneMaxMinAction = [UIAlertAction actionWithTitle:@"Calculate!" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        // save the written weight to 'aircraft'
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber* max = [f numberFromString:maxMinAlert.textFields.firstObject.text];
        NSNumber* min = [f numberFromString:maxMinAlert.textFields[1].text];
        
        NSLog(@"\n\nMAX: %f, MIN: %f\n\n", [max doubleValue], [min doubleValue]);
        
        [maxMinAlert dismissViewControllerAnimated:TRUE completion:nil];
        
        if (max == nil || min == nil || [min integerValue] < 0 || [max integerValue] < [min integerValue]) {
            NSLog(@"Problem with input data for max min");
            // [self presentViewController:specificRangeAlert animated:TRUE completion:nil];
            [self presentViewController:maxMinAlert animated:YES completion:nil];
        } else {
            // CALCULATE!
            aircraft.maxGrossWeight = max;
            aircraft.minGrossWeight = min;
            [self calculate:aircraft];
        }
    }];
    
    [maxMinAlert addAction:doneMaxMinAction];
    
    // gross weight alert view
    UIAlertController* weightAlert = [UIAlertController alertControllerWithTitle:@"Find wieght for given V(L/D)max" message:@"The KCAS speed you just entered was for a particular weight.  Either that weight is specified in the TAS/fuel flow chart in the POH you referenced, or if unspecified, it can be assumed to be the max gross weight as specified in the POH.  Please enter the correct weight in below, in lbs." preferredStyle:UIAlertControllerStyleAlert];
    
    [weightAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"gross weight in lbs", @"gross weight in lbs");
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];

    UIAlertAction* doneWeightAction = [UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        // save the written weight to 'aircraft'
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber* myNumber = [f numberFromString:weightAlert.textFields.firstObject.text];
        if (myNumber == nil || myNumber <= 0) {
            // incorrectly formatted number
            // get rid of alert and try it again
            [weightAlert dismissViewControllerAnimated:TRUE completion:nil];
            [self presentViewController:weightAlert animated:YES completion:nil];
        } else {
            aircraft.grossWeight = myNumber;
            // dismiss the alert and calculate
            [weightAlert dismissViewControllerAnimated:TRUE completion:nil];
            [self presentViewController:maxMinAlert animated:TRUE completion:nil];
        }
    }];
    
    [weightAlert addAction:doneWeightAction];
    
    // KCAS alert view
    UIAlertController* KCASAlert = [UIAlertController alertControllerWithTitle:@"Find V(L/D)max for known weight" message:@"Locate the performance reflecting the best TAS/fuel flow (in your POH).  Use a flight calculator to convert this into KCAS, and enter below." preferredStyle:UIAlertControllerStyleAlert];
    
    [KCASAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"V(L/D)max in KCAS", @"V(L/D)max in KCAS");
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction* doneKCASAction = [UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        // save the written weight to 'aircraft'
        // nsnumber conversion technique from http://stackoverflow.com/a/1448875/1586231
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber* myNumber = [f numberFromString:KCASAlert.textFields.firstObject.text];
        // dismiss the alert and show the next
        if (myNumber == nil || myNumber <= 0) {
            [KCASAlert dismissViewControllerAnimated:TRUE completion:nil];
            [self presentViewController:KCASAlert animated:YES completion:nil];
        } else {
            aircraft.KCASVLDM = myNumber;
            [KCASAlert dismissViewControllerAnimated:TRUE completion:nil];
            [self presentViewController:weightAlert animated:YES completion:nil];
        }
    }];
    
    [KCASAlert addAction:doneKCASAction];
    
    // ask for the model name of the aircraft
    UIAlertController* nameAlert = [UIAlertController alertControllerWithTitle:@"Aircraft Model"
                                                                       message:@"What is the model of the aircraft? E.g, P-51 Mustang, or V-Tail Bonanza"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"aircraft name", @"aircraft name");
    }];
    
    UIAlertAction* doneNameAction = [UIAlertAction actionWithTitle:@"Next"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                                                             // save the written name to 'aircraft'
                                                             aircraft.name = nameAlert.textFields.firstObject.text;
                                                             if (aircraft.name == NULL || [aircraft.name  isEqual: @""]) {
                                                                 [nameAlert dismissViewControllerAnimated:TRUE completion:nil];
                                                                 [self presentViewController:nameAlert animated:YES completion:nil];
                                                             } else {
                                                                 // dismiss the alert and show the next
                                                                 [nameAlert dismissViewControllerAnimated:TRUE completion:nil];
                                                                 [self presentViewController:KCASAlert animated:YES completion:nil];
                                                             }
                                                         }];
    [nameAlert addAction:doneNameAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
        [nameAlert dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [nameAlert addAction:cancelAction];
    
    // start the chain of alerts
    [self presentViewController:nameAlert animated:YES completion:nil];
    
}

// ---------------------------------- memory methods -------------------------------------

// write the array called hanger of aircrafts to memory
-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

@end

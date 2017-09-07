//
//  ViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ViewController.h"
#import "Knife.h"
#import "BladeViewController.h"
#import "SavedKniveViewController.h"
#import "SwitchBladeView.h"
#import "handle.h"
#import "OwnWantView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize knifeTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    knifeTable.dataSource = self;
    knifeTable.delegate = self;
    self.knifeTable.allowsMultipleSelectionDuringEditing = NO;
    [self.knifeTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [knifeTable reloadData];
}

// solution from this hero: http://stackoverflow.com/a/13634512/1586231
- (void) viewWillAppear: (BOOL) animated { [self.knifeTable reloadData]; }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addKnife:(id)sender {
    // name, blade, bladeMaterial, handleMaterial, fullTang, price, brand, bladeLength, knifeImage
    Knife* curKnife = [[Knife alloc] init];
    // -------------------------------------------------- 1 ---------------------------------------------------------
    // first: brand, name, price - remaining: blade, bladeMaterial, handleMaterial, fullTang, bladeLength, knifeImage
    UIAlertController* nameAlert = [UIAlertController alertControllerWithTitle:@"The Basics" message:@"Enter the brand, name, and price of your knife." preferredStyle:UIAlertControllerStyleAlert];
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField* brandField) {
       brandField.placeholder = @"brand name";
    }];
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField* nameField) {
        nameField.placeholder = @"model name";
    }];
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField* priceField) {
        priceField.keyboardType = UIKeyboardTypeNumberPad;
        priceField.placeholder = @"price";
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* cancel) {
        // nevermind.
        [nameAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    [nameAlert addAction:cancelAction];
    UIAlertAction* nextAction = [UIAlertAction actionWithTitle:@"Next" style:UIAlertActionStyleDefault handler:^(UIAlertAction* next) {
        // set variables of curKnife
        curKnife.brand = nameAlert.textFields[0].text;
        curKnife.name = nameAlert.textFields[1].text;

        // get number from price
        NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        curKnife.price = [[f numberFromString:nameAlert.textFields[2].text] integerValue];
        // done with this alert
        [nameAlert dismissViewControllerAnimated:YES completion:nil];
        // next step: blade, fullTang, bladeLength - remaining: bladeMaterial, handleMaterial, knifeImage
        NSString* storyboardName = @"Main";
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        BladeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BladeViewController"];
        vc.curKnife = curKnife;
        [self presentViewController:vc animated:YES completion:nil];

    }];
    [nameAlert addAction:nextAction];
    [self presentViewController:nameAlert animated:YES completion:nil];
}

- (IBAction)reviewApp:(id)sender {
    // http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1148457349&mt=8
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1148457349&mt=8"]];
}

// --------------------------------------------------- tableview stuff -----------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"knives"] != nil) {
        // which aircraft are we deleting and from where
        NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
        NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        return [knives count];
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"knives"] != nil) {
            // which aircraft are we deleting and from where
            NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
            NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
            Knife* knife = [knives objectAtIndex:indexPath.row];
            NSMutableArray* copyKnives = [NSMutableArray arrayWithArray:knives];
            // delete it
            [copyKnives removeObject:knife];
            [self writeArrayWithCustomObjToUserDefaults:@"knives" withArray:copyKnives];
            // reload data
            [knifeTable reloadData];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // debugging tip w/ cellIdentifyer from http://stackoverflow.com/a/16746684/1586231
    NSString *CellIdentifier  = [NSString stringWithFormat:@"Cell_%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    // define the cell
    // code from http://stackoverflow.com/a/34250654/1586231
    // Also got crucial debugging advice from http://stackoverflow.com/a/12737966/1586231
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }   

    // get the text to go in the cell
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"knives"] != nil) {
        NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
        NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        Knife* knife = [knives objectAtIndex:indexPath.row];
        cell.textLabel.text = @"";  // note: WEIRDLY, if this is not there, nothing works!!
        
        // add UIView with knife
        if ([[cell.contentView subviews] count] == 1) {
            
            handle* handleView = [[handle alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - 110, cell.contentView.frame.size.height - 5, 100, 60)];
            SwitchBladeView* bladeView = [[SwitchBladeView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - 10, cell.contentView.frame.size.height - 5, 100, 60)];
            OwnWantView* ownView = [[OwnWantView alloc] initWithFrame:CGRectMake(10, (cell.contentView.frame.size.height / 2), 50, 50)];
            UILabel* bladeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, (cell.contentView.frame.size.height / 2), cell.contentView.frame.size.width - 110 - 70, 60)];
            // set the correct settings of each
            ownView.curKnife = knife;
            handleView.curKnife = knife;
            bladeView.curKnife = knife;
            bladeLabel.text = [NSString stringWithFormat:@"%@", knife.name];
            
            handleView.backgroundColor = [UIColor colorWithRed:0.17 green:0.10 blue:0.08 alpha:1.0];
            bladeView.backgroundColor = [UIColor colorWithRed:0.17 green:0.10 blue:0.08 alpha:1.0];
            ownView.backgroundColor = [UIColor colorWithRed:0.17 green:0.10 blue:0.08 alpha:1.0];
            // add each to the cell
            handleView.tag = 1;
            bladeView.tag = 2;
            ownView.tag = 3;
            bladeLabel.tag = 4;
            bladeLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:handleView];
            [cell.contentView addSubview:bladeView];
            [cell.contentView addSubview:ownView];
            [cell.contentView addSubview:bladeLabel];
            
        } else {
            
            SwitchBladeView* bladeView = (id)[cell.contentView viewWithTag:2];
            handle* handleView = (id)[cell.contentView viewWithTag:1];
            OwnWantView* ownView = (id)[cell.contentView viewWithTag:3];
            UILabel* bladeLabel = (id)[cell.contentView viewWithTag:4];
            bladeLabel.text = [NSString stringWithFormat:@"%@", knife.name];
            bladeView.curKnife = knife;
            handleView.curKnife = knife;
            ownView.curKnife = knife;
            [bladeView setNeedsDisplay];
            [handleView setNeedsDisplay];
            [ownView setNeedsDisplay];
            [bladeLabel setNeedsDisplay];
        }
        
    } else cell.textLabel.text = @"You have no knives.";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor colorWithRed:0.17 green:0.10 blue:0.08 alpha:1.0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"knives"] != nil) {
        // go to the view for that knife
        NSString* storyboardName = @"Main";
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        SavedKniveViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SavedKniveViewController"];
        // what is the cur knife?
        NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
        NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        Knife* knife = [knives objectAtIndex:indexPath.row];
        vc.curKnife = knife;
        // present it
        [self presentViewController:vc animated:YES completion:nil];
    }
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

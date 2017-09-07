//
//  SavedKniveViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "SavedKniveViewController.h"
#import "WebSearchViewController.h"

@interface SavedKniveViewController ()

@end

@implementation SavedKniveViewController
@synthesize curKnife, titleNavigationBar, specsTable, ownItView, ownItLabel, ownItSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // first set the title nav bar title
    titleNavigationBar.topItem.title = curKnife.name;
    
    // make an nsarray of colors
    // thank jesus for this website: http://www.briangrinstead.com/blog/ios-uicolor-picker
    // -------------------------- colors -------------------------------------------------------------
    NSArray* bladeMaterialArray = [[NSArray alloc] initWithObjects:@"carbon steel", @"stainless steel", @"tool steel", @"alloy steel", @"steel", @"cobalt alloy", @"titanium alloy", @"carbon fiber", @"obsidian", @"ceramic", @"glass", @"plastic", @"copper", @"damascus", @"damasteel", nil];
    NSArray* bladeColorArray = [[NSArray alloc] initWithObjects:
                                [UIColor colorWithRed:0.71 green:0.73 blue:0.76 alpha:1.0], // carbon steel
                                [UIColor colorWithRed:0.88 green:0.90 blue:0.92 alpha:1.0], // stainless steel
                                [UIColor colorWithRed:0.37 green:0.39 blue:0.42 alpha:1.0], // tool steel
                                [UIColor colorWithRed:0.44 green:0.45 blue:0.47 alpha:1.0], // alloy steel
                                [UIColor colorWithRed:0.68 green:0.70 blue:0.72 alpha:1.0], // steel
                                [UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.0], // cobalt alloy
                                [UIColor colorWithRed:0.75 green:0.78 blue:0.77 alpha:1.0], // titaniumm alloy
                                [UIColor colorWithRed:0.12 green:0.07 blue:0.16 alpha:1.0], // carbon fiber
                                [UIColor colorWithRed:0.00 green:0.00 blue:0.01 alpha:1.0], // obsidian
                                [UIColor colorWithRed:0.50 green:0.46 blue:0.55 alpha:1.0], // ceramic
                                [UIColor colorWithRed:0.04 green:0.39 blue:0.74 alpha:1.0], // glass
                                [UIColor colorWithRed:0.90 green:0.51 blue:0.46 alpha:1.0], // plastic
                                [UIColor colorWithRed:0.90 green:0.84 blue:0.25 alpha:1.0], // copper
                                [UIColor colorWithRed:0.02 green:0.16 blue:0.16 alpha:1.0], // damascus
                                [UIColor colorWithRed:0.19 green:0.20 blue:0.20 alpha:1.0], // famasteel
                                nil];
    UIColor* bladeColor;
    if ([bladeMaterialArray containsObject:curKnife.bladeMaterial] && [bladeMaterialArray indexOfObject:curKnife.bladeMaterial] <= [bladeColorArray count] - 1) {
        bladeColor = [bladeColorArray objectAtIndex:[bladeMaterialArray indexOfObject:curKnife.bladeMaterial]];
    } else bladeColor = [UIColor grayColor];
    
    self.view.backgroundColor = bladeColor;
    
    specsTable.dataSource = self;
    specsTable.delegate = self;
    self.specsTable.allowsMultipleSelectionDuringEditing = NO;
    [self.specsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    ownItView.backgroundColor = self.view.backgroundColor;
    ownItView.curKnife = curKnife;
    ownItLabel.text = curKnife.ownIt ? @"Own it" : @"Want it";
    [ownItSwitch setOn:curKnife.ownIt];
    
    
    
    [ownItView setNeedsDisplay];
    [specsTable reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ---------------------------------------- helper methods --------------------------------------------------


// if the OwnSwitch is changed, we want to change the knife accordingly to reflect the fact that the knife is now owned / now owned

- (void)viewWillDisappear:(BOOL)animated {
    
    // remove curKnife from existing array
    // what is the cur knife?
    NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
    if (!existingData)
        return;
    NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
    if (!knives)
        return;
    NSMutableArray* copyKnives = [NSMutableArray arrayWithArray:knives];
    
    Knife* to_modify;
    Knife* copyKnife = [[Knife alloc] init];
    copyKnife.name = curKnife.name;
    copyKnife.bladeLength = curKnife.bladeLength;
    copyKnife.bladeMaterial = curKnife.bladeMaterial;
    copyKnife.blade = curKnife.blade;
    copyKnife.brand = curKnife.brand;
    copyKnife.fullTang = curKnife.fullTang;
    copyKnife.handleMaterial = curKnife.handleMaterial;
    copyKnife.name = curKnife.name;
    copyKnife.price = curKnife.price;
    copyKnife.ownIt = ![ownItSwitch isOn];
    
    for (Knife* knife in copyKnives) {
        if ([knife isEqual:copyKnife]) {
            to_modify = knife;
            break;
        }
    }
    
    if (!to_modify)
        return;
    
    [copyKnives replaceObjectAtIndex:[copyKnives indexOfObject:to_modify] withObject:curKnife];
    
    [self writeArrayWithCustomObjToUserDefaults:@"knives" withArray:copyKnives];
}

// write the array called hanger of aircrafts to memory
-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

// ---------------------------------------- IBACTIONS --------------------------------------------------

- (IBAction)ownItSwitchValueChanged:(id)sender {
    curKnife.ownIt = ownItSwitch.isOn;
    ownItView.curKnife = curKnife;
    ownItLabel.text = curKnife.ownIt ? @"Own it" : @"Want it";
    [ownItView setNeedsDisplay];
    [ownItLabel setNeedsDisplay];
}

- (IBAction)searchWebForKnife:(id)sender {
    
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    WebSearchViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"WebSearchViewController"];
    vc.curKnife = curKnife;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)revealPrice:(id)sender {
    // show a popup thingy with the knife's actual price
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Price"
                                                    message:[NSString stringWithFormat:@"You purchased this knife for $%ld", (long)curKnife.price]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

// --------------------------------------------------- tableview stuff -----------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1. picture of knife                  -> if selected, does nothing
    // 2. blade length & full-tang          -> if selected, goes to wikipedia for full-tang
    // 3. blade type                        -> if selected, goes to wikipedia for blade type
    // 4. blade material                    -> if selected, goes to wikipedia for blade material
    // 5. handle material                   -> if selected, goes to wikipedia for handle material
    // 6. own it?                           -> if selected, shows price
    if (section == 0)
        return 5;
    else return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId;
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        // --------------------------------------- knife picture -----------------------------------------------
        
        // 1. picture of knife                  -> if selected, does nothing
        cellId = @"knife pic cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = @"";
        if ([[cell.contentView subviews] count] == 1) {
            // views not yet set so add them
            // set up the handle view
            handle* handleView = [[handle alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width / 2 - 50, cell.contentView.frame.size.height / 2, 100, 60)];
            SwitchBladeView* bladeView = [[SwitchBladeView alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width / 2) + 50, cell.contentView.frame.size.height / 2, 100, 60)];
            handleView.tag = 0;
            bladeView.tag = 1;
            handleView.curKnife = curKnife;
            bladeView.curKnife = curKnife;
            handleView.backgroundColor = [UIColor whiteColor];
            bladeView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:handleView];
            [cell.contentView addSubview:bladeView];
            [handleView setNeedsDisplay];
            [bladeView setNeedsDisplay];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell;
            
        } else {
            
            // already set so update it
            handle* handleView = (id)[cell.contentView viewWithTag:0];
            SwitchBladeView* bladeView = (id)[cell.contentView viewWithTag:1];
            handleView.curKnife = curKnife;
            bladeView.curKnife = curKnife;
            [handleView setNeedsDisplay];
            [bladeView setNeedsDisplay];
            return cell;
        }
        
    } else if (indexPath.row == 1) {
        // --------------------------------------- blade length & full-tang -----------------------------------------------
        
        
        // 2. blade length & full-tang          -> if selected, goes to wikipedia for full-tang
        cellId = @"blade length cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = @"";
        if ([[cell.contentView subviews] count] == 1) {
            // set up the blade length view
            BladeLengthView* lengthView = [[BladeLengthView alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width / 2) - 50, cell.contentView.frame.size.height / 2, 200, 60)];
            lengthView.curKnife = curKnife;
            lengthView.tag = 1;
            lengthView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:lengthView];
            [lengthView setNeedsDisplay];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell;
            
        } else {
            BladeLengthView* lengthView = (id)[cell.contentView viewWithTag:1];
            lengthView.curKnife = curKnife;
            [lengthView setNeedsDisplay];
            return cell;
        }
        
    } else if (indexPath.row == 2) {
        // --------------------------------------- blade type -----------------------------------------------
        
        // 3. blade type                        -> if selected, goes to wikipedia for blade type
        cellId = @"blade type cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = @"";
        if ([[cell.contentView subviews] count] == 1) {
            UILabel* centeredBladeLabel = [[UILabel alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width - 100)/ 2, 0, 300, 25)];
            centeredBladeLabel.text = curKnife.fullTang ? [NSString stringWithFormat:@"Full-tang %@ style", curKnife.blade] : [NSString stringWithFormat:@"Partial-tang %@ style", curKnife.blade];
            centeredBladeLabel.tag = 0;
            [cell.contentView addSubview:centeredBladeLabel];
            [centeredBladeLabel setNeedsDisplay];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell;
        } else {
            UILabel* centeredBladeLabel = (id)[cell.contentView viewWithTag:0];
            centeredBladeLabel.text = curKnife.fullTang ? [NSString stringWithFormat:@"Full-tang %@ style", curKnife.blade] : [NSString stringWithFormat:@"Partial-tang %@ style", curKnife.blade];
            [centeredBladeLabel setNeedsDisplay];
            return cell;
        }
        
    } else if (indexPath.row == 3) {
        // --------------------------------------- blade material -----------------------------------------------
        
        // 4. blade material                    -> if selected, goes to wikipedia for blade material
        cellId = @"blade material cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = @"";
        if ([[cell.contentView subviews] count] == 1) {
            // material icon
            MaterialView* materialView = [[MaterialView alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width / 2) + 30, 5, 60, 60)];
            materialView.material = curKnife.bladeMaterial;
            materialView.tag = 1;
            // label
            UILabel* bladeMaterialLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width / 2 - 15, 66, 300, 25)];
            bladeMaterialLabel.text = [NSString stringWithFormat:@"%@ blade", curKnife.bladeMaterial];
            bladeMaterialLabel.tag = 0;
            materialView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:bladeMaterialLabel];
            [cell.contentView addSubview:materialView];
            [materialView setNeedsDisplay];
            [bladeMaterialLabel setNeedsDisplay];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell;
        } else {
            MaterialView* materialView = (id)[cell.contentView viewWithTag:1];
            materialView.material = curKnife.bladeMaterial;
            UILabel* bladeMaterialLabel = (id)[cell.contentView viewWithTag:0];
            bladeMaterialLabel.text = [NSString stringWithFormat:@"%@ blade", curKnife.bladeMaterial];
            [bladeMaterialLabel setNeedsDisplay];
            [materialView setNeedsDisplay];
            return cell;
        }
        
    } else if (indexPath.row == 4) {
        // --------------------------------------- handle material -----------------------------------------------
        
        // 5. handle material                   -> if selected, goes to wikipedia for handle material
        cellId = @"handle material cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = @"";
        if ([[cell.contentView subviews] count] == 1) {
            // material icon
            MaterialView* materialView = [[MaterialView alloc] initWithFrame:CGRectMake((cell.contentView.frame.size.width / 2) + 30, 5, 60, 60)];
            materialView.material = curKnife.handleMaterial;
            materialView.tag = 1;
            // label
            UILabel* handleMaterialLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width / 2, 66, 300, 25)];
            handleMaterialLabel.text = [NSString stringWithFormat:@"%@ handle", curKnife.handleMaterial];
            handleMaterialLabel.tag = 0;
            materialView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:handleMaterialLabel];
            [cell.contentView addSubview:materialView];
            [materialView setNeedsDisplay];
            [handleMaterialLabel setNeedsDisplay];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell;
        } else {
            MaterialView* materialView = (id)[cell.contentView viewWithTag:1];
            materialView.material = curKnife.handleMaterial;
            UILabel* handleMaterialLabel = (id)[cell.contentView viewWithTag:0];
            handleMaterialLabel.text = [NSString stringWithFormat:@"%@ handle", curKnife.handleMaterial];
            [materialView setNeedsDisplay];
            [handleMaterialLabel setNeedsDisplay];
            return cell;
        }
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
        return 30;
    else return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // search the web for that item
    NSString* wikiString;
    if (indexPath.row == 0) {
        NSLog(@"share action");
        // 1. picture of knife                  -> if selected, does nothing
        NSURL* appURL = [NSURL URLWithString:@"http://itunes.apple.com/us/app/cutlery/id1148457349"];
        [self shareText:[NSString stringWithFormat:@"I %@ a %@ %@ knife with a %.2ld inch, %.f cm %@ %@ %@ blade and a %@ handle.", curKnife.ownIt ? @"have" : @"want", curKnife.brand, curKnife.name, (long)curKnife.bladeLength, curKnife.bladeLength * 2.54, curKnife.fullTang ? @"full-tang" : @"partial-tang", curKnife.bladeMaterial, curKnife.blade, curKnife.handleMaterial] andImage:NULL andUrl:appURL];
        return;
    } else if (indexPath.row == 1) {
        NSLog(@"Full tang");
        // 2. blade length & full-tang          -> if selected, goes to wikipedia for full-tang
        wikiString = @"full tang";
    } else if (indexPath.row == 2) {
        NSLog(@"blade type");
        // 3. blade type                        -> if selected, goes to wikipedia for blade type
        wikiString = [NSString stringWithFormat:@"%@ blade", curKnife.blade];
    } else if (indexPath.row == 3) {
        NSLog(@"blade material");
        // 4. blade material                    -> if selected, goes to wikipedia for blade material
        wikiString = curKnife.bladeMaterial;
    } else if (indexPath.row == 4) {
        NSLog(@"handle material");
        // 5. handle material                   -> if selected, goes to wikipedia for handle material
        wikiString = curKnife.handleMaterial;
    }
    
    // launch the webview
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    WebSearchViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"WebSearchViewController"];
    if (indexPath.row != 2)
        vc.wikiSearch = wikiString;
    else vc.knifeCenterSearch = wikiString;
    vc.curKnife = curKnife;
    [self presentViewController:vc animated:YES completion:nil];
    
    return;
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

@end

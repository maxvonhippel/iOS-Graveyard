//
//  ViewController.m
//  Card Creator
//
//  Created by Max von Hippel on 6/24/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"
#import "ParticularCardView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize toolBar, deckTable;

// --------------------------- GENERIC STUFF, SETUP ---------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Show the user's current deck
    // https://www.codementor.io/swift/tutorial/two-basic-ways-to-populate-your-uitableview
    deckTable.dataSource = self;
    deckTable.delegate = self;

    [self showdeck];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------------------------- MAIN FUNCTIONS ( IBOUTLETS ) ---------------------------

// NewCard allows the user to create a new card
- (IBAction)NewCard:(id)sender {
    // -------------------------------
    // 1. Choose an image for the card
    // code from https://www.invasivecode.com/weblog/uialertcontroller-alert-action-sheet/
    
    UIAlertController* imageAlert = [UIAlertController alertControllerWithTitle:@"Choose Image"
                                                                   message:@"You need a cool picture for your card!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* firstAction = [UIAlertAction actionWithTitle:@"Take Picture"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction* actionOne) {
                                                              // take a picture and save it
                                                              // code from http://stackoverflow.com/a/10043160/1586231
                                                              
                                                              if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                  UIImagePickerController* pickerView =[[UIImagePickerController alloc]init];
                                                                  pickerView.allowsEditing = YES;
                                                                  pickerView.delegate = self;
                                                                  pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                  [self presentViewController:pickerView animated:YES completion:nil];
                                                              }
                                                          }];
    UIAlertAction* secondAction = [UIAlertAction actionWithTitle:@"Choose From Photos"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction* actionTwo) {
                                                               // choose a picture and save it
                                                               // code from http://stackoverflow.com/a/10043160/1586231
                                                               
                                                               UIImagePickerController* pickerView = [[UIImagePickerController alloc] init];
                                                               pickerView.allowsEditing = YES;
                                                               pickerView.delegate = self;
                                                               [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                               [self presentViewController:pickerView animated:YES completion:nil];
                                                           }];
    
    [imageAlert addAction:firstAction];
    [imageAlert addAction:secondAction];
    [self presentViewController:imageAlert animated:YES completion:nil];
}

// --------------------------- HELPER FUNCTIONS ---------------------------

// How many items are in the card deck table view?  Should be same as number of items in the existing deck
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1. Does the user have any saved cards? If not, show a message saying to make some!
    // check here: @property (weak, nonatomic) NSDictionary* savedData;
    // in large part code explained by http://stackoverflow.com/a/14970464/1586231
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deck"] != nil) {
        // say you have an empty deck
        NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deck"];
        NSArray *existingdeck = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        return [existingdeck count];
    }
    return 0;
}

// How many sectins in the table view?  Well just cards, so 1.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // define the cell
    // code from http://stackoverflow.com/a/34250654/1586231
    // Also got crucial debugging advice from http://stackoverflow.com/a/12737966/1586231
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // get the text to go in the cell
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deck"] != nil) {
        // say you have an empty deck
        NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deck"];
        NSArray *existingdeck = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        Card* thisCard = [existingdeck objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ : damage %ld, health %ld", thisCard.name, (long)thisCard.attack_points, (long)thisCard.health_points];
    } else cell.textLabel.text = @"You have no cards.";
    return cell;
}

// what happens if the user clicks on a cell in our tableview?  We need to show a share sheet with the card from that row.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Card* thisCard = [self readCardFromArrayWithCustomObjFromUserDefaults:indexPath];
    // present share sheet for card
    if (thisCard == NULL) {
        // present a popup thing and say no card found!
        UIAlertController* doneAlert = [UIAlertController alertControllerWithTitle:@"Hmm... Nothing There." message:@"It appears that there is something wrong with the app, and it failed to correctly load or save your card.  Please contact me (Max) through my developer page (on my iTunes profile) and let me know what happened, and I will do my very best to identify and fix the bug." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* doneAction = [UIAlertAction actionWithTitle:@"Darnit!" style:UIAlertActionStyleDestructive handler:nil];
        [doneAlert addAction:doneAction];
        [self presentViewController:doneAlert animated:YES completion:nil];
    } else {
        // present a share sheet for the graphics context of the card
        UIImage* cardImage = [self imageFromCard:thisCard];
        // present the share sheet with the card, link, and title
        [self shareText:[NSString stringWithFormat:@"Check out my sick new card, %@!", thisCard.name] andImage:cardImage andUrl:[NSURL URLWithString:@"http://linkedandloaded.ninja"]];
    }
    return;
}

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


// showdeck brings a UI card to the forefront containing the user's current deck
- (void)showdeck {
    [deckTable reloadData];
}

// returns the graphics of the newly generated card
-(UIImage*)imageFromCard:(Card*)newCard {
    // A) clear current graphics context
    toolBar.hidden = YES;
    deckTable.hidden = YES;
    
    // ----->>>>>>>>> using a ParticularCardView <<<<<<<----------
    ParticularCardView *pView = [[ParticularCardView alloc]initWithFrame:CGRectMake(0, 0, 640, 960)];
    pView.curCard = newCard;
    [self.view addSubview:pView];
    
    // 7.1 save the card graphics to the camera roll
    // code source: http://pinkstone.co.uk/how-to-take-a-screeshot-in-ios-programmatically/
    
    // define the size and grab a UIImage from it
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), NO, 1.0);
    [pView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // B) clear generated graphics
    [pView removeFromSuperview];
    // C) bring back toolbar, table
    toolBar.hidden = NO;
    deckTable.hidden = NO;
    return screengrab;
}

/* saveCard saves a card to camera roll and to the card index in the settings so it can be viewed in deck view
 * it is called at the end of the imagepickercontroller stuff below
 * newCard is passed to it and is the card generated by the user via the many many alertview thingies in the imagepicker stuff below
 */
- (void)saveCard:(Card*)newCard {
    // because of this: http://stackoverflow.com/a/3660047/1586231
    if (newCard == NULL)
        return;
    UIImage* screengrab = [self imageFromCard:newCard];
    // save screengrab to Camera Roll
    UIImageWriteToSavedPhotosAlbum(screengrab, nil, nil, nil);
    
    NSData *existingData;
    if ((existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deck"]) == nil) {
        // http://stackoverflow.com/a/1964894/1586231
        NSMutableArray* newdeck = [NSMutableArray arrayWithObjects:newCard, nil];
        [self writeArrayWithCustomObjToUserDefaults:@"deck" withArray:newdeck];
        // TEST
        // NSLog(@"In SaveCard, existing deck == nil");
    } else {
        NSArray *existingdeck = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        NSMutableArray* newdeck = [NSMutableArray arrayWithArray:existingdeck];
        [newdeck addObject:newCard];
        [self writeArrayWithCustomObjToUserDefaults:@"deck" withArray:newdeck];
    }
    
    // present a popup thing and say good work!
    UIAlertController* doneAlert = [UIAlertController alertControllerWithTitle:@"Sick New Card Saved!" message:@"Good work building a totally wicked new card!  Onward and upward, homie!  Trade, battle, and compete with your awesome new invention!  PS Not to worry, this card has been added both to your deck in the app and to your camera roll in the Photos app." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* doneAction = [UIAlertAction actionWithTitle:@"Sick!" style:UIAlertActionStyleDestructive handler:nil];
    [doneAlert addAction:doneAction];
    [self presentViewController:doneAlert animated:YES completion:^{[self showdeck];}];
}

// next 2 methods from http://stackoverflow.com/a/20627936/1586231
// write an array to the encoded user defaults at the name keyName (nsmutablearray)
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    // 7.2 if possible do so into a custom folder or something for finding cards from the creator!
    // 8. Save the created card and its information to the existing deck!
    // in large part code explained by http://stackoverflow.com/a/14970464/1586231
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

// read the nsmuttable array found in the user defaults at the key keyname (in my case this will always be "deck")
-(Card*)readCardFromArrayWithCustomObjFromUserDefaults:(NSIndexPath *)indexPath;
{
    NSData *existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deck"];
    // if no such data exists, return nil
    if (existingData == nil)
        return nil;
    NSArray *existingdeck = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
    Card* thisCard = [existingdeck objectAtIndex:indexPath.row];
    return thisCard;
}

// this code handles the image picking in creating a new card and moves to the next stage of the card creation
#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info {
    // note, all of this owes a huge debt of gratitude to: http://useyourloaf.com/blog/uialertcontroller-changes-in-ios-8/
    
    // ... from - (IBAction)NewCard
    // make the current instance of a card
    Card* newCard = [Card alloc];
    // save the photo to the current instance of a card
    newCard.picture = [info valueForKey:UIImagePickerControllerEditedImage];
    
    // ----------------------------------------------------------------------------------------------------------------
    // 6. What quote should be included on the card?
    UIAlertController* quoteAlert = [UIAlertController alertControllerWithTitle:@"Write A Quote"
                                                                        message:@"Write a short quote from someone cool saying how totally gnarly your card is."
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [quoteAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"SUPER COOL QUOTE", @"SUPER COOL QUOTE");
    }];
    [quoteAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"NAME OF PERSON WHO SAID THAT", @"NAME OF PERSON WHO SAID THAT");
    }];
    // done action
    UIAlertAction* doneQuoteAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        // save the written quote and author
        // holy fucking shit I think this is actually going to work I see no errors oh my god
        // jesus I do not want to build this I live in terror
        // it's now 10:24pm
        // sleep is for the weak, pathetic, and non-ADD
        // 6.1 Who said that quote?
        newCard.quote = [NSString stringWithFormat:@"\"%@\"\n-%@", quoteAlert.textFields.firstObject.text, quoteAlert.textFields.lastObject.text];
        [self saveCard:newCard];
    }];
    [quoteAlert addAction:doneQuoteAction];
    
    // ----------------------------------------------------------------------------------------------------------------
    // 5. What information should be saved on the card?
    UIAlertController* informationAlert = [UIAlertController alertControllerWithTitle:@"Write Your Card Info"
                                                                              message:@"Write a short description of exactly what powers & abilities your amazing card has."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    // information text
    [informationAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"Info", @"Info");
    }];
    // done action
    UIAlertAction* doneInfoAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        // save the written info
        newCard.information = informationAlert.textFields.firstObject.text;
        // launch next alert
        [informationAlert dismissViewControllerAnimated:TRUE completion:nil];
        [self presentViewController:quoteAlert animated:TRUE completion:nil];
    }];
    [informationAlert addAction:doneInfoAction];
    
    // ----------------------------------------------------------------------------------------------------------------
    // 3. How much health should the card have? && 4. How much damage should the card have?
    UIAlertController *healthAndDamageAlert = [UIAlertController alertControllerWithTitle:@"Choose Your Card's Health & Damage"
                                                                                  message:@"Choose a number for each between 0 and 100."
                                                                           preferredStyle:UIAlertControllerStyleAlert];
    // health
    [healthAndDamageAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        // numbers only!
        textField.keyboardType = UIKeyboardTypeNumberPad;
        // starts at 0
        textField.placeholder = NSLocalizedString(@"0", @"0");
    }];
    // damage
    [healthAndDamageAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        // numbers only!
        textField.keyboardType = UIKeyboardTypeNumberPad;
        // starts at 0
        textField.placeholder = NSLocalizedString(@"0", @"0");
    }];
    // done action
    UIAlertAction* doneHealthDamageAction = [UIAlertAction actionWithTitle:@"Done"
                                                                     style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                                                                         // save the written health and damage numbers to the current instance of a card
                                                                         // yes I am aware that I am using pointers in a disgusting manner
                                                                         // but let's be honest here
                                                                         // it's 10:08 pm
                                                                         // I've been at this for a long time
                                                                         // who gives a fuck
                                                                         // 4.1 limit the possible amount of damage to 100 or less
                                                                         NSInteger health = [healthAndDamageAlert.textFields.firstObject.text integerValue];
                                                                         NSInteger damage = [healthAndDamageAlert.textFields.lastObject.text integerValue];
                                                                         newCard.health_points = (int)health < 0 ? 0 : (int)health > 100 ? 100 : (int)health;
                                                                         newCard.attack_points = (int)damage < 0 ? 0 : (int)damage > 100 ? 100 : (int)damage;
                                                                         
                                                                         // launch the next alert
                                                                         [healthAndDamageAlert dismissViewControllerAnimated:TRUE completion:nil];
                                                                         [self presentViewController:informationAlert animated:YES completion:nil];
                                                                     }];
    [healthAndDamageAlert addAction:doneHealthDamageAction];
    
    // ----------------------------------------------------------------------------------------------------------------
    // 2. Name the card
    UIAlertController* nameAlert = [UIAlertController alertControllerWithTitle:@"Name Your Card"
                                                                        message:@"You need an awesome name for your card!"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    [nameAlert addTextFieldWithConfigurationHandler:^(UITextField* textField) {
        textField.placeholder = NSLocalizedString(@"Your Sick Card Name", @"Name");
    }];
    UIAlertAction* doneAction = [UIAlertAction actionWithTitle:@"Done"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                                                               // save the written name to the current instance of a card
                                                               newCard.name = nameAlert.textFields.firstObject.text;
                                                               // dismiss the alert and show the next
                                                               [nameAlert dismissViewControllerAnimated:TRUE completion:nil];
                                                               [self presentViewController:healthAndDamageAlert animated:YES completion:nil];
                                                           }];
    [nameAlert addAction:doneAction];
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // code from http://stackoverflow.com/a/13025138/1586231
    
    [self dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:nameAlert animated:YES completion:nil];
    }];
    // source for clever code throughout on completion handlers etc:
    // http://stackoverflow.com/questions/33804034/segue-to-next-view-controller-after-alert-controller-is-called <-----------
}

@end

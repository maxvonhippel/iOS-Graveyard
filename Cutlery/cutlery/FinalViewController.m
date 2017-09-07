//
//  FinalViewController.m
//  cutlery
//
//  Created by Max von Hippel on 8/18/16.
//  Copyright © 2016 Max von Hippel. All rights reserved.
//

#import "FinalViewController.h"
#import "ViewController.h"

@interface FinalViewController ()

@end

@implementation FinalViewController
@synthesize curKnife, handleMaterialPicker, handleMaterialArray, handleRenderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // carbon fiber, exotic wood, wood, aluminum, steel, nylon copolymer, elastomer, titanium, plastic, rubber, composite, paracord, dymondwood, bone, stag horn, mother of pearl, buffalo horn, damascus, antler, horn, mammoth, ivory
    handleMaterialArray = [[NSArray alloc] initWithObjects:@"carbon fiber", @"exotic wood", @"wood", @"aluminum", @"copper", @"steel", @"nylon copolymer", @"elastomer", @"titanium", @"plastic", @"rubber", @"composite", @"paracord", @"dymondwood", @"bone", @"stag horn", @"buffalo horn", @"mother of pearl", @"damascus", @"antler", @"horn", @"mammoth", @"ivory", nil];
    handleMaterialPicker.delegate = self;
    handleMaterialPicker.dataSource = self;
    [handleMaterialPicker reloadAllComponents];
    
    handleRenderView.curKnife = curKnife;
    handleRenderView.backgroundColor = [UIColor darkGrayColor];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // render
    handleRenderView.curKnife.handleMaterial = [handleMaterialArray objectAtIndex:[handleMaterialPicker selectedRowInComponent:0]];
    [handleRenderView setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ======== blade picker view stuff ===========
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    // fix this redundancy later
    return [handleMaterialArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // carbon steel, stainless steel, tool steel, alloy steel, steel, cobalt alloy, titanium alloy, carbon fiber, obsidian, ceramic, glass, plastic, copper, damascus, damasteel
    if (row < 0 || row > [handleMaterialArray count])
        return NULL;
    return handleMaterialArray[row];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    if ([handleMaterialPicker selectedRowInComponent:0] < [handleMaterialArray count])
        curKnife.handleMaterial = [handleMaterialArray objectAtIndex:[handleMaterialPicker selectedRowInComponent:0]];
    else curKnife.handleMaterial = [handleMaterialArray objectAtIndex:0];

    // do we currently have a knives array?
    NSMutableArray* knivesCopy;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"knives"] != nil) {
        // which aircraft are we deleting and from where
        NSData* existingData = [[NSUserDefaults standardUserDefaults] objectForKey:@"knives"];
        NSArray* knives = [NSKeyedUnarchiver unarchiveObjectWithData:existingData];
        knivesCopy = [[NSMutableArray alloc] initWithArray:knives];
    } else knivesCopy = [[NSMutableArray alloc] init];
    // add the new knive
    [knivesCopy addObject:curKnife];
    // save to the saved settings
    [self writeArrayWithCustomObjToUserDefaults:@"knives" withArray:knivesCopy];
    // now launch the main view controller!
    NSString* storyboardName = @"Main";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

// write the array called hanger of aircrafts to memory
-(void)writeArrayWithCustomObjToUserDefaults:(NSString*)keyName withArray:(NSMutableArray*)myArray {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

@end
